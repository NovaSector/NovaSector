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

/// Asks which of a player's homes to act on, out of the given slots. Skips the question when there
/// is only one to pick. Returns null if there is nothing to pick or the admin backed out.
/proc/prompt_for_home_slot(mob/user, target_ckey, title, list/slots)
	if(!length(slots))
		return null
	if(length(slots) == 1)
		return slots[1]
	var/list/choices = list()
	for(var/slot in slots)
		var/description = SShomes.has_home(target_ckey, slot) ? SShomes.home_display_name(target_ckey, slot) : "(no current record)"
		choices["Slot [slot]: [description]"] = slot
	var/picked = tgui_input_list(user, "Which of [target_ckey]'s homes?", title, choices)
	return isnull(picked) ? null : choices[picked]

/// Every slot holding any file at all for this player, current record or not.
/proc/home_slots_with_files(target_ckey)
	SShomes.adopt_legacy_home(target_ckey)
	var/list/slots = list()
	for(var/slot in 1 to HOME_MAX_SLOTS)
		if(SShomes.slot_has_files(target_ckey, slot))
			slots += slot
	return slots

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

/// Show every home a player has on file, with each one's metadata.
/proc/home_admin_inspect(client/user)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Inspect Home")
	if(!target_ckey)
		return
	var/list/slots = home_slots_with_files(target_ckey)
	if(!length(slots))
		to_chat(user, span_warning("[target_ckey] has no home on file."), confidential = TRUE)
		return

	var/list/lines = list("<b>[target_ckey]</b>: [length(SShomes.filed_slots(target_ckey))] of [CONFIG_GET(number/player_home_slots)] homes claimed")
	for(var/slot in slots)
		lines += ""
		lines += "<b>Slot [slot]: [html_encode(SShomes.home_display_name(target_ckey, slot))]</b>"
		lines += "Current record: [SShomes.has_home(target_ckey, slot) ? "yes" : "no (demolished?)"]"
		lines += "Loaded right now: [isnull(SShomes.get_active_home(target_ckey, slot)) ? "no" : "yes"]"
		lines += "Backup on file: [fexists(SShomes.home_file(target_ckey, slot, "home_backup.dmm")) ? "yes" : "no"]"
		var/list/metadata = SShomes.read_metadata(target_ckey, slot)
		for(var/key in metadata)
			lines += "[key]: [html_encode("[metadata[key]]")]"
	to_chat(user, boxed_message(lines.Join("<br>")), confidential = TRUE)

/// Grants someone a new plot. Primarily used to give the restricted ones. Admins may fill any slot,
/// past the config's limit on what players can claim for themselves.
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

	SShomes.adopt_legacy_home(target_ckey)
	var/list/slot_choices = list()
	for(var/slot in 1 to HOME_MAX_SLOTS)
		var/description = SShomes.has_home(target_ckey, slot) ? "replaces [SShomes.home_display_name(target_ckey, slot)]" : "empty"
		slot_choices["Slot [slot]: [description]"] = slot
	var/picked_slot = tgui_input_list(user.mob, "Which of [target_ckey]'s slots should it go in?", "Grant Home Plot", slot_choices)
	if(isnull(picked_slot))
		return
	var/slot = slot_choices[picked_slot]

	var/replacing = SShomes.has_home(target_ckey, slot)
	if(replacing)
		if(tgui_alert(user.mob, "[target_ckey] already has a home in slot [slot]. Filing a new plan demolishes it, keeping its current record as the backup. Continue?", "Grant Home Plot", list("Demolish and File", "Cancel")) != "Demolish and File")
			return
		var/datum/home_instance/loaded = SShomes.get_active_home(target_ckey, slot)
		if(!isnull(loaded))
			loaded.evict_all()
		var/live = SShomes.home_file(target_ckey, slot)
		if(fexists(live))
			var/backup = SShomes.home_file(target_ckey, slot, "home_backup.dmm")
			fdel(backup)
			fcopy(live, backup)
		SShomes.forget_preview(target_ckey, slot)

	if(!SShomes.write_starter(target_ckey, slot, chosen, user.mob))
		to_chat(user, span_warning("The registry refused to file that plan. Check the runtime log for which gate it tripped."), confidential = TRUE)
		return

	var/what_happened = "filed [target_ckey] a home in slot [slot] from plan '[chosen.name]'[replacing ? ", demolishing the one already on record" : ""]"
	log_admin("[key_name(user)] [what_happened].")
	message_admins("[key_name_admin(user)] [what_happened].")

