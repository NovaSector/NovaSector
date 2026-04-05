/datum/preference/numeric/social_anxiety
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "social_anxiety"
	savefile_identifier = PREFERENCE_CHARACTER

	step = 1

	minimum = 0
	maximum = 100 // why would anyone want it at 100, might as well take mute

/datum/preference/numeric/social_anxiety/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/social_anxiety/create_default_value()
	return 50
