/datum/map_template/shuttle/personal_buyable/mothership
	personal_shuttle_type = PERSONAL_SHIP_TYPE_MOTHERSHIP
	port_id = "outbound"

// One of the transport ships, but retrofit for carrying cargo in a central bay

/datum/map_template/shuttle/personal_buyable/mothership/station_shuttle
	name = "MZH Farax-Guiji"
	description = "The mothership of the station-going fleet, \
		with advanced support facilities as well as research \
		capability, it is the heart of any fleet-to-be."
	credit_cost = CARGO_CRATE_VALUE * 100
	suffix = "expedition"
	width = 42
	height = 18
	personal_shuttle_size = PERSONAL_SHIP_LARGE

/datum/map_template/shuttle/personal_buyable/mothership/station_shuttle/spawner
	name = "MZH Farax-Guiji (SPAWN LANDMARKS)"
	suffix = "expedition_spawner"

/area/shuttle/personally_bought/mothership
	name = "MZH Farax-Guiji"
