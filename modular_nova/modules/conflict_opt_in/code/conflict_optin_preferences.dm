/datum/preference/choiced/conflict_opt_in_status
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "conflict_opt_in_status_pref"

/datum/preference/choiced/conflict_opt_in_status/init_possible_values()
	return list(CONFLICT_OPT_OUT, CONFLICT_OPT_IN_PARTIAL, CONFLICT_OPT_IN_YES_KILL, CONFLICT_OPT_IN_YES_ROUND_REMOVE)

/datum/preference/choiced/conflict_opt_in_status/create_default_value()
	return CONFLICT_OPT_IN_DEFAULT_LEVEL

/datum/preference/choiced/conflict_opt_in_status/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return !(CONFIG_GET(flag/disable_conflict_opt_in_preferences))

/datum/preference/choiced/conflict_opt_in_status/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_conflict_opt_in_preferences))
		return CONFLICT_OPT_IN_DEFAULT_LEVEL

	return ..()

/datum/preference/choiced/conflict_opt_in_status/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/conflict_opt_in_status/compile_constant_data()
	var/list/data = ..()

	// An assoc list of values to display names so we don't show players numbers in their settings!
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.conflict_opt_in_strings

	return data
