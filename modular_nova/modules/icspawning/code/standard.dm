// NOVA MODULE IC-SPAWNING https://github.com/Skyrat-SS13/Skyrat-tg/pull/104
// Debug Datums
// Debug Storage Datum
/datum/storage/debug
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = WEIGHT_CLASS_GIGANTIC * 28
	max_slots = 28

/datum/armor/debug
	melee = 95
	melee = 95
	laser = 95
	energy = 95
	bomb = 95
	bio = 95
	fire = 98
	acid = 98

// Debug Items //
// Legacy
/obj/item/clothing/shoes/combat/debug // Someone made this for a reason, I'm not going to question it
	w_class = WEIGHT_CLASS_TINY // tiny ahh feet

/obj/item/gun/energy/taser/debug
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/debug)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_casing/energy/electrode/debug
	e_cost = LASER_SHOTS(1000, STANDARD_CELL_CHARGE)

/obj/item/clothing/suit/armor/vest/debug
	name = "\improper subspace vest"
	desc = "A sleek piece of armour designed for Bluespace agents."
	armor_type = /datum/armor/debug
	w_class = WEIGHT_CLASS_TINY

// Debug magbooties
/obj/item/clothing/magboots/advance/debug/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	AddElement(/datum/element/ignites_matches)

/obj/item/clothing/shoes/magboots/advance/debug
	name = "subspace magboots"
	desc = "Rare handcrafted boots made of the finest materials the sector has to offer. The bluespace crystal powering each boot gleam threateningly."
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/debug
	base_icon_state = "submag"
	icon_state = "submag0"
	magpulse_fishing_modifier = 10
	fishing_modifier = 10

// Debug Headset and Encryption Key
/obj/item/encryptionkey/debug
	name = "\proper the subspace encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/heads/captain"
	post_init_icon_state = "cypherkey_cube"
	channels = list(RADIO_CHANNEL_COMMAND = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SERVICE = 1, RADIO_CHANNEL_AI_PRIVATE = 1, RADIO_CHANNEL_CENTCOM = 1, RADIO_CHANNEL_CTF_BLUE = 1, RADIO_CHANNEL_CTF_GREEN = 1, RADIO_CHANNEL_CTF_RED = 1, RADIO_CHANNEL_CTF_YELLOW = 1, RADIO_CHANNEL_CYBERSUN = 1, RADIO_CHANNEL_ENTERTAINMENT = 1, RADIO_CHANNEL_FACTION = 1, RADIO_CHANNEL_GUILD = 1, RADIO_CHANNEL_INTERDYNE = 1, RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_TARKON = 1, RADIO_CHANNEL_SYNDICATE = 1, RADIO_CHANNEL_UPLINK = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2b2793#dca01b"

/obj/item/radio/headset/debug
	name = "\improper subspace bowman headset"
	desc = "You can hear all of them. THE VOICES. SO MANY VOICES. AAAAAAAAAA-"
	icon_state = "cent_headset_alt"
	worn_icon_state = "cent_headset_alt"
	keyslot2 = null
	keyslot = /obj/item/encryptionkey/debug

/obj/item/radio/headset/headset_debug/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)

// Nova Bluespace Tech Modsuits //
// Debug Modules
/obj/item/mod/module/energy_shield/debug
	shield_icon = "love_hearts"

/obj/item/mod/module/infiltrator/debug
	incompatible_modules = list(/obj/item/mod/module/infiltrator/debug)

/obj/item/mod/module/storage/debug
	name = "MOD subspace storage module"
	desc = "A storage system developed by CentCom, these compartments employ \
		miniaturized bluespace pockets for the ultimate in storage technology; regardless of the weight of objects put inside."
	icon_state = "storage_large"
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = WEIGHT_CLASS_GIGANTIC * 28
	max_items = 28
	big_nesting = TRUE

// Extremely cursed modsuit that will self install any modsuit module in existence
// Do NOT spawn this on a live server. The lag from this being created is impressive.
/obj/item/mod/control/pre_equipped/administrative/module_debug
    default_pins = list()
    applied_modules = list()

