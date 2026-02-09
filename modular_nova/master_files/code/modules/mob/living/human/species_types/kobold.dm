/datum/species/monkey/kobold
	name = "\improper Kobold"
	id = SPECIES_KOBOLD_PRIMITIVE
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	mutant_organs = list()

	mutanttongue = /obj/item/organ/tongue/lizard
	mutanteyes = /obj/item/organ/eyes/lizard
	skinned_type = /obj/item/stack/sheet/animalhide/carbon/lizard
	meat = /obj/item/food/meat/slab/human/mutant/lizard
	knife_butcher_results = list(/obj/item/food/meat/slab/human/mutant/lizard = 5, /obj/item/stack/sheet/animalhide/carbon/lizard = 1)
	inherent_traits = list(
		TRAIT_NO_AUGMENTS,
		TRAIT_NO_BLOOD_OVERLAY,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_UNDERWEAR,
		TRAIT_VENTCRAWLER_NUDE,
		TRAIT_WEAK_SOUL,
		TRAIT_MUTANT_COLORS,
	)
	no_equip_flags = null
	species_cookie = /obj/item/food/meat/slab
	coldmod = 1.5
	heatmod = 0.67
	death_sound = 'sound/mobs/humanoids/lizard/deathsound.ogg'
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_LAVALAND_SAFE
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 10)
	species_cookie = /obj/item/food/meat/slab
	species_language_holder = /datum/language_holder/kobold
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/kobold,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/kobold,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/kobold,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/kobold,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/kobold,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/kobold,
	)
	exotic_bloodtype = BLOOD_TYPE_LIZARD
	payday_modifier = 1

/datum/species/monkey/kobold/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT("Smooth", is_randomizable = TRUE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT("Round", is_randomizable = TRUE),
		FEATURE_FRILLS = MUTPART_BLUEPRINT("Short", is_randomizable = FALSE),
		FEATURE_HORNS = MUTPART_BLUEPRINT("Curled", is_randomizable = FALSE),
	)

/datum/species/monkey/kobold/randomize_features()
	var/list/features = ..()
	var/main_color = "#[random_color()]"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = main_color
	features[FEATURE_MUTANT_COLOR_THREE] = main_color
	features -= FEATURE_TAIL
	return features

/datum/species/monkey/kobold/get_scream_sound(mob/living/carbon/human/kobold)
	return pick(
		'sound/mobs/humanoids/lizard/lizard_scream_1.ogg',
		'sound/mobs/humanoids/lizard/lizard_scream_2.ogg',
		'sound/mobs/humanoids/lizard/lizard_scream_3.ogg',
	)

/datum/species/monkey/kobold/get_hiss_sound(mob/living/carbon/human/kobold)
	return 'sound/mobs/humanoids/lizard/lizard_hiss.ogg'

/datum/species/monkey/kobold/get_physical_attributes()
	return "Kobolds are functionally identical to monkeys, but with the downsides of lizards."

/datum/species/monkey/kobold/get_species_description()
	return "Kobolds are diminutive, reptilian creatures as related to Lizardpeople as monkeys are to humans."

/datum/species/monkey/kobold/get_species_lore()
	return list(
		"A smaller subspecies of lizardperson, tends to be rather excitable in nature.",
	)

/datum/species/monkey/kobold/create_pref_temperature_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "thermometer-empty",
		SPECIES_PERK_NAME = "Cold-blooded",
		SPECIES_PERK_DESC = "Kobolds have higher tolerance for hot temperatures, but lower \
			tolerance for cold temperatures. Additionally, they cannot self-regulate their body temperature - \
			they are as cold or as warm as the environment around them is. Stay warm!",
	))

	return to_add

/datum/species/monkey/kobold/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "spider",
			SPECIES_PERK_NAME = "Vent Crawling",
			SPECIES_PERK_DESC = "Kobolds can crawl through the vent and scrubber networks while wearing no clothing. \
				Stay out of the kitchen!",
		),
	)

/datum/species/monkey/kobold/create_pref_language_perk()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "comment",
		SPECIES_PERK_NAME = "Primitive Tongue",
		SPECIES_PERK_DESC = "You are able to understand [/datum/language/kobold::name].",
	))

	return to_add

/datum/species/monkey/kobold/prepare_human_for_preview(mob/living/carbon/human/kobold)
	var/main_color = "#926838"
	var/second_color = "#926838"
	var/third_color = "#926838"

	kobold.dna.features[FEATURE_MUTANT_COLOR] = main_color
	kobold.dna.features[FEATURE_MUTANT_COLOR_TWO] = second_color
	kobold.dna.features[FEATURE_MUTANT_COLOR_THREE] = third_color
	kobold.dna.mutant_bodyparts[FEATURE_SNOUT] = kobold.dna.species.build_mutant_part("Round", list(main_color, main_color, main_color))
	kobold.dna.mutant_bodyparts[FEATURE_TAIL] = kobold.dna.species.build_mutant_part("Smooth", list(second_color, main_color, main_color))
	kobold.dna.mutant_bodyparts[FEATURE_HORNS] = kobold.dna.species.build_mutant_part("Curled", list(main_color, main_color, main_color))
	kobold.dna.mutant_bodyparts[FEATURE_FRILLS] = kobold.dna.species.build_mutant_part("Short", list(main_color, main_color, main_color))
	regenerate_organs(kobold, src, visual_only = TRUE)
	kobold.update_body(TRUE)

// Same as regular kobolds except they cannot be butchered, and are smart enough to use devices (debatable)
/datum/species/monkey/kobold/roundstart
	id = SPECIES_KOBOLD
	examine_limb_id = SPECIES_KOBOLD
	mutantbrain = /obj/item/organ/brain/lizard
	knife_butcher_results = null
	inherent_traits = list(
		TRAIT_NO_AUGMENTS,
		TRAIT_NO_BLOOD_OVERLAY,
		TRAIT_VENTCRAWLER_NUDE,
		TRAIT_MUTANT_COLORS,
	)
