// Character-scoped holosynth prefs. apply_to_human seeds dna.features and asks the species to re-apply the filter.

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
	var/datum/species/synthetic/holosynth/species = target.dna?.species
	if(istype(species))
		species.refresh_opacity(target)
