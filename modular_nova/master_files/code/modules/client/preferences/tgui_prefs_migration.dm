/datum/preferences/proc/migrate_nova(list/nova_data)
	var/ooc_prefs = nova_data["ooc_prefs"]
	if(ooc_prefs)
		write_preference(GLOB.preference_entries[/datum/preference/text/ooc_notes], ooc_prefs)

	to_chat(parent, boxed_message(span_greentext("Preference migration successful! You may safely interact with the preferences menu.")))
	tgui_prefs_migration = TRUE
	nova_data["tgui_prefs_migration"] = tgui_prefs_migration

/datum/preferences/proc/migrate_mentor()
	write_preference(GLOB.preference_entries[/datum/preference/toggle/admin/auto_dementor], FALSE) // Someone thought it was a good idea to make it start at true :)
