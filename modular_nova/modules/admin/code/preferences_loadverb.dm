ADMIN_VERB(import_preferences, R_ADMIN, "Import Preferences", "Upload a character preferences JSON file to the server.", ADMIN_CATEGORY_MAIN)
	var/jsonfile = input(user, "Choose a JSON file to upload to replace a player save", "Import Preferences") as null|file
	if(!jsonfile)
		return
	// Prevent simple mistakes
	if(copytext("[jsonfile]", -5) != ".json")
		to_chat(user, span_warning("Filename must end in '.json': [jsonfile]"), confidential = TRUE)
		return
	var/player_key = input(user, "Enter player CKey to replace their save file", "Enter Player CKey")  as null|text
	if(isnull(player_key))
		return
	player_key = LOWER_TEXT(player_key)

	// Pre-parse the uploaded file to ensure valid JSON syntax
	var/new_save = file2text(file(jsonfile))
	var/json_tree
	try
		json_tree = json_decode(new_save)
	catch(var/exception/err)
		log_admin("Failed to parse json savefile: [err]")
		message_admins("Failed to parse json savefile: [err]")
		return

	// Delete the existing file if it exists, and save the new file as text
	var/savepath = "data/player_saves/[player_key[1]]/[player_key]/preferences.json"
	var/bacpath = savepath + ".updatebac"
	fdel(savepath)
	fdel(bacpath)
	text2file(json_encode(json_tree), file(savepath))

	// Reset existing datum so it gets reloaded from the new file
	if(!isnull(GLOB.preferences_datums[player_key]))
		GLOB.preferences_datums[player_key] = null

	to_chat(user, span_danger("Successfully imported new preferences for player [player_key]"), confidential = TRUE)
	log_admin("[key_name_admin(user)] has successfully imported new preferences for player [player_key].")
	message_admins("[key_name_admin(user)] has successfully imported new preferences for player [player_key].")

	var/client/target_client = GLOB.directory[player_key]
	if(!target_client)
		return

	// Kick to clear all GUIs and reset old prefs data. Prevents old prefs from being used
	to_chat(target_client, span_danger("Kicked to finish preference file importing. Please re-connect to the server."), confidential = TRUE)
	qdel(target_client)
	log_admin("Kicked [player_key] to complete preference file importing.")
	message_admins("Kicked [player_key] to complete preference file importing.")
