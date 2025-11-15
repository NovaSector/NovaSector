/datum/dynamic_ruleset/midround/from_ghosts/nightmare
	max_antag_cap = 2 // up to two candidates can be chosen

/// transfer the ghost's mind into the nightmare body
/datum/dynamic_ruleset/midround/from_ghosts/nightmare/prepare_for_role(datum/mind/candidate)
	candidate.transfer_to(create_ruleset_body(), force_key_move = TRUE)

#define NIGHTMARE_COLOR_DARK "#363232"
#define NIGHTMARE_COLOR_LIGHT "#565656"
#define NIGHTMARE_COLOR_RED "#613e38"

GLOBAL_LIST_INIT(nightmare_presets, list(
	"humanoid",
	"fox",
	"bunny",
))

/// beware! big body building below
/datum/dynamic_ruleset/midround/from_ghosts/nightmare/create_ruleset_body()
	/// the body we are creating to edit, provided by parent
	var/mob/living/carbon/human/body = ..()
	/// an associated list holding the feature keys and their indexed data
	var/list/feature_list = list()
	/// temporary cache of the data to index onto the aforementioned keys
	var/list/feature_index = list()

	// pick a gender first and foremost
	body.gender =  pick(MALE, FEMALE)
	body.physique = body.gender
	// legs are gender too
	body.dna.features[FEATURE_LEGS] = pick(DIGITIGRADE_LEGS, NORMAL_LEGS)

	// we set the underwear - only a small selection
	switch(body.physique)
		if(MALE)
			body.underwear = /datum/sprite_accessory/underwear/male_boxers::name
			body.bra = /datum/sprite_accessory/bra/nude::name
		if(FEMALE)
			body.underwear = /datum/sprite_accessory/underwear/panties_slim::name
			body.bra = /datum/sprite_accessory/bra/binder::name
	body.underwear_color = NIGHTMARE_COLOR_DARK
	body.bra_color = NIGHTMARE_COLOR_DARK
	body.update_underwear()

	// here we set the hair, this block is pretty big
	var/hairstyle
	switch(body.physique)
		if(MALE)
			hairstyle = pick(list(
				/datum/sprite_accessory/hair/bald::name,
				/datum/sprite_accessory/hair/oxton::name,
				/datum/sprite_accessory/hair/comet::name,
				/datum/sprite_accessory/hair/nofade::name,
				/datum/sprite_accessory/hair/undercutleft::name,
			))
		if(FEMALE)
			hairstyle = pick(list(
				/datum/sprite_accessory/hair/nova/simple_short::name,
				/datum/sprite_accessory/hair/nova/newyou::name,
				/datum/sprite_accessory/hair/nova/cottonalt::name,
				/datum/sprite_accessory/hair/longemo::name,
				/datum/sprite_accessory/hair/ponytail7::name,
				/datum/sprite_accessory/hair/doublebun::name,
				/datum/sprite_accessory/hair/nova/simple::name,
			))
	// update = FALSE, we only update once using the optimized update_body_parts_head_only() proc
	body.set_hairstyle(hairstyle, update = FALSE)
	body.set_hair_gradient_style(/datum/sprite_accessory/gradient/wavy_spike::name, update = FALSE)
	body.set_haircolor(NIGHTMARE_COLOR_DARK, update = FALSE)
	body.set_hair_gradient_color(NIGHTMARE_COLOR_RED, update = FALSE)
	body.update_body_parts_head_only()

	/*
		now we build the features from GLOB.nightmare_presets, this block is very big.
		because of that, it's the last part of this proc - feel free to add onto this,
		but keep it as tidy as can be - follow the existing formatting and commenting.
	*/
	var/preset = pick(GLOB.nightmare_presets)
	switch(preset)

		if("humanoid")
			body.dna.features[FEATURE_LEGS] = NORMAL_LEGS

		if("fox")
			//tail
			feature_index[MUTANT_INDEX_NAME] = pick(
				/datum/sprite_accessory/tails/mammal/wagging/vulpkanin/fox::name,
				/datum/sprite_accessory/tails/mammal/wagging/vulpkanin/fox/ann::name,
			)
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_LIGHT)
			feature_list[FEATURE_TAIL] = feature_index.Copy()
			//ears
			feature_index[MUTANT_INDEX_NAME] = pick(
				/datum/sprite_accessory/ears/external/vulpkanin/fox::name,
			)
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_LIGHT)
			feature_list[FEATURE_EARS] = feature_index.Copy()
			//snout
			feature_index[MUTANT_INDEX_NAME] = pick(
				/datum/sprite_accessory/snouts/mammal/leporid::name,
			)
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_LIGHT)
			feature_list[FEATURE_SNOUT] = feature_index.Copy()

		if("bunny")
			//tail
			feature_index[MUTANT_INDEX_NAME] = pick(
				/datum/sprite_accessory/tails/mammal/wagging/rabbit/alt::name,
			)
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_LIGHT)
			feature_list[FEATURE_TAIL] = feature_index.Copy()
			//ears
			feature_index[MUTANT_INDEX_NAME] = pick(
				/datum/sprite_accessory/ears/external/big/bunny_large::name,
				/datum/sprite_accessory/ears/external/big/hare_large::name,
			)
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_RED)
			feature_list[FEATURE_EARS] = feature_index.Copy()
			//snout
			feature_index[MUTANT_INDEX_NAME] = pick(
				/datum/sprite_accessory/snouts/mammal/leporid::name,
			)
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_DARK)
			feature_list[FEATURE_SNOUT] = feature_index.Copy()

	// we register the features, but we don't need to update the body
	// this happens later, in assign_role()
	for(var/feature in feature_list)
		body.dna.species.mutant_bodyparts[feature] = feature_list[feature]
		body.dna.mutant_bodyparts[feature] = feature_list[feature]

	// deliver the masterpiece
	return body

#undef NIGHTMARE_COLOR_DARK
#undef NIGHTMARE_COLOR_LIGHT
#undef NIGHTMARE_COLOR_RED
