/datum/dynamic_ruleset/midround/from_ghosts/nightmare
	max_antag_cap = 2 // up to two candidates can be chosen

/// transfer the ghost's mind into the nightmare body
/datum/dynamic_ruleset/midround/from_ghosts/nightmare/prepare_for_role(datum/mind/candidate)
	candidate.transfer_to(create_ruleset_body(), force_key_move = TRUE)

/// beware! big body building below
/datum/dynamic_ruleset/midround/from_ghosts/nightmare/create_ruleset_body()
	var/mob/living/carbon/human/body = ..()

	/// an associated list holding the feature keys and their indexed data
	var/list/feature_list = list()
	/// temporary cache of the data to index onto the aforementioned keys
	var/list/feature_details = list()

	var/preset = pick(list("Fox", "Bunny"))
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
		if("Bunny")
			//tail
			feature_details[MUTANT_INDEX_NAME] = "Rabbit (Alt)"
			feature_details[MUTANT_INDEX_COLOR_LIST] = list("#363232", "#533c3c", "#FFFFFF")
			feature_list[FEATURE_TAIL] = feature_details.Copy()
			//ears
			feature_details[MUTANT_INDEX_NAME] = pick("Curved Rabbit Ears (Large)", "Rabbit (Large)")
			feature_details[MUTANT_INDEX_COLOR_LIST] = list("#333333", "#333333", "#613e38")
			feature_list[FEATURE_EARS] = feature_details.Copy()
			//snout
			feature_details[MUTANT_INDEX_NAME] = "Leporid"
			feature_details[MUTANT_INDEX_COLOR_LIST] = list("#5f5f5f", "#565656", "#FFFFFF")
			feature_list[FEATURE_SNOUT] = feature_details.Copy()

	for(var/feature in feature_list)
		body.dna.species.mutant_bodyparts[feature] = feature_list[feature]
		body.dna.mutant_bodyparts[feature] = feature_list[feature]
		// we don't need to update the body here

	//gender
	body.gender =  pick(MALE, FEMALE)
	body.physique = body.gender

	//hair
	var/hairstyle
	switch(body.physique)
		if(MALE)
			hairstyle = pick(list("Oxton", "Comet", "Oxton", "Fade (None)", "Undercut Left")) //im not very good at these
		if(FEMALE)
			hairstyle = pick(list("Simple short", "New You", "Cotton (Alt)", "Long Emo", "Ponytail 7", "Double Bun", "Simple"))
	body.set_hairstyle(hairstyle, update = FALSE)
	body.set_hair_gradient_style("Spiked Wavy", update = FALSE)
	body.set_haircolor("#1c1c1c", update = FALSE)
	body.set_hair_gradient_color("#613d38", update = FALSE)
	body.set_facial_hairstyle("Shaved", update = FALSE)
	body.update_body_parts_head_only()

	//underwear
	switch(body.physique)
		if(MALE)
			body.underwear = "Boxers"
			body.bra = "Nude"
		if(FEMALE)
			body.underwear = "Panties - Slim"
			body.bra = "Binder"
	body.underwear_color = "#292929"
	body.bra_color = "#252525"
	body.update_underwear()

	return body
