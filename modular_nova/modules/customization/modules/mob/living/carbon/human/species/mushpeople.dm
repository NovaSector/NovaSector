/datum/species/mush/get_default_mutant_bodyparts()
	return list(
		FEATURE_EARS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_MUSH_CAP = MUTPART_BLUEPRINT("Round", FALSE), // we don't want cap-less mushpeople
	)

/datum/species/mush/randomize_features()
	var/list/features = ..()
	features[FEATURE_MUSH_CAP] = pick(SSaccessories.feature_list[FEATURE_MUSH_CAP] - list(SPRITE_ACCESSORY_NONE)) // No cap-less mushpeople.
	return features

/datum/species/mush/prepare_human_for_preview(mob/living/carbon/human/shrooman)
	shrooman.dna.mutant_bodyparts[FEATURE_MUSH_CAP] = shrooman.dna.species.build_mutant_part("Round", list("#FF4B19"))
	regenerate_organs(shrooman, src, visual_only = TRUE)
	shrooman.update_body(TRUE)