/obj/item/mod/control/pre_equipped/administrative/debug/Initialize(mapload, new_theme, new_skin, new_core)
    . = ..()
    for(var/path in subtypesof(/obj/item/mod/module))
        var/obj/item/mod/module/module = new path(src)
        module.mod = src
        modules += module
        module.on_install()
        module.forceMove(src)

//Our Custom Bluespace Tech Modsuit
/obj/item/mod/control/pre_equipped/administrative/subspace
	applied_modules = list(
		/obj/item/mod/module/hearing_protection,
		/obj/item/mod/module/storage/debug,
		/obj/item/mod/module/infiltrator/debug,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/energy_shield/debug,
		/obj/item/mod/module/plasma_stabilizer,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/stealth/ninja,
		/obj/item/mod/module/quick_carry/advanced,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/anomaly_locked/kinesis/admin,
		/obj/item/mod/module/dispenser,
		/obj/item/mod/module/shove_blocker,
		/obj/item/mod/module/quick_cuff,
		/obj/item/mod/module/anti_magic,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/longfall,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/hacker,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/mister/atmos,
		/obj/item/mod/module/defibrillator/combat,
		/obj/item/mod/module/medbeam,
		/obj/item/mod/module/surgical_processor/preloaded,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/baton_holster/preloaded,
		/obj/item/mod/module/flamethrower,
		/obj/item/mod/module/adrenaline_boost,
		/obj/item/mod/module/jaeger_sprint,
		/obj/item/mod/module/jump_jet,
		/obj/item/mod/module/reagent_scanner/advanced,
		/obj/item/mod/module/selfcleaner,
		/obj/item/mod/module/anomaly_locked/antigrav/prebuilt,
		/obj/item/mod/module/anomaly_locked/teleporter/prebuilt,
		/obj/item/mod/module/sphere_transform,
		/obj/item/mod/module/rewinder,
		/obj/item/mod/module/timestopper,
		/obj/item/mod/module/timeline_jumper,
		/obj/item/mod/module/tem,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/flashlight/darkness,
		/obj/item/mod/module/balloon/advanced,
		/obj/item/mod/module/paper_dispenser,
	)
	default_pins = list(
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/anomaly_locked/kinesis/admin,
		/obj/item/mod/module/timeline_jumper,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/mister/atmos,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/dispenser,
		/obj/item/mod/module/balloon/advanced,
	)

// Bluespace Tech Storage Belts //
// Chief engineer tools variant
/obj/item/storage/belt/utility/full/powertools/debug
	name = "\improper loaded Bluespace Technician's belt"
	w_class = WEIGHT_CLASS_TINY
	storage_type = /datum/storage/debug
	desc = "Can hold a boatload of things... Why do you have this?!"
	icon = 'modular_nova/modules/bluespace_admin/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = 'modular_nova/modules/bluespace_admin/icons/mob/belt.dmi'
	worn_icon_state = "admeme_satchel"

// Empty variant
/obj/item/storage/belt/utility/debug
	name = "\improper subspace utility belt"
	w_class = WEIGHT_CLASS_TINY
	storage_type = /datum/storage/debug
	desc = "Can hold a boatload of things... Why do you have this?!"
	icon = 'modular_nova/modules/bluespace_admin/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = 'modular_nova/modules/bluespace_admin/icons/mob/belt.dmi'
	worn_icon_state = "admeme_satchel"

//Legacy Outfit
/datum/outfit/debug/bst
	name = "Bluespace Tech"
	uniform = /obj/item/clothing/under/syndicate/combat
	belt = /obj/item/storage/belt/utility/full/powertools/debug
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
		/obj/item/storage/hypospraykit/cmo/combat = 1,
		/obj/item/summon_beacon/gas_miner/expanded/debug = 1,
		/obj/item/choice_beacon/job_locker/debug = 1,
	)

