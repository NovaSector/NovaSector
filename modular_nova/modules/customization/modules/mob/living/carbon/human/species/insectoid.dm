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
		"ears" = list("Royal Antenna", FALSE),
		"tail" = list("Insectoid", FALSE),
		"wings" = list("Insectoid II", FALSE),
		"fluff" = list("Insectoid", FALSE),
		"legs" = list(NORMAL_LEGS, FALSE),
		"taur" = list("None", FALSE),
	)

/datum/species/insectoid/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.dna.features["mcolor"] = "#292929"
	human_for_preview.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Royal Antenna", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	human_for_preview.dna.mutant_bodyparts["fluff"] = list(MUTANT_INDEX_NAME = "Insectoid", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
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
