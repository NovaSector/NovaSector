/obj/item/ammo_box/try_load(mob/living/user, obj/item/tool, silent = FALSE, replace_spent = FALSE)
	var/num_loaded = 0
	if(!can_load(user))
		return

	if(istype(tool, /obj/item/ammo_box))
		var/obj/item/ammo_box/other_box = tool
		for(var/obj/item/ammo_casing/casing in other_box.ammo_list())
			var/did_load = give_round(casing, replace_spent)
			if(did_load)
				other_box.stored_ammo -= casing
				num_loaded++
			// failed to load (full already? ran out of ammo?)
			if(!did_load)
				break
			// this box can't accept being multiloaded into
			if(!(ammo_box_multiload & AMMO_BOX_MULTILOAD_IN))
				break
			// the other box can't give multiple bullets in one go to an unloaded magazine
			if(!isgun(loc) && !(other_box.ammo_box_multiload & AMMO_BOX_MULTILOAD_OUT))
				break
			// the other box can't give multiple bullets in one go to a loaded magazine
			if(isgun(loc) && !(other_box.ammo_box_multiload & AMMO_BOX_MULTILOAD_OUT_LOADED))
				break

		if(num_loaded)
			other_box.update_appearance()

	if(isammocasing(tool))
		var/obj/item/ammo_casing/casing = tool
		if(give_round(casing, replace_spent))
			user.transferItemToLoc(casing, src, TRUE)
			num_loaded++
			casing.update_appearance()

	if(num_loaded)
		if(!silent)
			to_chat(user, span_notice("You load [num_loaded > 1 ? "[num_loaded] [casing_phrasing]s" : "a [casing_phrasing]"] into \the [src]!"))
			playsound(src, 'sound/items/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE)
		update_appearance()

	return num_loaded

/obj/item/ammo_box/strilka310
	ammo_box_multiload = AMMO_BOX_MULTILOAD_ALL
