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
		/obj/item/storage/part_replacer/bluespace/tier4/bst = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/debug/omnitool = 1,
		/obj/item/storage/box/stabilized = 1,
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
		/obj/item/storage/part_replacer/bluespace/tier4/bst = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/debug/omnitool = 1,
		/obj/item/storage/box/stabilized = 1,
	)

/obj/item/storage/part_replacer/bluespace/tier4/bst
	name = "\improper Bluespace Tech RPED"
	desc = "A specialized bluespace RPED for technicians that can manufacture stock parts on the fly. Alt-Right-Click to manufacture parts or clear its internal storage."
	var/destroy_worse = TRUE

/obj/item/storage/part_replacer/bluespace/tier4/bst/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 1000
	atom_storage.max_total_storage = 20000

/// An extension to the default RPED part replacement action - if you don't have the requisite parts in the RPED already, it will spawn T4 versions to use.
/obj/item/storage/part_replacer/bluespace/tier4/bst/part_replace_action(obj/attacked_object, mob/living/user)
	// If it's a machine frame, check if we need to spawn new parts for it.
	var/list/old_contents = null
	if(destroy_worse)
		old_contents = contents.Copy()
	var/obj/structure/frame/attacked_frame = attacked_object
	if(istype(attacked_frame, /obj/structure/frame/machine))
		var/obj/structure/frame/machine/machine_frame = attacked_frame
		for(var/obj/item/circuitboard/machine/circuit_in_machine in attacked_frame.contents)
			if(istype(circuit_in_machine))
				spawn_parts_for_components(user, circuit_in_machine.req_components)
				break
		if(machine_frame.req_components)
			spawn_parts_for_components(user, machine_frame.req_components)
	else
		// It's not a machine frame, so let's check if it's a regular machine.
		if(ismachinery(attacked_object) && !istype(attacked_object, /obj/machinery/computer))
			var/obj/machinery/attacked_machinery = attacked_object
			var/obj/item/circuitboard/machine/circuit = attacked_machinery.circuit
			if(istype(circuit))
				spawn_parts_for_components(user, circuit.req_components)
	. = ..()
	if(destroy_worse)
		for(var/obj/some_item in contents)
			if(!(some_item in old_contents))
				qdel(some_item)

/// A bespoke proc for spawning in parts
/obj/item/storage/part_replacer/bluespace/tier4/bst/proc/spawn_parts_for_components(mob/living/user, list/components_go_brr)
	// Since req_components in machineboards can list item types *OR* /datum/stock_part subtypes this gets a little complicated.
	var/list/subtypes = list()
	for(var/some_component in components_go_brr)
		// Start off noting how many the recipe calls for, a counter for how many matching parts have been found, and generating a list of subtypes for use in later checks.
		var/how_many = components_go_brr[some_component]
		var/found_matching = 0
		subtypes = typesof(some_component)

		if(!how_many)
			continue

		/// Then, check if the requested component is an object subtype - this means it's probably either materials (e.g, cables) or non-stock_part subtypes like beakers.
		if(ispath(some_component, /obj/item))
			// If it's a stack, it needs special treatment.
			if(ispath(some_component, /obj/item/stack))
				// Stacks generate the matching count based on how many matching stacks are in the RPED's inventory with sufficient count.
				for(var/obj/some_item in contents)
					var/obj/item/stack/some_item_as_stack = some_item
					if(istype(some_item_as_stack))
						if(some_item_as_stack.type in subtypes)
							found_matching += some_item_as_stack.amount
							// If there's enough, we can return early.
							if(found_matching >= how_many)
								break
				// If there's not enough left, spawn enough of the appropriate type that there will be.
				if(found_matching < how_many)
					new some_component(src, how_many - found_matching)
					continue
			else
				// It's not a stack, which means now we have to count how many matching items are present.
				for(var/obj/some_item in contents)
					if(some_item.type in subtypes)
						found_matching += 1
						// If there's enough, we can return early.
						if(found_matching >= how_many)
							break
				// If there's still not enough, we're going to have to spawn enough in manually.
				if(found_matching < how_many)
					for(var/i in 1 to how_many - found_matching)
						new some_component(src)
					continue
		// If it's not an obj, then it's a subtype of /datum/stock_part - or *should be*, anyway.
		else if(ispath(some_component, /datum/stock_part))
			var/datum/stock_part/part_type = new some_component()
			var/base_type = part_type.physical_object_base_type
			// Specific machines sometimes call for specific tiers of part; give them what they ask for, just in case.
			if(part_type.tier > 1)
				base_type = part_type.physical_object_type
				// Search to see if we have enough of that exact item, and if not, we'll spawn more.
				for(var/obj/some_item in contents)
					if(some_item.type == base_type)
						found_matching += 1
						// If there's enough, we can return early.
						if(found_matching >= how_many)
							break
				// If there's still not enough, we're going to have to spawn enough in manually.
				if(found_matching < how_many)
					for(var/i in 1 to how_many - found_matching)
						new base_type(src)
					continue
			else
				subtypes = typesof(base_type)
				for(var/obj/some_item in contents)
					if(some_item.type in subtypes)
						found_matching += 1
						// If there's enough, we can return early.
						if(found_matching >= how_many)
							break
				// If there's still not enough, we're going to have to spawn enough in manually.
				if(found_matching < how_many)
					// Reset the subtypes list so we can pick the highest tier of part available.
					subtypes = typesof(some_component)
					var/highest_tier = 0
					// Search those subtypes for the highest.  This SHOULD only ever go up to 4, but that's on the assumption upstream doesn't change it.
					for(var/subtype_path in subtypes)
						var/datum/stock_part/sub_part = new subtype_path()
						if(sub_part.tier > highest_tier)
							highest_tier = sub_part.tier
							base_type = sub_part.physical_object_type

					// Once the best component has been found, fill in enough remaining.
					for(var/i in 1 to how_many - found_matching)
						new base_type(src)
					continue
		// If it's not a /datum/stock_part subtype either, something has gone wrong and devs should probably be alerted.
		if(found_matching < how_many && how_many)
			to_chat(user, span_notice("Something went wrong manufacturing [some_component].  Alert the devs, and let them know what machine it was!"))

