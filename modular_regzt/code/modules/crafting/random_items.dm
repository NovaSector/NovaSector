/*
manual_charger
drone_handmade
stosk_part
handmade tool
mist
*/

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

//stosk_part

/datum/crafting_recipe/capacitor_handmade
	name = "handmade capacitor"
	result = /obj/item/stock_parts/capacitor/handmade
	reqs = list(
		/obj/item/stack/rods = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/sheet/iron = 2,
	)
	tool_behaviors = list(TOOL_WELDER,TOOL_WIRECUTTER)
	time = 20 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/scanning_module_handmade
	name = "handmade scanning module"
	result = /obj/item/stock_parts/scanning_module/handmade
	reqs = list(
		/obj/item/stack/rods = 2,
		/obj/item/stack/sheet/glass = 5,
		/obj/item/stack/sheet/iron = 2,
		/obj/item/stack/cable_coil = 5,
	)
	tool_behaviors = list(TOOL_WELDER,TOOL_WIRECUTTER,TOOL_SCREWDRIVER,TOOL_CROWBAR)
	time = 40 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/servo_handmade
	name = "handmade servo"
	result = /obj/item/stock_parts/servo/handmade
	reqs = list(
		/obj/item/stack/rods = 4,
		/obj/item/stack/sheet/iron = 5,
		/obj/item/stack/cable_coil = 10,
	)
	tool_behaviors = list(TOOL_WELDER,TOOL_WRENCH,TOOL_WIRECUTTER,TOOL_SCREWDRIVER,TOOL_CROWBAR)
	time = 30 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/laser_handmade
	name = "handmade laser"
	result = /obj/item/stock_parts/laser/handmade
	reqs = list(
		/obj/item/stack/rods = 2,
		/obj/item/stack/sheet/glass = 3,
		/obj/item/stack/sheet/iron = 2,
		/obj/item/stack/cable_coil = 2,
	)
	tool_behaviors = list(TOOL_WELDER,TOOL_WIRECUTTER,TOOL_SCREWDRIVER,TOOL_CROWBAR)
	time = 30 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/matter_bin_handmade
	name = "handmade matter_bin"
	result = /obj/item/stock_parts/matter_bin/handmade
	reqs = list(
		/obj/item/stack/rods = 2,
		/obj/item/stack/sheet/iron = 8,
	)
	tool_behaviors = list(TOOL_WELDER,TOOL_SCREWDRIVER,TOOL_CROWBAR)
	time = 20 SECONDS
	category = CAT_TOOLS

//handmade tool

/datum/crafting_recipe/crowbar
	name = "Makeshift Crowbar"
	result = /obj/item/crowbar/makeshift
	reqs = list(/obj/item/stack/rods = 3)
	time = 40
	category = CAT_TOOLS

/datum/crafting_recipe/screwdriver
	name = "Makeshift Screwdriver"
	result = /obj/item/screwdriver/makeshift
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/iron = 1)
	tool_behaviors = list(TOOL_CROWBAR)
	time = 40
	category = CAT_TOOLS

/datum/crafting_recipe/wirecutters
	name = "Makeshift Wirecutters"
	result = /obj/item/wirecutters/makeshift
	reqs = list(/obj/item/stack/rods = 2,
			/obj/item/stack/sheet/iron = 2,
			/obj/item/stack/cable_coil = 2)
	tool_behaviors = list(TOOL_CROWBAR, TOOL_SCREWDRIVER)
	time = 40
	category = CAT_TOOLS

/datum/crafting_recipe/wrench
	name = "Makeshift Wrench"
	result = /obj/item/wrench/makeshift
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/iron = 1)
	tool_behaviors = list(TOOL_CROWBAR, TOOL_SCREWDRIVER)
	time = 40
	category = CAT_TOOLS

/datum/crafting_recipe/makeshift_welder
	name = "Makeshift Welder"
	result = /obj/item/weldingtool/makeshift
	reqs = list(/obj/item/stack/rods = 4,
				/obj/item/stack/sheet/iron = 5,
				/obj/item/stack/cable_coil = 5,
				/obj/item/assembly/igniter = 1)
	tool_behaviors = list(TOOL_CROWBAR, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 40
	category = CAT_TOOLS

/datum/crafting_recipe/multitool_makeshift
	name = "makeshift multitool"
	result = /obj/item/multitool/makeshift
	reqs = list(
		/obj/item/stack/rods = 2,
		/obj/item/stack/sheet/iron = 2,
		/obj/item/stack/cable_coil = 8,
		/obj/item/assembly/igniter = 1,
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stack/sheet/glass = 2,
	)
	tool_behaviors = list(TOOL_WRENCH,TOOL_WIRECUTTER,TOOL_SCREWDRIVER,TOOL_CROWBAR)
	time = 60 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/analyzer_makeshift
	name = "makeshift analyzer"
	result = /obj/item/analyzer/makeshift
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/stack/sheet/iron = 2,
		/obj/item/stack/cable_coil = 4,
		/obj/item/stock_parts/scanning_module = 2,
		/obj/item/stack/sheet/glass = 2,
	)
	tool_behaviors = list(TOOL_WRENCH,TOOL_WIRECUTTER,TOOL_SCREWDRIVER,TOOL_CROWBAR)
	time = 60 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/makeshift_shovel
	name = "Makeshift shovel"
	result = /obj/item/shovel/makeshift
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/sheet/iron = 2)
	tool_behaviors = list(TOOL_CROWBAR)
	time = 40
	category = CAT_TOOLS

/datum/crafting_recipe/makeshift_arc_welder
	name = "makeshift arc welder"
	result = /obj/item/weldingtool/electric/arc_welder/makeshift
	reqs = list(/obj/item/stack/rods = 4,
				/obj/item/stock_parts/capacitor = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/stack/cable_coil = 10,
				/obj/item/stack/sheet/iron = 4)
	tool_behaviors = list(TOOL_CROWBAR, TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WRENCH)
	time = 60
	category = CAT_TOOLS

//mist

/datum/crafting_recipe/cable_coil
	name = "cable coil"
	result = /obj/item/stack/cable_coil
	reqs = list(/obj/item/stack/rods = 30,
			/obj/item/stack/sheet/glass = 15)
	tool_behaviors = list(TOOL_CROWBAR, TOOL_SCREWDRIVER)
	time = 70
	category = CAT_TOOLS

/datum/crafting_recipe/igniter
	name = "Igniter"
	result = /obj/item/assembly/igniter
	reqs = list(/obj/item/stack/sheet/iron = 1,
				/obj/item/stack/rods = 2)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 30
	category = CAT_TOOLS
