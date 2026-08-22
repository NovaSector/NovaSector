/**
 * Commits a home to disk.
 *
 * Reuses write_map() - the TGM writer the Map Export admin verb already runs on - over exactly the
 * reservation's block, so what comes out is a real .dmm that the ordinary map loader can read back.
 *
 * SAVE_SPACE is on because several interiors are built on space and lavaland turfs, and without it
 * write_map() writes those out as /turf/template_noop and the room comes back full of holes.
 *
 * SAVE_OBJECT_PROPERTIES is deliberately OFF. Its only substantial implementation dumps an ore
 * silo's entire material stockpile into the file. Leaving it off also means closet contents don't
 * persist, which the console's description warns about.
 *
 * Note that write_map() applies obj_blacklist to objects only - it has no mob filter - so anything
 * alive in the room persists. That is acceptable precisely because a home is sealed: whatever a
 * player breeds in there stays in there.
 */
/datum/controller/subsystem/homes/proc/save_home(datum/home_instance/home, mob/user)
	if(isnull(home?.reservation))
		return FALSE
	var/turf/bottom_left = home.reservation.bottom_left_turfs[1]
	var/turf/top_right = home.reservation.top_right_turfs[1]
	if(isnull(bottom_left) || isnull(top_right))
		to_chat(user, span_warning("The console can't get a fix on the walls around you."))
		return FALSE

	// Direct turf contents is exactly what write_map() writes, so it's the honest measure of how
	// big the file is about to be.
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
	// Photograph it while the rooms are still standing - the terminal has to show a player their
	// home before they step into it, when there is nothing loaded left to photograph.
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
