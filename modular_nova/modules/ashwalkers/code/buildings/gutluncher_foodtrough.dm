/obj/structure/ore_container/food_trough/gutlunch_trough
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)

/obj/structure/ore_container/food_trough/gutlunch_trough/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/storage/bag/ore))
		return ..()

	for(var/obj/item/stack/ore/stored_ore in tool.contents)
		tool.atom_storage?.attempt_remove(stored_ore, src)
	return ITEM_INTERACT_SUCCESS
