// HUD elements
/datum/inventory_slot/drone/l_pocket
	name = "left pocket"
	icon_state = "pocket"
	icon_full = "template_small"
	screen_loc = ui_storage1
	slot_id = ITEM_SLOT_LPOCKET

/datum/inventory_slot/drone/r_pocket
	name = "right pocket"
	icon_state = "pocket"
	icon_full = "template_small"
	screen_loc = ui_storage2
	slot_id = ITEM_SLOT_RPOCKET

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
