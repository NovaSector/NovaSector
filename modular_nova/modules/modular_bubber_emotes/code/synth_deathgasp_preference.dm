// Synthetic species deathgasp sound selection
// Allows synth players to choose their death sound in character creation
// Positioned under Character Scream in the character editor
// Follows the same pattern as /datum/preference/choiced/scream

/datum/preference/choiced/synth_deathgasp
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "synth_deathgasp"
	can_randomize = FALSE
	priority = PREFERENCE_PRIORITY_BODYPARTS // Apply after species (priority 2) to override species default death_sound

/datum/preference/choiced/synth_deathgasp/init_possible_values()
	return assoc_to_keys(GLOB.synth_deathgasp_types)

/datum/preference/choiced/synth_deathgasp/create_default_value()
	return "Hacked"

/datum/preference/choiced/synth_deathgasp/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	// Only show this preference for synthetic species
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	return ispath(species_type, /datum/species/synthetic)

/datum/preference/choiced/synth_deathgasp/apply_to_human(mob/living/carbon/human/target, value)
	var/deathgasp_id = GLOB.synth_deathgasp_types[value]
	if(deathgasp_id)
		var/datum/deathgasp_type/deathgasp_type = new deathgasp_id
		target.death_sound = deathgasp_type.sound_path

