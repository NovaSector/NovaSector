// removes syndicate weapon pins for weapons that may have them in the traitor uplink (nukeop weapons that we made available for tots)
/datum/uplink_item/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	var/atom/movable/created = ..()
	if(!created)
		return
	if(!(uplink_handler.uplink_flag & UPLINK_TRAITORS))
		return

	if(isgun(created))
		replace_pin(created)
	else if(istype(created, /obj/item/storage/toolbox/guncase))
		for(var/obj/item/gun/gun in created)
			replace_pin(gun)
