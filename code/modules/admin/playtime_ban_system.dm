#define PLAYTIME_BAN_MAX_REASON_LENGTH 600

/// converts a duration w interval to living playtime minutes
/proc/playtime_duration_to_minutes(duration, interval)
	var/duration_number = isnum(duration) ? duration : text2num(duration)
	if(!duration_number || duration_number < 0)
		return 0

	switch(uppertext(interval))
		if("SECOND")
			return CEILING(duration_number / 60, 1)
		if("MINUTE")
			return CEILING(duration_number, 1)
		if("HOUR")
			return CEILING(duration_number * 60, 1)
		if("DAY")
			return CEILING(duration_number * 24 * 60, 1)
		if("WEEK")
			return CEILING(duration_number * 7 * 24 * 60, 1)
		if("MONTH")
			return CEILING(duration_number * 30 * 24 * 60, 1)
		if("YEAR")
			return CEILING(duration_number * 365 * 24 * 60, 1)

	return CEILING(duration_number, 1)

/proc/get_ckey_playtime_for_type(player_ckey, playtime_type)
	player_ckey = ckey(player_ckey)
	if(!player_ckey || !playtime_type)
		return 0

	var/list/aggregate_jobs = SSjob.experience_jobs_map?[playtime_type]
	var/client/player_client = GLOB.directory[player_ckey]
	if(length(aggregate_jobs))
		if(player_client?.prefs?.exp)
			return max(player_client.calc_exp_type(playtime_type), 0)
		return get_ckey_aggregate_playtime(player_ckey, aggregate_jobs)

	if(player_client?.prefs?.exp)
		return text2num(player_client.prefs.exp[playtime_type]) || 0

	return get_ckey_direct_playtime(player_ckey, playtime_type)

/proc/get_ckey_direct_playtime(player_ckey, playtime_type)
	player_ckey = ckey(player_ckey)
	if(!player_ckey || !playtime_type)
		return 0
	if(!SSdbcore.Connect())
		return 0

	var/datum/db_query/query_playtime = SSdbcore.NewQuery(
		"SELECT minutes FROM [format_table_name("role_time")] WHERE ckey = :ckey AND job = :job",
		list("ckey" = player_ckey, "job" = playtime_type)
	)
	if(!query_playtime.warn_execute())
		qdel(query_playtime)
		return 0

	var/playtime = 0
	if(query_playtime.NextRow())
		playtime = text2num(query_playtime.item[1])
	qdel(query_playtime)
	return playtime

/// gets summed role_time rows for categories like command security or CC
/proc/get_ckey_aggregate_playtime(player_ckey, list/aggregate_jobs)
	player_ckey = ckey(player_ckey)
	if(!player_ckey || !length(aggregate_jobs))
		return 0
	if(!SSdbcore.Connect())
		return 0

	var/list/query_args = list("ckey" = player_ckey)
	var/list/job_args = list()
	var/job_index = 1
	for(var/datum/job/job as anything in aggregate_jobs)
		if(!job?.title)
			continue
		var/arg_name = "job_[job_index++]"
		query_args[arg_name] = job.title
		job_args += ":[arg_name]"

	if(!length(job_args))
		return 0

	var/datum/db_query/query_playtime = SSdbcore.NewQuery(
		"SELECT IFNULL(SUM(minutes), 0) FROM [format_table_name("role_time")] WHERE ckey = :ckey AND job IN ([job_args.Join(", ")])",
		query_args
	)
	if(!query_playtime.warn_execute())
		qdel(query_playtime)
		return 0

	var/playtime = 0
	if(query_playtime.NextRow())
		playtime = text2num(query_playtime.item[1])
	qdel(query_playtime)
	return playtime

/// gets current living playtime in minutes for a ckey
/proc/get_ckey_living_playtime(player_ckey)
	return get_ckey_playtime_for_type(player_ckey, EXP_TYPE_LIVING)

