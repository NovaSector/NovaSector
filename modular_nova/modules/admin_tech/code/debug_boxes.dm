//todo: recreational drugs box
//todo: fix all the slime boxes, those suck
//TODO: Antag box, Research box, Security box, Service Box, Cargo Box, Medical Box revisit
//Globals! Wow!
GLOBAL_LIST_INIT(subspace_box_types, list(
		"Clear All Items",
		"Another Subspace Box",
		"Medical",
		"Debug Tools",
		"Power",
		"Care Package"
))

GLOBAL_LIST_INIT(subspace_box_contents, list(
		"Another Subspace Box" = list(
			/obj/item/storage/box/debug = 1
		),
        "Medical" = list(//
			/obj/item/storage/briefcase/medicalgunset/cmo = 1,
			/obj/item/storage/hypospraykit/cmo/combat = 1,
			/obj/item/surgery_tray/full/advanced = 1,
			/obj/item/defibrillator/compact/combat/loaded/nanotrasen = 1,
			/obj/item/reagent_containers/cup/bottle/adminordrazine = 1,
			/obj/item/reagent_containers/hypospray/combat/nanites = 1,
			/obj/item/reagent_containers/hypospray/combat = 1,
			/obj/item/storage/pill_bottle/nanite_slurry = 1,
			/obj/item/storage/pill_bottle/liquid_solder = 1,
			/obj/item/storage/pill_bottle/system_cleaner = 1,
			/obj/item/storage/pill_bottle/sansufentanyl = 1,
			/obj/item/storage/pill_bottle/neurine = 1,
			/obj/item/storage/pill_bottle/potassiodide = 1,
			/obj/item/storage/pill_bottle/ondansetron = 1,
			/obj/item/storage/pill_bottle/stimulant = 1,
			/obj/item/storage/pill_bottle/lsd = 1,
			/obj/item/storage/pill_bottle/zoom = 1,
			/obj/item/reagent_containers/cup/bottle/potion/flight = 1,
			/obj/item/slimepotion/speed = 1,
			/obj/item/slimepotion/genderchange = 1,
			/obj/item/slimepotion/peacepotion = 1
		),
        "Debug Tools" = list(
			/obj/item/storage/box/stabilized = 1,
			/obj/item/storage/box/pinpointer_pairs = 1,
			/obj/item/storage/box/beakers/variety = 1,
			/obj/item/uplink/debug = 1,
			/obj/item/uplink/nuclear/debug = 1,
			/obj/item/card/emag/admin = 1,
			/obj/item/construction/rcd/combat/admin = 1,
			/obj/item/holochip/fiftythousand = 1,
			/obj/item/clothing/glasses/meson/engine/admin/debug = 1,
			/obj/item/summon_beacon/gas_miner/expanded/debug = 1,
			/obj/item/choice_beacon/job_locker/debug = 1,
			/obj/item/modular_computer/pda/admin = 1,
			/obj/item/modular_computer/debug = 1,
			/obj/item/healthanalyzer/advanced = 1,
			/obj/item/pinpointer/crew/admin = 1,
			/obj/item/sensor_device = 1,
			/obj/item/debug/omnitool = 1,
			/obj/item/debug/omnitool/item_spawner = 1,
			/obj/item/geiger_counter = 1,
			/obj/item/flashlight/emp/debug = 1,
			/obj/item/clothing/ears/earmuffs/debug = 1,
			/obj/item/gps/visible_debug = 1,
			/obj/item/survivalcapsule/fishing/hacked = 1,
			/obj/item/multitool/field_debug = 1,
			/obj/item/storage/bag/construction/admin = 1,
			/obj/item/integrated_circuit/admin = 1,
			/obj/item/device/traitor_announcer/infinite = 1,
			/obj/item/aicard/syndie/loaded = 1,
			/obj/item/aicard/aitater = 1,
			/obj/item/disk/tech_disk/debug = 1,
			/obj/item/flashlight/flare/torch/everburning = 1
		),
        "Power" = list(//Power Debugging -- todo: flatpacks
			/obj/item/stock_parts/power_store/cell/infinite = 7,
			/obj/item/stock_parts/power_store/battery/infinite = 7,
			/obj/item/mod/core/infinite = 2,
			/obj/item/stack/cable_coil = 4,
			/obj/item/clothing/glasses/meson/engine/admin = 1,
			/obj/item/multitool/abductor = 1,
			/obj/item/inducer/empty = 1,
			/obj/item/inducer = 1,
			/obj/item/screwdriver/power = 1,
			/obj/item/clothing/gloves/chief_engineer = 1,
			/obj/item/autosurgeon/toolset = 1,
        ),
        "Care Package" = list(//Should be populated with toys and room party stuff
			/obj/item/storage/box/hug/plushes = 1,
			/obj/item/storage/box/colonial_rations = 1,
			/obj/item/pizzabox/infinite = 1,
			/obj/item/wallframe/wall_heater = 1,
			/obj/item/pillow = 1,
			/obj/item/bedsheet/cosmos/double = 1,
			/obj/item/tank/internals/emergency_oxygen/double = 1,
			/obj/item/syndicate_contacts = 1,
			/obj/item/lighter/bright = 1,
			/obj/item/storage/fancy/cigarettes/khi = 1,
			/obj/item/camera/spooky/badmin = 1,
			/obj/item/holosign_creator/privacy = 1,
			/obj/item/toy/tennis = 1,
			/obj/item/hairbrush = 1,
			/obj/item/laser_pointer/infinite_range = 1,
			/obj/item/pai_card = 1,
			/obj/item/megaphone = 1,
			/obj/item/handheld_soulcatcher = 1,
			/obj/item/swapper = 1,
			/obj/item/swapper = 1,
			/obj/item/desynchronizer = 1,
			/obj/item/reagent_containers/cup/maunamug = 1,
			/obj/item/clothing/head/helmet/perceptomatrix/functioning = 1,
			/obj/item/polymorph_belt/functioning = 1,
			/obj/item/gun/energy/wormhole_projector/core_inserted = 1,
			/obj/item/gun/energy/gravity_gun = 1,
			/obj/item/flashlight/lamp/space_bubble/preactivated = 1,
			/obj/item/rolling_table_dock = 1,
			/obj/item/pneumatic_cannon/subspace = 1,
        ),
))

