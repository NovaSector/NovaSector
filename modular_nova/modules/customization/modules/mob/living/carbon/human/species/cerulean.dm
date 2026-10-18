/datum/species/human/cerulean
	digitigrade_customization = DIGITIGRADE_NEVER

// the fish tail is the Cerulean's lower body, so there are no tail or legs choices to make.
// frills and snout offer the fish styles (aquatic, fish) without mismatched parts.
/datum/species/human/cerulean/get_default_mutant_bodyparts()
	return list(
		FEATURE_EARS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_FRILLS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_WINGS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
	)

// frills come from the mutant bodyparts, in the tail's color, and the preview wears no snout
/datum/species/human/cerulean/prepare_human_for_preview(mob/living/carbon/human/cerulean)
	cerulean.set_haircolor("#C2DFED", update = FALSE)
	cerulean.set_hairstyle(/datum/sprite_accessory/hair/highponytail::name, update = TRUE)
	var/tail_color = cerulean.dna.features[FEATURE_TAIL_FISH_COLOR]
	cerulean.dna.mutant_bodyparts[FEATURE_FRILLS] = build_mutant_part(/datum/sprite_accessory/frills/aquatic::name, list(tail_color, tail_color, tail_color))
	regenerate_organs(cerulean, excluded_zones = GLOB.leg_zones)
	cerulean.update_body(is_creating = TRUE)

// get_features() has no relevant_organ check, which is how TG offers the tail color to Ceruleans
/datum/species/human/cerulean/get_features()
	var/list/features = ..()
	features |= /datum/preference/color/fish_tail_color::savefile_key
	return features

/obj/item/organ/tail/fish/cerulean
	// not a styled tail. it neither writes nor clears the DNA's tail entry, which the DNA pass would swap it for
	mutantpart_key = null

/obj/item/organ/frills/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	if(organ_owner.dna && isnull(organ_owner.dna.mutant_bodyparts[FEATURE_FRILLS]) && organ_owner.has_cerulean_tail())
		var/tail_color = organ_owner.dna.features[FEATURE_TAIL_FISH_COLOR]
		bodypart_overlay.draw_color = list(tail_color, tail_color, tail_color)
	return ..()

/// Returns whether this body wears a Cerulean tail, or its species grows one
/mob/living/carbon/proc/has_cerulean_tail()
	return istype(get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL), /obj/item/organ/tail/fish/cerulean) \
		|| ispath(dna?.species?.get_mutant_organ_type_for_slot(ORGAN_SLOT_EXTERNAL_TAIL), /obj/item/organ/tail/fish/cerulean)

/// Repaints the frills in the tail's color
/mob/living/carbon/human/proc/match_frills_to_tail()
	var/obj/item/organ/frills/frills = get_organ_slot(ORGAN_SLOT_EXTERNAL_FRILLS)
	if(isnull(frills))
		return
	var/tail_color = dna.features[FEATURE_TAIL_FISH_COLOR]
	var/list/colors = list(tail_color, tail_color, tail_color)
	var/datum/mutant_bodypart/frills_part = dna.mutant_bodyparts[FEATURE_FRILLS]
	frills_part?.set_colors(colors)
	frills.bodypart_overlay.draw_color = colors
	update_body_parts()

/mob/living/carbon/human/species/cerulean/abyss/set_species(datum/species/mrace, icon_update, pref_load, replace_missing, list/override_features, list/override_mutantparts, list/override_markings)
	. = ..()
	match_frills_to_tail() // its tail darkens after the frills grow
