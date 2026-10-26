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
/mob/living/basic/drone/handle_set_item_in_slot(obj/item/equipping, slot)
	// Pockets are part of ITEM_SLOT_STORAGE, so they have to be handled before the parent puts them in internal storage
	switch(slot)
		if(ITEM_SLOT_LPOCKET)
			l_store = equipping
			update_pockets()
			return TRUE
		if(ITEM_SLOT_RPOCKET)
			r_store = equipping
			update_pockets()
			return TRUE
	return ..()

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
