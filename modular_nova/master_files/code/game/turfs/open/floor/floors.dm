/// Add atmos tiles here for planetside safety

/turf/open/misc/beach/sand/safe_planet
	/// Initial gas mix should always be the specific planet's atmos ID
	initial_gas_mix = SAFE_PLANET_ATMOS
	/// Planetary atmos specifically makes it so incorrect gasses are deleted overtime, such as plasma, carbon, etc. This prevents planets from suddenly having too much plasma from a turbine or SM waste.
	planetary_atmos = TRUE

/turf/open/misc/beach/coast/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/beach/coast/corner/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/grass/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/wood/large/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/wood/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/iron/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/stone/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/openspace/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/openspace/safe_planet
