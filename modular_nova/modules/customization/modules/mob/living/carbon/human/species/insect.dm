/datum/species/insect
	name = "Anthromorphic Insect"
	id = SPECIES_INSECT
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutanttongue = /obj/item/organ/tongue/insect
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_INSECT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/insect,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/insect,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/insect,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/insect,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/insect,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/insect,
	)

/datum/species/insect/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_HORNS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_EARS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
		FEATURE_TAUR = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_FLUFF = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_WINGS = MUTPART_BLUEPRINT("Bee", is_randomizable = FALSE),
		FEATURE_MOTH_ANTENNAE = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
	)

/datum/species/insect/get_species_description()
	return placeholder_description

/datum/species/insect/get_species_lore()
	return list(placeholder_lore)

/datum/species/insect/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#644b07"
	var/secondary_color = "#9b9b9b"
	human.dna.features[FEATURE_MUTANT_COLOR] = main_color
	human.dna.features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	human.dna.features[FEATURE_MUTANT_COLOR_THREE] = secondary_color
	human.dna.body_markings[BODY_ZONE_HEAD] = list("Insect Antennae" = list("#644b07", 0))
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)
