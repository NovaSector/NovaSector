/datum/species/shadow
	mutantheart = /obj/item/organ/heart/nightmare
	mutantlungs = /obj/item/organ/lungs
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	sexes = TRUE

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

/datum/species/shadow/on_species_gain(mob/living/carbon/carbon_owner, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	// update the species bodypart index to be digitigrade if applicable
	if(carbon_owner.dna.features[FEATURE_LEGS] == DIGITIGRADE_LEGS)
		carbon_owner.dna.species.bodypart_overrides[BODY_ZONE_R_LEG] = /obj/item/bodypart/leg/right/digitigrade/shadow
		carbon_owner.dna.species.bodypart_overrides[BODY_ZONE_L_LEG] = /obj/item/bodypart/leg/left/digitigrade/shadow

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
