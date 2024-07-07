/datum/preference/choiced/footstep_sound
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "footstep_sound"

/datum/preference/choiced/footstep_sound/init_possible_values()
	return list("Default", "Shoes", "Claws")

/datum/preference/choiced/footstep_sound/create_default_value()
	return "Default"

/datum/preference/choiced/footstep_sound/apply_to_human(mob/living/carbon/human/target, value)
	if(value == "Default")
		return
	target.footstep_type = lowertext(value)
