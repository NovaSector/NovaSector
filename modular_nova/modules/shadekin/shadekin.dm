/datum/species/shadekin
	name = "Shadekin"
	id = SPECIES_SHADEKIN
	mutanttongue = /obj/item/organ/tongue/shadekin
	mutantears = /obj/item/organ/ears/shadekin
	mutantbrain = /obj/item/organ/brain/shadekin
	mutanteyes = /obj/item/organ/eyes/shadekin
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/shadekin,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/shadekin,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/shadekin,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/shadekin,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/shadekin,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/shadekin,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
		TRAIT_NIGHT_VISION,
		TRAIT_NOBREATH,
	)
	species_language_holder = /datum/language_holder/shadekin


/datum/species/shadekin/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "lightbulb",
		SPECIES_PERK_NAME = "Dark Regeneration",
		SPECIES_PERK_DESC = "Shadekins regenerate their physical wounds while in the darkness."
	),
	list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "moon",
			SPECIES_PERK_NAME = "Darkness Assist",
			SPECIES_PERK_DESC = "Thanks to their kinship with darkness, Shadekins gain additional  \
								speed of movement and actions when in the dark.",
		)
	)

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "crutch",
		SPECIES_PERK_NAME = "Light Averse",
		SPECIES_PERK_DESC = "Shadekins move slightly slower while in the light."
	))

	return to_add

/datum/species/shadekin/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Shadekin", TRUE),
		"snout" = list("None", FALSE),
		"ears" = list("Shadekin", TRUE),
		"legs" = list("Normal Legs", TRUE),
	)

/datum/species/shadekin/randomize_features()
	var/list/features = ..()
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#202020"
			secondary_color = "#505050"
			tertiary_color = "#3f3f3f"
		if(2)
			main_color = "#CF3565"
			secondary_color = "#d93554"
			tertiary_color = "#fbc2dd"
		if(3)
			main_color = "#FFC44D"
			secondary_color = "#FFE85F"
			tertiary_color = "#FFF9D6"
		if(4)
			main_color = "#DB35DE"
			secondary_color = "#BE3AFE"
			tertiary_color = "#F5E2EE"
	features["mcolor"] = main_color
	features["mcolor2"] = secondary_color
	features["mcolor3"] = tertiary_color
	return features

/datum/species/shadekin/prepare_human_for_preview(mob/living/carbon/human/shadekin)
	var/main_color = "#222222"
	var/secondary_color = "#b8b8b8"
	var/tertiary_color = "#b8b8b8"
	shadekin.dna.features["mcolor"] = main_color
	shadekin.dna.features["mcolor2"] = secondary_color
	shadekin.dna.features["mcolor3"] = tertiary_color
	shadekin.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Shadekin", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	shadekin.eye_color_left = "#c4c400"
	shadekin.eye_color_right = "#c4c400"
	regenerate_organs(shadekin, src, visual_only = TRUE)
	shadekin.update_body(TRUE)

/datum/species/shadekin/get_species_description()
    return list(
        "Shadekins appeared somewhere in distant space."
    )

/datum/species/shadekin/get_species_lore()
    return list(
        "It is unclear when exactly Shadekin first spawned, though it is assumedly a relatively recent development."
    )

/obj/item/organ/brain/shadekin
	name = "shadekin brain"
	desc = "A mysterious brain."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-x-d"
	var/applied_status = /datum/status_effect/shadekin_regeneration

/obj/item/organ/brain/shadekin/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/turf/owner_turf = owner.loc
	if(!isturf(owner_turf))
		return
	var/light_amount = owner_turf.get_lumcount()

	if (light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD) //heal in the dark and additional speed
		owner.apply_status_effect(applied_status)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/light_averse)
		owner.add_movespeed_modifier(/datum/movespeed_modifier/dark_affinity)
		owner.add_actionspeed_modifier(/datum/actionspeed_modifier/hands_of_darkness)
	else
		owner.add_movespeed_modifier(/datum/movespeed_modifier/light_averse)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/dark_affinity)
		owner.remove_actionspeed_modifier(/datum/actionspeed_modifier/hands_of_darkness)

/datum/status_effect/shadekin_regeneration
	id = "shadekin_regeneration"
	duration = 2 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/shadekin_regeneration

/datum/status_effect/shadekin_regeneration/on_apply()
	. = ..()
	if (!.)
		return FALSE
	heal_owner()
	return TRUE

/datum/status_effect/shadekin_regeneration/refresh(effect)
	. = ..()
	heal_owner()

/datum/status_effect/shadekin_regeneration/proc/heal_owner()
	owner.heal_overall_damage(brute = 0.5, burn = 0.5, required_bodytype = BODYTYPE_ORGANIC)
	if(owner.health < owner.maxHealth)
		new /obj/effect/temp_visual/heal(get_turf(owner), COLOR_EFFECT_HEAL_RED)

/atom/movable/screen/alert/status_effect/shadekin_regeneration
	name = "Dark Regeneration"
	desc = "Feeling the tug of home on your fur, some of its soothing warmth comes to ease your burdens."
	icon_state = "lightless"

/datum/movespeed_modifier/light_averse
	multiplicative_slowdown = 0.25

/datum/movespeed_modifier/dark_affinity
	multiplicative_slowdown = -0.2

/datum/actionspeed_modifier/hands_of_darkness
	multiplicative_slowdown = -0.25

/mob/living/carbon/human/species/shadekin
	race = /datum/species/shadekin
