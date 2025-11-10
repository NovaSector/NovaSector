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

/obj/machinery/computer/order_console/mining/interdyne/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/voucher_redeemer, /obj/item/mining_voucher, /datum/voucher_set/mining)
	AddElement(/datum/element/voucher_redeemer/interdyne, /obj/item/mining_voucher, /datum/voucher_set/mining)

/datum/element/voucher_redeemer/interdyne/generate_sets()
	..()
	qdel(set_instances[/datum/voucher_set/mining/minebot_kit::name])
	set_instances[/datum/voucher_set/mining/minebot_kit::name] = new /datum/voucher_set/interdyne/minebot_kit

/mob/living/basic/mining_drone/interdyne
	name = "\improper Interdyne minebot"
	faction = list(FACTION_NEUTRAL, ROLE_INTERDYNE_PLANETARY_BASE)

/datum/voucher_set/interdyne/minebot_kit
	name = "Minebot Kit"
	description = "Contains a little minebot companion that helps you in storing ore and hunting wildlife. Also comes with an upgraded industrial welding tool (80u), a welding mask and a KA modkit that allows shots to pass through the minebot."
	icon = 'icons/mob/silicon/aibots.dmi'
	icon_state = "mining_drone"
	set_items = list(
		/mob/living/basic/mining_drone/interdyne,
		/obj/item/weldingtool/hugetank,
		/obj/item/clothing/head/utility/welding,
		/obj/item/borg/upgrade/modkit/minebot_passthrough,
	)
