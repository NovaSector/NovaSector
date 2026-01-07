//
// Plantbag of Holding - 4x capacity but needs a bluespace core. Or a similar analogue.
//
/obj/item/storage/bag/plants/bluespace
	name = "plant bag of holding"
	desc = "A plant bag that holds a vast amount of botanicals."
	storage_type = /datum/storage/bag/plants/bluespace
	icon = 'modular_nova/master_files/icons/obj/storage/plantbag_of_holding.dmi'
	icon_state = "plantbag_of_holding"
	worn_icon_state = "plantbag"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.5)

//4x the size of a normal plant bag. this probably won't break things. probably.

/obj/item/storage/bag/plants/bluespace/setup_reskins()
	return

/datum/storage/bag/plants/bluespace
	max_total_storage = 400
	max_slots = 400

//Botany can make their own bluespace cores! Sort of.
/obj/item/botany_bluespace_core
	name = "botanical bluespace core"
	desc = "Botany's version of a bluespace core. Plenty of bluespace juice to go around! Let's ignore the fact that it's just a bunch of bluespace bananas wrapped around a tomato with some wire running through them."
	icon = 'modular_nova/master_files/icons/obj/storage/plantbag_of_holding.dmi'
	icon_state = "botanical_core"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.15, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.15)

/obj/item/plantbag_of_holding_inert
	name = "inert plantbag of holding"
	desc = "An inert container ready to accept a bluespace core. This one is tuned to hold plants.."
	icon = 'modular_nova/master_files/icons/obj/storage/plantbag_of_holding.dmi'
	icon_state = "plantbag_of_holding_inert"
	w_class = WEIGHT_CLASS_BULKY
	item_flags = NO_MAT_REDEMPTION

/obj/item/plantbag_of_holding_inert/examine_more(mob/user)
	. = ..()
	. += span_smallnoticeital("<i>Surely you don't have to bother science with this, right..?</i>\n")

//So while we CAN use a real refined bluespace core, we can also use a goofy botany-only "bluespace core" as well
/datum/crafting_recipe/botany_bluespace_core
	name = "Botanical Bluespace Core"
	result = /obj/item/botany_bluespace_core
	reqs = list(
		/obj/item/food/grown/banana/bluespace = 6,
		/obj/item/food/grown/tomato/blue/bluespace = 1,
		/obj/item/stack/cable_coil = 15,
	)
	time = 5 SECONDS
	category = CAT_MISC

/datum/crafting_recipe/plantbag_of_holding_botanycore
	name = "Plant Bag of Holding"
	result = /obj/item/storage/bag/plants/bluespace
	reqs = list(
		/obj/item/plantbag_of_holding_inert = 1,
		/obj/item/botany_bluespace_core = 1,
	)
	tool_behaviors = list(TOOL_SHOVEL)
	time = 5 SECONDS
	category = CAT_CONTAINERS

/datum/crafting_recipe/plantbag_of_holding_realcore
	name = "Plant Bag of Holding"
	result = /obj/item/storage/bag/plants/bluespace
	reqs = list(
		/obj/item/plantbag_of_holding_inert = 1,
		/obj/item/assembly/signaler/anomaly/bluespace = 1,
	)
	tool_behaviors = list(TOOL_SHOVEL)
	time = 5 SECONDS
	category = CAT_CONTAINERS
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/datum/design/plantbag_of_holding
	name = "Plant Bag of Holding"
	id = "plantbag_holding"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/plantbag_of_holding_inert
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_BOTANY_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

