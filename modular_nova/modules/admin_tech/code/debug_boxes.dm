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

// Debug Items //
// Debug Boxes TODO: Antag box, Research box, Security box, Service Box, Cargo Box, Medical Box revisit, Outfit Varianted Debug box to reduce
// ICON-TODO:Needs its own custom icons file, and variants for box types
// Its a box with a shitload of space and attitude
/obj/item/storage/box/debug
	name = "subspace box"
	desc = "A hand manufactured storage container composed of rare alloys and with exotic processes. \
		Stores an ungodly amount of anything. Your oversized Xeno wife will fit in this. \
		Its a box shaped bag of holding on cocaine. Reality warping recursion issues not included."
	icon_state = "alienbox"
	storage_type = /datum/storage/box/debug
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	illustration = null

// Box with a shitload of space, and actual debug tools, not just entirely random shit tossed in here
/obj/item/storage/box/debug/tools
	name = "debug tools in a subspace box"
	desc = "A hand manufactured storage container composed of rare alloys and with exotic processes. \
		Stores an ungodly amount of anything. This one comes stuffed with tools for destroying the server. \
		Your oversized Xeno or dog wife will fit in this. \
		Its a box shaped bag of holding on cocaine. Reality warping recursion issues not included."
	illustration = "disk_kit"

/obj/item/storage/box/debug/tools/PopulateContents()
	new	/obj/item/storage/box/stabilized(src)
	new	/obj/item/storage/box/pinpointer_pairs(src)
	new	/obj/item/storage/box/beakers/variety(src)
	new	/obj/item/uplink/debug(src)
	new	/obj/item/uplink/nuclear/debug(src)
	new	/obj/item/card/emag/debug(src)
	new	/obj/item/construction/rcd/combat/admin(src)
	new	/obj/item/holochip/fiftythousand(src)
	new	/obj/item/clothing/glasses/meson/engine/admin/debug(src)
	new	/obj/item/summon_beacon/gas_miner/expanded/debug(src)
	new	/obj/item/choice_beacon/job_locker/debug(src)
	new	/obj/item/modular_computer/debug(src)
	new	/obj/item/healthanalyzer/advanced(src)
	new	/obj/item/pinpointer/crew/admin(src)
	new /obj/item/sensor_device(src)
	new	/obj/item/debug/omnitool(src)
	new	/obj/item/debug/omnitool/item_spawner(src)
	new /obj/item/geiger_counter(src)
	new	/obj/item/flashlight/emp/debug(src)
	new	/obj/item/clothing/ears/earmuffs/debug(src)
	new	/obj/item/gps/visible_debug(src)
	new /obj/item/survivalcapsule/fishing/hacked(src)
	new	/obj/item/multitool/field_debug(src)
	new	/obj/item/storage/bag/construction/admin(src)
	new	/obj/item/integrated_circuit/admin(src)
	new	/obj/item/device/traitor_announcer/infinite(src)
	new	/obj/item/aicard/syndie/loaded(src)
	new	/obj/item/aicard/aitater(src)
	new	/obj/item/disk/tech_disk/debug(src)
	new	/obj/item/flashlight/flare/torch/everburning(src)

// Creature comforts and fun box
/obj/item/storage/box/debug/care_package
	name = "care package in a subspace box"
	icon_state = "hugbox"
	desc = "A hand manufactured storage container composed of rare alloys and with exotic processes. \
		Stores an ungodly amount of anything. This one comes stuffed with everything you might need to care for yourself. \
		Your oversized Xeno or dog wife will fit in this. \
		Its a box shaped bag of holding on cocaine. Reality warping recursion issues not included."
	illustration = "heart"

/obj/item/storage/box/debug/care_package/PopulateContents()
	new	/obj/item/storage/box/hug/plushes(src)
	new /obj/item/storage/box/colonial_rations(src)
	new	/obj/item/pizzabox/infinite(src)
	new	/obj/item/wallframe/wall_heater(src)
	new	/obj/item/pillow(src)
	new	/obj/item/bedsheet/cosmos/double(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)
	new /obj/item/syndicate_contacts(src)
	new	/obj/item/lighter/bright(src)
	new	/obj/item/storage/fancy/cigarettes/khi(src)
	new	/obj/item/camera/spooky/badmin(src)
	new /obj/item/holosign_creator/privacy(src)
	new	/obj/item/toy/tennis(src)
	new	/obj/item/hairbrush(src)
	new	/obj/item/laser_pointer/infinite_range(src)
	new	/obj/item/pai_card(src)
	new	/obj/item/megaphone(src)
	new /obj/item/handheld_soulcatcher(src)
	new	/obj/item/swapper(src)
	new	/obj/item/swapper(src)
	new	/obj/item/desynchronizer(src)
	new	/obj/item/reagent_containers/cup/maunamug(src)
	new	/obj/item/clothing/head/helmet/perceptomatrix/functioning(src)
	new	/obj/item/polymorph_belt/functioning(src)
	new /obj/item/gun/energy/wormhole_projector/core_inserted(src)
	new /obj/item/gun/energy/gravity_gun(src)
	new	/obj/item/flashlight/lamp/space_bubble/preactivated(src)
	new /obj/item/rolling_table_dock(src)

// Box with a shitload of space, some power related tools, and infinite power cells
/obj/item/storage/box/debug/power
	name = "power cells and tools in a subspace box"
	desc = "A hand manufactured storage container composed of rare alloys and with exotic processes. \
		Stores an ungodly amount of anything. This one comes stuffed with power cells and some useful tools. \
		Your oversized Xeno or dog wife will fit in this. \
		Its a box shaped bag of holding on cocaine. Reality warping recursion issues not included."
	icon_state = "engibox"
	illustration = "circuit"

