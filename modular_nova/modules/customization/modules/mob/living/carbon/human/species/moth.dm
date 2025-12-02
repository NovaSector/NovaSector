/datum/species/moth
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
	)

/datum/species/moth/get_default_mutant_bodyparts()
	return list(
		FEATURE_MOTH_MARKINGS = list("None", FALSE),
		FEATURE_EARS = list("None", FALSE),
		FEATURE_FLUFF = list("Plain", FALSE),
		FEATURE_WINGS = list("Moth (Plain)", TRUE),
		FEATURE_MOTH_ANTENNAE = list("Plain", TRUE),
	)

/datum/species/moth/randomize_features()
	var/list/features = ..()
	features[FEATURE_MUTANT_COLOR] = "#E5CD99"
	return features

/datum/species/moth/get_random_body_markings(list/passed_features)
	var/name = SPRITE_ACCESSORY_NONE
	var/list/candidates = GLOB.body_marking_sets.Copy()
	for(var/candi in candidates)
		var/datum/body_marking_set/setter = GLOB.body_marking_sets[candi]
		if(setter.recommended_species && isnull(setter.recommended_species[id]))
			candidates -= candi
	if(length(candidates))
		name = pick(candidates)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/moth/prepare_human_for_preview(mob/living/carbon/human/moth)
	moth.dna.features[FEATURE_MUTANT_COLOR] = "#E5CD99"
	moth.dna.mutant_bodyparts[FEATURE_MOTH_ANTENNAE] = moth.dna.species.build_mutant_part("Plain")
	moth.dna.mutant_bodyparts[FEATURE_MOTH_MARKINGS] = moth.dna.species.build_mutant_part("None")
	moth.dna.mutant_bodyparts[FEATURE_WINGS] = moth.dna.species.build_mutant_part("Moth (Plain)")
	regenerate_organs(moth, src, visual_only = TRUE)
	moth.update_body(TRUE)
