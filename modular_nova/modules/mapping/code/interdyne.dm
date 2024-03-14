/obj/item/circuitboard/computer/order_console/mining/interdyne
	name = "Interdyne Mining Equipment Vendor Console"
	build_path = /obj/machinery/computer/order_console/mining/interdyne

// Interdyne/DS-2 mining equipment vendor that doesn't need a cargo shuttle to work

/obj/machinery/computer/order_console/mining/interdyne
	name = "Interdyne mining equipment vendor"
	circuit = /obj/item/circuitboard/computer/order_console/mining/interdyne
	forced_express = TRUE
	express_cost_multiplier = 1
	order_categories = list(
		CATEGORY_MINING,
		CATEGORY_CONSUMABLES,
		CATEGORY_TOYS_DRONE,
		CATEGORY_PKA,
	)

// This is honestly quite terrible but, replaces voucher spawned mining drones with the interdyne subtype at this console

/obj/machinery/computer/order_console/mining/interdyne/redeem_voucher(obj/item/mining_voucher/voucher, mob/redeemer)
	. = ..()
	for(var/mob/living/basic/mining_drone/drone in drop_location())
		// There could already be an interdyne drone there
		if(!istype(drone, /mob/living/basic/mining_drone/interdyne))
			qdel(drone)
			new /mob/living/basic/mining_drone/interdyne(drop_location())

// Interdyne minebot

/mob/living/basic/mining_drone/interdyne
	name = "\improper Interdyne minebot"
	faction = list(FACTION_NEUTRAL, ROLE_SYNDICATE)

// Upgraded Interdyne science/chemistry machines

/obj/machinery/processor/slime/fullupgrade
	obj_flags = parent_type::obj_flags | NO_DECONSTRUCTION
	circuit = /obj/item/circuitboard/machine/processor/slime/fullupgrade

/obj/item/circuitboard/machine/processor/slime/fullupgrade
	name = "Slime Processor"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/processor/slime/fullupgrade
	req_components = list(
		/datum/stock_part/servo/tier4  = 1,
		/datum/stock_part/matter_bin/tier4 = 1,
		)

/obj/machinery/monkey_recycler/fullupgrade
	obj_flags = parent_type::obj_flags | NO_DECONSTRUCTION
	circuit = /obj/item/circuitboard/machine/monkey_recycler/fullupgrade

/obj/item/circuitboard/machine/monkey_recycler/fullupgrade
	name = "Monkey Recycler"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/monkey_recycler/fullupgrade
	req_components = list(
		/datum/stock_part/servo/tier4  = 1,
		/datum/stock_part/matter_bin/tier4 = 1,
		)

/obj/machinery/chem_master/fullupgrade
	name = "ChemMaster 4000"
	obj_flags = parent_type::obj_flags | NO_DECONSTRUCTION
	circuit = /obj/item/circuitboard/machine/chem_master/fullupgrade

/obj/item/circuitboard/machine/chem_master/fullupgrade
	name = "ChemMaster 4000"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/chem_master/fullupgrade
	desc = "You can turn the \"mode selection\" dial using a screwdriver, but you might not be able to turn it back."
	req_components = list(
		/obj/item/reagent_containers/cup/beaker/bluespace = 2,
		/datum/stock_part/servo/tier4 = 1,
		/obj/item/stack/sheet/glass = 1,
		)
	needs_anchored = FALSE

