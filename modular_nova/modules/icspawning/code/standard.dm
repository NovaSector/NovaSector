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

/obj/item/storage/part_replacer/bluespace/tier4_bst/PopulateContents()
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/part_replacer/bluespace/tier4_bst/alt_click_secondary(mob/user)
	var/spawn_selection
	to_chat(world, "Alt-RMB'd a RPED")
	spawn_selection = tgui_input_list(user, "Pick a part, or clear storage", "RPED Manufacture", list("Clear All Items", "Cables", "Glass", "Servos", "Lasers", "Matter Bins", "Cells", "Capacitors", "Scanning Modules", "Beakers"))
	if(spawn_selection)
		to_chat(world, "User selected [spawn_selection]")
		if(spawn_selection == "Clear All Items")
			to_chat(world, "Not implemented yet!")
		else if(spawn_selection == "Cables")
			new /obj/item/stack/cable_coil(src)
		else if(spawn_selection == "Glass")
			for(var/i in 1 to 10)
				new /obj/item/stack/sheet/glass(src)
		else
			var/subtype
			to_chat(world, "User asked for a part subtype")
			if(spawn_selection == "Servos")
				subtype = /obj/item/stock_parts/servo
			else if(spawn_selection == "Lasers")
				subtype = /obj/item/stock_parts/micro_laser
			else if(spawn_selection == "Matter Bins")
				subtype = /obj/item/stock_parts/matter_bin
			else if(spawn_selection == "Cells")
				subtype = /obj/item/stock_parts/cell
			else if(spawn_selection == "Capacitors")
				subtype = /obj/item/stock_parts/capacitor
			else if(spawn_selection == "Scanning Modules")
				subtype = /obj/item/stock_parts/scanning_module
			else if(spawn_selection == "Beakers")
				subtype = /obj/item/reagent_containers/cup/beaker
			//picked a type now
			if(subtype)
				to_chat(world, "User picked subtype [subtype]")
				var/list/items_temp = list()
				var/list/paths = subtypesof(subtype) + subtype
				for(var/path in paths)
					var/obj/item/O = path
					items_temp[initial(O.name)] = path
				var/target_item = tgui_input_list(user, "Select specific subtype", "RPED Manufacture", sort_list(items_temp))
				if(target_item)
					to_chat(world, "Picked item [target_item]")
					if(items_temp[target_item])
						to_chat(world, "Found the correct item type")
						var/the_item = items_temp[target_item]
						for(var/i in 1 to 10)
							new the_item(src) //this is so scrungly
				
	/*for(var/i in 1 to 5)
		new /obj/item/stock_parts/capacitor/quadratic(src)
		new /obj/item/stock_parts/scanning_module/triphasic(src)
		new /obj/item/stock_parts/servo/femto(src)
		new /obj/item/stock_parts/micro_laser/quadultra(src)
		new /obj/item/stock_parts/matter_bin/bluespace(src)
		new /obj/item/stock_parts/cell/bluespace(src)
	for(var/i in 1 to 20)
		new /obj/item/stock_parts/capacitor/quadratic(src)
		new /obj/item/stock_parts/servo/femto(src)
		new /obj/item/stock_parts/micro_laser/quadultra(src)
		new /obj/item/stock_parts/matter_bin/bluespace(src)
		new /obj/item/stock_parts/cell/bluespace(src)*/