//Bluespace Technician Outfit, used with the icspawning quick button
/datum/outfit/admin/bst
	name = "Bluespace Tech (MODsuit)"
	uniform = /obj/item/clothing/under/misc/adminsuit
	suit = /obj/item/clothing/suit/armor/vest/debug
	suit_store = /obj/item/tank/internals/emergency_oxygen/double
	ears = /obj/item/radio/headset/debug
	neck = /obj/item/clothing/neck/necklace/memento_mori
	gloves = /obj/item/clothing/gloves/kaza_ruk/combatglovesplus
	belt = /obj/item/storage/belt/utility/debug
	shoes = /obj/item/clothing/shoes/magboots/advance
	mask = /obj/item/clothing/mask/gas/atmos
	id = /obj/item/card/id/advanced/debug/bst
	box = /obj/item/storage/box/debugtools
	back = /obj/item/mod/control/pre_equipped/administrative
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack = 1,
		/obj/item/storage/box/stabilized = 1,
		/obj/item/storage/hypospraykit/cmo/combat = 1,
		/obj/item/melee/energy/axe = 1,
		/obj/item/gun/energy/pulse/destroyer = 1,
		/obj/item/gun/energy/taser/debug = 1,
		/obj/item/gun/magic/hook/debug = 1,
		/obj/item/storage/part_replacer/bluespace/tier4/bst = 1,
		/obj/item/modular_computer/debug = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/gun/magic/wand/safety/debug = 1,
		/obj/item/summon_beacon/gas_miner/expanded/debug = 1,
		/obj/item/choice_beacon/job_locker/debug = 1,
		/obj/item/multitool/field_debug = 1,
		/obj/item/camera/spooky/badmin = 1,
		/obj/item/integrated_circuit/admin = 1,
		/obj/item/autosurgeon/organ/nif/debug = 1,
		/obj/item/reagent_containers/cup/bottle/adminordrazine = 1,
		/obj/item/reagent_containers/hypospray/combat/nanites = 1,
	)
	belt_contents = list(
		/obj/item/screwdriver/power = 1,
		/obj/item/crowbar/power = 1,
		/obj/item/weldingtool/abductor = 1,
		/obj/item/multitool/abductor = 1,
		/obj/item/analyzer/ranged = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/storage/part_replacer/bluespace/tier4/bst = 1,
		/obj/item/construction/rcd/arcd/mattermanipulator = 1,
		/obj/item/pipe_dispenser/bluespace = 1,
		/obj/item/rpd_upgrade/unwrench = 1,
		/obj/item/construction/rtd/admin = 1,
		/obj/item/rwd/admin = 1,
		/obj/item/teleport_rod/admin = 1,
		/obj/item/debug/omnitool = 1,
		/obj/item/debug/omnitool/item_spawner = 1,
		/obj/item/lightreplacer/blue = 1,
		/obj/item/bodybag/bluespace = 1,
		/obj/item/clothing/glasses/thermal/xray = 1,
		/obj/item/clothing/glasses/meson/engine/admin = 1,
		/obj/item/melee/skateboard/hoverboard/admin = 1,
		/obj/item/mop/advanced = 1,
		/obj/item/gun/energy/wormhole_projector/core_inserted = 1,

	)

/obj/item/storage/part_replacer/bluespace/tier4/bst
	name = "\improper Bluespace Tech RPED"
	desc = "A specialized bluespace RPED for technicians that can manufacture stock parts on the fly. Alt-Right-Click to manufacture parts, change settings, or clear its internal storage."
	storage_type = /datum/storage/rped/bluespace/debug
	/// Whether or not auto-clear is enabled
	var/auto_clear = TRUE
	/// List of valid types for pick_stock_part().
	var/static/list/valid_stock_part_types = list(
		/obj/item/circuitboard/machine,
		/obj/item/stock_parts,
		/obj/item/reagent_containers/cup/beaker,
	)

/datum/storage/rped/bluespace/debug
	max_slots = 1000
	max_total_storage = 20000

