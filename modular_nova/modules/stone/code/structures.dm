/obj/item/wallframe/fireplace
	name = "fireplace frame"
	desc = "A do it yourself fireplace installation kit. What do you mean it looks like a tattoo kit? its totally different!"
	// Using the tattoo kit sprite as a placeholder, otherwise this will never be coded.
	icon_state = "tattoo_kit"
	icon = 'icons/obj/maintenance_loot.dmi'
	custom_materials = list(/datum/material/stone= SHEET_MATERIAL_AMOUNT * 7)
	result_path = /obj/structure/fireplace/nova

//We overwrite this one to make it use the reverse direction. 
/obj/item/wallframe/fireplace/after_attach(obj/object)
	object.setDir(REVERSE_DIR(object.dir))
	if (object.dir == NORTH)
		object.pixel_y = - 16 // Look, wall sprites suck, layers do shenanigans that happen from an orientation that doesnt from the other. 
	return ..()

/obj/structure/fireplace/nova
	icon = 'modular_nova/modules/aesthetics/furniture/icons/fireplace.dmi'
