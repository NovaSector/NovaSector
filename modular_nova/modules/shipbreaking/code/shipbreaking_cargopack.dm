/datum/supply_pack/engineering/shipbreaker_set
	name = "Shipbreaking Equipment Set"
	desc = "A set of necessary equipment to begin shipbreaking. Two engineering modsuits, docking clamp board, salvage computer board, recyclers, and plasma cutters. Air supply not included."
	cost = CARGO_CRATE_VALUE * 6 // 1200
	contains = list(/obj/item/circuitboard/computer/salvage_computer,
					/obj/item/circuitboard/machine/docking_clamp,
					/obj/item/mod/control/pre_equipped/engineering,
					/obj/item/mod/control/pre_equipped/engineering,
					/obj/item/circuitboard/machine/recycler,
					/obj/item/circuitboard/machine/recycler,
					/obj/item/gun/energy/plasmacutter,
					/obj/item/gun/energy/plasmacutter,
					)
	crate_name = "Shipbreaking Equipment Set"
