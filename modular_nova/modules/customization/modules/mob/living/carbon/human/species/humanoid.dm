/datum/species/humanoid
	name = "Humanoid"
	id = SPECIES_HUMANOID
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/humanoid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/humanoid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/humanoid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/humanoid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/humanoid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/humanoid,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1.0
	examine_limb_id = SPECIES_HUMAN

/datum/species/humanoid/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = list("None", FALSE),
		FEATURE_SNOUT = list("None", FALSE),
		FEATURE_EARS = list("None", FALSE),
		FEATURE_LEGS = list("Normal Legs", FALSE),
		FEATURE_WINGS = list("None", FALSE),
		FEATURE_TAUR = list("None", FALSE),
		FEATURE_HORNS = list("None", FALSE),
	)

/datum/species/humanoid/get_species_description()
	return "This is a template species for your own creations!"

/datum/species/humanoid/get_species_lore()
	return list("Make sure you fill out your own custom species lore!")

/datum/species/humanoid/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#722011"
	var/secondary_color = "#161616"
	human.dna.features[FEATURE_MUTANT_COLOR] = main_color
	human.dna.features[FEATURE_MUTANT_COLOR_TWO] = main_color
	human.dna.features[FEATURE_MUTANT_COLOR_THREE] = main_color
	human.dna.mutant_bodyparts[FEATURE_HORNS] = list(MUTANT_INDEX_NAME = "Curled", MUTANT_INDEX_COLOR_LIST = list(secondary_color, secondary_color, secondary_color))
	human.hairstyle = "Cornrows"
	human.hair_color = "#2b2b2b"
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)
