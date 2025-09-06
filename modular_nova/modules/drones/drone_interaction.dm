/mob/living/basic/drone/attack_hand(mob/user, list/modifiers)
	if(isdrone(user))
		attack_drone(user)
		return
	return ..()

/mob/living/basic/drone/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(isobserver(user))
		examine(user) // Show examine info to ghosts
		return


/mob/living/basic/drone/attack_hand_secondary(mob/user, list/modifiers)
	if(user == src || isAdminGhostAI(user) || (mind && mind.key == user.key))
		return ..()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

///mob/living/basic/drone/proc/on_mousedrop(atom/over, src_location, over_location, src_control, over_control, params)
	// Allow pickup by dragging to any mob that can hold us
//	if(ismob(over) && over != src && over.CanReach(src) && over.MouseDrop(src))
//		var/mob/over_mob = over
//		if(can_be_held && over_mob.can_hold_items())
//			return TRUE // Allow normal pickup handling
//
	// Allow self and admin interactions
//	if(usr == src || isAdminGhostAI(usr) || (mind && mind.key == usr.key))
//		return TRUE
//	return COMPONENT_CANCEL_MOUSEDROP_ONTO// Block all other drag-and-drop interactions

// Storage Changes
/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	// Register signals for interaction control
	RegisterSignal(src, COMSIG_CLICK, PROC_REF(handle_click), override = TRUE)
	RegisterSignal(src, COMSIG_CLICK_CTRL, PROC_REF(on_ctrl_click))
	RegisterSignal(src, COMSIG_CLICK_ALT, PROC_REF(handle_alt_click))
//	RegisterSignal(src, COMSIG_MOUSEDROP_ONTO, PROC_REF(on_mousedrop))

/datum/hud/dextrous/drone/New(mob/owner)
	. = ..()
	var/atom/movable/screen/inventory/inv_box

	// Left pocket UI element
	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "left pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_LPOCKET
	static_inventory += inv_box

	// Right pocket UI element
	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "right pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_RPOCKET
	static_inventory += inv_box
