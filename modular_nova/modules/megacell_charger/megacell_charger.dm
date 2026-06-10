// 	#define STANDARD_BATTERY_RATE (STANDARD_BATTERY_VALUE WATTS) // 1 MW
// code\__DEFINES\power.dm
// Adds a cell charger specifically for handling megacells. We have an aesthetic overwrite for normal cells on the original code, leaving the original sprites up for grabs from the rsc.
// This repurposes pre-existing assets to fill a hole we had.
// Doesn't sub-type the normal cell charger because seriously fuck that noise.
/obj/machinery/megacell_charger
	name = "megacell charger"
	desc = "It charges large batteries used in APCs and power storage units like the SMES."
	icon = 'icons/obj/machines/cell_charger.dmi'
	icon_state = "ccharger"
	power_channel = AREA_USAGE_EQUIP
	circuit = /obj/item/circuitboard/machine/cell_charger
	pass_flags = PASSTABLE
	var/obj/item/stock_parts/power_store/battery/charging = null
	var/charge_rate = STANDARD_BATTERY_RATE
    ///What charge lige sprite to use, null if no light
	var/charge_light_type = "standard"
    ///What connector sprite to use when in a cell charger, null if no connectors
	var/connector_type = "standard"

// Icons are all TG originals, but they look more like megacells than batteries, so this works. Reusing sprites, saving the RSC one PR at a time: I'm doing my part!
/obj/item/stock_parts/power_store/battery
	icon = 'icons/obj/machines/cell_charger.dmi'
	/// The charge overlay icon file for the cell charge lights
	var/charging_icon = "cell"
	connector_type = null

/obj/item/stock_parts/power_store/battery/high
	charging_icon = "hcell"

/obj/item/stock_parts/power_store/battery/super
	charging_icon = "scell"

/obj/item/stock_parts/power_store/battery/hyper
	charging_icon = "hpcell"

/obj/item/stock_parts/power_store/battery/bluespace
	charging_icon = "bscell"

/obj/item/stock_parts/power_store/battery/infinite
	charging_icon = "icell"

/obj/machinery/megacell_charger/examine(mob/user)
	. = ..()
	. += "There's [charging ? "\a [charging]" : "no cell"] in the charger."
	if(charging)
		. += "Current charge: [round(charging.percent(), 1)]%."
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: charging power: <b>[display_power(charge_rate, convert = FALSE)]</b>.")

/obj/machinery/megacell_charger/wrench_act(mob/living/user, obj/item/tool)
	if(charging)
		return NONE
	if(default_unfasten_wrench(user, tool))
		update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/megacell_charger/screwdriver_act(mob/living/user, obj/item/tool)
	return charging ? NONE : default_deconstruction_screwdriver(user, tool)

/obj/machinery/megacell_charger/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/megacell_charger/can_crowbar_deconstruct()
	return ..() && !charging

/obj/machinery/megacell_charger/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/battery) || panel_open)
		return NONE

	if(machine_stat & BROKEN)
		to_chat(user, span_warning("[src] is broken!"))
		return ITEM_INTERACT_BLOCKING
	if(!anchored)
		to_chat(user, span_warning("[src] isn't attached to the ground!"))
		return ITEM_INTERACT_BLOCKING
	if(charging)
		to_chat(user, span_warning("There is already a battery in the charger!"))
		return ITEM_INTERACT_BLOCKING
	// NOVA EDIT ADDITION START
	var/obj/item/stock_parts/power_store/battery/inserting_battery = tool
	if(inserting_battery.chargerate <= 0)
		to_chat(user, span_warning("[inserting_battery] cannot be recharged!"))
		return
	// NOVA EDIT ADDITION END

	var/area/charge_area = get_area(src)
	if(!isarea(charge_area))
		return ITEM_INTERACT_BLOCKING
	if(!charge_area.power_equip) // There's no APC in this area, don't try to cheat power!
		to_chat(user, span_warning("[src] blinks red as you try to insert the battery!"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING

	charging = tool
	user.visible_message(
		span_notice("[user] inserts a battery into [src]."),
		span_notice("You insert a battery into [src]."),
	)
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/megacell_charger/on_deconstruction(disassembled)
	charging?.forceMove(drop_location())

/obj/machinery/megacell_charger/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == charging)
		charging = null

/obj/machinery/megacell_charger/Destroy()
	QDEL_NULL(charging)
	return ..()

/obj/machinery/megacell_charger/proc/removebattery(new_loc)
	. = charging
	charging.update_appearance()
	charging.forceMove(new_loc)
	charging = null
	update_appearance()

/obj/machinery/megacell_charger/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(. || !charging)
		return

	charging.add_fingerprint(user)
	user.visible_message(span_notice("[user] removes [charging] from [src]."), span_notice("You remove [charging] from [src]."))
	user.put_in_hands(removebattery(drop_location()))

/obj/machinery/megacell_charger/attack_tk(mob/user)
	if(!charging)
		return

	to_chat(user, span_notice("You telekinetically remove [charging] from [src]."))
	removebattery(drop_location())
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/megacell_charger/attack_ai(mob/user)
	return

/obj/machinery/megacell_charger/emp_act(severity)
	. = ..()

	if(machine_stat & (BROKEN|NOPOWER) || . & EMP_PROTECT_CONTENTS)
		return

	if(charging)
		charging.emp_act(severity)

/obj/machinery/megacell_charger/RefreshParts()
	. = ..()
	charge_rate = STANDARD_BATTERY_RATE //NOVA EDIT CHANGE - ORIGINAL: 0.25 * STANDARD_CELL_RATE
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		charge_rate *= capacitor.tier

/obj/machinery/megacell_charger/process(seconds_per_tick)
	if(!charging || charging.percent() >= 100 || !anchored || !is_operational)
		return

	var/main_draw = charge_rate * seconds_per_tick
	if(!main_draw)
		return

	//charge cell, account for heat loss from work done
	var/charge_given = charge_cell(main_draw, charging, grid_only = TRUE)
	if(charge_given)
		use_energy((charge_given + active_power_usage) * 0.01)

	update_appearance()

/*/obj/machinery/megacell_charger/update_overlays()
	. = ..()

	if(!charging)
		return

	if(!(machine_stat & (BROKEN|NOPOWER)))
		var/newlevel = round(charging.percent() * 4 / 100)
		. += "ccharger-o[newlevel]"
	if(!charging.charging_icon)
		. += image(charging.icon, charging.icon_state)
	else
		.+= image('icons/obj/machines/cell_charger.dmi', charging.charging_icon)\
*/

/obj/machinery/megacell_charger/update_overlays()
	. = ..()

	if(!charging)
		return

	if(!(machine_stat & (BROKEN|NOPOWER)))
		var/newlevel = round(charging.percent() * 4 / 100)
		. += "ccharger-o[newlevel]"
	. += image(charging.icon, charging.icon_state)
	if(charging.grown_battery)
		. += mutable_appearance('icons/obj/machines/cell_charger.dmi', "grown_wires")
	. += "ccharger-[charging.connector_type]-on"
	if((charging.charge > 0.01) && charging.charge_light_type)
		. += mutable_appearance('icons/obj/machines/cell_charger.dmi', "cell-[charging.charge_light_type]-o[(charging.percent() >= 99.5) ? 2 : 1]")
