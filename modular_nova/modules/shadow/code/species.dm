/datum/species/shadow
	sexes = TRUE

	mutantheart = /obj/item/organ/heart/nightmare
	mutantlungs = /obj/item/organ/lungs
	digitigrade_customization = DIGITIGRADE_OPTIONAL

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
	)

/datum/species/shadow/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_SNOUT = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_EARS = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_TAUR = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_HORNS = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_LEGS = list(NORMAL_LEGS, FALSE),
	)

/datum/species/shadow/nightmare
	no_equip_flags = /datum/species/shadow::no_equip_flags

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)
