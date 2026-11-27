SUBSYSTEM_DEF(homes)
	name = "Player Homes"
	ss_flags = SS_NO_FIRE
	init_stage = INITSTAGE_LAST
	/// Starter interiors a first-time player can pick from. name -> /datum/map_template/home
	var/list/starter_templates = list()
	/// Homes currently loaded into a reservation. home_key() -> /datum/home_instance
	var/list/active_homes = list()
	/// Round-critical items pushed back out to the terminal when a home unloads, so a home never
	/// becomes a black hole for the round's objectives.
	var/list/eject_blacklist
	/// Types that would punch a hole in the closed economy by moving things out on their own.
	var/list/forbidden_types
	/// Typecache of everything write_map() must never write into a save file.
	var/list/save_blacklist
	/// Preview asset datums we have already built. home_key() -> /datum/asset/home_preview
	var/list/preview_assets = list()
	/// Everything the console can call down. Built at init from /datum/home_supply subtypes.
	var/list/supply_catalogue = list()
	/// ckey -> world.time they may file another requisition.
	var/list/supply_cooldowns = list()
	/// Requisitions waiting on an admin decision.
	var/list/pending_requisitions = list()
	/// Approved deliveries whose home had already been shut up. home_key() -> list of manifests.
	var/list/pending_deliveries = list()
	/// "visitor-owner" -> world.time they may knock at that owner's doors again.
	var/list/knock_cooldowns = list()
	/// ckey -> world.time their claim at the terminal lapses. Stops a double-click filing two homes
	/// while the first is still unfolding.
	var/list/claims_in_progress = list()

/datum/controller/subsystem/homes/Initialize()
	preload_starter_templates()
	preload_supply_catalogue()
	build_blacklists()
	return SS_INIT_SUCCESS

/// Registers every /datum/map_template/home subtype that actually points at a map file. Templates
/// built at runtime from a player's save have no compile-time mappath, so they get skipped here.
/datum/controller/subsystem/homes/proc/preload_starter_templates()
	for(var/datum/map_template/home/template_type as anything in subtypesof(/datum/map_template/home))
		if(!initial(template_type.mappath))
			continue
		var/datum/map_template/home/starter = new template_type()
		starter_templates[starter.name] = starter
		SSmapping.map_templates[starter.name] = starter

/datum/controller/subsystem/homes/proc/build_blacklists()
	// Inherited wholesale rather than drifting from it: anything too round-critical for a condo to
	// eat is too round-critical to sink into a permanent home.
	eject_blacklist = SScondos.item_blacklist.Copy()
	eject_blacklist |= list(
		/obj/item/disk/nuclear,
		/obj/item/documents,
		/obj/machinery/nuclearbomb,
	)

	// A home is sealed. These would let its contents talk to the outside world.
	forbidden_types = list(
		/obj/machinery/teleport,
		/obj/machinery/quantumpad,
		/obj/machinery/launchpad,
		/obj/machinery/cafe_condo_teleporter,
		/obj/machinery/home_terminal,
	)

	// write_map()'s own default blacklist, widened. /obj/effect/landmark is NOT spared the way
	// write_map spares it: a latejoin spawn point baked into a permanent save is a very bad time.
	// Objects only - write_map() never consults this for mobs.
	save_blacklist = typecacheof(list(
		/obj/effect,
		/obj/projectile,
		/obj/item/nuke_core,
		/obj/item/nuke_core_container,
		/obj/structure/blob,
	) + forbidden_types) - typecacheof(list(
		/obj/effect/decal,
		/obj/effect/turf_decal,
		/obj/effect/home_water_source,
	))

/// Directory holding every home on one account. Reuses the per-ckey layout preferences already use.
/datum/controller/subsystem/homes/proc/account_directory(ckey)
	if(!ckey)
		return null
	return "data/player_saves/[ckey[1]]/[ckey]/homes/"

/// Directory of one home. Every slot is self-contained, with its own record, backup, sidecar and preview.
/datum/controller/subsystem/homes/proc/home_directory(ckey, slot)
	var/account = account_directory(ckey)
	if(!account || isnull(sanitize_home_slot(slot)))
		return null
	return "[account][slot]/"

/// Path to one home's current save, its rolling backup, or its metadata sidecar.
/datum/controller/subsystem/homes/proc/home_file(ckey, slot, suffix = "home.dmm")
	var/directory = home_directory(ckey, slot)
	return directory ? "[directory][suffix]" : null

/// Identifies one home among every account's. What active_homes and the other per-home lists are keyed by.
/datum/controller/subsystem/homes/proc/home_key(ckey, slot)
	return "[ckey]:[slot]"

