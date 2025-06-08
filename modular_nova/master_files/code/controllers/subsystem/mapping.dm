/// Returns true if the map we're playing on is on a planet, but it DOES have space access.
/datum/controller/subsystem/mapping/proc/is_planetary_with_space()
	return is_planetary() && current_map.allow_space_when_planetary


/datum/map_config
	/// Are we allowing space even if we're planetary?
	var/allow_space_when_planetary = FALSE

/datum/controller/subsystem/mapping/setup_ruins()
	// Jungle Ruins, Serenity
	var/list/jungle_ruins = levels_by_trait(ZTRAIT_JUNGLE_RUINS)
	if(jungle_ruins.len)
		seedRuins(jungle_ruins, CONFIG_GET(number/jungle_budget), list(/area/forestplanet/outdoors/unexplored), themed_ruins[ZTRAIT_JUNGLE_RUINS], clear_below = TRUE)

	// Jungle Cave Ruins, Serenity
	var/list/jungle_cave_ruins = levels_by_trait(ZTRAIT_JUNGLE_CAVE_RUINS)
	if(jungle_cave_ruins.len)
		seedRuins(jungle_ruins, CONFIG_GET(number/jungle_cave_budget), list(/area/forestplanet/outdoors/unexplored/deep), themed_ruins[ZTRAIT_JUNGLE_CAVE_RUINS], clear_below = TRUE)
	return ..()
