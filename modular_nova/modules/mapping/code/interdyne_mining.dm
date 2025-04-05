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
		CATEGORY_INTERDYNE,
		CATEGORY_GOLEM,
	)

// This is honestly quite terrible but, replaces voucher spawned mining drones with the interdyne subtype at this console
/datum/voucher_set/mining/minebot_kit/spawn_set(atom/spawn_loc)
	if(!istype(get_area(spawn_loc), /area/ruin/interdyne_planetary_base))
		return ..()
	var/drone_index = set_items.Find(/mob/living/basic/mining_drone)
	if(drone_index)
		set_items[drone_index] = /mob/living/basic/mining_drone/interdyne
	return ..()

/mob/living/basic/mining_drone/interdyne
	name = "\improper Interdyne minebot"
	faction = list(FACTION_NEUTRAL, ROLE_INTERDYNE_PLANETARY_BASE)
