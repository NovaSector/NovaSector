/datum/atmosphere/safe_planet
	id = SAFE_PLANET_ATMOS

	base_gases = list(
		/datum/gas/oxygen=5,
		/datum/gas/nitrogen=10,
	)
	normal_gases = list(
		/datum/gas/oxygen=10,
		/datum/gas/carbon_dioxide=0.4,
	)
	restricted_gases = list(
	)
	restricted_chance = 0

	minimum_pressure = SAFE_PLANET_PRESSURE
	maximum_pressure = SAFE_PLANET_PRESSURE

	minimum_temp = SAFE_PLANET_TEMPERATURE - 5
	maximum_temp = SAFE_PLANET_TEMPERATURE + 5
