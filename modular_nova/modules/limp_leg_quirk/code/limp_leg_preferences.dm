/datum/preference/choiced/limp_leg
	savefile_key = "limp_leg"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/limp_leg/create_default_value()
	return "Random"

/datum/preference/choiced/limp_leg/init_possible_values()
	return list("Random", "Left leg", "Right leg")

/datum/preference/choiced/limp_leg/apply_to_human(mob/living/carbon/human/target, value)
	return
