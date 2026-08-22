/// Files a brand new home by copying a starter interior straight onto the player's record. Doing it
/// here, rather than loading the starter and waiting for a save, means a player's very first visit
/// is already persistent - walk out without touching the console and the home is still theirs.
/// rustg_file_write creates the parent directories, so this is also what makes the folder exist.
/datum/controller/subsystem/homes/proc/write_starter(ckey, datum/map_template/home/starter, mob/user)
	var/live = home_file(ckey)
	if(!live || isnull(starter) || !fexists(starter.mappath))
		return FALSE

	var/starter_text = file2text(file(starter.mappath))
	if(!starter_text)
		return FALSE
	fdel(live)
	rustg_file_write(starter_text, live)
	if(!fexists(live))
		return FALSE

	var/datum/home_instance/scratch = new()
	scratch.starter_name = starter.name
	scratch.landing_x = starter.landing_zone_x_offset
	scratch.landing_y = starter.landing_zone_y_offset
	write_metadata(ckey, scratch, 0, user)
	qdel(scratch)

	log_game("[key_name(user)] filed a new home from starter '[starter.name]'.")
	return TRUE

/// Parses a .dmm off disk into a loadable template, or returns null if it isn't usable.
///
/// Bad *object* paths - a type deleted from the codebase since the save was written - are dropped
/// silently by the loader, which is the graceful degradation we want. Bad turf or area paths make
/// the report unloadable, and those we refuse rather than load a room full of holes.
/datum/controller/subsystem/homes/proc/build_runtime_template(path, template_name)
	if(!path || !fexists(path))
		return null
	var/datum/map_template/home/player_save/candidate = new(path, template_name, TRUE)
	if(isnull(candidate.cached_map))
		qdel(candidate)
		return null
	if(!candidate.width || !candidate.height || (candidate.width > HOME_MAX_DIMENSION) || (candidate.height > HOME_MAX_DIMENSION))
		qdel(candidate)
		return null

	var/datum/map_report/report = candidate.cached_map.check_for_errors()
	var/loadable = TRUE
	if(report)
		loadable = report.loadable
		qdel(report)
	if(!loadable)
		qdel(candidate)
		return null

	candidate.keep_cached_map = TRUE // the parse is already paid for, don't make load() do it twice
	return candidate

/// Picks what to actually put in the reservation: their save, else their backup, else the starter it
/// grew from. A player is never left standing at the terminal with nowhere to go.
/datum/controller/subsystem/homes/proc/resolve_template(ckey, mob/user)
	var/datum/map_template/home/candidate = build_runtime_template(home_file(ckey), "[ckey] home")
	if(!isnull(candidate))
		return candidate

	candidate = build_runtime_template(home_file(ckey, "home_backup.dmm"), "[ckey] home (recovered)")
	if(!isnull(candidate))
		to_chat(user, span_warning("Your current record was unreadable. The registry restored the save before it."))
		message_admins("Player homes: [ckey] home.dmm failed validation - fell back to their backup.")
		log_game("Player homes: [ckey] home.dmm failed validation, loaded home_backup.dmm instead.")
		return candidate

	var/list/metadata = read_metadata(ckey)
	var/datum/map_template/home/starter = starter_templates[metadata["starter"]]
	if(isnull(starter))
		return null
	to_chat(user, span_warning("Both of your records were unreadable. The registry rebuilt your residence from its original plan."))
	message_admins("Player homes: [ckey] lost both records - rebuilt from starter '[starter.name]'.")
	log_game("Player homes: [ckey] fell all the way back to starter '[starter.name]'.")
	return starter

