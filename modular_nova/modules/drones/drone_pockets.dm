// HUD elements
/atom/movable/screen/inventory/drone_pocket
	slot_id = null  // will be set when created

/atom/movable/screen/inventory/drone_pocket/Click(location, control, params)
	// At this point in client Click() code we have passed the 1/10 sec check and little else
	// We don't even know if it's a middle click
	var/mob/user = hud?.mymob
	if(usr != user)
		return TRUE
	if(world.time <= user.next_move)
		return TRUE
	if(user.incapacitated)
		return TRUE

	if(hud?.mymob && slot_id)
		var/obj/item/inv_item = hud.mymob.get_item_by_slot(slot_id)
		if(inv_item)
			return inv_item.Click(location, control, params)

	usr.attack_ui(slot_id, params)

// Creates HUD for Pockets
/datum/hud/dextrous/drone/New(mob/owner)
	. = ..()
	var/atom/movable/screen/inventory/drone_pocket/inv_box

	// Left pocket UI element
	inv_box = new /atom/movable/screen/inventory/drone_pocket(null, src)
	inv_box.name = "left pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_LPOCKET
	static_inventory += inv_box

	// Right pocket UI element
	inv_box = new /atom/movable/screen/inventory/drone_pocket(null, src)
	inv_box.name = "right pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_RPOCKET
	static_inventory += inv_box

// Drone pocket storage type
/datum/storage/pockets/drone
	max_slots = 1
	max_specific_storage = WEIGHT_CLASS_SMALL
	attack_hand_interact = FALSE
	allow_quick_gather = FALSE
	allow_quick_empty = FALSE
	locked = STORAGE_FULLY_LOCKED

// Prevent pockets from being emptied
/datum/storage/pockets/drone/set_parent(atom/new_parent)
	. = ..()
	UnregisterSignal(new_parent, list(COMSIG_MOUSEDROP_ONTO, COMSIG_MOUSEDROPPED_ONTO))

/mob/living/basic/drone/can_equip(obj/item/target_item, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	switch(slot)
		if(ITEM_SLOT_LPOCKET)
			if(l_store)
				return FALSE
			if(target_item.w_class > WEIGHT_CLASS_SMALL && !(target_item.slot_flags & ITEM_SLOT_POCKETS))
				return FALSE
			return TRUE
		if(ITEM_SLOT_RPOCKET)
			if(r_store)
				return FALSE
			if(target_item.w_class > WEIGHT_CLASS_SMALL && !(target_item.slot_flags & ITEM_SLOT_POCKETS))
				return FALSE
			return TRUE
	return ..()

/mob/living/basic/drone/get_item_by_slot(slot_id)
	switch(slot_id)
		if(ITEM_SLOT_LPOCKET)
			return l_store
		if(ITEM_SLOT_RPOCKET)
			return r_store
	return ..()

/mob/living/basic/drone/get_slot_by_item(obj/item/target_item)
	if(target_item == internal_storage)
		return ITEM_SLOT_DEX_STORAGE
	if(target_item == head)
		return ITEM_SLOT_HEAD
	if(target_item == l_store)
		return ITEM_SLOT_LPOCKET
	if(target_item == r_store)
		return ITEM_SLOT_RPOCKET
	return ..()

/mob/living/basic/drone/update_pockets()
	if(client && hud_used)
		var/obj/item/left_item = l_store
		var/obj/item/right_item = r_store

		if(left_item)
			left_item.screen_loc = ui_storage1
			client.screen += left_item
		if(right_item)
			right_item.screen_loc = ui_storage2
			client.screen += right_item