/// The given home if it is loaded right now, else null.
/datum/controller/subsystem/homes/proc/get_active_home(ckey, slot)
	return active_homes[home_key(ckey, slot)]

/// TRUE if this slot has a home on disk waiting for its owner.
/datum/controller/subsystem/homes/proc/has_home(ckey, slot)
	var/path = home_file(ckey, slot)
	return !!path && fexists(path)

/// TRUE if anything at all is filed under this slot, even a lone backup left behind by a demolition.
/datum/controller/subsystem/homes/proc/slot_has_files(ckey, slot)
	for(var/suffix in list("home.dmm", "home_backup.dmm", "home.json"))
		var/path = home_file(ckey, slot, suffix)
		if(path && fexists(path))
			return TRUE
	return FALSE

/// Every slot on this account with a home filed in it, lowest first. This is how a player's homes are
/// discovered, so it is also where an old single-home record gets moved into its slot.
/datum/controller/subsystem/homes/proc/filed_slots(ckey)
	. = list()
	if(!ckey)
		return
	adopt_legacy_home(ckey)
	for(var/slot in 1 to HOME_MAX_SLOTS)
		if(has_home(ckey, slot))
			. += slot

/// The lowest slot this account could claim a new home into, or null if it already holds as many
/// homes as the config allows. A slot that is truly empty wins over one where a demolished home
/// left its backup behind, so that backup stays recoverable for as long as possible.
/datum/controller/subsystem/homes/proc/next_free_slot(ckey)
	var/list/filed = filed_slots(ckey)
	if(length(filed) >= CONFIG_GET(number/player_home_slots))
		return null
	var/leftover_slot
	for(var/slot in 1 to HOME_MAX_SLOTS)
		if(slot in filed)
			continue
		if(!slot_has_files(ckey, slot))
			return slot
		leftover_slot ||= slot
	return leftover_slot

/*
 * Before an account could hold more than one home, its files sat loose in the account directory.
 * This moves such a home into slot 1. Every file is copied and checked before any original is
 * deleted, so a failure partway through leaves the old record exactly where it was.
 *
 * Remove this once no server has flat-layout saves left.
 */
/datum/controller/subsystem/homes/proc/adopt_legacy_home(ckey)
	var/account = account_directory(ckey)
	if(!account || (!fexists("[account]home.dmm") && !fexists("[account]home.json")))
		return
	// Slot 1 is already in use, most likely by an earlier adoption that copied but could not clean up.
	// Never overwrite it: the loose files are left for an admin rather than guessed at.
	if(slot_has_files(ckey, 1))
		return

	var/list/copied = list()
	for(var/legacy_name in list("home.dmm", "home_backup.dmm", "home.json", "home_preview.png"))
		var/legacy = "[account][legacy_name]"
		if(!fexists(legacy))
			continue
		var/adopted = home_file(ckey, 1, legacy_name)
		fcopy(legacy, adopted)
		if(!fexists(adopted))
			stack_trace("Player homes: could not move [legacy] into slot 1. Its old record was left where it was.")
			for(var/undo in copied)
				fdel(home_file(ckey, 1, undo))
			return
		copied += legacy_name
	for(var/legacy_name in copied)
		fdel("[account][legacy_name]")
	log_game("Player homes: moved [ckey]'s single-home record into slot 1 ([copied.Join(", ")]).")

/// Reads one home's sidecar. Returns an empty list rather than null so callers can index freely.
/datum/controller/subsystem/homes/proc/read_metadata(ckey, slot)
	var/path = home_file(ckey, slot, "home.json")
	if(!path || !fexists(path))
		return list()
	var/list/parsed = safe_json_decode(file2text(file(path)))
	return islist(parsed) ? parsed : list()

/// What a home is called in lists: the owner's name for it, else the plan it grew from.
/// Pass metadata if it has already been read, so it is not read twice.
/datum/controller/subsystem/homes/proc/home_display_name(ckey, slot, list/metadata)
	if(isnull(metadata))
		metadata = read_metadata(ckey, slot)
	return metadata["label"] || metadata["starter"] || "Residence [slot]"

/// Renames one home, or clears its name if label is empty. Patches the sidecar in place, so nothing
/// else on record changes. A loaded copy is updated too, or its next save would put the old name back.
/datum/controller/subsystem/homes/proc/set_home_label(ckey, slot, label)
	var/path = home_file(ckey, slot, "home.json")
	if(!path || !has_home(ckey, slot))
		return FALSE
	var/list/metadata = read_metadata(ckey, slot)
	metadata["label"] = label || null
	rustg_file_write(json_encode(metadata), path)
	var/datum/home_instance/loaded = get_active_home(ckey, slot)
	if(!isnull(loaded))
		loaded.label = label || null
	return TRUE

