/obj/item/mod/control/toggle_activate(mob/user, force_deactivate = FALSE)
	. = ..()
	if(!. || !theme?.hardlight)
		return
	// make sure our parts update their overlays when we deactivate
	wearer.update_body_parts()
