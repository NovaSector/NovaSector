/obj/item/wallframe/fireplace
	name = "fireplace frame"
	desc = "A do it yourself fireplace installation kit. What do you mean it looks like a tattoo kit? its totally different!"
	// Using the tattoo kit sprite as a placeholder, otherwise this will never be coded.
	icon_state = "tattoo_kit"
	icon = 'icons/obj/maintenance_loot.dmi'
	custom_materials = list(/datum/material/stone= SHEET_MATERIAL_AMOUNT * 7)
	result_path = /obj/structure/fireplace
	pixel_shift = 0

//We overwrite this one to make it use the reverse direction. 
/obj/item/wallframe/fireplace/attach(turf/on_wall, mob/user)
	if(result_path)
		var/floor_to_wall = get_dir(user, on_wall)
		floor_to_wall = turn(floor_to_wall, 180)
		playsound(src.loc, 'sound/machines/click.ogg', 75, TRUE)
		user.visible_message(span_notice("[user.name] attaches [src] to the wall."),
			span_notice("You attach [src] to the wall."),
			span_hear("You hear clicking."))

		var/obj/hanging_object = new result_path(get_turf(user), floor_to_wall, TRUE)
		hanging_object.setDir(floor_to_wall)
		if(pixel_shift)
			switch(floor_to_wall)
				if(NORTH)
					hanging_object.pixel_y = pixel_shift
				if(SOUTH)
					hanging_object.pixel_y = -pixel_shift
				if(EAST)
					hanging_object.pixel_x = pixel_shift
				if(WEST)
					hanging_object.pixel_x = -pixel_shift
		after_attach(hanging_object)

	qdel(src)