//GLOBAL_LIST_INIT(subspace_box_icontype, list(
//		"Medical" = "medbox",
//))

GLOBAL_LIST_INIT(subspace_box_illustrations, list(
		"Another Subspace Box" = "heart_black",
		"Medical" = "pillbox",
		"Debug Tools" = "disk_kit",
		"Power" = "sparkler",
		"Care Package" = "heart",
))

// Debug Boxes
// ICON-TODO:Needs its own custom icons file, and variants for box types
// Its a box with a shitload of space and attitude
/obj/item/storage/box/debug
	name = "subspace box"
	desc = "A hand manufactured storage container composed of rare alloys and with exotic processes.\
		Stores an ungodly amount of anything. Your oversized Xeno wife will fit in this.\
		Its a box shaped bag of holding on cocaine. Reality warping recursion issues not included.\
		Ctrl + click to Populate. Ctrl + Shift + Left Click to clear contents."
	icon_state = "alienbox"
	storage_type = /datum/storage/admin
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	illustration = null
	// Thank you traitor guncases for this box.
	// Timer for the bomb in the case.
	var/explosion_timer
	// Whether or not our case is exploding. Used for determining sprite changes.
	var/currently_exploding = FALSE

/obj/item/storage/box/debug/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/storage/box/debug/examine(mob/user)
	. = ..()
	. += span_notice("Activate the Subspace Catalyst using Alt-Right-Click.")

/obj/item/storage/box/debug/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	context[SCREENTIP_CONTEXT_ALT_RMB] = "Activate Subspace Catalyst"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/storage/box/debug/click_alt_secondary(mob/user)
	. = ..()
	if(currently_exploding)
		user.balloon_alert(user, "already exploding!")
		return

	var/i_dont_even_think_once_about_blowing_stuff_up = tgui_alert(user, "Would you like to activate the subspace catalyst now?", "BYE BYE", list("Yes","No"))

	if(i_dont_even_think_once_about_blowing_stuff_up != "Yes" || currently_exploding || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING))
		return

	explosion_timer = addtimer(CALLBACK(src, PROC_REF(think_fast_chucklenuts)), 5 SECONDS, (TIMER_UNIQUE|TIMER_OVERRIDE))
	to_chat(user, span_warning("You prime [src]'s subspace catalyst!"))
	log_bomber(user, "has activated a", src, "for detonation")
	playsound(src, 'sound/items/weapons/armbomb.ogg', 50, TRUE)
	currently_exploding = TRUE
	update_appearance()

