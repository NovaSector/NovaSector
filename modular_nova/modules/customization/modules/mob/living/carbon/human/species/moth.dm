/datum/species/moth
	mutant_bodyparts = list()
	inherent_traits = list(
		TRAIT_HAS_MARKINGS,
		TRAIT_TACKLING_WINGED_ATTACKER,
		TRAIT_ANTENNAE,
		TRAIT_MUTANT_COLORS,
		TRAIT_HARD_SOLES, //They have weird clawed feet; boots don't really fit on their sprite anyway. Trust me on this one.
	)

/datum/species/moth/get_default_mutant_bodyparts()
	return list(
		"fluff" = list("Plain", FALSE),
		"wings" = list("Moth (Plain)", TRUE),
		"moth_antennae" = list("Plain", TRUE),
	)

/datum/species/moth/randomize_features()
	var/list/features = ..()
	features["mcolor"] = "#E5CD99"
	return features

/datum/species/moth/get_random_body_markings(list/passed_features)
	var/name = "None"
	var/list/candidates = GLOB.body_marking_sets.Copy()
	for(var/candi in candidates)
		var/datum/body_marking_set/setter = GLOB.body_marking_sets[candi]
		if(setter.recommended_species && !(id in setter.recommended_species))
			candidates -= candi
	if(length(candidates))
		name = pick(candidates)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/moth/prepare_human_for_preview(mob/living/carbon/human/moth)
	moth.dna.features["mcolor"] = "#E5CD99"
	moth.dna.mutant_bodyparts["moth_antennae"] = list(MUTANT_INDEX_NAME = "Plain", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	moth.dna.mutant_bodyparts["moth_markings"] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	moth.dna.mutant_bodyparts["wings"] = list(MUTANT_INDEX_NAME = "Moth (Plain)", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	regenerate_organs(moth, src, visual_only = TRUE)
	moth.update_body(TRUE)

/datum/species/moth/on_species_gain(mob/living/carbon/the_moth_in_question, datum/species/old_species, pref_load)
	. = ..()
	var/mob/living/carbon/human/mothman = the_moth_in_question
	if(!istype(mothman))
		return
	mothman.dna.add_mutation(/datum/mutation/human/olfaction, MUT_NORMAL)
	mothman.dna.activate_mutation(/datum/mutation/human/olfaction)

    // >mfw I take mutadone and my antennae atrophy
	var/datum/mutation/human/olfaction/mutation = locate() in mothman.dna.mutations
	mutation.mutadone_proof = TRUE
	mutation.instability = 0

/datum/species/human/moth/on_species_loss(mob/living/carbon/the_player_formerly_known_as_moth, datum/species/new_species, pref_load)
	. = ..()
	var/mob/living/carbon/human/mothman = the_player_formerly_known_as_moth
	if(!istype(mothman))
		return
	mothman.dna.remove_mutation(/datum/mutation/human/olfaction)

/datum/species/moth/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "shoe-prints",
			SPECIES_PERK_NAME = "Clawed Gait",
			SPECIES_PERK_DESC = "Moths have clawed feet and strange legs; meaning they don't need shoes to avoid hazards.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "signal",
			SPECIES_PERK_NAME = "Antenna Reception",
			SPECIES_PERK_DESC = "Moths, highly sensitive to pheromones, are also highly sensitive to other scents; to the degree of being able to track them.",
		),
	)

	return to_add