/proc/ensure_playtime_ban_schema()
	var/static/playtime_ban_schema_checked = FALSE
	if(playtime_ban_schema_checked)
		return TRUE
	if(!SSdbcore.Connect())
		return FALSE

	var/table_name = format_table_name("playtime_ban")
	var/datum/db_query/query_playtime_ban_table = SSdbcore.NewQuery({"
		SELECT COUNT(*)
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = DATABASE()
			AND TABLE_NAME = :table_name
	"}, list("table_name" = table_name))
	if(!query_playtime_ban_table.Execute(async = FALSE, log_error = FALSE))
		qdel(query_playtime_ban_table)
		return FALSE

	var/table_exists = FALSE
	if(query_playtime_ban_table.NextRow())
		table_exists = text2num(query_playtime_ban_table.item[1]) > 0
	qdel(query_playtime_ban_table)
	if(!table_exists)
		return FALSE

	var/datum/db_query/query_required_playtime_type = SSdbcore.NewQuery({"
		SELECT COUNT(*)
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = DATABASE()
			AND TABLE_NAME = :table_name
			AND COLUMN_NAME = 'required_playtime_type'
	"}, list("table_name" = table_name))
	if(!query_required_playtime_type.Execute(async = FALSE, log_error = FALSE))
		qdel(query_required_playtime_type)
		return FALSE

	var/has_required_playtime_type = FALSE
	if(query_required_playtime_type.NextRow())
		has_required_playtime_type = text2num(query_required_playtime_type.item[1]) > 0
	qdel(query_required_playtime_type)
	if(has_required_playtime_type)
		playtime_ban_schema_checked = TRUE
		return TRUE

	var/datum/db_query/query_add_required_playtime_type = SSdbcore.NewQuery("ALTER TABLE [table_name] ADD COLUMN `required_playtime_type` VARCHAR(32) NOT NULL DEFAULT 'Living' AFTER `role`")
	if(!query_add_required_playtime_type.Execute(async = FALSE, log_error = FALSE))
		log_sql("Failed to add missing playtime_ban.required_playtime_type column: [query_add_required_playtime_type.ErrorMsg()]")
		qdel(query_add_required_playtime_type)
		return FALSE
	qdel(query_add_required_playtime_type)

	log_sql("Added missing playtime_ban.required_playtime_type column.")
	playtime_ban_schema_checked = TRUE
	return TRUE

/proc/collect_selected_ban_panel_roles(list/href_list, list/error_state, ban_type_name = "Role ban")
	for(var/group_name in get_playtime_ban_panel_group_names())
		href_list.Remove(group_name)
	var/delimiter_pos = href_list.Find("roleban_delimiter")
	if(href_list.len == delimiter_pos)
		error_state += "[ban_type_name] was selected but no roles to ban were selected."
		return list()
	if(delimiter_pos == 0)
		error_state += "roleban_delimiter not found in href. Report this to coders."
		return list()

	var/list/roles_to_ban = list()
	href_list.Cut(1, delimiter_pos + 1)
	for(var/key in href_list)
		roles_to_ban |= key
	return roles_to_ban

/// Gets the playtime-ban cache of the passed client.
/proc/retrieve_playtime_ban_cache(client/player_client)
	if(QDELETED(player_client))
		return

	if(player_client.playtime_ban_cache)
		return player_client.playtime_ban_cache

	var/config_delay = CONFIG_GET(number/blocking_query_timeout) SECONDS
	if(player_client.playtime_ban_cache_start + config_delay < REALTIMEOFDAY)
		return build_playtime_ban_cache(player_client)

	while(player_client && player_client?.playtime_ban_cache_start + config_delay >= REALTIMEOFDAY && !player_client?.playtime_ban_cache)
		stoplag(2)

	return player_client?.playtime_ban_cache || build_playtime_ban_cache(player_client)

/proc/build_playtime_ban_cache(client/player_client)
	if(!SSdbcore.Connect())
		return
	if(QDELETED(player_client))
		return
	if(!ensure_playtime_ban_schema())
		return

	var/current_time = REALTIMEOFDAY
	player_client.playtime_ban_cache_start = current_time

	var/player_ckey = player_client.ckey
	var/is_admin = !!(GLOB.admin_datums[player_ckey] || GLOB.deadmins[player_ckey])
	var/list/playtime_ban_cache = list()

	var/datum/db_query/query_build_playtime_ban_cache = SSdbcore.NewQuery({"
		SELECT role, required_playtime_type, target_playtime
		FROM [format_table_name("playtime_ban")]
		WHERE ckey = :ckey
			AND unbanned_datetime IS NULL
			AND (NOT :must_apply_to_admins OR applies_to_admins = 1)
	"}, list(
		"ckey" = player_ckey,
		"must_apply_to_admins" = is_admin,
	))
	var/query_successful = query_build_playtime_ban_cache.warn_execute()
	if(player_client?.playtime_ban_cache_start == current_time)
		player_client.playtime_ban_cache_start = 0
	if(!query_successful)
		qdel(query_build_playtime_ban_cache)
		return

	while(query_build_playtime_ban_cache.NextRow())
		var/role = query_build_playtime_ban_cache.item[1]
		var/required_playtime_type = query_build_playtime_ban_cache.item[2]
		var/target_playtime = text2num(query_build_playtime_ban_cache.item[3])
		var/current_playtime = get_ckey_playtime_for_type(player_ckey, required_playtime_type)
		var/remaining_playtime = max(0, target_playtime - current_playtime)
		if(!remaining_playtime)
			continue
		var/list/current_entry = playtime_ban_cache[role]
		if(current_entry && text2num(current_entry["remaining_playtime"]) >= remaining_playtime)
			continue
		playtime_ban_cache[role] = list(
			"required_playtime_type" = required_playtime_type,
			"remaining_playtime" = remaining_playtime,
			"target_playtime" = target_playtime,
		)
	qdel(query_build_playtime_ban_cache)

	if(QDELETED(player_client))
		return
	player_client.playtime_ban_cache = playtime_ban_cache
	return playtime_ban_cache

/proc/get_playtime_ban_details(player_key, role)
	if(!player_key || !role)
		return

	var/player_ckey = ckey(player_key)
	var/client/player_client = GLOB.directory[player_ckey]
	if(player_client)
		var/list/playtime_ban_cache = retrieve_playtime_ban_cache(player_client)
		if(!islist(playtime_ban_cache))
			return
		var/list/cached_entry = playtime_ban_cache[role]
		if(!cached_entry)
			return
		var/required_playtime_type = cached_entry["required_playtime_type"]
		var/target_playtime = text2num(cached_entry["target_playtime"])
		var/current_playtime = get_ckey_playtime_for_type(player_ckey, required_playtime_type)
		var/remaining_playtime = max(0, target_playtime - current_playtime)
		if(!remaining_playtime)
			playtime_ban_cache -= role
			return
		return list(
			"required_playtime_type" = required_playtime_type,
			"remaining_playtime" = remaining_playtime,
			"target_playtime" = target_playtime,
		)

	if(!SSdbcore.Connect())
		return
	if(!ensure_playtime_ban_schema())
		return

	var/is_admin = !!(GLOB.admin_datums[player_ckey] || GLOB.deadmins[player_ckey])
	var/datum/db_query/query_check_playtime_ban = SSdbcore.NewQuery({"
		SELECT required_playtime_type, target_playtime
		FROM [format_table_name("playtime_ban")]
		WHERE ckey = :ckey
			AND role = :role
			AND unbanned_datetime IS NULL
			AND (NOT :must_apply_to_admins OR applies_to_admins = 1)
	"}, list(
		"ckey" = player_ckey,
		"role" = role,
		"must_apply_to_admins" = is_admin,
	))
	if(!query_check_playtime_ban.warn_execute())
		qdel(query_check_playtime_ban)
		return

	var/list/best_entry
	while(query_check_playtime_ban.NextRow())
		var/required_playtime_type = query_check_playtime_ban.item[1]
		var/target_playtime = text2num(query_check_playtime_ban.item[2])
		var/current_playtime = get_ckey_playtime_for_type(player_ckey, required_playtime_type)
		var/remaining_playtime = max(0, target_playtime - current_playtime)
		if(!remaining_playtime)
			continue
		if(best_entry && text2num(best_entry["remaining_playtime"]) >= remaining_playtime)
			continue
		best_entry = list(
			"required_playtime_type" = required_playtime_type,
			"remaining_playtime" = remaining_playtime,
			"target_playtime" = target_playtime,
		)
	qdel(query_check_playtime_ban)
	return best_entry

/proc/get_playtime_ban_details_for_roles(player_key, roles)
	if(!player_key || !roles)
		return

	if(!islist(roles))
		roles = list(roles)

	var/list/best_entry
	var/best_role
	for(var/role in roles)
		if(!role)
			continue
		var/list/current_entry = get_playtime_ban_details(player_key, role)
		var/remaining_playtime = text2num(current_entry?["remaining_playtime"])
		if(remaining_playtime <= 0)
			continue
		if(best_entry && text2num(best_entry["remaining_playtime"]) >= remaining_playtime)
			continue
		best_entry = current_entry
		best_role = role

	if(!best_entry)
		return

	var/list/entry_copy = best_entry.Copy()
	entry_copy["role"] = best_role
	return entry_copy

/proc/get_playtime_banned_role(player_key, roles)
	var/list/playtime_ban_details = get_playtime_ban_details_for_roles(player_key, roles)
	return playtime_ban_details?["role"]

/proc/get_playtime_ban_remaining(player_key, role)
	var/list/playtime_ban_details = get_playtime_ban_details(player_key, role)
	return text2num(playtime_ban_details?["remaining_playtime"])

/proc/get_playtime_ban_required_type(player_key, role)
	var/list/playtime_ban_details = get_playtime_ban_details(player_key, role)
	return playtime_ban_details?["required_playtime_type"] || EXP_TYPE_LIVING

/proc/get_playtime_ban_required_experience(player_key, role)
	var/list/playtime_ban_details = get_playtime_ban_details(player_key, role)
	if(!playtime_ban_details)
		return
	var/remaining_playtime = text2num(playtime_ban_details["remaining_playtime"])
	var/required_playtime_type = playtime_ban_details["required_playtime_type"]
	return list(
		"experience_type" = required_playtime_type,
		"required_playtime" = remaining_playtime,
		"required_playtime_text" = DisplayTimeText(remaining_playtime MINUTES),
	)

/proc/get_playtime_ban_unavailable_message(player_key, role, display_role = null)
	var/list/playtime_ban_details = get_playtime_ban_details(player_key, role)
	var/remaining_playtime = text2num(playtime_ban_details?["remaining_playtime"])
	var/required_playtime_type = playtime_ban_details?["required_playtime_type"] || EXP_TYPE_LIVING
	display_role ||= role
	if(remaining_playtime <= 0)
		return "You need more [required_playtime_type] playtime before you can play [display_role]."

	return "You need [DisplayTimeText(remaining_playtime MINUTES)] more [required_playtime_type] playtime before you can play [display_role]."

/proc/get_playtime_ban_requirement_message(player_key, role)
	var/list/playtime_ban_details = get_playtime_ban_details(player_key, role)
	var/remaining_playtime = text2num(playtime_ban_details?["remaining_playtime"])
	var/required_playtime_type = playtime_ban_details?["required_playtime_type"] || EXP_TYPE_LIVING
	if(remaining_playtime <= 0)
		return "More [required_playtime_type] playtime required"

	return "[DisplayTimeText(remaining_playtime MINUTES)] more [required_playtime_type] playtime required"

/datum/admins/proc/playtime_unban_panel_entries(player_key, admin_key, player_ip, player_cid)
	if(player_ip || player_cid)
		return ""
	if(!SSdbcore.Connect())
		return ""
	if(!ensure_playtime_ban_schema())
		return ""

	var/datum/db_query/query_unban_search_playtime_bans = SSdbcore.NewQuery({"
		SELECT
			id,
			bantime,
			round_id,
			role,
			required_playtime_type,
			start_playtime,
			duration,
			target_playtime,
			applies_to_admins,
			reason,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE [format_table_name("player")].ckey = [format_table_name("playtime_ban")].ckey), ckey),
			ckey,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE [format_table_name("player")].ckey = [format_table_name("playtime_ban")].a_ckey), a_ckey),
			unbanned_datetime,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE [format_table_name("player")].ckey = [format_table_name("playtime_ban")].unbanned_ckey), unbanned_ckey),
			unbanned_round_id
		FROM [format_table_name("playtime_ban")]
		WHERE
			(:player_key IS NULL OR ckey = :player_key) AND
			(:admin_key IS NULL OR a_ckey = :admin_key)
		ORDER BY id DESC
		LIMIT 50
	"}, list(
		"player_key" = ckey(player_key) || null,
		"admin_key" = ckey(admin_key) || null,
	))
	if(!query_unban_search_playtime_bans.warn_execute())
		qdel(query_unban_search_playtime_bans)
		return ""

	var/list/output = list()
	var/found_playtime_ban = FALSE
	while(query_unban_search_playtime_bans.NextRow())
		if(!found_playtime_ban)
			found_playtime_ban = TRUE
			output += "<h2>Playtime bans</h2>"

		var/ban_id = query_unban_search_playtime_bans.item[1]
		var/ban_datetime = query_unban_search_playtime_bans.item[2]
		var/ban_round_id = query_unban_search_playtime_bans.item[3]
		var/role = query_unban_search_playtime_bans.item[4]
		var/required_playtime_type = query_unban_search_playtime_bans.item[5]
		var/start_playtime = text2num(query_unban_search_playtime_bans.item[6])
		var/duration = text2num(query_unban_search_playtime_bans.item[7])
		var/target_playtime = text2num(query_unban_search_playtime_bans.item[8])
		var/applies_to_admins = text2num(query_unban_search_playtime_bans.item[9])
		var/reason = query_unban_search_playtime_bans.item[10]
		var/banned_player_key = query_unban_search_playtime_bans.item[11]
		var/banned_player_ckey = query_unban_search_playtime_bans.item[12]
		var/banning_admin_key = query_unban_search_playtime_bans.item[13]
		var/unban_datetime = query_unban_search_playtime_bans.item[14]
		var/unban_key = query_unban_search_playtime_bans.item[15]
		var/unban_round_id = query_unban_search_playtime_bans.item[16]
		var/current_playtime = get_ckey_playtime_for_type(banned_player_ckey, required_playtime_type)
		var/remaining_playtime = max(0, target_playtime - current_playtime)
		var/target = ban_target_string(banned_player_key, null, null)

		output += "<div class='banbox'><div class='header [unban_datetime ? "unbanned" : "banned"]'><b>[target]</b>[applies_to_admins ? " <b>ADMIN</b>" : ""] playtime banned by <b>[banning_admin_key]</b> from <b>[role]</b> on <b>[ban_datetime]</b> during round <b>#[ban_round_id]</b>.<br>"
		output += "Started at <b>[get_exp_format(start_playtime)]</b> [required_playtime_type] playtime and requires <b>[DisplayTimeText(duration MINUTES)]</b> more, ending at <b>[get_exp_format(target_playtime)]</b> [required_playtime_type] playtime."
		if(remaining_playtime)
			output += " <b>[DisplayTimeText(remaining_playtime MINUTES)]</b> remaining."
		else
			output += " <b>Playtime target reached.</b>"
		if(unban_datetime)
			output += "<br>Unbanned by <b>[unban_key]</b> on <b>[unban_datetime]</b> during round <b>#[unban_round_id]</b>."
		output += "</div><div class='container'><div class='reason'>[reason]</div><div class='edit'>"

		if(unban_datetime)
			output += "<a href='byond://?_src_=holder;[HrefToken()];rebanplaytimeid=[ban_id];applies_to_admins=[applies_to_admins];rebankey=[banned_player_key];rebanadminkey=[banning_admin_key];rebanrole=[role]'>Reban</a>"
		else
			output += "<a href='byond://?_src_=holder;[HrefToken()];unbanplaytimeid=[ban_id];unbankey=[banned_player_key];unbanadminkey=[banning_admin_key];unbanrole=[role]'>Unban</a>"
		output += "</div></div></div>"
	qdel(query_unban_search_playtime_bans)

	return output.Join("")

