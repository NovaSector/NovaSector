/obj/item/storage/belt/holster/energy
	desc = "A rather plain pair of shoulder holsters with insulated padding and an integrated wireless recharger. \
		Designed to hold energy weaponry."
	/// The cell we're draining from to act as an on-the-go recharger.
	var/obj/item/stock_parts/power_store/cell/recharger_cell
	/// The multiplier for charge rate (see its usage in device/weapon rechargers)
	var/recharge_coeff = 1
	/// The multiplier for rechargable magazines' charge rate.
	VAR_PROTECTED/recharge_magazine_coeff = 1

/obj/item/storage/belt/holster/energy/onegun
	name = "high-output energy shoulder holster"
	desc = "A rather plain shoulder holster with insulated padding and an integrated, upgraded, high-throughput wireless recharger. \
		Designed to hold energy weaponry."
	storage_type = /datum/storage/holster/energy/onegun
	recharge_coeff = 2.5
	recharge_magazine_coeff = 3
	/*
	Theoretically, the coefficients could be buffed to 4 on both, matching the standalone recharger with a T4 capacitor.
	With the state of the game as of writing being "everyone's easily capable of carrying 120+ rounds for whatever gun they're using",
	it might not be terribly offensive compared to the rest of crewside. Caveat emptor, though.
	- Hatterhat, 11/16/2025
	*/

/obj/item/storage/belt/holster/energy/examine(mob/user)
	. = ..()
	. += span_notice("The integrated recharger is \
		[recharger_cell ? "active, with [recharger_cell] inserted at <b>[round(recharger_cell.percent(), 1)]%</b>" : "<b>empty</b>"].")
	. += span_notice("The integrated recharger can have its cell ejected via screwdriver. You can only insert a cell while the holsters are empty.")

/obj/item/storage/belt/holster/energy/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	// attempt to insert the cell
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return NONE
	// holster occupied?
	if(length(contents))
		to_chat(user, span_warning("[src]'s recharger cell port is obstructed! Remove everything else in the way first."))
		return ITEM_INTERACT_BLOCKING
	// slot already occupied?
	if(recharger_cell)
		to_chat(user, span_warning("[src]'s recharger cell port is occupied! Remove it with a screwdriver first."))
		return ITEM_INTERACT_BLOCKING
	// can transfer into holster?
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	recharger_cell = tool
	tool.anchored = TRUE
	to_chat(user, span_notice("You insert [tool] into [src]'s recharger cell port."))
	playsound(src, 'sound/items/weapons/kinetic_reload.ogg', 50, TRUE, -5)
	return ITEM_INTERACT_SUCCESS

/obj/item/storage/belt/holster/energy/screwdriver_act(mob/living/user, obj/item/tool)
	// attempt to eject the cell
	. = ..()
	if(!recharger_cell)
		to_chat(user, span_warning("[src] doesn't have a cell to remove!"))
		return ITEM_INTERACT_BLOCKING
	recharger_cell.forceMove(drop_location())
	user.put_in_hands(recharger_cell)
	to_chat(user, span_notice("You remove [recharger_cell] from [src]."))
	unregister_cell()
	return ITEM_INTERACT_SUCCESS

// In the event that, somehow, our recharger cell is removed without a screwdriver act, unregister and unanchor our recharger cell.
/obj/item/storage/belt/holster/energy/Exited(atom/movable/gone, direction)
	if(gone == recharger_cell)
		unregister_cell()
	return ..()

/// Unregister and unanchor our recharger cell.
/obj/item/storage/belt/holster/energy/proc/unregister_cell()
	recharger_cell.anchored = FALSE
	recharger_cell = null

/// Attempt to charge a target cell `target_cell` by `amount`, draining from our (presumably inserted) `recharger_cell`.
/obj/item/storage/belt/holster/energy/proc/charge_cell(amount, obj/item/stock_parts/power_store/target_cell)
	if(!recharger_cell)
		return
	var/transferred = min(recharger_cell.charge, target_cell.used_charge(), amount)
	recharger_cell.use(target_cell.give(transferred))
	recharger_cell.update_appearance()
	return transferred

/// Attempt to refill a target magazine `power_pack`, using power based on `seconds_per_tick`, draining from our (presumably inserted) `recharger_cell`.
/obj/item/storage/belt/holster/energy/proc/charge_mag(obj/item/ammo_box/magazine/recharge/power_pack, seconds_per_tick)
	var/used_charge = 0
	for(var/charge_iterations in 1 to recharge_magazine_coeff)
		if(power_pack.stored_ammo.len >= power_pack.max_ammo)
			continue
		power_pack.stored_ammo += new power_pack.ammo_type(power_pack)
		used_charge += recharger_cell.use(BASE_MACHINE_ACTIVE_CONSUMPTION * seconds_per_tick)
	return used_charge

/obj/item/storage/belt/holster/energy/process(seconds_per_tick)
	if(!recharger_cell)
		return // no cell no charge
	var/charge_given = 0
	for(var/obj/item/charging in contents)
		// if it's an energy gun...
		if(istype(charging, /obj/item/gun/energy))
			var/obj/item/gun/energy/charge_gun = charging
			if(!charge_gun.can_charge)
				continue
			var/obj/item/stock_parts/power_store/charging_cell = charge_gun.get_cell()
			if(charging_cell)
				if(charging_cell.charge < charging_cell.maxcharge)
					charge_given += charge_cell(charging_cell.chargerate * recharge_coeff * seconds_per_tick, charging_cell) || 0
					charge_gun.update_appearance()
		// alternatively, if it's a rechargable magazine (out of a gun)
		else if(istype(charging, /obj/item/ammo_box/magazine/recharge))
			charge_given += charge_mag(charging, seconds_per_tick) || 0
		// or if it's a gun with a rechargable magazine
		else if(istype(charging, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/shooty = charging
			if(!istype(shooty.magazine, /obj/item/ammo_box/magazine/recharge))
				continue
			charge_given += charge_mag(shooty.magazine, seconds_per_tick) || 0
			if(!shooty.chambered)
				shooty.chamber_round()
				continue
	if(!charge_given)
		STOP_PROCESSING(SSobj, src) // Nothing is left to charge, we can stop trying

// desc adjustments

/obj/item/storage/belt/holster/energy/thermal
	desc = "A rather plain pair of shoulder holsters with a bit of insulated padding and an integrated wireless recharger. \
		Meant to hold a twinned pair of thermal pistols, but can fit several kinds of energy handguns as well. "

/obj/item/storage/belt/holster/energy/disabler
	desc = "A rather plain pair of shoulder holsters with a bit of insulated padding and an integrated wireless recharger. \
		Designed to hold energy weaponry. A production stamp indicates that it was shipped with a disabler."

/obj/item/storage/belt/holster/energy/smoothbore
	desc = "A rather plain pair of shoulder holsters with a bit of insulated padding and an integrated wireless recharger. \
		Designed to hold energy weaponry. Seems it was meant to fit two smoothbores."
