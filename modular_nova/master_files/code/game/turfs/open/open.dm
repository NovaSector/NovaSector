/turf/open/misc/beach
	leave_footprints = FALSE

/turf/open/misc/asteroid/snow/Initialize(mapload)
	// no footprints if the mapping level doesn't naturally have snowstorms
	if(!SSmapping.level_trait(z, ZTRAIT_SNOWSTORM))
		leave_footprints = FALSE
	return ..()

/turf/open/misc/snow/Initialize(mapload)
	// no footprints if the mapping level doesn't naturally have snowstorms
	if(!SSmapping.level_trait(z, ZTRAIT_SNOWSTORM))
		leave_footprints = FALSE
	return ..()