/// An extension to the default RPED part replacement action - if you don't have the requisite parts in the RPED already, it will spawn T4 versions to use.
/obj/item/storage/part_replacer/bluespace/tier4/bst/interact_with_atom(obj/attacked_object, mob/living/user, list/modifiers)
	//duplicate checks from parent since
	if(user.combat_mode)
		return ITEM_INTERACT_SKIP_TO_ATTACK
	if(!ismachinery(attacked_object) || istype(attacked_object, /obj/machinery/computer))
		return NONE
	var/obj/machinery/attacked_machinery = attacked_object
	if(!LAZYLEN(attacked_machinery.component_parts))
		return ITEM_INTERACT_FAILURE

	// We start with setting up a list of the current contents of the RPED when using auto-clear.  This is used to detect new items after upgrades are applied & remove them.
	var/list/old_contents = list()
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	if(auto_clear)
		old_contents = atom_storage.return_inv(FALSE)
	// Once old_contents has been initialized, if needed, we check if the target object is a machine frame.
	var/obj/structure/frame/attacked_frame = attacked_object
	if(istype(attacked_frame, /obj/structure/frame/machine))
		var/obj/structure/frame/machine/machine_frame = attacked_frame
		var/obj/item/circuitboard/machine/circuit = machine_frame.circuit
		// Prioritize using the circuit's components list first, if present, to maintain consistency.
		if(istype(circuit))
			spawn_parts_for_components(user, circuit.req_components)
		else if(machine_frame.req_components)
			spawn_parts_for_components(user, machine_frame.req_components)
	else
		// It's not a machine frame, so let's check if it's a regular machine.
		if(ismachinery(attacked_object) && !istype(attacked_object, /obj/machinery/computer))
			var/obj/item/circuitboard/machine/circuit = attacked_machinery.circuit
			// If it is, we need to use the circuit's components; there's no good way to get required components off of an already-built machine.
			if(istype(circuit))
				spawn_parts_for_components(user, circuit.req_components)
	. = ..()
	// If auto-clear is in use,
	if(auto_clear)
		inv_grab.Cut()
		inv_grab = atom_storage.return_inv(FALSE)
		for(var/obj/item/stored_item in inv_grab)
			if(!(stored_item in old_contents))
				qdel(stored_item)

