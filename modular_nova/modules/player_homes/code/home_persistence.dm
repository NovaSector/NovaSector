/*
 * Getting a home on and off the disk: filing a new one, parsing a save back into a loadable
 * template, unfolding it into a reservation, and committing it again.
 */

/// Files a brand new home by copying a starter interior straight onto the player's record, so a
/// player's very first visit is already persistent - walk out without touching the console and the
/// home is still theirs. rustg_file_write creates the parent directories.
/// Every failure here means a player asked for a home and did not get one, so each one says which
/// gate it tripped rather than a bare FALSE. Loud on purpose: silent failure looks identical from
/// the terminal whether the map is missing, unreadable, or the save directory is not writable.
/datum/controller/subsystem/homes/proc/write_starter(ckey, datum/map_template/home/starter, mob/user)
	var/live = home_file(ckey)
	if(!live)
		stack_trace("Player homes: no save path for ckey '[ckey]'.")
		return FALSE
	if(isnull(starter))
		stack_trace("Player homes: asked to file a null starter for '[ckey]'.")
		return FALSE
	if(!fexists(starter.mappath))
		stack_trace("Player homes: starter '[starter.name]' has no readable map at '[starter.mappath]'.")
		return FALSE

	var/starter_text = file2text(file(starter.mappath))
	if(!starter_text)
		stack_trace("Player homes: starter '[starter.name]' read empty from '[starter.mappath]'.")
		return FALSE
	fdel(live)
	rustg_file_write(starter_text, live)
	if(!fexists(live))
		stack_trace("Player homes: wrote '[starter.name]' to '[live]' but nothing is there. Is the save directory writable?")
		message_admins("Player homes: [ckey] attempted to write a home to save directory, but nothing was written. Contact a sysadmin.")
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
/// Bad objects are fine, they disappear. Bad turfs are a bigger problem and it refuses the load.
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

/// Picks what to actually put in the reservation: their save, else their backup, else the initial starter
/datum/controller/subsystem/homes/proc/resolve_template(ckey, mob/user)
	var/datum/map_template/home/candidate = build_runtime_template(home_file(ckey), "[ckey] home")
	if(!isnull(candidate))
		return candidate

	candidate = build_runtime_template(home_file(ckey, "home_backup.dmm"), "[ckey] home (recovered)")
	if(!isnull(candidate))
		// Neutrally worded: a guest the owner let in can be the one who triggers this load.
		to_chat(user, span_warning("This residence's current record was unreadable. The registry restored the save before it."))
		message_admins("Player homes: [ckey] home.dmm failed validation - fell back to their backup.")
		log_game("Player homes: [ckey] home.dmm failed validation, loaded home_backup.dmm instead.")
		return candidate

	var/list/metadata = read_metadata(ckey)
	var/datum/map_template/home/starter = starter_templates[metadata["starter"]]
	if(isnull(starter))
		return null
	to_chat(user, span_warning("Both records were unreadable. The registry rebuilt this residence from its original plan."))
	message_admins("Player homes: [ckey] lost both records - rebuilt from starter '[starter.name]'.")
	log_game("Player homes: [ckey] fell all the way back to starter '[starter.name]'.")
	return starter

/// Brings a player's home into the world and registers it as active.
/datum/controller/subsystem/homes/proc/load_home(ckey, obj/machinery/home_terminal/terminal, mob/user)
	if(!isnull(active_homes[ckey]))
		return active_homes[ckey]

	var/datum/map_template/home/template = resolve_template(ckey, user)
	if(isnull(template))
		to_chat(user, span_warning("The registry has no readable record of that residence. Contact an administrator."))
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
		to_chat(user, span_warning("The registry couldn't find anywhere to unfold the residence! Contact an administrator."))
		if(!isnull(reservation))
			qdel(reservation)
		if(disposable_template)
			qdel(template)
		return null

	if(!template.load(bottom_left))
		to_chat(user, span_warning("The residence failed to unfold. Contact an administrator."))
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

	// Defaults on the datum cover a home saved before these settings existed, so an old record just
	// loads lit and with gravity on.
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
/datum/controller/subsystem/homes/proc/claim_area(datum/home_instance/home)
	var/area/misc/player_home/home_area = new
	home_area.home = home
	for(var/turf/reserved as anything in home.reservation.reserved_turfs)
		reserved.change_area(get_area(reserved), home_area)

/// If someone manages to lose their door or their console somehow this puts them back so things continue to function.
/datum/controller/subsystem/homes/proc/heal_home(datum/home_instance/home)
	var/list/reserved_turfs = home.reservation.reserved_turfs

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