/// BSTs' special Bluespace RPED can manufacture parts on Alt-RMB, either cables, glass, machine boards, or stock parts.
/obj/item/storage/part_replacer/bluespace/tier4/bst/alt_click_secondary(mob/user)
	// Ask the user what they want to make, or if they want to clear the storage.
	var/spawn_selection = tgui_input_list(user, "Pick a part, or clear storage", "RPED Manufacture", list("Clear All Items", "Toggle Auto-Clear", "Cables", "Glass", "Spare T4s", "Machine Board", "Stock Part", "Beaker"))
	// If they didn't cancel out of the list selection, we do things.  Clear-all QDELs the entire contents, auto-clear destroys left-overs after upgrades, cable coils add new cable coil stacks, glass adds new glass sheets, and spare T4s resets.
	// Machine boards and stock parts use a recursive subtype selector.
	if(spawn_selection)
		if(spawn_selection == "Clear All Items")
			QDEL_LIST(src.contents)
		else if(spawn_selection == "Toggle Auto-Clear")
			if(!destroy_worse)
				destroy_worse = TRUE
			else
				destroy_worse = FALSE
			to_chat(user, span_notice("The RPED will now [(destroy_worse ? "destroy" : "keep")] items left-over after upgrades."))
		else if(spawn_selection == "Cables")
			new /obj/item/stack/cable_coil(src)
		else if(spawn_selection == "Glass")
			new /obj/item/stack/sheet/glass/fifty(src)
		else if(spawn_selection == "Spare T4s")
			for(var/i in 1 to 10)
				new /obj/item/stock_parts/capacitor/quadratic(src)
				new /obj/item/stock_parts/scanning_module/triphasic(src)
				new /obj/item/stock_parts/servo/femto(src)
				new /obj/item/stock_parts/micro_laser/quadultra(src)
				new /obj/item/stock_parts/matter_bin/bluespace(src)
				new /obj/item/stock_parts/cell/bluespace(src)
		else
			var/subtype
			if(spawn_selection == "Machine Board")
				subtype = /obj/item/circuitboard/machine
			else if(spawn_selection == "Stock Part")
				subtype = /obj/item/stock_parts
			else if(spawn_selection == "Beaker")
				subtype = /obj/item/reagent_containers/cup/beaker
			if(subtype)
				pick_stock_part(user, FALSE, subtype)

/// A bespoke proc for picking a subtype to spawn in a relatively user-friendly way.
/obj/item/storage/part_replacer/bluespace/tier4/bst/proc/pick_stock_part(mob/user, recurse, subtype)
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
