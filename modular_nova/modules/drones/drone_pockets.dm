// Drone pocket storage type
/datum/storage/pockets/drone
	max_slots = 1
	max_specific_storage = WEIGHT_CLASS_SMALL
	attack_hand_interact = FALSE
	allow_quick_gather = FALSE
	allow_quick_empty = FALSE
	locked = STORAGE_FULLY_LOCKED

/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	// Initialize pocket storage with restricted access
	var/datum/storage/pockets/drone/left_pocket = new(src)
	left_pocket.set_real_location(src, FALSE)
	left_pocket.silent = TRUE

	var/datum/storage/pockets/drone/right_pocket = new(src)
	right_pocket.set_real_location(src, FALSE)
	right_pocket.silent = TRUE

	// Register signals for interaction control
	RegisterSignal(src, COMSIG_CLICK, PROC_REF(handle_click))
	RegisterSignal(src, COMSIG_CLICK_ALT, PROC_REF(handle_alt_click))

/mob/living/basic/drone/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	switch(slot)
		if(ITEM_SLOT_LPOCKET)
			if(l_store)
				return FALSE
			if(I.w_class > WEIGHT_CLASS_SMALL && !(I.slot_flags & ITEM_SLOT_POCKETS))
				return FALSE
			return TRUE
		if(ITEM_SLOT_RPOCKET)
			if(r_store)
				return FALSE
			if(I.w_class > WEIGHT_CLASS_SMALL && !(I.slot_flags & ITEM_SLOT_POCKETS))
				return FALSE
			return TRUE
	return ..()

/mob/living/basic/drone/get_slot_by_item(obj/item/I)
	if(I == internal_storage)
		return ITEM_SLOT_DEX_STORAGE
	if(I == head)
		return ITEM_SLOT_HEAD
	if(I == l_store)
		return ITEM_SLOT_LPOCKET
	if(I == r_store)
		return ITEM_SLOT_RPOCKET
	return ..()

/mob/living/basic/drone/proc/update_inv_pockets()
	if(client && hud_used)
		var/obj/item/left_item = l_store
		var/obj/item/right_item = r_store

		if(left_item)
			left_item.screen_loc = ui_storage1
			client.screen += left_item
		if(right_item)
			right_item.screen_loc = ui_storage2
			client.screen += right_item

/mob/living/basic/drone/equip_to_slot(obj/item/equipping, slot, initial = FALSE, redraw_mob = FALSE, indirect_action = FALSE)
	if(!slot)
		return
	if(!istype(equipping))
		return

	var/index = get_held_index_of_item(equipping)
	if(index)
		held_items[index] = null
	update_held_items()

	if(equipping.pulledby)
		equipping.pulledby.stop_pulling()

	equipping.screen_loc = null
	equipping.forceMove(src)
	SET_PLANE_EXPLICIT(equipping, ABOVE_HUD_PLANE, src)

	switch(slot)
		if(ITEM_SLOT_HEAD)
			head = equipping
			update_worn_head()
		if(ITEM_SLOT_DEX_STORAGE)
			internal_storage = equipping
			update_inv_internal_storage()
		if(ITEM_SLOT_LPOCKET)
			l_store = equipping
			update_inv_pockets()
		if(ITEM_SLOT_RPOCKET)
			r_store = equipping
			update_inv_pockets()
		else
			to_chat(src, span_danger("You are trying to equip this item to an unsupported inventory slot!"))
			return

	equipping.on_equipped(src, slot)

/mob/living/basic/drone/doUnEquip(obj/item/item_dropping, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	if(..())
		if(item_dropping == l_store)
			l_store = null
			update_inv_pockets()
		if(item_dropping == r_store)
			r_store = null
			update_inv_pockets()
		return TRUE
	return FALSE

/mob/living/basic/drone/proc/on_mouse_drop(datum/source, atom/over, mob/user)
	SIGNAL_HANDLER
	// Always allow pickup attempts
	if(ismob(over) && over != src && can_be_held)
		return TRUE

	// Block all other mouse drop interactions unless authorized
	if(user == src || isAdminGhostAI(user) || (mind && mind.key == user.key))
		return NONE

	return COMPONENT_CANCEL_MOUSEDROP_ONTO

/mob/living/basic/drone/proc/handle_click(datum/source, atom/clicked_atom, location, control, params)
	SIGNAL_HANDLER
	// First check for drone-to-drone interaction restrictions
	if(isdrone(clicked_atom) && usr != src && !isAdminGhostAI(usr) && (!mind || mind.key != usr.key))
		return FALSE

	// Then handle pocket interactions if applicable
	if(client && hud_used)
		var/list/modifiers = params2list(params)
		if(!LAZYACCESS(modifiers, SHIFT_CLICK)) // Skip if it's a shift-click
			var/atom/movable/screen/inventory/inv = locate() in hud_used.static_inventory
			if(inv && (clicked_atom == inv || (istype(clicked_atom, /atom/movable/screen) && clicked_atom:name == inv.name)))
				if(handle_pocket_click(inv.slot_id))
					return TRUE

	return NONE

/mob/living/basic/drone/proc/handle_alt_click(datum/source, atom/clicked_atom, location, control, params)
	SIGNAL_HANDLER
	if(isdrone(clicked_atom) && usr != src && !isAdminGhostAI(usr) && (!mind || mind.key != usr.key))
		return FALSE

/mob/living/basic/drone/attack_hand_secondary(mob/user, list/modifiers)
	if(user == src || isAdminGhostAI(user) || (mind && mind.key == user.key))
		return ..()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/mob/living/basic/drone/attack_ghost(mob/dead/observer/user)
	// Only allow ghosts to access storage if they're admin or the drone's ghost
	if(isAdminGhostAI(user) || (mind && mind.key == user.key))
		return ..()
	return FALSE

/mob/living/basic/drone/proc/get_pocket_item(slot_id)
	switch(slot_id)
		if(ITEM_SLOT_LPOCKET)
			return l_store
		if(ITEM_SLOT_RPOCKET)
			return r_store
	return null
