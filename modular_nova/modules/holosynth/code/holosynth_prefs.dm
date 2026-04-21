// Character-scoped holosynth prefs. apply_to_human seeds dna.features and asks the component to re-read.

/// How solid the holosynth looks (integer percentage). 60 is the floor — any lower invites camouflage; 100 is solid.
/datum/preference/numeric/holosynth_transparency
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "holo_transparency"
	relevant_inherent_trait = TRAIT_HOLOSYNTH
	minimum = 60
	maximum = 100

/datum/preference/numeric/holosynth_transparency/create_default_value()
	return 60

/datum/preference/numeric/holosynth_transparency/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["holo_transparency"] = value
	var/datum/component/holosynth_effects/effects = target.GetComponent(/datum/component/holosynth_effects)
	effects?.refresh_opacity()

/// Whether the scanline flicker filter is rendered on the holosynth.
/datum/preference/toggle/holosynth_scanline
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "holo_scanline"
	relevant_inherent_trait = TRAIT_HOLOSYNTH
	default_value = TRUE

/datum/preference/toggle/holosynth_scanline/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["holo_scanline"] = value
	var/datum/component/holosynth_effects/effects = target.GetComponent(/datum/component/holosynth_effects)
	effects?.refresh_scanline()
