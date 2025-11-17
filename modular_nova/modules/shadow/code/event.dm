/datum/dynamic_ruleset/midround/from_ghosts/nightmare
	max_antag_cap = 2 // up to two candidates can be chosen

// transfer the ghost's mind into the nightmare body
/datum/dynamic_ruleset/midround/from_ghosts/nightmare/prepare_for_role(datum/mind/candidate)
	candidate.transfer_to(create_ruleset_body(), force_key_move = TRUE)

// give the antag preview something to cover up with
/datum/outfit/nightmare
	uniform = /obj/item/clothing/under/color/black

/// colors for preset style accessories
#define NIGHTMARE_COLOR_DARK "#363232"
#define NIGHTMARE_COLOR_LIGHT "#565656"
#define NIGHTMARE_COLOR_RED "#5a3c3c"
/// probability the preset gets transmorgified into a demi-human
#define NIGHTMARE_DEMIHUMAN_PROB 50

// only bloodthirsty animals please
GLOBAL_LIST_INIT(nightmare_presets, list(
	"bat",
	"bunny", //nighthare
	"lizard",
	"carp",
	"drider",
))

GLOBAL_LIST_INIT(nightmare_presets_hair_male, list(
	/datum/sprite_accessory/hair/comet::name,
	/datum/sprite_accessory/hair/nova/ponytail_short::name,
	/datum/sprite_accessory/hair/nova/sabitsuki::name,
	/datum/sprite_accessory/hair/nova/dave::name,
)) //clear the list and add "Afro" for admin abuse

GLOBAL_LIST_INIT(nightmare_presets_hair_female, list(
	/datum/sprite_accessory/hair/nova/simple_short::name,
	/datum/sprite_accessory/hair/nova/newyou::name,
	/datum/sprite_accessory/hair/longemo::name,
	/datum/sprite_accessory/hair/nova/simple::name,
))

// beware! big body building below
/datum/dynamic_ruleset/midround/from_ghosts/nightmare/create_ruleset_body()
	/// the body we are creating to edit, provided by parent
	var/mob/living/carbon/human/body = ..()

	body.gender =  pick(MALE, FEMALE)
	body.physique = body.gender
	body.dna.features[FEATURE_LEGS] = pick(DIGITIGRADE_LEGS, NORMAL_LEGS)

	body.underwear = (body.physique == MALE) ? /datum/sprite_accessory/underwear/male_boxers::name : /datum/sprite_accessory/underwear/panties_slim::name
	body.underwear_color = NIGHTMARE_COLOR_DARK
	body.bra = (body.physique == MALE) ? /datum/sprite_accessory/bra/nude::name : /datum/sprite_accessory/bra/binder::name
	body.bra_color = NIGHTMARE_COLOR_DARK
	body.update_underwear()

	body.set_hairstyle((body.physique == MALE) ? pick(GLOB.nightmare_presets_hair_male) : pick(GLOB.nightmare_presets_hair_female), update = FALSE)
	body.set_hair_gradient_style(/datum/sprite_accessory/gradient/wavy_spike::name, update = FALSE)
	body.set_haircolor(NIGHTMARE_COLOR_DARK, update = FALSE)
	body.set_hair_gradient_color(NIGHTMARE_COLOR_RED, update = FALSE)
	body.set_facial_hairstyle(/datum/sprite_accessory/facial_hair/shaved::name, update = FALSE)
	body.update_body_parts_head_only()

	/// an associated list holding the feature keys and their indexed data
	var/list/features_list = list()
	/// temporary cache of the data to index onto the aforementioned keys
	var/list/feature_index = list()
	//	now we build the features from GLOB.nightmare_presets, this block is very big.
	//	because of that, it's the last part of this proc - feel free to add onto this,
	//	but keep it as tidy as can be - follow the existing formatting and commenting.
	var/preset = pick(GLOB.nightmare_presets)
	switch(preset)

		if("bat")
			feature_index[MUTANT_INDEX_NAME] = pick(
				/datum/sprite_accessory/tails/mammal/wagging/bat_short::name,
				/datum/sprite_accessory/tails/mammal/wagging/bat_long::name,
			)
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_LIGHT)
			features_list[FEATURE_TAIL] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/ears/external/vulpkanin/fox::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_LIGHT)
			features_list[FEATURE_EARS] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/snouts/mammal/leporid::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK)
			features_list[FEATURE_SNOUT] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = pick(
				/datum/sprite_accessory/wings/mammal/bat::name,
				/datum/sprite_accessory/wings/mammal/tiny/bat::name,
			)
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK)
			features_list[FEATURE_WINGS] = feature_index.Copy()

		if("bunny")
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/tails/mammal/wagging/rabbit/alt::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_LIGHT)
			features_list[FEATURE_TAIL] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/ears/external/big/hare_large::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_RED)
			features_list[FEATURE_EARS] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/snouts/mammal/leporid::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK)
			features_list[FEATURE_SNOUT] = feature_index.Copy()

		if("lizard")
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/tails/lizard/short/twotone::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_LIGHT)
			features_list[FEATURE_TAIL] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = pick(
				/datum/sprite_accessory/horns/drake::name,
				/datum/sprite_accessory/horns/lifted::name,
			)
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_RED)
			features_list[FEATURE_HORNS] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/snouts/round::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK)
			features_list[FEATURE_SNOUT] = feature_index.Copy()

		if("carp")
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/tails/fish/crescent::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_RED)
			features_list[FEATURE_TAIL] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/ears/mutant/ramatae/sharp::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_LIGHT)
			features_list[FEATURE_EARS] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/snouts/mammal/ramatae::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK)
			features_list[FEATURE_SNOUT] = feature_index.Copy()

		if("drider") // you thought finding a nightmare in maintenance couldn't get worse?
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/taur/drider::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_LIGHT, NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_RED)
			features_list[FEATURE_TAUR] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/snouts/mammal/top/fmandibles::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_RED, NIGHTMARE_COLOR_LIGHT)
			features_list[FEATURE_SNOUT] = feature_index.Copy()
			feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/ears/external/antenna_simple1::name
			feature_index[MUTANT_INDEX_COLOR_LIST] = list(NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK, NIGHTMARE_COLOR_DARK)
			features_list[FEATURE_EARS] = feature_index.Copy()

	// straightens your legs and steals your snout
	if(prob(NIGHTMARE_DEMIHUMAN_PROB))
		body.dna.features[FEATURE_LEGS] = NORMAL_LEGS
		feature_index[MUTANT_INDEX_NAME] = /datum/sprite_accessory/snouts/none::name
		features_list[FEATURE_SNOUT] = feature_index.Copy()

	// we register the features, but we don't need to update the body
	// this happens later, in assign_role()
	for(var/feature in features_list)
		body.dna.species.mutant_bodyparts[feature] = features_list[feature]
		body.dna.mutant_bodyparts[feature] = features_list[feature]

	// garbage
	features_list.Cut()
	feature_index.Cut()

	// deliver the masterpiece
	return body


#undef NIGHTMARE_COLOR_DARK
#undef NIGHTMARE_COLOR_LIGHT
#undef NIGHTMARE_COLOR_RED

#undef NIGHTMARE_DEMIHUMAN_PROB