/// Writes a home's sidecar: the landing spot and room settings, which a player-authored .dmm has
/// nowhere to store the way a compiled-in template stores them on its datum.
/datum/controller/subsystem/homes/proc/write_metadata(datum/home_instance/home, object_count, mob/saver)
	var/path = home_file(home.owner_ckey, home.slot, "home.json")
	if(!path)
		return
	rustg_file_write(json_encode(list(
		"version" = HOME_SAVE_VERSION,
		"label" = home.label,
		"starter" = home.starter_name,
		"landing_x" = home.landing_x,
		"landing_y" = home.landing_y,
		"landing_pinned" = home.landing_pinned,
		"saved_at" = time2text(world.realtime, "YYYY-MM-DD hh:mm:ss", TIMEZONE_UTC),
		"saved_by_name" = saver?.real_name,
		"object_count" = object_count,
		"brightness" = home.brightness,
		"lamp_color" = home.lamp_color,
		"gravity" = home.gravity,
	)), path)

/// Marks everything the save file spawned as belonging to this home. The whole anti-duplication
/// mechanism, so it has to run before anybody is let in.
/datum/controller/subsystem/homes/proc/mark_furnishings(datum/home_instance/home)
	for(var/turf/reserved as anything in home.reservation.reserved_turfs)
		for(var/atom/movable/furnishing in reserved.get_all_contents())
			ADD_TRAIT(furnishing, TRAIT_HOME_FURNISHING, HOME_FURNISHING_TRAIT)
			// Materials painted over the saved colour while this initialized. See home_stand_ins.dm.
			if(isobj(furnishing))
				var/obj/painted = furnishing
				if(painted.home_paint)
					painted.set_home_paint(painted.home_paint)
		CHECK_TICK

/// Warps a mob into an already-loaded home.
/datum/controller/subsystem/homes/proc/warp_into_home(datum/home_instance/home, mob/user)
	var/turf/landing = home.get_landing_turf()
	if(isnull(landing))
		to_chat(user, span_warning("Your home offers no safe place to stand! Contact an administrator."))
		return FALSE
	do_sparks(3, FALSE, get_turf(user))
	user.forceMove(landing)
	return TRUE

/// Releases a home's reservation once the last minded occupant leaves. Deliberately does NOT save,
/// so a home griefed while its owner was out is never written to disk.
/datum/controller/subsystem/homes/proc/release_home(datum/home_instance/home)
	if(isnull(home))
		return
	active_homes -= home.registry_key()
	var/datum/turf_reservation/player_home/reservation = home.reservation
	// Drop the area's handle first: emptying the turfs below fires Exited(), and an area still
	// pointing at a half-deleted home would try to release it a second time.
	var/area/misc/player_home/home_area = get_area(reservation?.bottom_left_turfs[1])
	if(istype(home_area))
		home_area.releasing = TRUE
		home_area.home = null
	if(!isnull(reservation))
		eject_round_critical(home, reservation)
		// remove this once clearing turf reservations is actually reliable
		for(var/turf/to_empty as anything in reservation.reserved_turfs)
			// Every wall in the interior registered a screentip context, and turfs carry their signal
			// registrations across a type change. Emptying the turf would hand that registration to the
			// baseturf and on to whatever home is loaded into this reservation next, whose own walls
			// would then collide with it. Give the reservation back clean.
			clear_home_screentip_context(to_empty)
			to_empty.empty()
		home.reservation = null
		qdel(reservation)
	qdel(home)

/// TRUE if this is something a home must never be allowed to swallow.
/// Two things lean on it: unloading pushes these back out to the terminal,
/// and the waste compactor refuses to destroy them.
/datum/controller/subsystem/homes/proc/is_round_critical(atom/movable/thing)
	return is_type_in_list(thing, eject_blacklist) || HAS_TRAIT(thing, TRAIT_CONTRABAND)

/// Pushes round-critical gear abandoned inside back out to the terminal rather than destroying it
/// with the room. Furnishings are skipped: they came out of the save file and must never reach the
/// round, and save_blacklist already keeps this gear out of save files.
/datum/controller/subsystem/homes/proc/eject_round_critical(datum/home_instance/home, datum/turf_reservation/player_home/reservation)
	var/turf/eject_to = get_turf(home.parent_terminal)
	if(isnull(eject_to))
		return
	for(var/turf/reserved as anything in reservation.reserved_turfs)
		for(var/atom/movable/stranded in reserved.get_all_contents())
			if(HAS_TRAIT(stranded, TRAIT_HOME_FURNISHING))
				continue
			if(is_round_critical(stranded))
				stranded.forceMove(eject_to)
				log_game("Player homes: ejected [stranded] from [home.owner_ckey] home [home.slot] back to the terminal.")
