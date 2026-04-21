/datum/preference/text/low_arousal
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "low_arousal_text"
	maximum_value_length = 100

/datum/preference/text/low_arousal/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["low_arousal"] = value

/datum/preference/text/medium_arousal
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "medium_arousal_text"
	maximum_value_length = 100

/datum/preference/text/medium_arousal/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["medium_arousal"] = value

/datum/preference/text/high_arousal
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "high_arousal_text"
	maximum_value_length = 100

/datum/preference/text/high_arousal/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["high_arousal"] = value
