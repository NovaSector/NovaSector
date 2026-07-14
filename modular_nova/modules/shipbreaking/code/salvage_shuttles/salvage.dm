/datum/map_template/shuttle/salvage_scrap/vautour_salvage
	name = "Vautour Salvage Runner"
	suffix = "vautour_salvage"
	ship_class = "Vautour Salvage Runner"
	prior_usage = "In-situ salvage operations."
	ship_hazards = list(
		SALVAGE_HAZARD_ELECTRICAL,
		SALVAGE_HAZARD_COOLANT,
		SALVAGE_HAZARD_CARGO,
		SALVAGE_HAZARD_FUEL,
		SALVAGE_HAZARD_REACTOR,
	)
	random_owner_types = list(
		/datum/shipbreaking_owner/shipping,
		/datum/shipbreaking_owner/mining,
	)
