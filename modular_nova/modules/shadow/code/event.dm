/datum/dynamic_ruleset/midround/from_ghosts/nightmare
	max_antag_cap = 2 // up to two candidates can be chosen

/// transfer the ghost's mind into the nightmare body
/datum/dynamic_ruleset/midround/from_ghosts/nightmare/prepare_for_role(datum/mind/candidate)
	candidate.transfer_to(create_ruleset_body(), force_key_move = TRUE)

/// build dat body
/datum/dynamic_ruleset/midround/from_ghosts/nightmare/create_ruleset_body()
	var/mob/living/carbon/human/body = ..()
	///
	var/list/feature_list = list()
	///
	var/list/feature_details = list()

	var/preset = pick(list("Fox"))
	switch(preset)
		if("Fox")
			//legs
			body.dna.features[FEATURE_LEGS] = DIGITIGRADE_LEGS
			//tail
			feature_details[MUTANT_INDEX_NAME] = "Fox (Alt 3)"
			feature_details[MUTANT_INDEX_COLOR_LIST] = list("#363232", "#533c3c", "#FFFFFF")
			feature_list[FEATURE_TAIL] = feature_details.Copy()
			//ears
			feature_details[MUTANT_INDEX_NAME] = "Fox"
			feature_details[MUTANT_INDEX_COLOR_LIST] = list("#333333", "#613e38", "#FFFFFF")
			feature_list[FEATURE_EARS] = feature_details.Copy()
			//snout
			feature_details[MUTANT_INDEX_NAME] = "Leporid"
			feature_details[MUTANT_INDEX_COLOR_LIST] = list("#5f5f5f", "#565656", "#FFFFFF")
			feature_list[FEATURE_SNOUT] = feature_details.Copy()

	for(var/feature in feature_list)
		body.dna.species.mutant_bodyparts[feature] = feature_list[feature]
		body.dna.mutant_bodyparts[feature] = feature_list[feature]

	//hair
	body.set_facial_hairstyle("Shaved", update = FALSE)
	body.set_hairstyle("Simple short", update = FALSE)
	body.set_hair_gradient_style("Spiked Wavy", update = FALSE)
	body.set_haircolor("#1c1c1c", update = FALSE)
	body.set_hair_gradient_color("#613E38", update = FALSE)
	body.update_body_parts_head_only()
	//underwear
	body.underwear = "Panties - Slim"
	body.underwear_color = "#292929"
	body.bra = "Binder"
	body.bra_color = "#252525"
	body.update_underwear()

	return body
