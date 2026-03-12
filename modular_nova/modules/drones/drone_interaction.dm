/// Handles general click interactions, including pocket access and drone restrictions.
/mob/living/basic/drone/proc/handle_click(datum/source, atom/clicked_atom, location, control, params)
	SIGNAL_HANDLER
	// First check for drone-to-drone interaction restrictions
	if(isdrone(clicked_atom) && !can_user_interact_with(usr))
		return FALSE

	return NONE

/// Handles Alt+Click interactions with drone restrictions.
/mob/living/basic/drone/proc/handle_alt_click(datum/source, atom/clicked_atom, location, control, params)
	SIGNAL_HANDLER
	if(isdrone(clicked_atom) && !can_user_interact_with(usr))
		return FALSE

/mob/living/basic/drone/attack_hand(mob/user, list/modifiers)
	if(isdrone(user))
		attack_drone(user)
		return
	return ..()

/mob/living/basic/drone/attack_hand_secondary(mob/user, list/modifiers)
	if(can_user_interact_with(user))
		return ..()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/// Returns TRUE if the user is the same player as the target,
/// an admin ghost, or otherwise authorized to act for them.
/mob/living/basic/drone/proc/can_user_interact_with(mob/user)
	if(!ismob(user))
		return FALSE
	if(user == src)
		return TRUE
	if(isAdminGhostAI(user))
		return TRUE
	if(mind && ckey(mind.key) == user.ckey)
		return TRUE

	return FALSE

/mob/living/basic/drone/attack_hand_secondary(mob/user, list/modifiers)
	if(can_user_interact_with(user))
		return ..()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/mob/living/basic/drone/attack_ghost(mob/dead/observer/user)
	// Only allow ghosts to access storage if they're admin or the drone's ghost
	if(can_user_interact_with(user))
		return ..()
	return FALSE

// Let them use quick equip hotkey despite being human-only
/datum/keybinding/human/quick_equip/can_use(client/user)
	return ..() || isdrone(user.mob)

// Inventory interactions
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
			update_pockets()
		if(ITEM_SLOT_RPOCKET)
			r_store = equipping
			update_pockets()
		else
			to_chat(src, span_danger("You are trying to equip this item to an unsupported inventory slot!"))
			return

	has_equipped(equipping, slot)

/mob/living/basic/drone/doUnEquip(obj/item/item_dropping, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	if(..())
		if(item_dropping == l_store)
			l_store = null
			update_pockets()
		if(item_dropping == r_store)
			r_store = null
			update_pockets()
		return TRUE
	return FALSE
