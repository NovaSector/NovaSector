/datum/quirk/changeling
	name = "Changeling"
	desc = "(THIS DOES NOT MAKE YOU AN ANTAG) You are a changeling, one that for some reason or another has entered a dormant, non-predatory state. The crew will likely still hunt you down if you are discovered, because as far as they're concerned, you're the same monster through-and-through. As part of this momentary suppressed state, some of your typical abilities seem to be just as dormant."
	icon = FA_ICON_SPAGHETTI_MONSTER_FLYING
	value = 16
	medical_record_text = ""
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	veteran_only = TRUE

/datum/quirk/changeling/add_unique(client/client_source)
	var/datum/mind/target_mind = quirk_holder.mind
	var/datum/antagonist/changeling/quirk/changeling_datum = target_mind.has_antag_datum(/datum/antagonist/changeling/quirk)
	if(isnull(changeling_datum))
		changeling_datum = target_mind.add_antag_datum(/datum/antagonist/changeling/quirk)
		target_mind.special_role = ROLE_CHANGELING
	return changeling_datum

/datum/quirk/changeling/remove(client/client_source)
	var/datum/mind/target_mind = quirk_holder.mind
	var/datum/antagonist/changeling/quirk/changeling_datum = quirk_holder?.mind.has_antag_datum(/datum/antagonist/changeling/quirk)
	if(changeling_datum)
		target_mind.remove_antag_datum(/datum/antagonist/changeling/quirk)
		target_mind.special_role = null

/datum/quirk/changeling/is_species_appropriate(datum/species/mob_species)
	if (ispath(mob_species, /datum/species/synthetic))
		return FALSE
	if (ispath(mob_species, /datum/species/hemophage))
		return FALSE
	if (ispath(mob_species, /datum/species/jelly))
		return FALSE
	if (ispath(mob_species, /datum/species/plasmaman))
		return FALSE
	if (ispath(mob_species, /datum/species/ethereal))
		return FALSE
	return ..()
