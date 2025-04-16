
#define TECHWEB_NODE_POWERATOR "powerator"

/obj/item/circuitboard/machine/powerator
	name = "Powerator"
	desc = "The powerator is a machine that allows stations to sell their power to other stations that require additional sources."
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/powerator
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/ore/bluespace_crystal/refined = 1,
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/servo = 2,
	)
	needs_anchored = TRUE

/datum/supply_pack/misc/powerator
	name = "Powerator"
	desc = "We know the feeling of losing power and Central sending power, it is our time to do the same."
	cost = CARGO_CRATE_VALUE * 50 // 10,000
	contains = list(/obj/item/circuitboard/machine/powerator)
	crate_name = "Powerator Circuitboard Crate"
	crate_type = /obj/structure/closet/crate

/datum/design/board/powerator
	name = "Machine Design (Powerator)"
	desc = "Allows for the construction of circuit boards used to build a powerator."
	id = "powerator"
	build_path = /obj/item/circuitboard/machine/powerator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/powerator
	id = TECHWEB_NODE_POWERATOR
	display_name = "Powerator"
	description = "We've been saved by it in the past, we should send some power ourselves!"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	hidden = TRUE
	experimental = TRUE
	prereq_ids = list(TECHWEB_NODE_PARTS_ADV)
	design_ids = list(
		"powerator",
	)

/obj/machinery/powerator
	name = "powerator"
	desc = "Beyond the ridiculous name, it is the standard for transporting and selling energy to power networks that require additional sources!"
	icon = 'modular_nova/modules/powerator/machines.dmi'
	icon_state = "powerator"

	density = TRUE
	circuit = /obj/item/circuitboard/machine/powerator
	idle_power_usage = 100

	/// the current amount of power that we are trying to process
	var/current_power = 10 KILO WATTS

	/// the max amount of power that can be sent per process, from 100 KW (t1) to 10000 KW (t4)
	var/max_power = 100 KILO WATTS

	/// the rating change for the max power (upgrades)
	var/power_rating = 1650 KILO WATTS

	/// how much the current_power is divided by to determine the profit
	var/divide_ratio = 0.00001

	// the rating change for the divide ratio (upgrade)
	var/divide_rating = 0.000005

	/// the attached cable to the machine
	var/obj/structure/cable/attached_cable

	/// how many credits this machine has actually made so far
	var/credits_made = 0

/obj/machinery/powerator/Initialize(mapload)
	. = ..()
	attached_cable = locate() in get_turf(src)
	START_PROCESSING(SSobj, src)

/obj/machinery/powerator/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(attached_cable)
		UnregisterSignal(attached_cable, COMSIG_QDELETING)
		attached_cable = null

	return ..()

/obj/machinery/powerator/examine(mob/user)
	. = ..()
	. += "<br>"
	if(panel_open)
		. += span_warning("The maintenance panel is currently open, preventing [src] from working!")
	else
		. += span_notice("The maintenance panel is closed.")

	if(!anchored)
		. += span_warning("The anchors are not bolted to the floor, preventing [src] from working!")
	else
		. += span_notice("The anchors are bolted to the floor.")

	if(machine_stat & (NOPOWER | BROKEN))
		. += span_warning("There is either damage or no power being supplied, preventing [src] from working!")
	else
		. += span_notice("There is no damage and power is being supplied.")

	if(isnull(attached_cable))
		. += span_warning("There is no power cable underneath, preventing [src] from working!")
	else
		. += span_notice("There is a power cable underneath.")

	. += span_notice("Current Power: [display_power(current_power)]/[display_power(max_power)]")
	. += span_notice("This machine has made [credits_made] credits from selling power so far.")

/obj/machinery/powerator/RefreshParts()
	. = ..()

	var/efficiency = -2 //set to -2 so that tier 1 parts do nothing
	max_power = 100 KILO WATTS
	for(var/datum/stock_part/micro_laser/laser_part in component_parts)
		efficiency += laser_part.tier
	max_power += (efficiency * power_rating)

	efficiency = -2
	divide_ratio = 0.00001
	for(var/datum/stock_part/servo/servo_part in component_parts)
		efficiency += servo_part.tier
	divide_ratio += (efficiency * divide_rating)

/obj/machinery/powerator/update_overlays()
	. = ..()

	cut_overlay("cable")
	cut_overlay("power")
	cut_overlay("work")

	if(isnull(attached_cable))
		add_overlay("cable")
		return

	if(!attached_cable.avail(current_power))
		add_overlay("power")
		return

	add_overlay("work")

/obj/machinery/powerator/process()
	update_appearance() //lets just update this
	if(machine_stat & (NOPOWER | BROKEN) || !anchored || panel_open || isnull(attached_cable)) //no power, broken, unanchored, maint panel open, or no cable? lets reset
		return

	if(current_power < 0)
		current_power = 0 //this is just for the fringe case, wouldn't want it to somehow produce power for money! unless...

	if(!attached_cable.avail(current_power))
		if(!attached_cable.newavail())
			return

		current_power = attached_cable.newavail()

	current_power = clamp(current_power, 0, max_power)

	if(current_power == 0)
		return

	attached_cable.add_delayedload(current_power)

	var/money_ratio = round(current_power * divide_ratio) * 0.5 //split it in half for cargo and engi
	var/datum/bank_account/synced_cargo_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	var/datum/bank_account/synced_engi_account = SSeconomy.get_dep_account(ACCOUNT_ENG)
	synced_cargo_account.adjust_money(money_ratio)
	synced_engi_account.adjust_money(money_ratio)
	credits_made += money_ratio //don't want to be misleading, but just display what half each departments get and not the total

/obj/machinery/powerator/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	current_power = tgui_input_number(user, "How much power (in Watts) would you like to draw? Max: [display_power(max_power)]", "Power Draw", current_power, max_power, 0)
	if(isnull(current_power))
		return

/obj/machinery/powerator/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	panel_open = !panel_open
	if(panel_open)
		add_overlay("error")
		add_overlay("panel_open")
		cut_overlay("panel_close")

	else
		cut_overlay("error")
		cut_overlay("panel_open")
		add_overlay("panel_close")

	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/powerator/on_set_machine_stat(old_value)
	. = ..()
	if(machine_stat & (NOPOWER | BROKEN))
		add_overlay("error")

	else
		cut_overlay("error")

/obj/machinery/powerator/crowbar_act(mob/user, obj/item/tool)
	if(default_deconstruction_crowbar(tool))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/powerator/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	if(anchored)
		var/turf/src_turf = get_turf(src)
		attached_cable = locate() in src_turf
		RegisterSignal(attached_cable, COMSIG_QDELETING, PROC_REF(on_cable_deleted), override = TRUE)
		cut_overlay("error")

	else
		add_overlay("error")
		attached_cable = null

	return ITEM_INTERACT_SUCCESS

/obj/machinery/powerator/proc/on_cable_deleted()
	SIGNAL_HANDLER

	UnregisterSignal(attached_cable, COMSIG_QDELETING)
	attached_cable = null
