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

// Just adds handling for the other two mutcolors being changed to silver.
/datum/species/lizard/silverscale/on_species_gain(mob/living/carbon/human/new_silverscale, datum/species/old_species, pref_load, regenerate_icons)
	old_mutcolor2 = new_silverscale.dna.features["mcolor2"]
	old_mutcolor3 = new_silverscale.dna.features["mcolor3"]
	new_silverscale.dna.features["mcolor2"] = "#eeeeee"
	new_silverscale.dna.features["mcolor3"] = "#eeeeee"
	return ..()

/datum/species/lizard/silverscale/on_species_loss(mob/living/carbon/human/was_silverscale, datum/species/new_species, pref_load)
	new_silverscale.dna.features["mcolor2"] = old_mutcolor2
	new_silverscale.dna.features["mcolor3"] = old_mutcolor3
	return ..()

/*
Lizard subspecies: ASHWALKERS
*/

/datum/species/lizard/ashwalker/
	language_prefs_whitelist = list(/datum/language/ashtongue)

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
