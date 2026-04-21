/datum/preference/text/taste
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_taste"
	maximum_value_length = MAX_FLAVOR_ERP_TEXT_LEN

/datum/preference/text/taste/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[FLAVOR_KEY_TASTE] = value
	return FALSE

/datum/preference/text/smell
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "custom_smell"
	maximum_value_length = MAX_FLAVOR_ERP_TEXT_LEN

/datum/preference/text/smell/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[FLAVOR_KEY_SMELL] = value
	return FALSE
