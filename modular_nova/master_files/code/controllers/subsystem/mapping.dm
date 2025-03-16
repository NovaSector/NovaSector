/// Returns true if the map we're playing on is on a planet, but it DOES have space access.
/datum/controller/subsystem/mapping/proc/is_planetary_with_space()
	return is_planetary() && current_map.allow_space_when_planetary

/// Sets up modular ruin archetypes
/datum/controller/subsystem/mapping/setup_ruins()
	// Ocean Ruins, Aquastation
	var/list/ocean_ruins = levels_by_trait(ZTRAIT_OCEAN_RUINS)
	if(ocean_ruins.len)
		seedRuins(ocean_ruins, CONFIG_GET(number/ocean_budget), list(/area/ocean/generated), themed_ruins[ZTRAIT_OCEAN_RUINS], clear_below = TRUE)

	// Trench Ruins, Aquastation
	var/list/trench_ruins = levels_by_trait(ZTRAIT_TRENCH_RUINS)
	if(trench_ruins.len)
		seedRuins(trench_ruins, CONFIG_GET(number/trench_budget), list(/area/ocean/trench/generated), themed_ruins[ZTRAIT_TRENCH_RUINS], clear_below = TRUE)
	return ..()


/datum/map_config
	/// Are we allowing space even if we're planetary?
	var/allow_space_when_planetary = FALSE
