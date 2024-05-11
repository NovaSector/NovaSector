/datum/preference/choiced/snout_sensitivity
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "snout_sensitivity"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/snout_sensitivity/init_possible_values()
	return assoc_to_keys(GLOB.possible_snout_sensitivities)

/datum/preference/choiced/snout_sensitivity/create_default_value()
	return "Collapse"

/datum/preference/choiced/snout_sensitivity/apply_to_human()
	return

/datum/preference/choiced/snout_sensitivity/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Sensitive Snout" in preferences.all_quirks
