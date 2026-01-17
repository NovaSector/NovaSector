/datum/crafting_recipe/charge_holster
	name = "Energy Shoulder Holster Conversion"
	desc = "Retool a regular shoulder holster into one that can't hold regular sidearms, but can recharge energy weapons."
	result = /obj/item/storage/belt/holster/energy
	reqs = list(
		/obj/item/storage/belt/holster = 1, // holster
		/obj/item/stack/sheet/plastic = 2, // insulation
		/obj/item/stock_parts/capacitor = 1, // capacitor
		/obj/item/circuitboard/machine/recharger = 1, // recharger board (cannibalized)
	)
	steps = list(
		"Empty the holster",
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 15 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/charge_holster/New()
	. = ..()
	LAZYOR(blacklist, (subtypesof(/obj/item/storage/belt/holster) - list(/obj/item/storage/belt/holster/thigh)) + subtypesof(/obj/item/stock_parts/capacitor))

/datum/crafting_recipe/charge_holster/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/storage/belt/holster/the_drip = collected_requirements[/obj/item/storage/belt/holster][1]
	if(length(the_drip.contents))
		return FALSE
	return ..()

/datum/crafting_recipe/supercharge_holster
	name = "High-Output Energy Shoulder Holster Conversion"
	desc = "Sacrifice the second holster in return for extra charging throughput on your energy holster. \
		Do you lose the ability to have two guns? Yes. Do you have a faster wearable recharger? Also yes."
	result = /obj/item/storage/belt/holster/energy/onegun
	reqs = list(
		/obj/item/storage/belt/holster/energy = 1,
		/obj/item/stack/sheet/plastic = 3, // more insulation
		/obj/item/stock_parts/capacitor/quadratic = 1,
	)
	steps = list(
		"Empty the holster",
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 15 SECONDS
	category = CAT_CLOTHING
	blacklist = list(/obj/item/storage/belt/holster/energy/onegun,)

/datum/crafting_recipe/supercharge_holster/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/storage/belt/holster/the_drip = collected_requirements[/obj/item/storage/belt/holster/energy][1]
	if(length(the_drip.contents))
		return FALSE
	return ..()
