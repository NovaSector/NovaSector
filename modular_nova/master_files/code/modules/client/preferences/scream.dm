/datum/preference/choiced/scream
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "character_scream"
	randomize_by_default = FALSE

/datum/preference/choiced/scream/init_possible_values()
	return assoc_to_keys(GLOB.scream_types_by_name)

/datum/preference/choiced/scream/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/scream_type/chosen_scream = GLOB.scream_types_by_name[value]
	if(chosen_scream)
		target.selected_scream = chosen_scream
