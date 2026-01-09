//pref for the contraband item choices
/datum/preference/choiced/smuggler
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "smuggler"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/smuggler/init_possible_values()
	return GLOB.smuggler_items

/datum/preference/choiced/smuggler/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Contraband Smuggler" in preferences.all_quirks

/datum/preference/choiced/smuggler/apply_to_human(mob/living/carbon/human/target, value)
	return
