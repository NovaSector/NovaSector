//rimmmmmwoorrld yyeeeee port

/datum/crafting_recipe/autolathe_spot
	name = "assembly spot"
	result = /obj/item/autolathe_spot
	reqs = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/assembly/igniter = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/servo  = 2,
	)
	tool_behaviors = list(TOOL_WRENCH,TOOL_WIRECUTTER,TOOL_SCREWDRIVER,TOOL_CROWBAR)
	time = 10 SECONDS
	category = CAT_TOOLS

/obj/machinery/autolathe/spot
	name = "assembly spot"
	desc = "place for various activities"
	icon = 'modular_regzt/icons/obj/structures/spot.dmi'
	icon_state = "assembly_spot"
	base_icon_state = "assembly_spot"
	max_integrity = 50
	use_power = NO_POWER_USE
	idle_power_usage = 0
	active_power_usage = 0
	density = FALSE
	anchored = FALSE
	circuit = NONE
	creation_efficiency = 3
	var/repacked_type = /obj/item/autolathe_spot

/obj/machinery/autolathe/spot/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/autolathe/spot/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/autolathe/spot/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/machinery/autolathe/spot/Initialize(mapload)
	. = ..()
	if(materials)
		materials.max_amount = 10 * SHEET_MATERIAL_AMOUNT  // 10 листов
	AddElement(/datum/element/repackable, repacked_type, 5 SECONDS)

// Критически важное исправление:
/obj/machinery/autolathe/spot/directly_use_energy(amount)
	return TRUE

/obj/item/autolathe_spot
	name = "folded assembly tool"
	desc = /obj/machinery/autolathe/spot::desc
	icon = 'modular_regzt/icons/obj/structures/spot.dmi'
	icon_state = "folded_assembly_spot"
	w_class = WEIGHT_CLASS_NORMAL
	var/obj/type_to_deploy = /obj/machinery/autolathe/spot
	var/deploy_time = 5 SECONDS

/obj/item/autolathe_spot/Initialize(mapload)
	. = ..()
	give_deployable_component()

/obj/item/autolathe_spot/proc/give_deployable_component()
	AddComponent(/datum/component/deployable, deploy_time, type_to_deploy)

/obj/machinery/autolathe/spot/update_icon_state()
	. = ..()
	icon_state = busy ? base_icon_state : panel_open ? base_icon_state : base_icon_state
