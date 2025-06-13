/obj/structure/ore_container/food_trough/gutlunch_trough/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(!istype(attacking_item, /obj/item/storage/bag/ore))
		return ..()

	for(var/obj/item/stack/ore/stored_ore in attacking_item.contents)
		attacking_item.atom_storage?.attempt_remove(stored_ore, src)
