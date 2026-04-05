
/datum/preference/color/mutant/holosynth_color
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "holo_color"
	relevant_inherent_trait = TRAIT_HOLOSYNTH

/datum/preference/color/mutant/holosynth_color/compile_constant_data()
	var/list/data = list()
	data["type"] = "color"
	data["category"] = category
	data["default"] = create_default_value()
	return data

/datum/preference/color/mutant/holosynth_color/apply_to_human(mob/living/carbon/human/target, value)
	if(!value)
		return FALSE

	target.dna.features["holo_color"] = sanitize_hexcolor(value)
	return TRUE
