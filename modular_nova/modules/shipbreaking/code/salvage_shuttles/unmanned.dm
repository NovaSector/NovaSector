/datum/map_template/shuttle/salvage_scrap/solar_probe
	name = "Solestra Probe (Research)"
	suffix = "solestra_probe"
	ship_class = "Solestra Probe"
	prior_usage = "Unmanned research data collection and observation"
	ship_hazards = list(
		SALVAGE_HAZARD_ELECTRICAL,
		SALVAGE_HAZARD_SHIPMIND,
		SALVAGE_HAZARD_COOLANT,
	)
	random_owner_types = list(
		/datum/shipbreaking_owner/research,
	)

/datum/map_template/shuttle/salvage_scrap/mining_probe
	name = "Solestra Probe (Mining)"
	suffix = "solestra_probe_mining"
	ship_class = "Solestra Probe"
	prior_usage = "Unmanned material and geological surveys."
	ship_hazards = list(
		SALVAGE_HAZARD_ELECTRICAL,
		SALVAGE_HAZARD_SHIPMIND,
		SALVAGE_HAZARD_COOLANT,
		SALVAGE_HAZARD_FUEL,
	)
	random_owner_types = list(
		/datum/shipbreaking_owner/mining,
	)
