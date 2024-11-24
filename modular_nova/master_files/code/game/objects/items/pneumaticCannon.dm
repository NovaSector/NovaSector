
/obj/item/pneumatic_cannon/load_item(obj/item/I, mob/user) //we do a full redo here because it changes instead of just adds.
	if(!can_load_item(I, user))
		return FALSE
	if(user) //Only use transfer proc if there's a user, otherwise just set loc.
		if(!user.transferItemToLoc(I, src))
			return FALSE
		if(istype(I, /obj/item/storage/toolbox/emergency/turret/mag_fed))
			to_chat(user, span_warning("You load \the [I] into \the [src], blocking the loader's opening."))
		else
			to_chat(user, span_notice("You load \the [I] into \the [src]."))
	else
		I.forceMove(src)
	loadedItems += I
	if(isitem(I))
		loadedWeightClass += I.w_class
	else
		loadedWeightClass++
	return TRUE

/obj/item/pneumatic_cannon/can_load_item(obj/item/I, mob/user)
	. = ..()
	if(!.)
		return
	if(locate(/obj/item/storage/toolbox/emergency/turret/mag_fed) in src) //If loaded with a turret, stops more from being put in
		if(user)
			to_chat(user, span_warning("\The [I] is blocked from \the [src]'s loader!"))
		return FALSE
	if(istype(I, /obj/item/storage/toolbox/emergency/turret/mag_fed) && length(loadedItems) >= 1)
		if(user)
			to_chat(user, span_warning("\The [I] needs an empty cannon!"))
		return FALSE
