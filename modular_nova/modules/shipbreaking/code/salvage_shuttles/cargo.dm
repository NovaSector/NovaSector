/datum/map_template/shuttle/salvage_scrap/meridian_cargo
	name = "Meridian Cargo Shuttle"
	suffix = "meridian_cargo"
	ship_class = "Meridian Cargo Shuttle"
	prior_usage = "Short range cargo delivery."
	ship_hazards = list(
		SALVAGE_HAZARD_ELECTRICAL,
		SALVAGE_HAZARD_FUEL,
		SALVAGE_HAZARD_REACTOR,
		SALVAGE_HAZARD_CARGO,
	)
	random_owner_types = list(
		/datum/shipbreaking_owner/shipping,
		/datum/shipbreaking_owner/mining,
	)

/datum/map_template/shuttle/salvage_scrap/ikwa_cargo
	name = "Ikwa Heavy Cargo"
	suffix = "ikwa_cargo"
	ship_class = "Ikwa Heavy Cargo"
	prior_usage = "Long range cargo hauling."
	ship_hazards = list(
		SALVAGE_HAZARD_ELECTRICAL,
		SALVAGE_HAZARD_COOLANT,
		SALVAGE_HAZARD_CARGO,
		SALVAGE_HAZARD_FUEL,
		SALVAGE_HAZARD_REACTOR,
	)
	random_owner_types = list(
		/datum/shipbreaking_owner/shipping,
	)

/datum/map_template/shuttle/salvage_scrap/ikwa_tanker
	name = "Ikwa Fuel Tanker"
	suffix = "ikwa_tanker"
	ship_class = "Ikwa Fuel Tanker"
	prior_usage = "Long range fuel hauling."
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
		/datum/shipbreaking_owner/military,
	)

/datum/map_template/shuttle/salvage_scrap/vautour_cargo
	name = "Vautour Container Skipper"
	suffix = "vautour_cargo"
	ship_class = "Vautour Container Skipper"
	prior_usage = "Inter-orbital container and large cargo shipping."
	ship_hazards = list(
		SALVAGE_HAZARD_ELECTRICAL,
		SALVAGE_HAZARD_COOLANT,
		SALVAGE_HAZARD_CARGO,
		SALVAGE_HAZARD_FUEL,
		SALVAGE_HAZARD_REACTOR,
	)
	random_owner_types = list(
		/datum/shipbreaking_owner/shipping,
	)