/datum/admins/proc/unban_playtime_ban(ban_id, player_key, role, admin_key)
	if(!check_rights(R_BAN))
		return
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	if(!ensure_playtime_ban_schema())
		to_chat(usr, span_danger("Playtime ban database schema is not available."), confidential = TRUE)
		return

	var/target = ban_target_string(player_key, null, null)
	if(tgui_alert(usr, "Please confirm unban of [target] from playtime ban [role].", "Unban confirmation", list("Yes", "No")) != "Yes")
		return

	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_unban_playtime_ban = SSdbcore.NewQuery({"
		UPDATE [format_table_name("playtime_ban")] SET
			unbanned_datetime = NOW(),
			unbanned_ckey = :admin_ckey,
			unbanned_round_id = :round_id
		WHERE id = :ban_id
	"}, list("ban_id" = ban_id, "admin_ckey" = usr.client.ckey, "round_id" = GLOB.round_id))
	if(!query_unban_playtime_ban.warn_execute())
		qdel(query_unban_playtime_ban)
		return
	qdel(query_unban_playtime_ban)

	log_admin_private("[kn] has unbanned [target] from playtime ban [role].")
	message_admins("[kna] has unbanned [target] from playtime ban [role].")

	var/client/player_client = GLOB.directory[ckey(player_key)]
	if(player_client)
		build_playtime_ban_cache(player_client)
		to_chat(player_client, span_boldannounce("[usr.client.key] has removed a playtime ban from [role] for your key."), confidential = TRUE)
	unban_panel(player_key, admin_key)

/datum/admins/proc/reban_playtime_ban(ban_id, applies_to_admins, player_key, role, admin_key)
	if(!check_rights(R_BAN))
		return
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	if(!ensure_playtime_ban_schema())
		to_chat(usr, span_danger("Playtime ban database schema is not available."), confidential = TRUE)
		return

	var/target = ban_target_string(player_key, null, null)
	if(tgui_alert(usr, "Please confirm undoing of unban of [target] from playtime ban [role].", "Reban confirmation", list("Yes", "No")) != "Yes")
		return

	if(text2num(applies_to_admins) && !can_place_additional_admin_ban(usr.client.ckey))
		return

	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_reban_playtime_ban = SSdbcore.NewQuery({"
		UPDATE [format_table_name("playtime_ban")] SET
			unbanned_datetime = NULL,
			unbanned_ckey = NULL,
			unbanned_round_id = NULL
		WHERE id = :ban_id
	"}, list("ban_id" = ban_id))
	if(!query_reban_playtime_ban.warn_execute())
		qdel(query_reban_playtime_ban)
		return
	qdel(query_reban_playtime_ban)

	log_admin_private("[kn] has rebanned [target] from playtime ban [role].")
	message_admins("[kna] has rebanned [target] from playtime ban [role].")

	var/client/player_client = GLOB.directory[ckey(player_key)]
	if(player_client)
		build_playtime_ban_cache(player_client)
		to_chat(player_client, span_boldannounce("[usr.client.key] has re-activated a removed playtime ban from [role] for your key."), confidential = TRUE)
	unban_panel(player_key, admin_key)

/proc/playtime_ban_source_option(playtime_type, selected_playtime_type)
	return "<option value='[playtime_type]'[playtime_type == selected_playtime_type ? " selected" : ""]>[playtime_type]</option>"

/proc/get_available_playtime_sources()
	var/list/playtime_sources = list()
	var/list/seen = list()
	for(var/playtime_type in list(EXP_TYPE_LIVING, EXP_TYPE_CREW))
		if(seen[playtime_type])
			continue
		seen[playtime_type] = TRUE
		playtime_sources += playtime_type

	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		if(!department.department_experience_type || seen[department.department_experience_type])
			continue
		seen[department.department_experience_type] = TRUE
		playtime_sources += department.department_experience_type

	for(var/datum/job/job as anything in SSjob.joinable_occupations)
		if(seen[job.title])
			continue
		seen[job.title] = TRUE
		playtime_sources += job.title

	return playtime_sources

/proc/playtime_ban_source_options(selected_playtime_type = EXP_TYPE_LIVING)
	var/list/options = list()
	for(var/playtime_type in get_available_playtime_sources())
		options += playtime_ban_source_option(playtime_type, selected_playtime_type)

	return options.Join("")

/proc/is_valid_playtime_ban_source(playtime_type)
	return playtime_type in get_available_playtime_sources()

/proc/get_playtime_ban_target_role_groups()
	var/list/groups = list()

	var/list/antag_roles = get_playtime_ban_antag_roles()
	var/list/ghost_roles = get_playtime_ban_ghost_roles(antag_roles)
	var/list/broad_roles = get_playtime_ban_broad_role_bans()

	if(length(ghost_roles))
		groups["Ghost and Other Roles"] = ghost_roles
	if(length(antag_roles))
		groups["Antagonist Positions"] = antag_roles
	if(length(broad_roles))
		groups["Playtime Ban Options"] = broad_roles

	return groups

/proc/get_playtime_ban_panel_group_names()
	var/list/group_names = list()
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		group_names |= department.department_name
		group_names |= department.label_class
		group_names |= ckey(department.department_name)

	var/list/target_role_groups = get_playtime_ban_target_role_groups()
	for(var/group_name in target_role_groups)
		group_names |= group_name
		group_names |= ckey(group_name)

	return group_names

/proc/get_playtime_ban_antag_roles()
	var/list/antag_roles = list(ROLE_SYNDICATE)
	for(var/antag_role in get_all_antag_flags())
		antag_roles |= antag_role
	for(var/datum/antagonist/antagonist as anything in subtypesof(/datum/antagonist))
		var/pref_flag = initial(antagonist.pref_flag)
		var/jobban_flag = initial(antagonist.jobban_flag)
		if(pref_flag)
			antag_roles |= pref_flag
		if(jobban_flag)
			antag_roles |= jobban_flag
	return sort_list(antag_roles, GLOBAL_PROC_REF(cmp_text_asc))

/// ghost role spawner bans are pulled from their role_ban var so new ghost roles show up automatically- (hopefully)
/proc/get_playtime_ban_ghost_roles(list/known_antag_roles)
	var/list/ghost_roles = list(
		ROLE_BOT,
		ROLE_PAI,
		ROLE_POSIBRAIN,
		ROLE_MIND_TRANSFER,
	)

	for(var/obj/effect/mob_spawn/ghost_role/ghost_role as anything in subtypesof(/obj/effect/mob_spawn/ghost_role))
		var/role_ban = initial(ghost_role.role_ban)
		if(!role_ban || (role_ban in known_antag_roles))
			continue
		ghost_roles |= role_ban

	return sort_list(ghost_roles, GLOBAL_PROC_REF(cmp_text_asc))

/proc/get_playtime_ban_broad_role_bans()
	return list(
		BAN_GHOST_ROLE_SPAWNER,
		BAN_GHOST_TAKEOVER,
		BAN_ANTAGONIST,
	)

/proc/get_playtime_banned_roles_for_panel(player_key)
	var/player_ckey = ckey(player_key)
	if(!player_ckey || !SSdbcore.Connect())
		return list()
	if(!ensure_playtime_ban_schema())
		return list()

	var/datum/db_query/query_get_playtime_banned_roles = SSdbcore.NewQuery({"
		SELECT role, required_playtime_type, target_playtime
		FROM [format_table_name("playtime_ban")]
		WHERE
			ckey = :player_ckey
			AND unbanned_datetime IS NULL
	"}, list("player_ckey" = player_ckey))
	if(!query_get_playtime_banned_roles.warn_execute())
		qdel(query_get_playtime_banned_roles)
		return list()

	var/list/banned_from = list()
	while(query_get_playtime_banned_roles.NextRow())
		var/role = query_get_playtime_banned_roles.item[1]
		var/required_playtime_type = query_get_playtime_banned_roles.item[2]
		var/target_playtime = text2num(query_get_playtime_banned_roles.item[3])
		if(target_playtime > get_ckey_playtime_for_type(player_ckey, required_playtime_type))
			banned_from += role
	qdel(query_get_playtime_banned_roles)
	return banned_from

/proc/render_playtime_ban_department_group(datum/job_department/department, list/banned_from)
	var/list/output = list()
	var/label_class = department.label_class
	var/department_name = department.department_name
	var/group_class = ckey(department_name)
	output += "<div class='column'><label class='rolegroup [label_class] [group_class]'><input type='checkbox' name='[group_class]' class='hidden' onClick='header_click_all_checkboxes(this)'> \
	[department_name]</label><div class='content'>"

	var/break_counter = 0
	for(var/datum/job/job_datum as anything in department.get_jobban_jobs())
		if(break_counter > 0 && (break_counter % 3 == 0))
			output += "<br>"
		break_counter++
		var/job_name = job_datum.title
		if(length(job_datum.departments_list) > 1)
			var/department_index = job_datum.departments_list.Find(department.type)
			if(!department_index)
				stack_trace("Failed to find a department index for [department.type] in the departments_list of [job_datum.type]")
			output += {"<label class='inputlabel checkbox'>[job_name]
				<input type='checkbox' id='[job_name]_[department_index]' name='[job_name]' class='[group_class]' value='1'
				onClick='toggle_other_checkboxes(this, \"[length(job_datum.departments_list)]\", \"[department_index]\")'">
				<div class='inputbox[(job_name in banned_from) ? " banned" : ""]'></div></label>
				"}
		else
			output += {"<label class='inputlabel checkbox'>[job_name]
					<input type='checkbox' name='[job_name]' class='[group_class]' value='1'>
					<div class='inputbox[(job_name in banned_from) ? " banned" : ""]'></div></label>
					"}

	output += "</div></div>"
	return output.Join("")

/proc/render_playtime_ban_role_group(group_name, list/roles, list/banned_from)
	var/list/output = list()
	var/group_class = ckey(group_name)
	output += "<div class='column'><label class='rolegroup long [group_class]'><input type='checkbox' name='[group_class]' class='hidden' onClick='header_click_all_checkboxes(this)'>[group_name]</label><div class='content'>"
	var/break_counter = 0
	for(var/role in roles)
		if(!role)
			continue
		if(break_counter > 0 && (break_counter % 10 == 0))
			output += "<br>"
		output += {"<label class='inputlabel checkbox'>[role]
					<input type='checkbox' name='[role]' class='[group_class]' value='1'>
					<div class='inputbox[(role in banned_from) ? " banned" : ""]'></div></label>
		"}
		break_counter++
	output += "</div></div>"
	return output.Join("")

/datum/admins/proc/playtime_ban_panel(player_key, player_ip, player_cid, duration = 1, required_playtime_type = EXP_TYPE_LIVING, applies_to_admins, reason)
	if(!check_rights(R_BAN))
		return

	var/datum/browser/panel = new(usr, "playtimebanpanel", "Playtime Banning Panel", 910, 620)
	panel.add_stylesheet("admin_panelscss", 'html/admin/admin_panels.css')
	panel.add_stylesheet("banpanelcss", 'html/admin/banpanel.css')
	panel.add_stylesheet("admin_panelscss3", 'html/admin/admin_panels_css3.css')
	panel.add_script("banpaneljs", 'html/admin/banpanel.js')

	var/list/banned_from = get_playtime_banned_roles_for_panel(player_key)
	var/list/output = list("<form method='get' action='?src=[REF(src)]'>[HrefTokenFormField()]")
	output += {"<input type='hidden' name='src' value='[REF(src)]'>
	<input type='hidden' name='playtimeban' value='1'>
	<label class='inputlabel checkbox'>Key:
	<input type='checkbox' id='keycheck' name='keycheck' value='1'[player_key ? " checked": ""]>
	<div class='inputbox'></div></label>
	<input type='text' name='keytext' size='26' value='[player_key]'>
	<label class='inputlabel checkbox'>IP:
	<input type='checkbox' id='ipcheck' name='ipcheck' value='1'[player_ip ? " checked" : ""]>
	<div class='inputbox'></div></label>
	<input type='text' name='iptext' size='18' value='[player_ip]'>
	<label class='inputlabel checkbox'>CID:
	<input type='checkbox' id='cidcheck' name='cidcheck' value='1'[player_cid ? " checked" : ""]>
	<div class='inputbox'></div></label>
	<input type='text' name='cidtext' size='14' value='[player_cid]'>
	<br>
	<label class='inputlabel checkbox'>Use IP and CID from last connection of key
	<input type='checkbox' id='lastconn' name='lastconn' value='1' [(!player_ip || !player_cid) ? " checked": ""]>
	<div class='inputbox'></div></label>
	<label class='inputlabel checkbox'>Applies to Admins
	<input type='checkbox' id='applyadmins' name='applyadmins' value='1'[applies_to_admins ? " checked": ""]>
	<div class='inputbox'></div></label>
	<input type='submit' value='Submit'>
	<br>
	<div class='row'>
		<div class='column left'>
			Playtime Required
			<br>
			<input type='text' name='duration' size='7' value='[duration]'>
			<div class="select">
				<select name='intervaltype'>
					<option value='MINUTE'>Minutes</option>
					<option value='HOUR' selected>Hours</option>
					<option value='DAY'>Days</option>
					<option value='WEEK'>Weeks</option>
					<option value='MONTH'>Months</option>
					<option value='YEAR'>Years</option>
				</select>
			</div>
		</div>
		<div class='column middle playtimesource'>
			Playtime Source
			<br>
			<div class="select">
				<select name='requiredplaytimetype'>
					[playtime_ban_source_options(required_playtime_type)]
				</select>
			</div>
		</div>
		<div class='column right'>
			Severity
			<br>
			<label class='inputlabel radio'>None
			<input type='radio' id='none' name='radioseverity' value='none'>
			<div class='inputbox'></div></label>
			<label class='inputlabel radio'>Medium
			<input type='radio' id='medium' name='radioseverity' value='medium'>
			<div class='inputbox'></div></label>
			<br>
			<label class='inputlabel radio'>Minor
			<input type='radio' id='minor' name='radioseverity' value='minor'>
			<div class='inputbox'></div></label>
			<label class='inputlabel radio'>High
			<input type='radio' id='high' name='radioseverity' value='high'>
			<div class='inputbox'></div></label>
		</div>
		<div class='column'>
			Reason
			<br>
			<textarea class='reason' name='reason' maxlength='[PLAYTIME_BAN_MAX_REASON_LENGTH]'>[reason]</textarea>
		</div>
	</div>
	<input type='hidden' name='roleban_delimiter' value='1'>
	"}

	output += "<div class='row playtimeroles'>"
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		output += render_playtime_ban_department_group(department, banned_from)

	var/list/target_role_groups = get_playtime_ban_target_role_groups()
	for(var/group_name in target_role_groups)
		output += render_playtime_ban_role_group(group_name, target_role_groups[group_name], banned_from)

	output += "</div></form>"
	panel.set_content(output.Join())
	panel.open()

/datum/admins/proc/playtime_ban_parse_href(list/href_list)
	if(!check_rights(R_BAN))
		return
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return

	var/list/error_state = list()
	var/player_key = href_list["keytext"]
	var/player_ip = href_list["iptext"]
	var/player_cid = href_list["cidtext"]
	var/use_last_connection = !!href_list["lastconn"]
	var/applies_to_admins = !!href_list["applyadmins"]
	var/duration = text2num(href_list["duration"])
	var/interval = href_list["intervaltype"]
	var/severity = href_list["radioseverity"]
	var/reason = href_list["reason"]
	var/required_playtime_type = href_list["requiredplaytimetype"] || EXP_TYPE_LIVING

	if(!player_key)
		error_state += "Playtime bans require a key."
	if(!duration)
		error_state += "Playtime bans require a playtime amount."
	if(!reason)
		error_state += "Playtime bans require a reason."
	if(!is_valid_playtime_ban_source(required_playtime_type))
		error_state += "Invalid required playtime source."
	if(!(interval in list("SECOND", "MINUTE", "HOUR", "DAY", "WEEK", "MONTH", "YEAR")))
		interval = "HOUR"

	var/list/roles_to_ban = collect_selected_ban_panel_roles(href_list, error_state, "Playtime ban")
	if(required_playtime_type in roles_to_ban)
		error_state += "The required playtime source cannot be one of the roles being blocked."

	if(error_state.len)
		tgui_alert(usr, error_state.Join("\n"), "Error")
		return

	create_playtime_ban(player_key, !!href_list["ipcheck"], player_ip, !!href_list["cidcheck"], player_cid, use_last_connection, applies_to_admins, duration, interval, severity, reason, roles_to_ban, required_playtime_type)

/datum/admins/proc/create_playtime_ban(player_key, ip_check, player_ip, cid_check, player_cid, use_last_connection, applies_to_admins, duration, interval, severity, reason, list/roles_to_ban, required_playtime_type = EXP_TYPE_LIVING)
	if(!check_rights(R_BAN))
		return
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	if(!ensure_playtime_ban_schema())
		to_chat(usr, span_danger("Playtime ban database schema is not available."), confidential = TRUE)
		return

	var/player_ckey = ckey(player_key)
	if(!player_ckey)
		to_chat(usr, span_danger("Playtime bans require a valid player key."), confidential = TRUE)
		return

	var/datum/db_query/query_create_playtime_ban_get_player = SSdbcore.NewQuery({"
		SELECT byond_key, INET_NTOA(ip), computerid
		FROM [format_table_name("player")]
		WHERE ckey = :player_ckey
	"}, list("player_ckey" = player_ckey))
	if(!query_create_playtime_ban_get_player.warn_execute())
		qdel(query_create_playtime_ban_get_player)
		return
	if(query_create_playtime_ban_get_player.NextRow())
		player_key = query_create_playtime_ban_get_player.item[1]
		if(use_last_connection)
			if(ip_check)
				player_ip = query_create_playtime_ban_get_player.item[2]
			if(cid_check)
				player_cid = query_create_playtime_ban_get_player.item[3]
	else if(tgui_alert(usr, "[player_key]/([player_ckey]) has not been seen before, are you sure you want to create a playtime ban for them?", "Unknown key", list("Yes", "No", "Cancel")) != "Yes")
		qdel(query_create_playtime_ban_get_player)
		return
	qdel(query_create_playtime_ban_get_player)

	var/admin_ckey = usr.client.ckey
	if(applies_to_admins && !can_place_additional_admin_ban(admin_ckey))
		return

	var/duration_minutes = playtime_duration_to_minutes(duration, interval)
	if(duration_minutes <= 0)
		to_chat(usr, span_danger("Playtime ban duration must be greater than zero."), confidential = TRUE)
		return

	if(!is_valid_playtime_ban_source(required_playtime_type))
		to_chat(usr, span_danger("Invalid required playtime source."), confidential = TRUE)
		return

	var/current_required_playtime = get_ckey_playtime_for_type(player_ckey, required_playtime_type) || 0
	var/target_playtime = current_required_playtime + duration_minutes
	var/time_message = DisplayTimeText(duration_minutes MINUTES)
	var/admin_ip = usr.client.address
	var/admin_cid = usr.client.computer_id
	var/list/clients_online = GLOB.clients.Copy()
	var/list/admins_online = list()
	for(var/client/client_online in clients_online)
		if(client_online.holder)
			admins_online += client_online
	var/who = clients_online.Join(", ")
	var/adminwho = admins_online.Join(", ")
	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)

	var/list/special_columns = list(
		"bantime" = "NOW()",
		"server_ip" = "INET_ATON(?)",
		"a_ip" = "INET_ATON(?)",
	)
	var/list/sql_playtime_bans = list()
	for(var/role in roles_to_ban)
		sql_playtime_bans += list(list(
			"server_name" = CONFIG_GET(string/serversqlname),
			"server_ip" = world.internet_address || 0,
			"server_port" = world.port,
			"round_id" = GLOB.round_id,
			"role" = role,
			"required_playtime_type" = required_playtime_type,
			"start_playtime" = current_required_playtime,
			"duration" = duration_minutes,
			"target_playtime" = target_playtime,
			"applies_to_admins" = applies_to_admins,
			"reason" = reason,
			"ckey" = player_ckey,
			"a_ckey" = admin_ckey,
			"a_ip" = admin_ip || null,
			"a_computerid" = admin_cid,
			"who" = who,
			"adminwho" = adminwho,
		))

	if(!SSdbcore.MassInsert(format_table_name("playtime_ban"), sql_playtime_bans, warn = TRUE, special_columns = special_columns))
		return

	var/target = ban_target_string(player_key, player_ip, player_cid)
	var/msg = "has created a playtime ban requiring [time_message] more [required_playtime_type] playtime for [target] from [roles_to_ban.len] roles."
	log_admin_private("[kn] [msg] Roles: [roles_to_ban.Join(", ")] Reason: [reason]")
	message_admins("[kna] [msg] Roles: [roles_to_ban.Join("\n")]\nReason: [reason]")
	if(applies_to_admins)
		send2adminchat("BAN ALERT", "[kn] [msg]")

	var/note_reason = "Playtime banned from Roles: [roles_to_ban.Join(", ")] until [get_exp_format(target_playtime)] [required_playtime_type] playtime ([time_message] from [get_exp_format(current_required_playtime)]) - [reason]"
	create_message("note", player_ckey, admin_ckey, note_reason, null, null, 0, 0, null, 0, severity)

	var/client/player_client = GLOB.directory[player_ckey]
	if(player_client)
		build_playtime_ban_cache(player_client)
		to_chat(player_client, span_boldannounce("You have been playtime banned by [usr.client.key] from Roles: [roles_to_ban.Join(", ")].\nReason: [reason]</span><br>[span_danger("This ban will be removed after [time_message] more [required_playtime_type] playtime. The round ID is [GLOB.round_id].")]"), confidential = TRUE)

	admin_ticket_log(player_ckey, "[kna] [msg]", FALSE)

#undef PLAYTIME_BAN_MAX_REASON_LENGTH
