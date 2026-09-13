/*
 * Admin tooling for stored homes.
 */

#define HOME_ACTION_INSPECT "Inspect a home"
#define HOME_ACTION_GRANT "Grant a plot"
#define HOME_ACTION_DOWNLOAD "Download as .dmm"
#define HOME_ACTION_RESTORE "Restore backup"
#define HOME_ACTION_WIPE "Wipe a home"
#define HOME_ACTION_AUDIT "Audit disk usage"

/// Asks for a ckey and normalises it, so admins can type it however they remember it.
/proc/prompt_for_home_ckey(mob/user, title)
	var/typed = tgui_input_text(user, "Which player's home?", title, max_length = MAX_NAME_LEN)
	if(!typed)
		return null
	return ckey(typed)

ADMIN_VERB(player_homes, R_ADMIN, "Player Homes", "Inspect, grant, download, restore, wipe and audit stored homes.", ADMIN_CATEGORY_DEBUG)
	var/static/list/actions = list(
		HOME_ACTION_INSPECT,
		HOME_ACTION_GRANT,
		HOME_ACTION_DOWNLOAD,
		HOME_ACTION_RESTORE,
		HOME_ACTION_WIPE,
		HOME_ACTION_AUDIT,
	)
	var/choice = tgui_input_list(user.mob, "What would you like to do?", "Player Homes", actions)
	if(isnull(choice))
		return

	switch(choice)
		if(HOME_ACTION_INSPECT)
			home_admin_inspect(user)
		if(HOME_ACTION_GRANT)
			home_admin_grant(user)
		if(HOME_ACTION_DOWNLOAD)
			home_admin_download(user)
		if(HOME_ACTION_RESTORE)
			home_admin_restore_backup(user)
		if(HOME_ACTION_WIPE)
			home_admin_wipe(user)
		if(HOME_ACTION_AUDIT)
			home_admin_audit(user)

/// Show a player's home record and its metadata.
/proc/home_admin_inspect(client/user)
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

/// Grants someone a new plot. Primarily used to give the restricted ones.
/proc/home_admin_grant(client/user)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Grant Home Plot")
	if(!target_ckey)
		return

	var/list/choices = list()
	for(var/starter_name in sort_list(SShomes.starter_templates))
		var/datum/map_template/home/starter = SShomes.starter_templates[starter_name]
		choices["[starter.name] - [starter.width]x[starter.height][starter.admin_only ? " (restricted)" : ""]"] = starter
	if(!length(choices))
		to_chat(user, span_warning("No home plans are registered."), confidential = TRUE)
		return

	var/picked = tgui_input_list(user.mob, "Which plan should [target_ckey] be filed into?", "Grant Home Plot", choices)
	if(isnull(picked))
		return
	var/datum/map_template/home/chosen = choices[picked]
	if(isnull(chosen))
		return

	var/replacing = SShomes.has_home(target_ckey)
	if(replacing)
		if(tgui_alert(user.mob, "[target_ckey] already has a home on file. Filing a new plan demolishes it, keeping their current record as the backup. Continue?", "Grant Home Plot", list("Demolish and File", "Cancel")) != "Demolish and File")
			return
		var/datum/home_instance/loaded = SShomes.active_homes[target_ckey]
		if(!isnull(loaded))
			loaded.evict_all()
		var/live = SShomes.home_file(target_ckey)
		if(fexists(live))
			var/backup = SShomes.home_file(target_ckey, "home_backup.dmm")
			fdel(backup)
			fcopy(live, backup)
		SShomes.forget_preview(target_ckey)

	if(!SShomes.write_starter(target_ckey, chosen, user.mob))
		to_chat(user, span_warning("The registry refused to file that plan. Check the runtime log for which gate it tripped."), confidential = TRUE)
		return

	var/what_happened = "filed [target_ckey] a home from plan '[chosen.name]'[replacing ? ", demolishing the one already on record" : ""]"
	log_admin("[key_name(user)] [what_happened].")
	message_admins("[key_name_admin(user)] [what_happened].")

/// Download a player's saved home as a .dmm.
/proc/home_admin_download(client/user)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Download Home")
	if(!target_ckey)
		return
	var/path = SShomes.home_file(target_ckey)
	if(!fexists(path))
		to_chat(user, span_warning("[target_ckey] has no home on file."), confidential = TRUE)
		return
	log_admin("[key_name(user)] downloaded [target_ckey] home record.")
	DIRECT_OUTPUT(user, ftp(file(path), "[target_ckey]_home.dmm"))

/// Roll a player's home back to its previous save.
/proc/home_admin_restore_backup(client/user)
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

/// Delete a player's home and backup.
/proc/home_admin_wipe(client/user)
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

/// Walks the per-ckey save tree and reports every home with its last save date.
/proc/home_admin_audit(client/user)
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

#undef HOME_ACTION_INSPECT
#undef HOME_ACTION_GRANT
#undef HOME_ACTION_DOWNLOAD
#undef HOME_ACTION_RESTORE
#undef HOME_ACTION_WIPE
#undef HOME_ACTION_AUDIT
