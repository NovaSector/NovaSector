//Mining Component
/datum/design/component/mining
	name = "Mining Component"
	build_path = /obj/item/circuit_component/mining

//Item Interact Component
/datum/design/component/item_interact
	name = "Item Interact Component"
	build_path = /obj/item/circuit_component/item_interact

/datum/techweb_node/comp_advanced_interacts
	display_name = "Advanced Action Components"
	description = "Grants access to more advanced action components for the drone shell."
	prerequisite_nodes = list(/datum/techweb_node/programmed_robot)
	unlocked_designs = list(
		/datum/design/component/mining,
		/datum/design/component/item_interact,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

//Target Scanner Component
/datum/design/component/radar_scanner
	name = "Target Scanner Component"
	build_path = /obj/item/circuit_component/target_scanner

//Cell Charge Component
/datum/design/component/cell_charge
	name = "Cell Charge Component"
	build_path = /obj/item/circuit_component/cell_charge

/datum/techweb_node/comp_advanced_sensors
	display_name = "Advanced Sensor Components"
	description = "Grants access to advanced sensor components component for shells."
	prerequisite_nodes = list(/datum/techweb_node/programming)
	unlocked_designs = list(
		/datum/design/component/radar_scanner,
		/datum/design/component/cell_charge,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)
