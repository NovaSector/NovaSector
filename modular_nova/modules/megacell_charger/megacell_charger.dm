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
	circuit = /obj/item/circuitboard/machine/megacell_charger
	pass_flags = PASSTABLE
	var/obj/item/stock_parts/power_store/battery/charging = null
	var/charge_rate = STANDARD_BATTERY_RATE

// Icons are all TG originals, but they look more like megacells than batteries, so this works. Reusing sprites, saving the RSC one PR at a time: I'm doing my part! (this is greenwashing)
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

// Handles the inspect on our new charger
/obj/machinery/megacell_charger/examine(mob/user)
	. = ..()
	. += "There's [charging ? "\a [charging]" : "no cell"] in the charger."
	if(charging)
		. += "Current charge: [round(charging.percent(), 1)]%."
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: charging power: <b>[display_power(charge_rate, convert = FALSE)]</b>.")

// Handles our anchor states
/obj/machinery/megacell_charger/wrench_act(mob/living/user, obj/item/tool)
	if(charging)
		return NONE
	if(default_unfasten_wrench(user, tool))
		update_appearance()
	return ITEM_INTERACT_SUCCESS

// Handles screwdriver interactions
/obj/machinery/megacell_charger/screwdriver_act(mob/living/user, obj/item/tool)
	return charging ? NONE : default_deconstruction_screwdriver(user, tool)

// Handles the final tool deconstruction step
/obj/machinery/megacell_charger/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

// Checks if we can actually destroy it
/obj/machinery/megacell_charger/can_crowbar_deconstruct()
	return ..() && !charging

// Handles the interaction of cells into the new charger
/obj/machinery/megacell_charger/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/battery) || panel_open)// No cells in with lid open
		return NONE

	if(machine_stat & BROKEN)
		to_chat(user, span_warning("[src] is broken!"))// The charger is broken
		return ITEM_INTERACT_BLOCKING
	if(!anchored)
		to_chat(user, span_warning("[src] isn't attached to the ground!"))// the charger needs to be anchored
		return ITEM_INTERACT_BLOCKING
	if(charging)
		to_chat(user, span_warning("There is already a battery in the charger!"))// no bluespace cell stacking
		return ITEM_INTERACT_BLOCKING
	var/obj/item/stock_parts/power_store/battery/inserting_battery = tool// Sets up a last sanity check on the cell
	if(inserting_battery.chargerate <= 0)// If the cell is unchargable for w/e reason
		to_chat(user, span_warning("[inserting_battery] cannot be recharged!"))// Reject it entirely
		return

	var/area/charge_area = get_area(src)
	if(!isarea(charge_area))// If we arent in an area that will charge us
		return ITEM_INTERACT_BLOCKING// Block usage
	if(!charge_area.power_equip) // There's no APC in this area, don't try to cheat power!
		to_chat(user, span_warning("[src] blinks red as you try to insert the battery!"))// If we cant even supply power
		return ITEM_INTERACT_BLOCKING// Block usage
	if(!user.transferItemToLoc(tool, src))// If we cant transfer the cell because we have nodrop or something
		return ITEM_INTERACT_BLOCKING// Dont violate the laws of nature

	charging = tool// crossmaps our obj were trying to stick in to the tool interact of the proc
	user.visible_message(
		span_notice("[user] inserts a battery into [src]."),
		span_notice("You insert a battery into [src]."),
	)// Let them know we did it woo!
	update_appearance()// Give it a fresh icon
	return ITEM_INTERACT_SUCCESS

// If our machine is broken while we have a cell, do not nullspace my cell
/obj/machinery/megacell_charger/on_deconstruction(disassembled)
	charging?.forceMove(drop_location())

// If the thing that were charging is gone, we arent technically charging anymore, so cleanup the slot
/obj/machinery/megacell_charger/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == charging)
		charging = null

// If the thing we're charging is being removed appropriately, cleanup our structure states
/obj/machinery/megacell_charger/proc/removebattery(new_loc)
	. = charging
	charging.update_appearance()
	charging.forceMove(new_loc)
	charging = null
	update_appearance()

// If our machine is annihilated while we are charging something
/obj/machinery/megacell_charger/Destroy()
	QDEL_NULL(charging)// The cell evaporates, incredible choices
	return ..()

// Handles the literal cell removal itself
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

// Do nothing for AIs so they cant unmount the cell while clicking about
/obj/machinery/megacell_charger/attack_ai(mob/user)
	return

// Updates our EMP interactions
/obj/machinery/megacell_charger/emp_act(severity)
	. = ..()

	if(machine_stat & (BROKEN|NOPOWER) || . & EMP_PROTECT_CONTENTS)
		return

	if(charging)
		charging.emp_act(severity)

// Modifies charging logic based on parts used to make the charger
// Yes, you read that right, this machine pulls a maximum potential of 4MW off the grid.
// Yes, you are correct, an APC wired directly to the SM is now the smartest way to charge these
// Yes, I think it will be hilarious to cause blackouts with this.
// If we dont want it to do this, then, remove the two lines beneath charge__rate
/obj/machinery/megacell_charger/RefreshParts()
	. = ..()
	charge_rate = STANDARD_BATTERY_RATE
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		charge_rate *= capacitor.tier

// Slowly charge our cell
/obj/machinery/megacell_charger/process(seconds_per_tick)
	if(!charging || charging.percent() >= 100 || !anchored || !is_operational)
		return

	var/main_draw = charge_rate * seconds_per_tick
	if(!main_draw)
		return

	//account for heat loss from work done. this is pretty sizable loss, all things considered
	var/charge_given = charge_cell(main_draw, charging, grid_only = TRUE)
	if(charge_given)
		use_energy((charge_given + active_power_usage) * 0.01)

	update_appearance()

// Ungodly icon management staircase stolen and updated from our base cell charger code
/obj/machinery/megacell_charger/update_overlays()
	. = ..()

	if(!charging)
		return

	if(!(machine_stat & (BROKEN|NOPOWER)))
		var/newlevel = round(charging.percent() * 4 / 100)
		. += "ccharger-o[newlevel]"
	if(!charging.charging_icon)
		. += image(charging.icon, charging.icon_state)
	else
		. += image('icons/obj/machines/cell_charger.dmi', charging.charging_icon)
	if(charging.grown_battery)
		. += mutable_appearance('icons/obj/machines/cell_charger.dmi', "grown_wires")
	. += "ccharger-[charging.connector_type]-on"
	if((charging.charge > 0.01) && charging.charge_light_type)
		. += mutable_appearance('icons/obj/machines/cell_charger.dmi', "cell-[charging.charge_light_type]-o[(charging.percent() >= 99.5) ? 2 : 1]")
