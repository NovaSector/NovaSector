/datum/quirk/rad_fiend
	name = "Rad Fiend"
	desc = "You've been blessed by Cherenkov's warming light! Radiation is incapable of penetrating your protective barrier."
	value = 6
	gain_text = span_notice("You feel empowered by Cherenkov's glow.")
	lose_text = span_notice("You realize that rads aren't so rad.")
	medical_record_text = "Patient emits a slight radioactive aura. The effect is harmless."
	mob_trait = TRAIT_RADIMMUNE
	icon = FA_ICON_RADIATION
	mail_goodies = list (
		/obj/item/geiger_counter = 1,
		/datum/glass_style/drinking_glass/nuka_cola,
	)

// This quirk does two things:
// - Immunity to radiation
// - A favorite food mood bonus for drinking Nuka Cola

/datum/quirk/rad_fiend/is_species_appropriate(datum/species/mob_species)
	if(TRAIT_RADIMMUNE in GLOB.species_prototypes[mob_species].inherent_traits)
		return FALSE
	return ..()

/datum/quirk/rad_fiend/add()
	// Add radiation immunity
	ADD_TRAIT(quirk_holder, TRAIT_RADIMMUNE, REF(src))

/datum/quirk/rad_fiend/remove()
	// Remove radiation immunity
	REMOVE_TRAIT(quirk_holder, TRAIT_RADIMMUNE, REF(src))
