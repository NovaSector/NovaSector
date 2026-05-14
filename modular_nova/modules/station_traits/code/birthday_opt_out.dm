/// When TRUE, will prevent you from being selected for the "Employee Birthday" station trait.
/datum/preference/toggle/birthday_opt_out
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	can_randomize = FALSE
	default_value = FALSE
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "birthday_opt_out"

/datum/preference/toggle/birthday_opt_out/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return