// this only exists to inherit the air contents of the tanks used to craft it
/obj/item/tank/internals/emergency_oxygen/double/empty/crafted/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	for(var/obj/item/tank/internals/emergency_oxygen/engi/long_boy in components)
		assume_air(long_boy.return_air())
