/datum/map_template/shuttle/salvage_scrap/meridian_passenger
	name = "Meridian Station Hopper"
	suffix = "meridian_passenger"
	ship_class = "Meridian Station Hopper"
	prior_usage = "Short range passenger transfer."
	ship_hazards = list(
		SALVAGE_HAZARD_ELECTRICAL,
		SALVAGE_HAZARD_FUEL,
		SALVAGE_HAZARD_REACTOR,
	)
	random_owner_types = list(
		/datum/shipbreaking_owner/shipping,
		/datum/shipbreaking_owner/medical,
		/datum/shipbreaking_owner/mining,
	)
