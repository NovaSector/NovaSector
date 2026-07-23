/datum/map_template/shuttle/salvage_scrap/scrappie
	name = "Salvage Training Shuttle"
	description = "Everyone's favourite salvage training ship, nearly clean of danger and excitement \
		in an effort to teach a new generation of shipbreakers how to do the job safely."
	suffix = "scrappie"
	prior_name = "Scrappie"
	ship_class = "Training Ship"
	prior_usage = "Shipbreaker training vessel."
	ship_hazards = list(
		SALVAGE_HAZARD_COOLANT,
		SALVAGE_HAZARD_ELECTRICAL,
		SALVAGE_HAZARD_CARGO,
	)
	prior_owner_datum = /datum/shipbreaking_owner/pallas
	prior_date = "2520 to Present"
	shows_up_as_salvage = FALSE // scrappie doesn't randomly roll with the other shuttles
