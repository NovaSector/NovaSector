/datum/map_template/shuttle/personal_buyable/mining
	personal_shuttle_type = PERSONAL_SHIP_TYPE_MINING
	port_id = "mining"

// One of the transport ships, but retrofit for carrying cargo in a central bay

/datum/map_template/shuttle/personal_buyable/mining/small_cargo
	name = "CAS Tawsil"
	description = "A small cargo ship based off of another shuttle design, retains space for crew \
		and a front mounted hold, while also featuring a retrofitted bay for loaders."
	credit_cost = CARGO_CRATE_VALUE * 12
	suffix = "tawsil"
	width = 23
	height = 10
	personal_shuttle_size = PERSONAL_SHIP_MEDIUM

/area/shuttle/personally_bought/small_cargo
	name = "CAS Tawsil"

// Mining ship, meant to be a hub for deep space mech mining

/datum/map_template/shuttle/personal_buyable/mining/mech_hub
	name = "CAS Cigale"
	description = "A large shuttle for mining and cargo, features a large hold in the center of the ship, \
		as well as living space for crew and a decently sized loader bay."
	credit_cost = CARGO_CRATE_VALUE * 22
	suffix = "cigale"
	width = 28
	height = 11
	personal_shuttle_size = PERSONAL_SHIP_LARGE

/area/shuttle/personally_bought/mining_hub
	name = "CAS Cigale"
