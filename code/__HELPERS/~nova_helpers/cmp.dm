/// Orders species by priority
/proc/cmp_species_priority(datum/species/species_a, datum/species/species_b)
	return initial(species_b.species_sort_priority) - initial(species_a.species_sort_priority)
