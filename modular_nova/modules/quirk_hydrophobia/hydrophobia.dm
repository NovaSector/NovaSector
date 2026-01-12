/datum/quirk/hydrophobia
	name = "Hydrophobia"
	desc = "You're terrified of water! For Slime Hybrids, this also means you will be unable to repel water."
	gain_text = span_danger("You believe that water is the worst thing to ever exist.")
	lose_text = span_danger("You no longer believe that water is all that bad.")
	medical_record_text = "Patient suffers from hydrophobia, exhibiting extreme anxiety around water sources."
	value = -2
	mob_trait = TRAIT_WATER_HATER
	icon = FA_ICON_WATER_LADDER
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/hydrophobia/is_species_appropriate(datum/species/mob_species)
	if(TRAIT_WATER_HATER in GLOB.species_prototypes[mob_species].inherent_traits)
		return FALSE
	else
		return ..()

/datum/quirk/hydrophobia/add(client/client_source)
	// If they're a slime, let's remove their ability
	var/datum/action/cooldown/spell/slime_hydrophobia/slime_hydrophobia = locate() in quirk_holder.actions
	if(slime_hydrophobia)
		qdel(slime_hydrophobia)

/datum/quirk/hydrophobia/remove()
	// If they're a slime, let's grant them the ability to repel water
	var/datum/action/cooldown/spell/slime_hydrophobia/slime_hydrophobia = locate() in quirk_holder.actions
	if(isnull(slime_hydrophobia) && isroundstartslime(quirk_holder) && !HAS_TRAIT(quirk_holder, TRAIT_WATER_BREATHING))
		slime_hydrophobia = new(src)
		slime_hydrophobia.Grant(quirk_holder)
