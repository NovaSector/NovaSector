SUBSYSTEM_DEF(homes)
	name = "Player Homes"
	ss_flags = SS_NO_FIRE
	init_stage = INITSTAGE_LAST
	/// Starter interiors a first-time player can pick from. name -> /datum/map_template/home
	var/list/starter_templates = list()
	/// Homes currently loaded into a reservation. ckey -> /datum/home_instance
	var/list/active_homes = list()
	/// Round-critical items pushed back out to the terminal when a home unloads, so a home can
	/// never become a black hole for the round's objectives. Same courtesy the condos extend.
	var/list/eject_blacklist
	/// Types that would punch a hole in the closed economy by moving things out on their own.
	var/list/forbidden_types
	/// Typecache of everything write_map() must never write into a save file.
	var/list/save_blacklist
	/// Preview asset datums we have already built. ckey -> /datum/asset/home_preview
	var/list/preview_assets = list()
	/// Everything the console can call down. Built at init from /datum/home_supply subtypes.
	var/list/supply_catalogue = list()
	/// ckey -> world.time they may file another requisition.
	var/list/supply_cooldowns = list()
	/// Requisitions waiting on an admin decision.
	var/list/pending_requisitions = list()
	/// Approved deliveries whose owner had already left. ckey -> list of manifests.
	var/list/pending_deliveries = list()
	/// "visitor-owner" -> world.time they may knock at that door again.
	var/list/knock_cooldowns = list()

/datum/controller/subsystem/homes/Initialize()
	preload_starter_templates()
	preload_supply_catalogue()
	build_blacklists()
	return SS_INIT_SUCCESS

/// Registers every /datum/map_template/home subtype that actually points at a map file.
/// Mirrors SScondos.preload_condo_templates() - templates built at runtime from a player's save
/// have no compile-time mappath, which is exactly how they get skipped here.
/datum/controller/subsystem/homes/proc/preload_starter_templates()
	for(var/datum/map_template/home/template_type as anything in subtypesof(/datum/map_template/home))
		if(!initial(template_type.mappath))
			continue
		var/datum/map_template/home/starter = new template_type()
		starter_templates[starter.name] = starter
		SSmapping.map_templates[starter.name] = starter

/datum/controller/subsystem/homes/proc/build_blacklists()
	// Anything the condos already consider too round-critical to lose is too round-critical to sink
	// into a permanent home, so we inherit that list wholesale rather than drifting from it.
	eject_blacklist = SScondos.item_blacklist.Copy()
	eject_blacklist |= list(
		/obj/item/disk/nuclear,
		/obj/item/documents,
		/obj/machinery/nuclearbomb,
	)

	// A home is sealed. These would let its contents talk to the outside world.
	forbidden_types = list(
		/obj/machinery/disposal,
		/obj/structure/disposalpipe,
		/obj/structure/disposaloutlet,
		/obj/machinery/mineral/ore_redemption,
		/obj/machinery/teleport,
		/obj/machinery/quantumpad,
		/obj/machinery/launchpad,
		/obj/machinery/cafe_condo_teleporter,
		/obj/machinery/home_terminal,
	)

	// write_map()'s own default blacklist, widened. Note that /obj/effect/landmark is NOT spared the
	// way write_map spares it by default: a latejoin spawn point or a ruin marker baked into a
	// player's permanent save is a very bad time.
	// Only objects belong in here - write_map() never consults this list for mobs.
	save_blacklist = typecacheof(list(
		/obj/effect,
		/obj/projectile,
		/obj/item/nuke_core,
		/obj/item/nuke_core_container,
		/obj/structure/blob,
	) + forbidden_types) - typecacheof(list(
		/obj/effect/decal,
		/obj/effect/turf_decal,
	))

/// Absolute path of a player's home directory. Reuses the per-ckey layout preferences already use.
/datum/controller/subsystem/homes/proc/home_directory(ckey)
	if(!ckey)
		return null
	return "data/player_saves/[ckey[1]]/[ckey]/homes/"

/// Path to a player's current save, their rolling backup, or their metadata sidecar.
/datum/controller/subsystem/homes/proc/home_file(ckey, suffix = "home.dmm")
	var/directory = home_directory(ckey)
	return directory ? "[directory][suffix]" : null

/// TRUE if this player has a home on disk waiting for them.
/datum/controller/subsystem/homes/proc/has_home(ckey)
	return fexists(home_file(ckey))

/// Reads a player's sidecar. Returns an empty list rather than null so callers can index freely.
/datum/controller/subsystem/homes/proc/read_metadata(ckey)
	var/path = home_file(ckey, "home.json")
	if(!path || !fexists(path))
		return list()
	var/list/parsed = safe_json_decode(file2text(file(path)))
	return islist(parsed) ? parsed : list()

/// Writes a player's sidecar. It carries the landing spot, which a player-authored .dmm has
/// nowhere to store the way a compiled-in template stores it on its datum.
/datum/controller/subsystem/homes/proc/write_metadata(ckey, datum/home_instance/home, object_count, mob/saver)
	var/path = home_file(ckey, "home.json")
	if(!path)
		return
	rustg_file_write(json_encode(list(
		"version" = HOME_SAVE_VERSION,
		"starter" = home.starter_name,
		"landing_x" = home.landing_x,
		"landing_y" = home.landing_y,
		"saved_at" = time2text(world.realtime, "YYYY-MM-DD hh:mm:ss", TIMEZONE_UTC),
		"saved_by_name" = saver?.real_name,
		"object_count" = object_count,
		"brightness" = home.brightness,
		"lamp_color" = home.lamp_color,
		"gravity" = home.gravity,
	)), path)

/// Marks everything the save file spawned as belonging to this home. See TRAIT_HOME_FURNISHING -
/// this is the whole anti-duplication mechanism, so it has to run before anybody is let in.
/datum/controller/subsystem/homes/proc/mark_furnishings(datum/home_instance/home)
	for(var/turf/reserved as anything in home.reservation.reserved_turfs)
		for(var/atom/movable/furnishing in reserved.get_all_contents())
			ADD_TRAIT(furnishing, TRAIT_HOME_FURNISHING, HOME_FURNISHING_TRAIT)
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

/// Releases a home's reservation once the last minded occupant leaves. Deliberately does NOT save:
/// saving is always an explicit act at the console, so a griefed home is never written to disk.
/datum/controller/subsystem/homes/proc/release_home(datum/home_instance/home)
	if(isnull(home))
		return
	active_homes -= home.owner_ckey
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
			to_empty.empty()
		home.reservation = null
		qdel(reservation)
	qdel(home)

/// Pushes round-critical gear somebody abandoned inside back out to the terminal, rather than
/// destroying it with the room. Furnishings are skipped on purpose: they came out of the save file
/// and must never reach the round, and save_blacklist already keeps this gear out of save files.
/datum/controller/subsystem/homes/proc/eject_round_critical(datum/home_instance/home, datum/turf_reservation/player_home/reservation)
	var/turf/eject_to = get_turf(home.parent_terminal)
	if(isnull(eject_to))
		return
	for(var/turf/reserved as anything in reservation.reserved_turfs)
		for(var/atom/movable/stranded in reserved.get_all_contents())
			if(HAS_TRAIT(stranded, TRAIT_HOME_FURNISHING))
				continue
			if(is_type_in_list(stranded, eject_blacklist) || HAS_TRAIT(stranded, TRAIT_CONTRABAND))
				stranded.forceMove(eject_to)
				log_game("Player homes: ejected [stranded] from [home.owner_ckey] home back to the terminal.")
