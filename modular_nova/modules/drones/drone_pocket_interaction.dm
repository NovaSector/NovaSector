/mob/living/basic/drone/ClickOn(atom/A, params)
	var/list/modifiers = params2list(params)
	if(modifiers[SHIFT_CLICK] && ismob(A))
		examine(A)
		return

	// Handle pocket slot clicks
	if(ismob(usr) && usr == src && client && hud_used)
		var/atom/movable/screen/inventory/inv = locate() in hud_used.static_inventory
		if(inv && (A == inv || (istype(A, /atom/movable/screen) && A:name == inv.name)))
			var/obj/item/item_in_pocket
			if(inv.slot_id == ITEM_SLOT_LPOCKET)
				item_in_pocket = l_store
			else if(inv.slot_id == ITEM_SLOT_RPOCKET)
				item_in_pocket = r_store

			if(item_in_pocket)
				item_in_pocket.attack_hand(src)
				return

	return ..()

/mob/living/basic/drone/proc/handle_pocket_click(slot_id)
	var/obj/item/item_in_pocket
	if(slot_id == ITEM_SLOT_LPOCKET)
		item_in_pocket = l_store
	else if(slot_id == ITEM_SLOT_RPOCKET)
		item_in_pocket = r_store

	if(item_in_pocket)
		item_in_pocket.attack_hand(src)
		return TRUE
	return FALSE

// Register signals for pocket interaction
/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK, PROC_REF(handle_click), override = TRUE)
	RegisterSignal(src, COMSIG_CLICK_CTRL, PROC_REF(on_ctrl_click))

/mob/living/basic/drone/proc/on_ctrl_click(datum/source, atom/clicked_atom, location, control, params)
	SIGNAL_HANDLER
	if(!client || !hud_used)
		return

	var/atom/movable/screen/inventory/inv = locate() in hud_used.static_inventory
	if(inv && (clicked_atom == inv || (istype(clicked_atom, /atom/movable/screen) && clicked_atom:name == inv.name)))
		if(handle_pocket_click(inv.slot_id))
			return
