/datum/species/human/cerulean
	digitigrade_customization = DIGITIGRADE_NEVER
	species_language_holder = /datum/language_holder/akula

/datum/species/human/cerulean/get_default_mutant_bodyparts()
	return list(
		FEATURE_EARS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_FRILLS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_WINGS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
	)

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

/datum/species/human/cerulean/get_physical_attributes()
	return "Ceruleans struggle with the need to be wet at all times, the pull of gravity, and a lack of legs. \
			They're slightly more durable, and can fly while not affected by gravity."

/datum/species/human/cerulean/get_species_description()
	return "Ceruleans are upright, ambulatory descendants of Space Carp and genetic siblings to the bipedal Akulans. \
			They lack distinct legs—when they absolutely must move on land alone, they flop awkwardly with their thick, muscled tail. \
			They also require water within their lungs, a step up from Akulans' need to just remain moist."

/datum/species/human/cerulean/get_species_lore()
	return list(
			"Ceruleans are upright, ambulatory descendants of Space Carp and genetic siblings to the bipedal Akulans. \
			The main distinction lies in the tail and legs: Akulans have jointed plantigrade legs and a tail, \
			and Ceruleans have a larger tail with vestigial leg-bones within.",

			"Ceruleans require water within their lungs, in contrast to Akulans' need to merely remain moist, \
			and both achieve this through portable hydro-vaporizers. The Cerulean tail is flexible vertically, \
			as typical of mammals, aided by the muscular formations typical of a leg, while the Akulan tail flexes \
			horizontally, aided by their gluteal muscles. Ceruleans tend to inhabit deeper waters than Akulans, \
			though given the Akulan propensity to live on land, this isn't a low bar to sink beneath.",

			"As a deep-sea creature, Ceruleans wanting to experience the greater galaxy and drag themselves among \
			the ambulatory need a slight surgery or augmentation to adjust their body's inner pressure, lest they \
			bloat like a blobfish. This can come from significant fat cell eradication, significant blood volume loss, \
			or microgravity adjustments, all of which allow the Cerulean body to thrive in human-standard atmospheric conditions \
			without skin tearing. These \"Surfaced\" Ceruleans may find it difficult to return home, potentially succumbing to human conditions \
			like the Bends when free-diving so deep.",

			"Ceruleans are sheltered from the violent Akulan past by simple virtue of their cultural exclusion from space-faring. \
			The most action Ceruleans were allowed to see was a careful escort to other oceanic planets, for settling and housekeeping. \
			Only with the advent of modern technology like MODsuits and wheelchairs are Ceruleans considered able to properly interact with society.",

			"There is one category of technology the Ceruleans have managed to stand out with: they are pioneers of gravity manipulation technology. \
			Not many decades ago, Ceruleans of planet Marina, known as the Marinians, built grav-gen megastructures onto their sea beds to cast its planet's ocean currents \
			upward past atmosphere, building an aquatic bridge flowing towards Moryana into a connection between the two worlds within modern Void Imperium borders.",

			"While Ceruleans have been, and continue to be, part of the Azulean Empire, Marina and several other oceanic conquests stand out as strictly Cerulean habitations. \
			Azula are permitted but not welcome there, and the harsh oceanic conditions tend to deter other groups from more than a surface-level interest. \
			Cerulean cultures tend to reject the Azulean notions of goofy knighthood and over-servile repentance for their war crimes, \
			instead attempting to allow the Akulan past to remain water under the bridge.",
		)

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