/// Download one of a player's saved homes as a .dmm.
/proc/home_admin_download(client/user)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Download Home")
	if(!target_ckey)
		return
	var/list/filed = SShomes.filed_slots(target_ckey)
	var/slot = prompt_for_home_slot(user.mob, target_ckey, "Download Home", filed)
	if(isnull(slot))
		if(!length(filed))
			to_chat(user, span_warning("[target_ckey] has no home on file."), confidential = TRUE)
		return
	var/path = SShomes.home_file(target_ckey, slot)
	if(!fexists(path))
		return
	log_admin("[key_name(user)] downloaded [target_ckey] home [slot].")
	DIRECT_OUTPUT(user, ftp(file(path), "[target_ckey]_home_[slot].dmm"))

/// Roll one of a player's homes back to its previous save.
/proc/home_admin_restore_backup(client/user)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Restore Home Backup")
	if(!target_ckey)
		return
	// Includes slots with no current record: a demolished home keeps its backup for exactly this.
	var/list/with_backup = list()
	for(var/slot in home_slots_with_files(target_ckey))
		if(fexists(SShomes.home_file(target_ckey, slot, "home_backup.dmm")))
			with_backup += slot
	var/slot = prompt_for_home_slot(user.mob, target_ckey, "Restore Home Backup", with_backup)
	if(isnull(slot))
		if(!length(with_backup))
			to_chat(user, span_warning("[target_ckey] has no backup on file."), confidential = TRUE)
		return
	var/backup = SShomes.home_file(target_ckey, slot, "home_backup.dmm")
	if(!fexists(backup))
		return

	var/datum/home_instance/loaded = SShomes.get_active_home(target_ckey, slot)
	if(!isnull(loaded))
		loaded.evict_all()
	var/live = SShomes.home_file(target_ckey, slot)
	fdel(live)
	fcopy(backup, live)
	log_admin("[key_name(user)] restored [target_ckey] home [slot] from its backup.")
	message_admins("[key_name_admin(user)] restored [target_ckey] home [slot] from its backup.")

/// Delete one of a player's homes, its backup and its metadata.
/proc/home_admin_wipe(client/user)
	var/target_ckey = prompt_for_home_ckey(user.mob, "Wipe Home")
	if(!target_ckey)
		return
	var/list/slots = home_slots_with_files(target_ckey)
	var/slot = prompt_for_home_slot(user.mob, target_ckey, "Wipe Home", slots)
	if(isnull(slot))
		if(!length(slots))
			to_chat(user, span_warning("[target_ckey] has no home on file."), confidential = TRUE)
		return
	if(tgui_alert(user.mob, "Permanently delete [target_ckey]'s home in slot [slot], its backup and its metadata? Their other homes are untouched. This cannot be undone.", "Wipe Home", list("Wipe", "Cancel")) != "Wipe")
		return

	var/datum/home_instance/loaded = SShomes.get_active_home(target_ckey, slot)
	if(!isnull(loaded))
		loaded.evict_all()
	fdel(SShomes.home_file(target_ckey, slot))
	fdel(SShomes.home_file(target_ckey, slot, "home_backup.dmm"))
	fdel(SShomes.home_file(target_ckey, slot, "home.json"))
	SShomes.forget_preview(target_ckey, slot)
	log_admin("[key_name(user)] wiped [target_ckey] home [slot] entirely.")
	message_admins("[key_name_admin(user)] wiped [target_ckey] home [slot] entirely.")

/// Walks the per-ckey save tree and reports every home with its last save date. Moves any
/// single-home record it finds into slot 1 on the way, as discovering homes always does.
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
			for(var/slot in SShomes.filed_slots(found_ckey))
				var/list/metadata = SShomes.read_metadata(found_ckey, slot)
				rows += "[found_ckey] #[slot] - [html_encode(SShomes.home_display_name(found_ckey, slot, metadata))], last saved [metadata["saved_at"] || "never"], [metadata["object_count"] || 0] objects, from [metadata["starter"] || "unknown"]"
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
