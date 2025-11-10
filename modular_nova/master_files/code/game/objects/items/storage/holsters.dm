/obj/item/storage/belt/holster/energy
	desc = "A rather plain pair of shoulder holsters with insulated padding and a slow wireless recharger inside. \
		Designed to hold energy weaponry."
	var/obj/item/stock_parts/power_store/cell/recharger_cell
	var/recharge_coeff = 1

/obj/item/storage/belt/holster/energy/thermal
	desc = "A rather plain pair of shoulder holsters with a bit of insulated padding and a slow wireless recharger inside. \
		Meant to hold a twinned pair of thermal pistols, but can fit several kinds of energy handguns as well. "

/obj/item/storage/belt/holster/energy/disabler
	desc = "A rather plain pair of shoulder holsters with a bit of insulated padding and a slow wireless recharger inside. \
		Designed to hold energy weaponry. A production stamp indicates that it was shipped with a disabler."

/obj/item/storage/belt/holster/energy/smoothbore
	desc = "A rather plain pair of shoulder holsters with a bit of insulated padding and a slow wireless recharger inside. \
		Designed to hold energy weaponry. Seems it was meant to fit two smoothbores."

/obj/item/storage/belt/holster/energy/equipped(mob/user, slot)
	. = ..()
	if(slot & (ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE))
		START_PROCESSING(SSobj, src)

/obj/item/storage/belt/holster/energy/dropped(mob/user)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/storage/belt/holster/energy/examine(mob/user)
	. = ..()
	. += span_notice("The integrated recharger <b>only</b> works when worn as a belt or on suit storage, \
		and can have its cell ejected via screwdriver. You can only insert a cell while the holsters are empty.")
	. += span_notice("The integrated recharger's cell port is \
		[recharger_cell ? "occupied with [recharger_cell] at <b>[round(recharger_cell.percent(), 1)]%</b>" : "<b>empty</b>"].")

/obj/item/storage/belt/holster/energy/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	// attempt to insert the cell
	if(istype(tool, /obj/item/stock_parts/power_store/cell))
		// holster occupied?
		if(contents.len)
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
		return ITEM_INTERACT_SUCCESS

/obj/item/storage/belt/holster/energy/screwdriver_act(mob/living/user, obj/item/tool)
	// attempt to eject the cell
	. = ..()
	if(!recharger_cell)
		to_chat(user, span_warning("[src] doesn't have a cell to remove!"))
		return ITEM_INTERACT_BLOCKING
	recharger_cell.anchored = FALSE
	recharger_cell.forceMove(drop_location())
	user.put_in_hands(recharger_cell)
	to_chat(user, span_notice("You remove [recharger_cell] from [src]."))
	recharger_cell = null
	return ITEM_INTERACT_SUCCESS

/obj/item/storage/belt/holster/energy/proc/charge_cell(amount, obj/item/stock_parts/power_store/target_cell)
	if(!recharger_cell)
		return
	var/transferred = min(recharger_cell.charge, target_cell.used_charge(), amount)
	recharger_cell.use(target_cell.give(transferred))
	recharger_cell.update_appearance()
	return

/obj/item/storage/belt/holster/energy/process(seconds_per_tick)
	if(!recharger_cell)
		return // no cell no charge
	for(var/obj/item/charging in contents)
		if(istype(charging, /obj/item/stock_parts/power_store/cell))
			continue // let's not do a charging ouroboros
		var/obj/item/stock_parts/power_store/charging_cell = charging.get_cell()
		if(charging_cell)
			if(charging_cell.charge < charging_cell.maxcharge)
				charge_cell(charging_cell.chargerate * recharge_coeff * seconds_per_tick, charging_cell)
				charging.update_appearance()
		// the following only works on rechargable magazines that are outside of a gun
		// todo typecache of guns with rechargable magazines to check/charge *them* while loaded
		if(istype(charging, /obj/item/ammo_box/magazine/recharge))
			var/obj/item/ammo_box/magazine/recharge/power_pack = charging
			for(var/charge_iterations in 1 to recharge_coeff)
				if(power_pack.stored_ammo.len >= power_pack.max_ammo)
					continue
				power_pack.stored_ammo += new power_pack.ammo_type(power_pack)
				recharger_cell.use(BASE_MACHINE_ACTIVE_CONSUMPTION * seconds_per_tick)
