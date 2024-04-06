/datum/preference/choiced/sensitive_snout
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "snout_sensitivity"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/sensitive_snout/init_possible_values()
    var/static/list/options = list("Sneeze" = 1, "Stun" = 2, "Collapse" = 3)
	return options

/datum/preference/choiced/sensitive_snout/create_default_value()
    return "Collapse"

/datum/preference/choiced/sensitive_snout/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Sensitive Snout" in preferences.all_quirks
