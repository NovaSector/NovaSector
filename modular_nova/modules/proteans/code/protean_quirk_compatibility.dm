// Protean quirk compatibility overrides
// Proteans should be able to use cybernetic organ quirks since they're already synthetic

// Nearsighted - affects eyes, which proteans have
/datum/quirk/item_quirk/nearsighted/is_species_appropriate(datum/species/mob_species)
	// Allow for proteans since they have robotic eyes
	if(ispath(mob_species, /datum/species/protean))
		return TRUE
	return ..()

// Shifty Eyes - affects eyes
/datum/quirk/shifty_eyes/is_species_appropriate(datum/species/mob_species)
	// Allow for proteans since they have robotic eyes
	if(ispath(mob_species, /datum/species/protean))
		return TRUE
	return ..()

// Transhumanist - replaces organs with cybernetic versions, proteans already have these
/datum/quirk/transhumanist/is_species_appropriate(datum/species/mob_species)
	// Allow for proteans - they're already transhumanist by nature
	if(ispath(mob_species, /datum/species/protean))
		return TRUE
	return ..()

// Any other quirks that specifically target eyes/ears/tongue
// These should work for proteans since they have these organs as cybernetic versions

