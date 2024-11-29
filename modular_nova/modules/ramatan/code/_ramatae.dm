/datum/species/mammal/ramatae
	name = "Ramatae"
	id = SPECIES_RAMATAE
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/ramatae/eyes,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/ramatae,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/ramatae,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/ramatae,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/ramatae,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/ramatae,
	)
	species_language_holder = /datum/language_holder/ramatae

/datum/species/mammal/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Ramatae", TRUE),
		"snout" = list("Ramatae", TRUE),
		"horns" = list("None", FALSE),
		"ears" = list("Ramatae", TRUE),
		"legs" = list("Digitigrade Legs", TRUE),
		"taur" = list("None", FALSE),
		"fluff" = list("None", FALSE),
		"frills" = list("Ramatae", TRUE),
		"wings" = list("None", FALSE),
		"head_acc" = list("None", FALSE),
		"neck_acc" = list("None", FALSE),
	)

/datum/species/mammal/ramatae/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#ffee66"
	var/secondary_color = "#ffaa66"
	human.dna.features["mcolor"] = main_color
	human.dna.features["mcolor2"] = secondary_color
	human.dna.features["mcolor3"] = secondary_color
	human.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Ramatae", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#464646"))
	human.dna.mutant_bodyparts["frills"] = list(MUTANT_INDEX_NAME = "Ramatae", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#464646"))
	human.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Ramatae", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#4D4D4D"))
	human.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Ramatae", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#4D4D4D"))
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)


/*
* LIMBS AS AUGS ZONE
*/
/datum/augment_item/limb/head/species/mutant/ramatae
	name = "small-eyes ramatae head"
	path = /obj/item/bodypart/head/mutant/ramatae

/datum/augment_item/limb/head/species/mutant/ramatae/eyes
	name = "big-eyes ramatae head"
	path = /obj/item/bodypart/head/mutant/ramatae/eyes

/datum/augment_item/limb/chest/species/mutant/ramatae
	name = "ramatae chest"
	path = /obj/item/bodypart/chest/mutant/ramatae

/datum/augment_item/limb/l_arm/species/mutant/ramatae
	name = "ramatae left arm"
	path = /obj/item/bodypart/arm/left/mutant/ramatae

/datum/augment_item/limb/r_arm/species/mutant/ramatae
	name = "ramatae right arm"
	path = /obj/item/bodypart/arm/right/mutant/ramatae

/datum/augment_item/limb/l_leg/species/mutant/ramatae
	name = "ramatae left leg"
	path = /obj/item/bodypart/leg/left/mutant/ramatae

/datum/augment_item/limb/r_leg/species/mutant/ramatae
	name = "ramatae right leg"
	path = /obj/item/bodypart/leg/right/mutant/ramatae
