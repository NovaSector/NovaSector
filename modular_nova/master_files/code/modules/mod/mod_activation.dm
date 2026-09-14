/obj/item/mod/control/toggle_activate(mob/user, force_deactivate = FALSE)
	. = ..()
	if(!. || !theme?.hardlight)
		return
	// make sure parts update their overlays when the suit activates/deactivates
	wearer.update_body_parts()

/obj/item/mod/control/deploy(mob/user, obj/item/part, instant)
	. = ..()
	if(!. || !theme?.hardlight)
		return
	// make sure parts update their overlays when a part is deployed
	wearer.update_body_parts()

/obj/item/mod/control/retract(mob/user, obj/item/part, instant)
	. = ..()
	if(!. || !theme?.hardlight)
		return
	// make sure parts update their overlays when a part is retracted
	wearer.update_body_parts()
