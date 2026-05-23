/datum/preference/choiced/laugh
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "character_laugh"
	randomize_by_default = FALSE

/datum/preference/choiced/laugh/init_possible_values()
	return assoc_to_keys(GLOB.laugh_types_by_name)

/datum/preference/choiced/laugh/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/laugh_type/chosen_laugh = GLOB.laugh_types_by_name[value]
	if(chosen_laugh)
		target.selected_laugh = chosen_laugh