/// Brings a player's home into the world and registers it as active.
/datum/controller/subsystem/homes/proc/load_home(ckey, obj/machinery/home_terminal/terminal, mob/user)
	if(!isnull(active_homes[ckey]))
		return active_homes[ckey]

	var/datum/map_template/home/template = resolve_template(ckey, user)
	if(isnull(template))
		to_chat(user, span_warning("The registry has no readable record of your residence. Contact an administrator."))
		return null
	// Starters are the subsystem's own and must outlive this call; a template parsed off disk is
	// ours to throw away once it has been unfolded.
	var/disposable_template = istype(template, /datum/map_template/home/player_save)

	var/datum/turf_reservation/player_home/reservation = SSmapping.request_turf_block_reservation(
		template.width,
		template.height,
		1,
		reservation_type = /datum/turf_reservation/player_home,
	)
	var/turf/bottom_left = reservation?.bottom_left_turfs[1]
	if(isnull(bottom_left))
		to_chat(user, span_warning("The registry couldn't find anywhere to unfold your residence! Contact an administrator."))
		if(!isnull(reservation))
			qdel(reservation)
		if(disposable_template)
			qdel(template)
		return null

	if(!template.load(bottom_left))
		to_chat(user, span_warning("Your residence failed to unfold. Contact an administrator."))
		message_admins("Player homes: [ckey] interior failed to load into its reservation.")
		qdel(reservation)
		if(disposable_template)
			qdel(template)
		return null

	var/list/metadata = read_metadata(ckey)
	var/datum/home_instance/home = new()
	home.owner_ckey = ckey
	home.parent_terminal = terminal
	home.reservation = reservation
	home.starter_name = metadata["starter"] || template.name
	home.last_saved = metadata["saved_at"]
	// A save carries its own landing spot in the sidecar; a starter carries it on its datum. Using
	// the sidecar's offsets for a starter would drop somebody in entirely the wrong room.
	if(disposable_template && isnum(metadata["landing_x"]) && isnum(metadata["landing_y"]))
		home.landing_x = metadata["landing_x"]
		home.landing_y = metadata["landing_y"]
	else
		home.landing_x = template.landing_zone_x_offset
		home.landing_y = template.landing_zone_y_offset

	// Room settings, restored from the sidecar. Defaults on the datum cover a home saved before
	// these existed, so an old record just loads lit and with gravity on.
	if(isnum(metadata["brightness"]))
		home.brightness = clamp(round(metadata["brightness"]), HOME_BRIGHTNESS_MIN, HOME_BRIGHTNESS_MAX)
	home.lamp_color = sanitize_home_lamp_color(metadata["lamp_color"])
	if(!isnull(metadata["gravity"]))
		home.gravity = !!metadata["gravity"]

	reservation.home = home
	active_homes[ckey] = home
	if(disposable_template)
		qdel(template)

	claim_area(home)
	heal_home(home)
	// Must happen before anybody is let in: this is what stops a saved item walking back out.
	mark_furnishings(home)
	home.apply_settings()
	flush_pending_deliveries(home)
	return home

/// Moves every reserved turf into a freshly made /area/misc/player_home.
///
/// This is not optional. The area type in a save file comes off the disk, so forcing it here is what
/// guarantees a home can't load itself into a station area - and because the area isn't UNIQUE_AREA,
/// it's also what gives every simultaneously-loaded home its own area instance.
/datum/controller/subsystem/homes/proc/claim_area(datum/home_instance/home)
	var/area/misc/player_home/home_area = new
	home_area.home = home
	for(var/turf/reserved as anything in home.reservation.reserved_turfs)
		reserved.change_area(get_area(reserved), home_area)

/// A home is only ever as good as its last save, and a save can be missing the two things that make
/// it usable. Put them back rather than stranding somebody in a sealed box.
/datum/controller/subsystem/homes/proc/heal_home(datum/home_instance/home)
	var/list/reserved_turfs = home.reservation.reserved_turfs

	// A player can file a record with the door taken down only by having it in hand as they leave -
	// the console refuses to save otherwise - so this is a genuine last resort rather than routine.
	if(isnull(home.find_door()) && !locate(/obj/item/home_door_kit) in reserved_turfs)
		install_door(home)
		message_admins("Player homes: [home.owner_ckey] had no door on record and one was fitted for them.")
	for(var/turf/closed/indestructible/hoteldoor/door in reserved_turfs)
		door.parentSphere = home.parent_terminal

	var/obj/machinery/home_saver/first_console
	for(var/turf/reserved as anything in reserved_turfs)
		for(var/obj/machinery/home_saver/console in reserved)
			if(isnull(first_console))
				first_console = console
				continue
			qdel(console) // a record only ever needed one
	if(isnull(first_console))
		install_console(home)

/// Converts a perimeter wall into a door. Only ever runs for a save that somehow lost its own.
/datum/controller/subsystem/homes/proc/install_door(datum/home_instance/home)
	var/list/reserved_turfs = home.reservation.reserved_turfs
	for(var/turf/closed/wall in reserved_turfs)
		if(home.has_open_neighbour(wall))
			return home.hang_door(wall)
	var/turf/last_resort = home.reservation.bottom_left_turfs[1]
	return isnull(last_resort) ? null : home.hang_door(last_resort)

/// Drops a console by the front door, or on the landing spot if there is no room beside it.
/datum/controller/subsystem/homes/proc/install_console(datum/home_instance/home)
	var/turf/door = home.find_door()
	if(!isnull(door))
		for(var/turf/open/doorstep in orange(1, door))
			if(!doorstep.density && (doorstep in home.reservation.reserved_turfs))
				return new /obj/machinery/home_saver(doorstep)
	var/turf/landing = home.get_landing_turf()
	return isnull(landing) ? null : new /obj/machinery/home_saver(landing)