/// proc to handle our detonation
/obj/item/storage/box/debug/proc/think_fast_chucklenuts()
	explosion(src, devastation_range = 0, heavy_impact_range = 0, light_impact_range = 2, explosion_cause = src)
	qdel(src)

/obj/item/storage/box/debug/click_ctrl_shift(mob/user)
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	for(var/obj/item/stored_item in inv_grab)
		qdel(stored_item)
	return

/obj/item/storage/box/debug/item_ctrl_click(mob/user)
	// Ask the user what they want to make, or if they want to clear the storage.
	var/choice = tgui_input_list(user, "Populate the Box", "Subspace Box Stuffer", GLOB.subspace_box_types)
	// If they didn't cancel out of the list selection, we do things.  Clear-all removes all items.
	if(isnull(choice))
		return
	// Empties the box of ITEMS.
	if(choice == "Clear All Items")
		var/list/inv_grab = atom_storage.return_inv(FALSE)
		for(var/obj/item/stored_item in inv_grab)
			qdel(stored_item)
		illustration = null
		return
	// Checks contents lists with an input choice match
	for(var/item_path in GLOB.subspace_box_contents[choice])
		for(var/i in 1 to GLOB.subspace_box_contents[choice][item_path])
			new item_path(src)
	if(choice in GLOB.subspace_box_illustrations)
		illustration = GLOB.subspace_box_illustrations[choice]
//	if(choice in GLOB.subspace_box_icontype)
//		icon_state = GLOB.subspace_box_icontype[choice]
	update_appearance()
	return CLICK_ACTION_SUCCESS

// Box which was made to boilerplate the box populating method used here.
// Because of the way I insert the cats, the cat can't be removed from the storage. This is funny to me. Don't let the cat suffocate!
/obj/item/storage/box/debug/schrodinger
	name = "schrodinger's subspace box"
	desc = "There is always a cat inside. Why are we asking?\
	Alt+Rightclick to populate the contents."

/obj/item/storage/box/debug/schrodinger/click_alt_secondary(mob/user)
	// Ask the user what they want to make, or if they want to clear the storage.
	var/spawn_selection = tgui_input_list(user, "Populate the Box", "Box Stuffer", list("Clear All Items", "Cat", "Kitten"))
	// If they didn't cancel out of the list selection, we do things.  Clear-all removes all items, auto-clear destroys left-overs after upgrades, and everything else is pretty self-explanatory.
	if(isnull(spawn_selection))
		return
	// Empties the box
	else if(spawn_selection == "Clear All Items")
		var/list/inv_grab = atom_storage.return_inv(FALSE)
		for(var/obj/item/stored_item in inv_grab)
			qdel(stored_item)
	else if(spawn_selection == "Cat")
		atom_storage.attempt_insert(new /mob/living/basic/pet/cat(src), user, TRUE)
	else if(spawn_selection == "Kitten")
		atom_storage.attempt_insert(new /mob/living/basic/pet/cat/kitten(src), user, TRUE)

// Fun Boxes and Spawners//
// Nova Plushie Spawners, no filtering
/obj/effect/spawner/random/entertainment/plushie/nova/
	name = "nova sector plushies spawner"
	icon_state = "plushie"
	loot_subtype_path = /obj/item/toy/plush/nova
	loot = list( )

//Scatter versions for... Whatever. Mapping, probably.
/obj/effect/spawner/random/entertainment/plushie/nova/scatter
	name = "nova sector plushies spawner - scatter"
	spawn_loot_split = TRUE
	spawn_random_offset = TRUE
	spawn_scatter_radius = 3

/obj/effect/spawner/random/entertainment/plushie/nova/scatter/three
	name = "nova sector plushies spawner - scatter - three plushies"
	spawn_loot_count = 3

/obj/effect/spawner/random/entertainment/plushie/nova/scatter/five
	name = "nova sector plushies spawner - scatter - five plushies"
	spawn_loot_count = 5
	spawn_scatter_radius = 4

/obj/effect/spawner/random/entertainment/plushie/nova/scatter/seven
	name = "nova sector plushies spawner - scatter - seven plushies"
	spawn_loot_count = 7
	spawn_scatter_radius = 5

// Donator / Nova Plushies Box and Spawners
/obj/effect/spawner/random/entertainment/plushie/nova/donator
	name = "nova sector donator plushie spawner"
	icon_state = "plushie"
	loot_subtype_path = /obj/item/toy/plush/nova/donator/
	loot = list( )

//Sane item to actually be used
/obj/item/storage/box/hug/plushes/nova/donator
	name = "box of nova sector supporter plushies"
	desc = "Thank you to everyone who has helped to keep the lights on."