/// A bespoke proc for spawning in parts
/obj/item/storage/part_replacer/bluespace/tier4/bst/proc/spawn_parts_for_components(mob/living/user, list/required_components)
	// Since req_components in machineboards can list item types *OR* /datum/stock_part subtypes this gets a little complicated.
	var/list/subtypes = list()
	for(var/req_component in required_components)
		// Start off noting how many the recipe calls for, a counter for how many matching parts have been found, and generating a list of subtypes for use in later checks.
		var/parts_amount_required = required_components[req_component]
		var/found_matching = 0
		subtypes = typesof(req_component)

		if(!parts_amount_required)
			continue

		/// Then, check if the requested component is an object subtype - this means it's probably either materials (e.g, cables) or non-stock_part subtypes like beakers.
		if(ispath(req_component, /obj/item))
			// If it's a stack, it needs special treatment.
			if(ispath(req_component, /obj/item/stack))
				// Stacks generate the matching count based on how many matching stacks are in the RPED's inventory with sufficient count.
				// To find stacks inside the RPED, we search its contents for anything that's a subtype of /obj/item/stack.
				for(var/obj/stored_item in contents)
					var/obj/item/stack/stored_item_as_stack = stored_item
					if(istype(stored_item_as_stack))
						// If a stack item is found, we check if it's in the typesof list for the current requested component, and if so, mark its count.
						if(stored_item_as_stack.type in subtypes)
							found_matching += stored_item_as_stack.amount
							// If there's enough, we can return early.
							if(found_matching >= parts_amount_required)
								break
				// If there's not enough left, spawn enough of the appropriate type that there will be.  Stacks' Initialialize accepts an amount for the newly-spawned stack to have, and will auto-split as needed.
				if(found_matching < parts_amount_required)
					atom_storage.attempt_insert(new req_component(src, parts_amount_required - found_matching), user, TRUE)
					continue
			else
				// It's not a stack, which means now we have to count how many matching items are present.
				for(var/obj/stored_item in contents)
					if(stored_item.type in subtypes)
						found_matching += 1
						// If there's enough, we can break - no need to spawn extras.
						if(found_matching >= parts_amount_required)
							break
				// If there's still not enough, we're going to have to spawn enough in manually.
				if(found_matching < parts_amount_required)
					for(var/i in 1 to parts_amount_required - found_matching)
						atom_storage.attempt_insert(new req_component(src), user, TRUE)
					continue

		/// If it's not an obj, then it's a subtype of /datum/stock_part - or *should be*, anyway.
		else if(ispath(req_component, /datum/stock_part))
			var/datum/stock_part/part_type = new req_component()
			var/base_type = part_type.physical_object_base_type
			// Specific machines sometimes call for specific tiers of part; give them precisely what they ask for, just in case.
			if(part_type.tier > 1)
				base_type = part_type.physical_object_type
				// Search to see if we have enough of that exact item, and if not, we'll spawn more.
				for(var/obj/stored_item in contents)
					if(stored_item.type == base_type)
						found_matching += 1
						// If there's enough, we can return early.
						if(found_matching >= parts_amount_required)
							break
				// If there's still not enough, we're going to have to spawn enough in manually.
				if(found_matching < parts_amount_required)
					for(var/i in 1 to parts_amount_required - found_matching)
						atom_storage.attempt_insert(new base_type(src), user, TRUE)
					continue
			else
				// For everything else, just make sure we have enough valid items of the stock part's subtypes.
				subtypes = typesof(base_type)
				for(var/obj/stored_item in contents)
					if(stored_item.type in subtypes)
						found_matching += 1
						// If there's enough, we can return early.
						if(found_matching >= parts_amount_required)
							break

				// If there's still not enough, we're going to have to spawn enough in manually.
				if(found_matching < parts_amount_required)
					// Reset the subtypes list so we can pick the highest tier of part available.
					subtypes = typesof(req_component)
					var/highest_tier = 0

					// Search those subtypes for the highest.  This SHOULD only ever go up to 4, but that's on the assumption upstream doesn't change it.
					for(var/subtype_path in subtypes)
						var/datum/stock_part/sub_part = new subtype_path()
						if(sub_part.tier > highest_tier)
							highest_tier = sub_part.tier
							base_type = sub_part.physical_object_type

					// Once the best component has been found, fill in enough remaining.
					for(var/i in 1 to parts_amount_required - found_matching)
						atom_storage.attempt_insert(new base_type(src), user, TRUE)
					continue

		// If it's not a /datum/stock_part subtype either, something has gone wrong and devs should probably be alerted.
		if(found_matching < parts_amount_required)
			to_chat(user, span_notice("Something went wrong manufacturing [req_component]. Alert the devs, and let them know what machine it was!"))

