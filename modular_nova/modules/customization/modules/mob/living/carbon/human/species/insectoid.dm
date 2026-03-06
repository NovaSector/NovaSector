/mob/living/carbon/human/species/insectoid
	race = /datum/species/insectoid

/datum/species/insectoid
	name = "\improper Insectoid"
	plural_form = "Insectoid"
	id = SPECIES_INSECTOID
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WEB_WEAVER,
		TRAIT_WEB_SURFER,
	)
	meat = /obj/item/food/meat/slab/spider
	exotic_bloodtype = "Chlorocruorin" // awkwardly not a define
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT

	digitigrade_customization = DIGITIGRADE_OPTIONAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/insectoid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/insectoid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/insectoid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/insectoid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/insectoid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/insectoid,
	)

	mutanteyes = /obj/item/organ/eyes/bug
	mutantstomach = /obj/item/organ/stomach/roach
	mutantliver = /obj/item/organ/liver/roach
	mutantappendix = /obj/item/organ/appendix/roach

/datum/species/insectoid/get_default_mutant_bodyparts()
	return list(
		FEATURE_EARS = MUTPART_BLUEPRINT("Royal Antenna", is_randomizable = FALSE),
		FEATURE_TAIL = MUTPART_BLUEPRINT("Insectoid", is_randomizable = FALSE),
		FEATURE_WINGS = MUTPART_BLUEPRINT("Insectoid II", is_randomizable = FALSE),
		FEATURE_FLUFF = MUTPART_BLUEPRINT("Insectoid", is_randomizable = FALSE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
		FEATURE_TAUR = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
	)

/datum/species/insectoid/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.dna.features[FEATURE_MUTANT_COLOR] = "#292929"
	human_for_preview.dna.mutant_bodyparts[FEATURE_EARS] = human_for_preview.dna.species.build_mutant_part("Royal Antenna")
	human_for_preview.dna.mutant_bodyparts[FEATURE_FLUFF] = human_for_preview.dna.species.build_mutant_part("Insectoid")
	regenerate_organs(human_for_preview)
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/insectoid/get_species_description()
	return "Nothing yet."

/datum/species/insectoid/get_species_lore()
	return list(
		"Nothing yet.",
	)

/obj/item/organ/eyes/bug
	blink_animation = FALSE
