/datum/map_template/shuttle/salvage_scrap/meridian_exolab
	name = "Meridian Exolab"
	suffix = "meridian_exolab"
	ship_class = "Meridian Exolab"
	prior_usage = "Local system research and surveys."
	ship_hazards = list(
		SALVAGE_HAZARD_ELECTRICAL,
		SALVAGE_HAZARD_FUEL,
		SALVAGE_HAZARD_REACTOR,
		SALVAGE_HAZARD_CARGO,
	)
	random_owner_types = list(
		/datum/shipbreaking_owner/research,
		/datum/shipbreaking_owner/medical,
	)