/// BSTs' special Bluespace RPED can manufacture parts on Alt-RMB, either cables, glass, machine boards, or stock parts.
/obj/item/storage/part_replacer/bluespace/tier4/bst/click_alt_secondary(mob/user)
	// Ask the user what they want to make, or if they want to clear the storage.
	var/spawn_selection = tgui_input_list(user, "Pick a part, or clear storage", "RPED Manufacture", list("Clear All Items", "Toggle Auto-Clear", "Cables", "Glass", "Spare T4s", "Machine Board", "Stock Part", "Beaker"))
	// If they didn't cancel out of the list selection, we do things.  Clear-all removes all items, auto-clear destroys left-overs after upgrades, and everything else is pretty self-explanatory.
	// Machine boards and stock parts use a recursive subtype selector.
	if(isnull(spawn_selection))
		return
	else if(spawn_selection == "Clear All Items")
		var/list/inv_grab = atom_storage.return_inv(FALSE)
		for(var/obj/item/stored_item in inv_grab)
			qdel(stored_item)
	else if(spawn_selection == "Toggle Auto-Clear")
		auto_clear = !auto_clear
		to_chat(user, span_notice("The RPED will now [(auto_clear ? "destroy" : "keep")] items left over after upgrades."))
	else if(spawn_selection == "Tier 4 Parts")
		for(var/i in 1 to 10)
			atom_storage.attempt_insert(new /obj/item/stock_parts/capacitor/quadratic(src), user, TRUE)
			atom_storage.attempt_insert(new /obj/item/stock_parts/scanning_module/triphasic(src), user, TRUE)
			atom_storage.attempt_insert(new /obj/item/stock_parts/servo/femto(src), user, TRUE)
			atom_storage.attempt_insert(new /obj/item/stock_parts/micro_laser/quadultra(src), user, TRUE)
			atom_storage.attempt_insert(new /obj/item/stock_parts/matter_bin/bluespace(src), user, TRUE)
			atom_storage.attempt_insert(new /obj/item/stock_parts/power_store/cell/bluespace(src), user, TRUE)
			atom_storage.attempt_insert(new /obj/item/stock_parts/power_store/battery/bluespace(src), user, TRUE)
	else if(spawn_selection == "Cable Coils")
		atom_storage.attempt_insert(new /obj/item/stack/cable_coil(src), user, TRUE)
	else if(spawn_selection == "Glass Sheets")
		atom_storage.attempt_insert(new /obj/item/stack/sheet/glass/fifty(src), user, TRUE)
	else if(spawn_selection == "Plasteel Sheets")
		atom_storage.attempt_insert(new /obj/item/stack/sheet/plasteel/fifty(src), user, TRUE)
	else if(spawn_selection == "Bluespace Crystals")
		atom_storage.attempt_insert(new /obj/item/stack/sheet/bluespace_crystal/fifty(src), user, TRUE)
	else
		var/subtype
		if(spawn_selection == "Machine Boards")
			subtype = /obj/item/circuitboard/machine
		else if(spawn_selection == "Computer Boards")
			subtype = /obj/item/circuitboard/computer
		else if(spawn_selection == "Material Sheets")
			subtype = /obj/item/stack/sheet
		else if(spawn_selection == "Stock Parts")
			subtype = /obj/item/stock_parts
		else if(spawn_selection == "Beakers")
			subtype = /obj/item/reagent_containers/cup/beaker
		if(subtype)
			pick_stock_part(user, FALSE, subtype)

/// A bespoke proc for picking a subtype to spawn in a relatively user-friendly way.
/obj/item/storage/part_replacer/bluespace/tier4/bst/proc/pick_stock_part(mob/user, recurse, subtype)
	// Sanity check: make sure it's actually an item, and not an atom, machine, or whatever else someone might try to feed it down the line.
	if(!is_path_in_list(subtype, valid_stock_part_types))
		return
	// Stores a list of pretty type names : actual paths.
	var/list/items_temp = list()
	// Grab the initial list of paths, NOT INCLUDING this specific path.
	var/list/paths = subtypesof(subtype)

	// Simplistic check to only list top-level subtypes.
	var/list/top_level_subtypes_only = list()
	for(var/datum/subtype_path as anything in paths)
		if(initial(subtype_path.parent_type) != subtype)
			continue
		top_level_subtypes_only += subtype_path
	paths = top_level_subtypes_only

	// With all sub-subtypes removed, initialize the list of valid, spawnable items & their pretty names - and if this is a recursion, include the original subtype.
	if(recurse)
		paths += subtype
	for(var/path in paths)
		var/obj/path_as_obj = path
		// Generates a pretty list of item names & paths, including notes for those with subtypes.  When browsing subtypes, the parent won't have the (# more) note added.
		if(length(subtypesof(path)))
			if(path == subtype)
				items_temp["[initial(path_as_obj.name)]: [path]"] = path
			else
				items_temp["[initial(path_as_obj.name)] (+[length(subtypesof(path))] more): [path]"] = path
		else
			items_temp["[initial(path_as_obj.name)]: [path]"] = path

	// Finally, once the listed is generated, ask the user what they want to spawn.
	var/target_item = tgui_input_list(user, "Select Subtype", "RPED Manufacture", sort_list(items_temp))
	if(target_item)
		// If they select something, and the name:path binding is valid, then either spawn it, OR, if it has subtypes, and isn't the parent type, recurse to let them pick a subtype.
		if(items_temp[target_item])
			var/the_item = items_temp[target_item]
			if(length(subtypesof(the_item)) && the_item != subtype)
				pick_stock_part(user, TRUE, the_item)
			else
				for(var/i in 1 to 25)
					atom_storage.attempt_insert(new the_item(src), user, TRUE)
