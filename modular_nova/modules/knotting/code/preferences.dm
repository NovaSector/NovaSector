/datum/preference/toggle/knotting
	abstract_type = /datum/preference/toggle/knotting

/datum/preference/toggle/knotting/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/toggle/knotting/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// "My character can knot — apply TRAIT_CAN_KNOT at spawn."
/datum/preference/toggle/knotting/enable
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "knotting_enable"
	default_value = FALSE

/datum/preference/toggle/knotting/enable/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(value)
		ADD_TRAIT(target, TRAIT_CAN_KNOT, ROUNDSTART_TRAIT)
	else
		REMOVE_TRAIT(target, TRAIT_CAN_KNOT, ROUNDSTART_TRAIT)

/// "Other characters with knots can knot me during climax."
/datum/preference/toggle/knotting/receive
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "knotting_receive"
	default_value = FALSE