/obj/item/storage/box/debug/power/PopulateContents()
	var/static/items_inside = list(
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
		)
	generate_items_inside(items_inside, src)

// Medipen Holy Grail. Not all the pens, just most, because I'm a deforest stan.
/obj/item/storage/box/debug/medipens
	name = "medipens in a subspace box"
	desc = "A hand manufactured storage container composed of rare alloys and with exotic processes. \
		Stores an ungodly amount of anything. This one comes stuffed with autoinjectors. \
		Your oversized Xeno or dog wife will fit in this. \
		Its a box shaped bag of holding on cocaine. Reality warping recursion issues not included."
	icon_state = "medbox"
	illustration = "epipen"

/obj/item/storage/box/debug/medipens/PopulateContents()
	new	/obj/item/reagent_containers/hypospray/medipen/invisibility(src)
	new	/obj/item/reagent_containers/hypospray/medipen/stimpack/traitor(src)
	new	/obj/item/reagent_containers/hypospray/medipen/stimulants(src)
	new	/obj/item/reagent_containers/hypospray/medipen/survival/luxury(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/twitch(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/demoneye(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/morpital(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/lipital(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/meridine(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/calopine(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner(src)
	new	/obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder(src)
	new	/obj/item/reagent_containers/hypospray/medipen/glucose(src)

// Useful Implants Set Box
/obj/item/storage/box/debug/autosurgeon
	name = "autosurgeons in a subspace box"
	desc = "A hand manufactured storage container composed of rare alloys and with exotic processes. \
		Stores an ungodly amount of anything. This one comes stuffed with useful autosurgeons and implants. \
		Your oversized Xeno or dog wife will fit in this. \
		Its a box shaped bag of holding on cocaine. Reality warping recursion issues not included."
	icon_state = "cyber_implants"
	illustration = null

/obj/item/storage/box/debug/autosurgeon/PopulateContents()
	new	/obj/item/autosurgeon/organ/nif/debug(src)
	new	/obj/item/autosurgeon/toolset(src)
	new	/obj/item/autosurgeon/syndicate/emaggedsurgerytoolset(src)
	new	/obj/item/autosurgeon/syndicate/contraband_sechud(src)
	new	/obj/item/autosurgeon/syndicate/nodrop(src)
	new /obj/item/autosurgeon/syndicate/xray_eyes(src)
	new /obj/item/autosurgeon/syndicate/anti_stun(src)
	new /obj/item/autosurgeon/syndicate/reviver(src)
	new	/obj/item/organ/heart/cybernetic/anomalock/prebuilt(src)
	new	/obj/item/organ/ears/cybernetic/whisper(src)
	new	/obj/item/organ/cyberimp/chest/spine/atlas(src)
	new	/obj/item/organ/cyberimp/chest/nutriment/plus(src)

// Implant Subtype Box
/obj/item/storage/box/debug/autosurgeon/all
	name = "all the autosurgeons in a subspace box"
	desc = "A hand manufactured storage container composed of rare alloys and with exotic processes. \
		Stores an ungodly amount of anything. This one has every single known autosurgeon, what the hell? \
		Your oversized Xeno or dog wife will fit in this. \
		Its a box shaped bag of holding on cocaine. Reality warping recursion issues not included."
	icon_state = "cyber_implants"

/obj/item/storage/box/debug/autosurgeon/all/PopulateContents()
	new /obj/item/autosurgeon/syndicate/xray_eyes(src)
	new /obj/item/autosurgeon/syndicate/anti_stun(src)
	new /obj/item/autosurgeon/syndicate/reviver(src)

// Medical Holy Grail. We have more options than just a simple hypospray kit, lets use them
/obj/item/storage/box/debug/medical
	name = "medical supplies in a subspace box"
	desc = "A hand manufactured storage container composed of rare alloys and with exotic processes. \
		Stores an ungodly amount of anything. This one comes stuffed with medical supplies. \
		Your oversized Xeno or dog wife will fit in this. \
		Its a box shaped bag of holding on cocaine. Reality warping recursion issues not included."
	icon_state = "medbox_large"
	illustration = "implant"

/obj/item/storage/box/debug/medical/PopulateContents()
	new	/obj/item/storage/box/debug/medipens(src)
	new	/obj/item/storage/box/debug/autosurgeon(src)
	new	/obj/item/storage/briefcase/medicalgunset/cmo(src)
	new	/obj/item/storage/hypospraykit/cmo/combat(src)
	new	/obj/item/surgery_tray/full/advanced(src)
	new	/obj/item/defibrillator/compact/combat/loaded/nanotrasen(src)
	new	/obj/item/reagent_containers/cup/bottle/adminordrazine(src)
	new	/obj/item/reagent_containers/hypospray/combat/nanites(src)
	new	/obj/item/reagent_containers/hypospray/combat(src)
	new	/obj/item/storage/pill_bottle/nanite_slurry(src)
	new	/obj/item/storage/pill_bottle/liquid_solder(src)
	new	/obj/item/storage/pill_bottle/system_cleaner(src)
	new	/obj/item/storage/pill_bottle/sansufentanyl(src)
	new	/obj/item/storage/pill_bottle/neurine(src)
	new	/obj/item/storage/pill_bottle/potassiodide(src)
	new	/obj/item/storage/pill_bottle/ondansetron(src)
	new	/obj/item/storage/pill_bottle/stimulant(src)
	new	/obj/item/storage/pill_bottle/lsd(src)
	new	/obj/item/storage/pill_bottle/zoom(src)
	new	/obj/item/reagent_containers/cup/bottle/potion/flight(src)
	new	/obj/item/slimepotion/speed(src)
	new	/obj/item/slimepotion/genderchange(src)
	new	/obj/item/slimepotion/peacepotion(src)
