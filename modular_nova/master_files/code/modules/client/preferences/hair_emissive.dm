/datum/preference/toggle/hair_emissive
	savefile_key = "hair_emissive"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_head_flag = HEAD_HAIR

/datum/preference/toggle/hair_emissive/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	value = value && preferences && is_allowed(preferences)

	target.emissive_hair = value
	return TRUE

/datum/preference/toggle/hair_emissive/create_default_value()
	return FALSE

/datum/preference/toggle/hair_emissive/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = is_allowed(preferences)
	return passed_initial_check && allowed

/**
 * If hair emissives are actually on.
 */
/datum/preference/toggle/hair_emissive/proc/is_allowed(datum/preferences/preferences)
	return preferences.read_preference(/datum/preference/toggle/allow_emissives)
