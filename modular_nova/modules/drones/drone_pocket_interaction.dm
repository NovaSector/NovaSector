/mob/living/basic/drone/ClickOn(atom/clicked_atom, params)
	var/list/modifiers = params2list(params)
	if(modifiers[SHIFT_CLICK] && ismob(clicked_atom))
		examine(clicked_atom)
		return

	// Handle pocket slot clicks
	if(ismob(usr) && usr == src && client && hud_used)
		var/atom/movable/screen/inventory/inv = locate() in hud_used.static_inventory
		if(inv && (clicked_atom == inv || (istype(clicked_atom, /atom/movable/screen) && clicked_atom:name == inv.name)))
			var/obj/item/item_in_pocket
			if(inv.slot_id == ITEM_SLOT_LPOCKET)
				item_in_pocket = l_store
			else if(inv.slot_id == ITEM_SLOT_RPOCKET)
				item_in_pocket = r_store

			if(item_in_pocket)
				item_in_pocket.attack_hand(src)
				return

	return ..()

/// Handles clicking on pocket UI elements to interact with pocket items.
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

/// Handles Ctrl+Click events for pocket interactions.
/mob/living/basic/drone/proc/on_ctrl_click(datum/source, atom/clicked_atom, location, control, params)
	SIGNAL_HANDLER
	if(!client || !hud_used)
		return

	var/atom/movable/screen/inventory/inv = locate() in hud_used.static_inventory
	if(inv && (clicked_atom == inv || (istype(clicked_atom, /atom/movable/screen) && clicked_atom.name == inv.name)))

		INVOKE_ASYNC(src, PROC_REF(async_handle_pocket_click), inv.slot_id)
		return TRUE

	return NONE
