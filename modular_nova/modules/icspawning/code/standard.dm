//SKYRAT MODULE IC-SPAWNING https://github.com/Skyrat-SS13/Skyrat-tg/pull/104
/obj/item/gun/energy/taser/debug
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/debug)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_casing/energy/electrode/debug
	e_cost = LASER_SHOTS(1000, STANDARD_CELL_CHARGE)

/obj/item/clothing/suit/armor/vest/debug
	name = "Bluespace Tech vest"
	desc = "A sleek piece of armour designed for Bluespace agents."
	armor_type = /datum/armor/vest_debug
	w_class = WEIGHT_CLASS_TINY

/datum/armor/vest_debug
	melee = 95
	melee = 95
	laser = 95
	energy = 95
	bomb = 95
	bio = 95
	fire = 98
	acid = 98

/obj/item/clothing/shoes/combat/debug
	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/belt/utility/chief/full/debug
	name = "\improper Bluespace Tech's belt"
	w_class = WEIGHT_CLASS_TINY

/datum/outfit/debug/bst //Debug objs
	name = "Bluespace Tech"
	uniform = /obj/item/clothing/under/syndicate/combat
	belt = /obj/item/storage/belt/utility/chief/full/debug
	shoes = /obj/item/clothing/shoes/combat/debug
	id = /obj/item/card/id/advanced/debug/bst
	box = /obj/item/storage/box/debugtools
	backpack_contents = list(
		/obj/item/melee/energy/axe = 1,
		/obj/item/storage/part_replacer/bluespace/tier4_bst = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/debug/omnitool = 1,
	)

/datum/outfit/admin/bst //Debug objs plus modsuit
	name = "Bluespace Tech (MODsuit)"
	uniform = /obj/item/clothing/under/syndicate/combat
	belt = /obj/item/storage/belt/utility/chief/full/debug
	shoes = /obj/item/clothing/shoes/combat/debug
	id = /obj/item/card/id/advanced/debug/bst
	box = /obj/item/storage/box/debugtools
	backpack_contents = list(
		/obj/item/melee/energy/axe = 1,
		/obj/item/storage/part_replacer/bluespace/tier4_bst = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/debug/omnitool = 1,
	)

/obj/item/storage/part_replacer/bluespace/tier4_bst
	name = "BST's RPED"
	desc = "A specialized bluespace RPED for technicians that can manufacture stock parts on the fly.  Alt-Right-Click to manufacture parts or clear its internal storage."

/obj/item/storage/part_replacer/bluespace/tier4_bst/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 1000
	atom_storage.max_total_storage = 20000

/// BSTs' special Bluespace RPED can manufacture parts on Alt-RMB, either cables, glass, machine boards, or stock parts.
/obj/item/storage/part_replacer/bluespace/tier4_bst/alt_click_secondary(mob/user)
	// Ask the user what they want to make, or if they want to clear the storage.
	var/spawn_selection = tgui_input_list(user, "Pick a part, or clear storage", "RPED Manufacture", list("Clear All Items", "Cables", "Glass", "Machine Board", "Stock Part"))
	// If they didn't cancel out of the list selection, we do things.  Clear-all QDELs the entire contents, cable coils add new cable coil stacks, and glass adds new glass sheets.  Machine boards and stock parts use a recursive subtype selector.
	if(spawn_selection)
		if(spawn_selection == "Clear All Items")
			QDEL_LIST(src.contents)
		else if(spawn_selection == "Cables")
			new /obj/item/stack/cable_coil(src)
		else if(spawn_selection == "Glass")
			for(var/i in 1 to 10)
				new /obj/item/stack/sheet/glass(src)
		else
			var/subtype
			if(spawn_selection == "Machine Board")
				subtype = /obj/item/circuitboard/machine
			else if(spawn_selection == "Stock Part")
				subtype = /obj/item/stock_parts
			else if(spawn_selection == "Beakers")
				subtype = /obj/item/reagent_containers/cup/beaker
			if(subtype)
				pick_stock_part(user, FALSE, subtype)

/// A bespoke proc for picking a subtype to spawn in a relatively user-friendly way.
/obj/item/storage/part_replacer/bluespace/tier4_bst/proc/pick_stock_part(mob/user, recurse, subtype)
	// Sanity check - this should never be called with a null subtype.
	if(subtype)
		// Stores a list of pretty type names : actual paths.
		var/list/items_temp = list()
		// Grab the initial list of paths, NOT INCLUDING this specific path.
		var/list/paths = subtypesof(subtype)
		// Used to remove subtypes-of-subtypes to prevent list bloat.
		var/list/paths_to_clear = list()
		// Simplistic anti-recursion check.  Check every path, then remove every subtype it has from the main list.
		for(var/path in paths)
			var/list/path_subtypes = subtypesof(path)
			for(var/path2 in path_subtypes)
				if(!(path2 in paths_to_clear))
					paths_to_clear += path2
		for(var/path in paths_to_clear)
			paths -= path
		// With all sub-subtypes removed, initialize the list of valid, spawnable items & their pretty names - and if this is a recursion, include the original subtype.
		if(recurse)
			paths += subtype
		for(var/path in paths)
			var/obj/O = path
			if(length(subtypesof(path)) > 0)
				items_temp["[initial(O.name)] (+[length(subtypesof(path))] more): [path]"] = path
			else
				items_temp["[initial(O.name)]: [path]"] = path
		// Finally, ask the user what they want to spawn.
		var/target_item = tgui_input_list(user, "Select Subtype", "RPED Manufacture", sort_list(items_temp))
		if(target_item)
			// If they select something, and the name:path binding is valid, then either spawn it, OR, if it has subtypes, recurse to let them pick a subtype.
			if(items_temp[target_item])
				var/the_item = items_temp[target_item]
				if(length(subtypesof(the_item)) > 0 && the_item != subtype)
					pick_stock_part(user, TRUE, the_item)
				else
					for(var/i in 1 to 10)
						new the_item(src) //this is so scrungly
	else
		return