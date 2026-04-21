/datum/preference/text/taste
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_taste"
	maximum_value_length = 100

/datum/preference/text/taste/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["taste"] = value
	return FALSE

/datum/preference/text/smell
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_smell"
	maximum_value_length = 100

/datum/preference/text/smell/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["smell"] = value
	return FALSE
