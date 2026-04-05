/datum/crafting_recipe/manual_charger
	name = "dynamo machine"
	result = /obj/item/manual_charger
	reqs = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/stack/rods = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/sheet/iron = 6,
	)
	tool_behaviors = list(TOOL_WELDER,TOOL_WRENCH,TOOL_WIRECUTTER)
	time = 20 SECONDS
	category = CAT_TOOLS
