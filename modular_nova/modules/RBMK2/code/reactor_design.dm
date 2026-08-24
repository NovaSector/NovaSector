/datum/design/board/rbmk2_reactor
	name = "RB-MK2 Reactor Board"
	desc = "The circuit board for a RB-MK2 reactor."
	build_path = /obj/item/circuitboard/machine/rbmk2
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 8)
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/board/rbmk2_reactor_sniffer
	name = "RB-MK2 Reactor Sniffer"
	desc = "The circuit board for a RB-MK2 reactor sniffer."
	build_path = /obj/item/circuitboard/machine/rbmk2_sniffer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/rbmk2_rod
	name = "RB-MK2 Reactor Rod"
	desc = "A specialized rod for the RB-MK2 reactor."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 2)
	construction_time = 100
	build_path = /obj/item/tank/rbmk2_rod
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/rbmk2
	display_name = "RB-MK2"
	description = "The latest in non-dangerous Nanotrasen power generation!"
	prerequisite_nodes = list(/datum/techweb_node/energy_manipulation)
	unlocked_designs = list(
		/datum/design/board/rbmk2_reactor,
		/datum/design/rbmk2_rod,
		/datum/design/board/rbmk2_reactor_sniffer,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	announce_channels = list(RADIO_CHANNEL_ENGINEERING)
