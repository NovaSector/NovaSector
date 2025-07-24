// DRONE POCKET IMPLEMENTATION

/// Drone pocket storage type
/datum/storage/pockets/drone
	max_slots = 1
	max_specific_storage = WEIGHT_CLASS_SMALL
	attack_hand_interact = FALSE

/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	// Initialize pocket storage after main initialization
	var/datum/storage/pockets/drone/left_pocket = new(src)
	left_pocket.set_real_location(src, FALSE)
	left_pocket.silent = TRUE
	l_store = atom_storage // Store reference to left pocket

	var/datum/storage/pockets/drone/right_pocket = new(src)
	right_pocket.set_real_location(src, FALSE)
	right_pocket.silent = TRUE
	r_store = atom_storage // Store reference to right pocket

/mob/living/basic/drone/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	switch(slot)
		if(ITEM_SLOT_LPOCKET, ITEM_SLOT_RPOCKET)
			if(I.w_class <= WEIGHT_CLASS_SMALL || (I.slot_flags & ITEM_SLOT_POCKETS))
				return TRUE
			if(!disable_warning)
				to_chat(src, span_warning("[I] is too big to fit in your pocket!"))
			return FALSE
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
		if(ITEM_SLOT_RPOCKET)
			r_store = equipping

	equipping.on_equipped(src, slot)

/mob/living/basic/drone/doUnEquip(obj/item/item_dropping, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	if(..())
		if(item_dropping == l_store)
			l_store = null
		if(item_dropping == r_store)
			r_store = null
		return TRUE
	return FALSE
