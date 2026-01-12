/datum/quirk/masquerade_food
	name = "Masquerade"
	desc = "A hemophage that has adapted to be able to consume normal food and drink. Such an act is merely for pleasure, as they derive no nutritional benefit from such."
	gain_text = span_notice("You feel that your body has adapted to consumption of normal food and drink without mixing in blood.")
	lose_text = span_danger("You feel that your body is no longer able to consume normal food or drink without mixing in blood.")
	medical_record_text = "Patient is able to consume food or drink without having to mix in blood, though they derive no nutritional benefit from it."
	value = 2
	mob_trait = TRAIT_MASQUERADE_FOOD
	icon = FA_ICON_MASK
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/masquerade_food/is_species_appropriate(datum/species/mob_species)
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits
	if(TRAIT_DRINKS_BLOOD in species_traits)
		return TRUE
	else
		return FALSE
