/datum/species/lizard
	monkey_species = /datum/species/monkey/kobold

/*
Lizard subspecies: Silverscale
*/

/datum/species/lizard/silverscale
	///stored mutcolor2 for when we turn back off of a silverscale.
	var/old_mutcolor2
	///stored mutcolor3 for when we turn back off of a silverscale.
	var/old_mutcolor3
	/// assoc list of old mutant bodypart colors, for when we turn back off of a silverscale.
	var/list/old_mutant_bodyparts_colors

// Just adds handling for the other two mutcolors and mutant bodyparts being changed to silver.
/datum/species/lizard/silverscale/on_species_gain(mob/living/carbon/human/new_silverscale, datum/species/old_species, pref_load, regenerate_icons)
	if(istype(old_species, /datum/species/lizard/silverscale) && old_mutcolor2) // If we are somehow doing silverscale->silverscale don't override the old stored colors
		return ..()
	old_mutcolor2 = new_silverscale.dna.features["mcolor2"]
	old_mutcolor3 = new_silverscale.dna.features["mcolor3"]
	old_mutant_bodyparts_colors = list()
	for(var/key in new_silverscale.dna.mutant_bodyparts)
		old_mutant_bodyparts_colors[key] = new_silverscale.dna.mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST]
		new_silverscale.dna.mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = list("#eeeeee", "#eeeeee", "#eeeeee")

	new_silverscale.dna.features["mcolor2"] = "#eeeeee"
	new_silverscale.dna.features["mcolor3"] = "#eeeeee"
	regenerate_organs(new_silverscale, src, visual_only = TRUE)

	return ..()

/datum/species/lizard/silverscale/on_species_loss(mob/living/carbon/human/was_silverscale, datum/species/new_species, pref_load)
	was_silverscale.dna.features["mcolor2"] = old_mutcolor2
	was_silverscale.dna.features["mcolor3"] = old_mutcolor3
	for(var/key in was_silverscale.dna.mutant_bodyparts)
		was_silverscale.dna.mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = old_mutant_bodyparts_colors[key]
	regenerate_organs(was_silverscale, src, visual_only = TRUE)
	return ..()

/*
Lizard subspecies: ASHWALKERS
*/

/datum/species/lizard/ashwalker/
	language_prefs_whitelist = list(/datum/language/ashtongue = TRUE)

/datum/species/lizard/ashwalker/create_pref_language_perk()
	var/list/to_add = list()
	// Holding these variables so we can grab the exact names for our perk.
	var/datum/language/common_language = /datum/language/ashtongue

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "comment",
		SPECIES_PERK_NAME = "Native Speaker",
		SPECIES_PERK_DESC = "Ashwalkers can only speak [initial(common_language.name)]. \
			It is rare, but not impossible, for an Ashwalker to learn another language."
	))

	return to_add
