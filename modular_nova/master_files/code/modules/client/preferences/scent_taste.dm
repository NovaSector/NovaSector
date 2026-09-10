/datum/preference/text/erp_flavor/taste
	savefile_key = "custom_taste"

/datum/preference/text/erp_flavor/taste/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[ERP_FLAVOR_DNA_TASTE] = value

/datum/preference/text/erp_flavor/smell
	savefile_key = "custom_smell"

/datum/preference/text/erp_flavor/smell/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[ERP_FLAVOR_DNA_SCENT] = value
