/datum/preference_middleware/species/pre_set_preference(mob/user, preference, value)
	preferences.species_updated(GLOB.species_list[value])
	return ..()
