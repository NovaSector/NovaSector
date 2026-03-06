#define WHITELISTFILE "[global.config.directory]/whitelist.txt"

GLOBAL_LIST_EMPTY(whitelist)
GLOBAL_PROTECT(whitelist)

/**
 * Loads the whitelist. Tries to load it from the database if enabled, otherwise will load it
 * from the legacy `whitelist.txt` file as normal.
 */
/proc/load_whitelist()
	GLOB.whitelist = list()

	if(!CONFIG_GET(flag/sql_whitelist))
		load_whitelist_legacy()
		return

	if(!SSdbcore.Connect())
		log_config("Could not connect to the database to load the whitelist, reverting to legacy whitelist.txt file!")
		load_whitelist_legacy()
		return

	var/datum/db_query/query_load_whitelist = SSdbcore.NewQuery(
		"SELECT ckey, revoked FROM [format_table_name("whitelist")]"
	)

	if(!query_load_whitelist.Execute())
		qdel(query_load_whitelist)
		return

	while(query_load_whitelist.NextRow())
		var/revoked = query_load_whitelist.item[2]
		if(revoked) // Don't add revoked whitelist entries to the whitelist
			continue

		GLOB.whitelist[query_load_whitelist.item[1]] = TRUE

	qdel(query_load_whitelist)


/**
 * Loads the whitelist with the legacy way of loading it (from the `whitelist.txt` file).
 */
/proc/load_whitelist_legacy()
	for(var/line in world.file2list(WHITELISTFILE))
		if(!line)
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		GLOB.whitelist[ckey(line)] = TRUE


/**
 * Checks whether someone's whitelisted or not.
 * Will return `FALSE` if the whitelist hasn't been loaded yet (which shouldn't normally happen).
 *
 * Returns `TRUE` if they are, `null` or `FALSE` if not.
 */
/proc/check_whitelist(ckey)
	if(!GLOB.whitelist || !GLOB.whitelist.len)
		return FALSE

	return GLOB.whitelist[ckey]


ADMIN_VERB(add_whitelist, R_ADMIN, "Add Whitelist", "Adds a given ckey to the whitelist, allowing them access to the server.", ADMIN_CATEGORY_MAIN)
	if(!SSdbcore.Connect())
		to_chat(user, span_warning("Couldn't connect to the SQL database!"))
		return

	var/ckey_to_whitelist = input(user, "Enter a ckey to add to the whitelist.", "Ckey Input") as text|null
	ckey_to_whitelist = ckey(ckey_to_whitelist)
	if(!ckey_to_whitelist)
		return

	var/datum/db_query/query_add_whitelist = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("whitelist")] (ckey) VALUES(:ckey) ON DUPLICATE KEY UPDATE revoked = 0",
		list("ckey" = ckey_to_whitelist)
	)

	if(!query_add_whitelist.warn_execute())
		qdel(query_add_whitelist)
		return

	qdel(query_add_whitelist)
	GLOB.whitelist[ckey_to_whitelist] = TRUE
	log_admin("[key_name(user)] has added [ckey_to_whitelist] to the whitelist.")
	message_admins("[key_name_admin(user)] has added [ckey_to_whitelist] to the whitelist.")
	BLACKBOX_LOG_ADMIN_VERB("Add Whitelist")


ADMIN_VERB_CUSTOM_EXIST_CHECK(add_whitelist)
	return CONFIG_GET(flag/usewhitelist) && CONFIG_GET(flag/sql_enabled) && CONFIG_GET(flag/sql_whitelist)


/* TODO: Discuss this and which permissions should be tied to it, since this is equivalent to banning someone, but is a lot less obvious.
ADMIN_VERB(revoke_whitelist, R_BAN, "Revoke Whitelist", "Revokes a given's ckey's whitelist access, effectively preventing them from playing on the server.", ADMIN_CATEGORY_MAIN)
	if(!SSdbcore.Connect())
		to_chat(user, span_warning("Couldn't connect to the SQL database!"))
		return

	var/ckey_to_revoke = input(user, "Enter a ckey to revoke whitelist access from.", "Ckey Input") as text|null
	ckey_to_revoke = ckey(ckey_to_revoke)
	if(!ckey_to_revoke)
		return

	var/datum/db_query/query_revoke_whitelist = SSdbcore.NewQuery(
		"UPDATE [format_table_name("whitelist")] SET `revoked` = 0 WHERE ckey = :ckey",
		list("ckey" = ckey_to_revoke)
	)

	if(!query_revoke_whitelist.Execute())
		qdel(query_revoke_whitelist)
		to_chat(user, span_danger("[ckey_to_revoke] wasn't in the whitelist."))
		return

	qdel(query_revoke_whitelist)
	GLOB.whitelist[ckey_to_revoke] = FALSE
	log_admin("[key_name(user)] has revoked [ckey_to_revoke]'s whitelist status.")
	message_admins("[key_name_admin(user)] has revoked  [ckey_to_revoke]'s whitelist status.")
	BLACKBOX_LOG_ADMIN_VERB("Revoke Whitelist")


ADMIN_VERB_CUSTOM_EXIST_CHECK(revoke_whitelist)
	return CONFIG_GET(flag/usewhitelist) && CONFIG_GET(flag/sql_enabled) && CONFIG_GET(flag/sql_whitelist)
*/


/datum/tgs_chat_command/add_whitelist
	name = "whitelist"
	help_text = "whitelist <ckey>"
	admin_only = TRUE


/datum/tgs_chat_command/add_whitelist/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(flag/usewhitelist))
		return new /datum/tgs_message_content("This feature only works if the whitelist is enabled!")

	if(!CONFIG_GET(flag/sql_enabled))
		return new /datum/tgs_message_content("This feature requires a SQL database!")

	if(!CONFIG_GET(flag/sql_whitelist))
		return new /datum/tgs_message_content("This feature is unavailable for the legacy whitelist system and requires the SQL-based whitelist to be enabled instead!")

	var/ckey_to_whitelist = ckey(params)

	var/datum/db_query/query_add_whitelist = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("whitelist")] (ckey) VALUES(:ckey) ON DUPLICATE KEY UPDATE revoked = 0",
		list("ckey" = ckey_to_whitelist)
	)

	if(!query_add_whitelist.Execute())
		qdel(query_add_whitelist)
		return new /datum/tgs_message_content("A SQL error occurred during this operation, report this ASAP.")

	qdel(query_add_whitelist)

	GLOB.whitelist[ckey_to_whitelist] = TRUE

	log_admin("[sender.friendly_name] has added [ckey_to_whitelist] to the whitelist.")
	message_admins("[sender.friendly_name] has added [ckey_to_whitelist] to the whitelist.")
	return new /datum/tgs_message_content("[ckey_to_whitelist] has been added to the whitelist.")


#undef WHITELISTFILE
