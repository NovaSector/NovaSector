/datum/preferences/proc/migrate_nova(list/nova_data)
	if(features["flavor_text"])
		write_preference(GLOB.preference_entries[/datum/preference/text/flavor_text], features["flavor_text"])

	var/ooc_prefs = nova_data["ooc_prefs"]
	if(ooc_prefs)
		write_preference(GLOB.preference_entries[/datum/preference/text/ooc_notes], ooc_prefs)

	var/list/mutant_colors = list()
	/// Intensive checking to ensure this process does not runtime. If it runtimes, goodbye savefiles.
	if(features["FEATURE_MUTANT_COLOR"])
		mutant_colors += sanitize_hexcolor(features["FEATURE_MUTANT_COLOR"])
	else
		mutant_colors += "#[random_color()]"

	if(features["FEATURE_MUTANT_COLOR_TWO"])
		mutant_colors += sanitize_hexcolor(features["FEATURE_MUTANT_COLOR_TWO"])
	else
		mutant_colors += "#[random_color()]"

	if(features["FEATURE_MUTANT_COLOR_THREE"])
		mutant_colors += sanitize_hexcolor(features["FEATURE_MUTANT_COLOR_TWO"])
	else
		mutant_colors += "#[random_color()]"

	write_preference(GLOB.preference_entries[/datum/preference/tri_color/mutant_colors], mutant_colors)

	to_chat(parent, boxed_message(span_greentext("Preference migration successful! You may safely interact with the preferences menu.")))
	tgui_prefs_migration = TRUE
	nova_data["tgui_prefs_migration"] = tgui_prefs_migration

/datum/preferences/proc/migrate_mentor()
	write_preference(GLOB.preference_entries[/datum/preference/toggle/admin/auto_dementor], FALSE) // Someone thought it was a good idea to make it start at true :)
