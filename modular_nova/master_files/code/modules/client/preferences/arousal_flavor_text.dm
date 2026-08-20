#define MAX_FLAVOR_ERP_TEXT_LEN 100

/datum/preference/text/erp_flavor
	abstract_type = /datum/preference/text/erp_flavor
	category = PREFERENCE_CATEGORY_ERP
	savefile_identifier = PREFERENCE_CHARACTER
	maximum_value_length = MAX_FLAVOR_ERP_TEXT_LEN

/datum/preference/text/erp_flavor/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/text/erp_flavor/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return ""
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return ""
	return ..()

/datum/preference/text/erp_flavor/low_arousal
	savefile_key = "low_arousal_text"

/datum/preference/text/erp_flavor/low_arousal/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[ERP_FLAVOR_DNA_LOW_AROUSAL] = value

/datum/preference/text/erp_flavor/medium_arousal
	savefile_key = "medium_arousal_text"

/datum/preference/text/erp_flavor/medium_arousal/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[ERP_FLAVOR_DNA_MEDIUM_AROUSAL] = value

/datum/preference/text/erp_flavor/high_arousal
	savefile_key = "high_arousal_text"

/datum/preference/text/erp_flavor/high_arousal/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[ERP_FLAVOR_DNA_HIGH_AROUSAL] = value

#undef MAX_FLAVOR_ERP_TEXT_LEN
