/datum/crafting_recipe/manual_charger
	name = "dynamo machine"
	result = /obj/item/manual_charger
	reqs = list(
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/servo = 1,
		/obj/item/stack/cable_coil = 10,
		/obj/item/stack/rods = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/sheet/iron = 6,
	)
	tool_behaviors = list(TOOL_WELDER,TOOL_WRENCH,TOOL_WIRECUTTER)
	time = 20 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/drone_handmade
	name = "dynamo machine"
	result = /mob/living/basic/drone/handmade
	reqs = list(
		/obj/item/stock_parts/servo = 2,
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stack/cable_coil = 10,
		/obj/item/stack/rods = 8,
		/obj/item/stack/sheet/glass = 5,
		/obj/item/stack/sheet/iron = 10,
	)
	tool_behaviors = list(TOOL_WELDER,TOOL_WRENCH,TOOL_WIRECUTTER,TOOL_MULTITOOL,TOOL_SCREWDRIVER)
	time = 30 SECONDS
	category = CAT_ROBOT

/datum/crafting_recipe/manual_charger
	name = "dynamo machine"
	result = /obj/item/manual_charger
	reqs = list(
		/obj/item/stock_parts/servo = 2,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 10,
		/obj/item/stack/rods = 4,
		/obj/item/stack/sheet/glass = 2,
		/obj/item/stack/sheet/iron = 6,
	)
	tool_behaviors = list(TOOL_WELDER,TOOL_WRENCH,TOOL_WIRECUTTER,TOOL_MULTITOOL,TOOL_SCREWDRIVER)
	time = 40 SECONDS
	category = CAT_TOOLS