/obj/item/storage/box/hug/plushes/nova/donator/PopulateContents()
	for(var/i in 1 to 7)
		var/plush_path = /obj/effect/spawner/random/entertainment/plushie/nova/donator
		new plush_path(src)

//Big box that will eventually not fit all of them, but thats a problem for later
/obj/item/storage/box/hug/plushes/nova/donator/all
	name = "box of all nova sector supporter plushies"
	desc = "Thank you to everyone who has helped to keep the lights on."
	storage_type = /datum/storage/box/debug
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/effect/spawner/random/entertainment/plushie/nova/donator/all
	name = "nova sector donator plushie spawner"
	icon_state = "plushie"
	spawn_all_loot = TRUE

//Same as above but spawns everything possible. This might not be a good thing to have existing
/obj/effect/spawner/random/entertainment/plushie/nova/donator/all/
	name = "nova sector donator all plushies spawner"
	icon_state = "plushie"
	spawn_all_loot = TRUE

/obj/item/storage/box/hug/plushes/nova/donator/all/PopulateContents()
	var/plush_path = /obj/effect/spawner/random/entertainment/plushie/nova/donator/all
	new plush_path(src)

//Scatter Donator Plushies. Plushie explosions!
//Use these with buildmode for fun times. Or as mapping features, as intended.
/obj/effect/spawner/random/entertainment/plushie/nova/donator/scatter
	name = "nova sector donator plushies spawner - scatter"
	icon_state = "plushie"
	spawn_loot_split = TRUE
	spawn_random_offset = TRUE
	spawn_scatter_radius = 3

/obj/effect/spawner/random/entertainment/plushie/nova/donator/scatter/three
	name = "nova sector donator plushies spawner - scatter - three plushies"
	spawn_loot_count = 3

/obj/effect/spawner/random/entertainment/plushie/nova/donator/scatter/five
	name = "nova sector donator plushies spawner - scatter - five plushies"
	spawn_loot_count = 5
	spawn_scatter_radius = 3

/obj/effect/spawner/random/entertainment/plushie/nova/donator/scatter/seven
	name = "nova sector donator plushies spawner - scatter - seven plushies"
	spawn_loot_count = 7
	spawn_scatter_radius = 4

/obj/effect/spawner/random/entertainment/plushie/nova/donator/scatter/all
	name = "nova sector donator plushies spawner - scatter - all plushies"
	spawn_all_loot = TRUE
	spawn_scatter_radius = 7

// Staff & Maints Plushies Box and Spawners
/obj/item/storage/box/hug/plushes/nova/team
	name = "box of nova sector team plushies"
	desc = "Holds random plushies owned by current or prior Staff of Nova Sector."

/obj/effect/spawner/random/entertainment/plushie/nova/team
	name = "nova sector team plushie spawner"
	icon_state = "plushie"
	loot_subtype_path = null
	loot = list(
		/obj/item/toy/plush/nova/melon,//Deadmon_Wonderland
		/obj/item/toy/plush/nova/parsec,//Moonridden
		/obj/item/toy/plush/nova/akinshi,//Darkinite
		/obj/item/toy/plush/nova/donator/delphic_synth,//Sciamach
		/obj/item/toy/plush/nova/skaag,//Aganoo
	)

/obj/item/storage/box/hug/plushes/nova/team/PopulateContents()
	for(var/i in 1 to 7)
		var/plush_path = /obj/effect/spawner/random/entertainment/plushie/nova/team
		new plush_path(src)

/obj/item/storage/box/hug/plushes/nova/team/all
	name = "box of all nova sector staff plushies"
	desc = "Holds plushies owned by current or prior Staff of Nova Sector."
	storage_type = /datum/storage/box/debug
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//Same as above, but spawns the whole list instead
/obj/effect/spawner/random/entertainment/plushie/nova/team/all
	name = "nova sector all team plushies spawner"
	icon_state = "plushie"
	spawn_all_loot = TRUE

/obj/item/storage/box/hug/plushes/nova/team/all/PopulateContents()
	var/plush_path = /obj/effect/spawner/random/entertainment/plushie/nova/team/all
	new plush_path(src)

//Same as above but spawns everything possible. This might not be a good thing to have existing
/obj/effect/spawner/random/entertainment/plushie/nova/team/all/scatter
	name = "nova sector donator all plushies spawner - scatter"
	spawn_all_loot = TRUE
	spawn_scatter_radius = 2
