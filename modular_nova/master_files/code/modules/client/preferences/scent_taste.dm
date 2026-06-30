/datum/preference/text/erp_flavor/taste
	savefile_key = "custom_taste"

/datum/preference/text/erp_flavor/taste/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[FLAVOR_KEY_TASTE] = value

/datum/preference/text/erp_flavor/smell
	savefile_key = "custom_smell"

/datum/preference/text/erp_flavor/smell/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[FLAVOR_KEY_SMELL] = value