/*
 * Commits a home to disk with write_map() - the TGM writer the Map Export admin verb runs on - over
 * exactly the reservation's block, so what comes out is a real .dmm the ordinary loader reads back.
 */
/datum/controller/subsystem/homes/proc/save_home(datum/home_instance/home, mob/user)
	if(isnull(home?.reservation))
		return FALSE
	var/turf/bottom_left = home.reservation.bottom_left_turfs[1]
	var/turf/top_right = home.reservation.top_right_turfs[1]
	if(isnull(bottom_left) || isnull(top_right))
		to_chat(user, span_warning("The console can't get a fix on the walls around you."))
		return FALSE

	// Direct turf contents is exactly what write_map() writes, so it's the honest measure.
	var/object_count = 0
	for(var/turf/counted as anything in home.reservation.reserved_turfs)
		object_count += length(counted.contents)
	if(object_count > HOME_MAX_OBJECTS)
		to_chat(user, span_warning("Registry refused: [object_count] cataloguable objects exceeds the [HOME_MAX_OBJECTS] permitted. Clear some out and try again."))
		return FALSE

	var/directory = home_directory(home.owner_ckey)
	var/scratch = "[directory]home.dmm.tmp"
	var/live = "[directory]home.dmm"
	var/backup = "[directory]home_backup.dmm"

	var/map_text = write_map(
		bottom_left.x, bottom_left.y, bottom_left.z,
		top_right.x, top_right.y, top_right.z,
		save_flag = HOME_SAVE_FLAGS,
		obj_blacklist = save_blacklist,
	)
	if(!map_text)
		to_chat(user, span_warning("The console failed to transcribe your residence. Contact an administrator."))
		return FALSE

	fdel(scratch)
	rustg_file_write(map_text, scratch)
	if(!verify_save(scratch))
		fdel(scratch)
		to_chat(user, span_warning("The registry transcribed a corrupt record and discarded it. Your previous save is untouched - please tell an administrator."))
		message_admins("Player homes: save verification FAILED for [home.owner_ckey]. Their previous save was left intact.")
		log_game("Player homes: save verification failed for [home.owner_ckey].")
		return FALSE

	// Only now is it safe to touch the good copy.
	if(fexists(live))
		fdel(backup)
		fcopy(live, backup)
	fdel(live)
	fcopy(scratch, live)
	fdel(scratch)

	home.last_saved = time2text(world.realtime, "YYYY-MM-DD hh:mm:ss", TIMEZONE_UTC)
	write_metadata(home.owner_ckey, home, object_count, user)
	// Photograph it while the rooms are still standing; there is nothing to shoot once it unloads.
	render_preview(home)
	log_game("[key_name(user)] saved their home ([object_count] objects).")
	return TRUE

/// Parses a freshly written save back off disk before it is allowed to replace the good copy.
/// A save that won't load is worse than no save at all, and this is cheap next to write_map().
/datum/controller/subsystem/homes/proc/verify_save(path)
	var/datum/map_template/home/player_save/proof = new(path, "save verification", TRUE)
	var/valid = !isnull(proof.cached_map)
	if(valid)
		var/datum/map_report/report = proof.cached_map.check_for_errors()
		if(report)
			valid = report.loadable
			qdel(report)
	qdel(proof)
	return valid

/// Rolls a home back to the save before its last one, then turns everyone out so the rooms rebuild
/// from the restored file the next time somebody walks in.
/datum/controller/subsystem/homes/proc/restore_backup(datum/home_instance/home, mob/user)
	var/backup = home_file(home.owner_ckey, "home_backup.dmm")
	if(!fexists(backup))
		to_chat(user, span_warning("There is no earlier record to restore."))
		return FALSE
	var/live = home_file(home.owner_ckey)
	fdel(live)
	fcopy(backup, live)
	to_chat(user, span_notice("Record restored. The registry is cycling everyone out so it can rebuild the rooms."))
	log_game("[key_name(user)] restored their home from its backup.")
	home.evict_all()
	return TRUE

/// Demolishes a player's home. The backup survives on purpose, so an admin can still put it back.
/datum/controller/subsystem/homes/proc/reset_home(ckey, mob/user)
	var/datum/home_instance/home = active_homes[ckey]
	if(!isnull(home))
		home.evict_all()

	var/live = home_file(ckey)
	if(fexists(live))
		var/backup = home_file(ckey, "home_backup.dmm")
		fdel(backup)
		fcopy(live, backup)
		fdel(live)
	fdel(home_file(ckey, "home.json"))
	forget_preview(ckey)
	log_game("[key_name(user)] demolished [ckey] home record.")
	return TRUE
