/// Asks for a ckey and normalises it, so admins can type it however they remember it.
/proc/prompt_for_home_ckey(mob/user, title)
	var/typed = tgui_input_text(user, "Which player's home?", title, max_length = MAX_NAME_LEN)
	if(!typed)
		return null
	return ckey(typed)

ADMIN_VERB(player_home_inspect, R_ADMIN, "Player Homes - Inspect", "Show a player's home record and its metadata.", ADMIN_CATEGORY_DEBUG)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Inspect Home")
	if(!target_ckey)
		return
	if(!SShomes.has_home(target_ckey))
		to_chat(user, span_warning("[target_ckey] has no home on file."), confidential = TRUE)
		return

	var/list/metadata = SShomes.read_metadata(target_ckey)
	var/list/lines = list("<b>[target_ckey]</b>")
	lines += "Loaded right now: [isnull(SShomes.active_homes[target_ckey]) ? "no" : "yes"]"
	lines += "Backup on file: [fexists(SShomes.home_file(target_ckey, "home_backup.dmm")) ? "yes" : "no"]"
	for(var/key in metadata)
		lines += "[key]: [metadata[key]]"
	to_chat(user, boxed_message(lines.Join("<br>")), confidential = TRUE)

ADMIN_VERB(player_home_download, R_ADMIN, "Player Homes - Download", "Download a player's saved home as a .dmm.", ADMIN_CATEGORY_DEBUG)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Download Home")
	if(!target_ckey)
		return
	var/path = SShomes.home_file(target_ckey)
	if(!fexists(path))
		to_chat(user, span_warning("[target_ckey] has no home on file."), confidential = TRUE)
		return
	log_admin("[key_name(user)] downloaded [target_ckey] home record.")
	DIRECT_OUTPUT(user, ftp(file(path), "[target_ckey]_home.dmm"))

ADMIN_VERB(player_home_wipe, R_ADMIN, "Player Homes - Wipe", "Delete a player's home, backup and all.", ADMIN_CATEGORY_DEBUG)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Wipe Home")
	if(!target_ckey)
		return
	if(tgui_alert(user.mob, "Permanently delete [target_ckey] home, its backup and its metadata? This cannot be undone.", "Wipe Home", list("Wipe", "Cancel")) != "Wipe")
		return

	var/datum/home_instance/loaded = SShomes.active_homes[target_ckey]
	if(!isnull(loaded))
		loaded.evict_all()
	fdel(SShomes.home_file(target_ckey))
	fdel(SShomes.home_file(target_ckey, "home_backup.dmm"))
	fdel(SShomes.home_file(target_ckey, "home.json"))
	SShomes.forget_preview(target_ckey)
	log_admin("[key_name(user)] wiped [target_ckey] home record entirely.")
	message_admins("[key_name_admin(user)] wiped [target_ckey] home record entirely.")

ADMIN_VERB(player_home_restore_backup, R_ADMIN, "Player Homes - Restore Backup", "Roll a player's home back to its previous save.", ADMIN_CATEGORY_DEBUG)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Restore Home Backup")
	if(!target_ckey)
		return
	var/backup = SShomes.home_file(target_ckey, "home_backup.dmm")
	if(!fexists(backup))
		to_chat(user, span_warning("[target_ckey] has no backup on file."), confidential = TRUE)
		return

	var/datum/home_instance/loaded = SShomes.active_homes[target_ckey]
	if(!isnull(loaded))
		loaded.evict_all()
	var/live = SShomes.home_file(target_ckey)
	fdel(live)
	fcopy(backup, live)
	log_admin("[key_name(user)] restored [target_ckey] home from its backup.")
	message_admins("[key_name_admin(user)] restored [target_ckey] home from its backup.")

/// Walks the per-ckey save tree and reports every home with its last save date. Disk is the running
/// cost of this feature and nothing else on the server will tell you what it is being spent on.
ADMIN_VERB(player_homes_audit, R_ADMIN, "Player Homes - Audit Disk", "List every stored home and when it was last saved.", ADMIN_CATEGORY_DEBUG)
	if(tgui_alert(user.mob, "This walks every player save folder on disk and can take a while. Continue?", "Audit Player Homes", list("Audit", "Cancel")) != "Audit")
		return

	var/list/rows = list()
	for(var/letter in flist("data/player_saves/"))
		if(copytext(letter, -1) != "/")
			continue
		for(var/player_folder in flist("data/player_saves/[letter]"))
			if(copytext(player_folder, -1) != "/")
				continue
			var/found_ckey = copytext(player_folder, 1, -1)
			if(!SShomes.has_home(found_ckey))
				continue
			var/list/metadata = SShomes.read_metadata(found_ckey)
			rows += "[found_ckey] - last saved [metadata["saved_at"] || "never"], [metadata["object_count"] || 0] objects, from [metadata["starter"] || "unknown"]"
			CHECK_TICK

	if(!length(rows))
		to_chat(user, span_notice("No stored homes found."), confidential = TRUE)
		return
	rows = sort_list(rows)
	to_chat(user, boxed_message("<b>[length(rows)] stored homes</b><br>[rows.Join("<br>")]"), confidential = TRUE)
