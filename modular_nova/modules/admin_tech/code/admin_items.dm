//todo:subspace boxcutter. injectors. better adminodrazine. pocket extinguisher. tennis ball gun. /obj/item/teleportation_scroll code theft? admin vendor spawner /obj/item/summon_beacon/vendors. fix the locker spawner. new meteor pen? admin cyborgs. /obj/item/abductor/alien_omnitool.
//todo:implement delayed item population of pouches and boxes to decrease the intensiveness of spawning in / despawning
//todo:radials out the ass would be nice! But they're a bit above my smooth brain at the moment. Ideas for radials: slime core / useful clothing traits necklace. admin spessknife. fix the medicell gun module to use radials instead of sequence.
//todo:subclass admin capsules for useful testing setups, such as instant departments and test environments. 'oh just use xyz location, it already exists-' shut up nerd
//todo:subspace materials?
//Admeme bags. Better than a trash bag, better than a pouch, cooler than your belt, and comes totally empty.
//Sprite Credits to CEV-ERIS, y'all really fucked with this one, it has no reason to look this cool
//These will let you quickly spawn in, grab a pile of leftovers from something like a body respawn, and poof out, destroying all of it quickly
//todo: pickup people or machiens with it too? wouldn't that be cool.
//check admin_datums for the storage datum for this
/obj/item/storage/bag/admin
	name = "bluespace pocket"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "blue-pocket"
	worn_icon_state = "null"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_POCKETS | ITEM_SLOT_BELT | ITEM_SLOT_BACK//I know someone will want a backpack with no worn icon so here shut up in advance
	storage_type = /datum/storage/admin/bag

/obj/item/storage/bag/admin/subspace
	name = "subspace pocket"
	desc = parent_type::desc + "This advanced version fills you with a sense of dread when you open it and peer inside."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "sub-pocket"
	worn_icon_state = "null"
	storage_type = /datum/storage/admin/bag/badmin

// The sheetsnatcher extreme is really ugly, misses features, and misses materials. Lets make our own.
// Using a construction bag as our base, instead of the sheetsnatcher.
// I can probably adapt the BST-BRPED manufacturing function to this, but for now, an improvement is better than nothing
/obj/item/storage/bag/construction/admin//code\game\objects\items\storage\bags.dm
	name = "bluespace construction bag"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials. \
	Peeking inside the pocket, cherenkov-esque radiation illuminates a mass of materials and supplies."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "blue-bag"
	worn_icon_state = "null"//Dont fuck with my drip
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	slot_flags = ITEM_SLOT_POCKETS//pockets only >:( if i accidentally equip a construction bag to my belt slot instead of my pockets first, where the value proposition is much higher, I will explode
	storage_type = /datum/storage/admin/bag

//This makes me physically ill. My skin crawls and I can feel the professionals judging me.
/obj/item/storage/bag/construction/admin/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stack/rods = 50,// amount should be null if it should spawn with the type's default amount
		/obj/item/stack/sheet/iron/fifty = null,
		/obj/item/stack/rods/lava/thirty = null,
		/obj/item/stack/rods/shuttle/fifty = null,
		/obj/item/stack/sheet/glass/fifty = null,
		/obj/item/stack/sheet/rglass/fifty = null,
		/obj/item/stack/sheet/mineral/plasma/fifty = null,
		/obj/item/stack/sheet/plasmaglass/fifty = null,
		/obj/item/stack/sheet/plasmarglass/fifty = null,
		/obj/item/stack/sheet/plasteel/fifty = null,
		/obj/item/stack/sheet/mineral/titanium/fifty = null,
		/obj/item/stack/sheet/titaniumglass/fifty = null,
		/obj/item/stack/sheet/mineral/plastitanium = 50,
		/obj/item/stack/sheet/plastitaniumglass/fifty = null,
		/obj/item/stack/sheet/mineral/gold/fifty = null,
		/obj/item/stack/sheet/mineral/silver/fifty = null,
		/obj/item/stack/sheet/mineral/uranium = 50,//Radiation stack concerns dont exist, thats how fucking old the original comment on uranium was
		/obj/item/stack/sheet/mineral/diamond/fifty = null,
		/obj/item/stack/sheet/bluespace_crystal/fifty = null,
		/obj/item/stack/sheet/mineral/bananium = 50,
		/obj/item/stack/sheet/mineral/wood/fifty = null,
		/obj/item/stack/sheet/plastic/fifty = null,
		/obj/item/stack/sheet/runed_metal/fifty = null,
		/obj/item/stack/sheet/mineral/abductor = 50,
		/obj/item/stack/sheet/mineral/sandstone = 50,
		/obj/item/stack/sheet/cardboard/fifty = null,
		/obj/item/stack/sheet/leather = 50,
		/obj/item/stack/sheet/hairlesshide = 50,
		/obj/item/stack/sheet/hot_ice = 50,
		/obj/item/stack/sheet/mineral/sandbags/fifty = null,
		/obj/item/stack/sheet/cloth = 50,
		/obj/item/stack/cable_coil = MAXCOIL,
		/obj/item/stack/sheet/mineral/snow = 50,
		/obj/item/stack/sheet/mineral/adamantine = 50,
		/obj/item/stack/sheet/mineral/runite = 50,
		/obj/item/stack/sheet/mineral/coal = 50,
		/obj/item/stack/sheet/mineral/metal_hydrogen = 50,
		/obj/item/stack/sheet/paperframes = 50,
		/obj/item/stack/sheet/meat = 50,
		/obj/item/stack/sheet/durathread = 50,
		/obj/item/stack/sheet/mineral/stone = 50,
		/obj/item/stack/sheet/mineral/bamboo = 50,
		/obj/item/stack/sheet/mineral/zaukerite = 50,
		/obj/item/stack/sheet/brussite = 50,
		/obj/item/stack/sheet/tinumium = 50,
		/obj/item/stack/sheet/copporcitite = 50,//why do copper tools exist in minecraft?
		/obj/item/stack/sheet/cobolterium = 50,
		/obj/item/stack/sheet/pizza/fifty = 50,
		/obj/item/stack/sheet/spaceship = 50,
		/obj/item/stack/sheet/spaceshipglass = 50,
		/obj/item/stack/circuit_stack/full = null,
	)
	for(var/obj/item/stack/stack_type as anything in items_inside)
		var/amt = items_inside[stack_type]
		new stack_type(src, amt, FALSE)

//above bag, but now its purple and has even more stuff
/obj/item/storage/bag/construction/admin/subspace
	name = "subspace construction bag"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials. \
	Peeking inside the pocket, cherenkov-esque radiation illuminates a mass of materials and supplies."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "sub-bag"

// Badmin pinpointer. The bool lets you find people, even if they aren't wearing clothes, as long as you share a z-layer
// The lack of adaption of the Lifeline PDA app to these pinpointers is just disappointing. These are objectively worse when compared to lifeline.
/obj/item/pinpointer/crew/admin//code\game\objects\items\pinpointer.dm
	name = "subspace target locator"
	desc = "A sleek handheld tablet with a complex looking antennae."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "sub-sniffer"//you like sniffing subs, dont you
	ignore_suit_sensor_level = TRUE
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//Tech's Disruptor - its a fischer but with every flavor of phasing on the projectile
//Sometimes you need something to just not work for a moment. You could just use buildmode, sure.
//to-do:steal code from /obj/projectile/beam/emitter/hitscan/psy to make this a depression pistol when shooting a mob with a disruptor.
//Techs do Infiltration and Lights testing.
/obj/projectile/energy/fisher/admin//Passes essentially everything, make sure you click on what you want to disable directly
	projectile_phasing = PASSTABLE | PASSMOB | PASSMACHINE | PASSSTRUCTURE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSDOORS

/obj/item/ammo_casing/energy/fisher/admin
	projectile_type = /obj/projectile/energy/fisher/admin
	e_cost = 0

//code\modules\projectiles\guns\energy\recharge.dm
/obj/item/gun/energy/recharge/fisher/admin
	name = "subspace disruptor"
	icon_state = "protolaser"
	w_class = WEIGHT_CLASS_TINY
	suppressed = SUPPRESSED_QUIET
	recharge_time = 0.25 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/fisher/admin)

// We need updated money for the debug box. Space cash is not splittable, and spawning 10 stacks of 5000 credits is not an ok solution to that problem
//code\game\objects\items\credit_holochip.dm
/obj/item/holochip/fiftythousand
	name = "unusually dense holochip"
	desc = "Oh lawd she thicc."
	credits = 50000

// Subspace boxcutter to replace the BST's energy axe.
// Tool mode / weapon mode alt hold state, weapon mode should have built in anti-drop + high destruction coef + rwall destruction abilities
// weapon + metal hydrogen fire axe inspired
// todo: channeled gutting / organ carving ability, steal the channel attack from extinguishers
// "only if it can unbox people and just dumps human skin on the floor and all their organs"
///obj/item/boxcutter
//code\game\objects\objs.dm & code\game\objects\items.dm

//Debug Global Access Door Remote
//code\game\objects\items\tools\control_wand.dm
//todo:subspace icon variant
/obj/item/door_remote/admin
	name = "subspace door remote"
	desc = "This remote controls airlocks through narrative will alone. Also comes emagged, did you know that you can emag door remotes?"
	department = "omni"
	region_access = REGION_ALL_GLOBAL
	owner_trim = /datum/id_trim/admin/subspace
	our_domain = list( /area )
	obj_flags = EMAGGED
	w_class = WEIGHT_CLASS_TINY

//New admin RCD, but using the cooler RCD type. Did you know that there already exists a decently superior alternative to the /obj/item/construction/rcd/combat/admin?
//It was /obj/item/construction/rcd/arcd and for whatever reason this unused one had the potential to be better. But wasn't used.
//modular_nova\master_files\code\game\objects\items\RCD.dm
//code\game\objects\items\rcd\RCD.dm
//todo:subspace icons
/obj/item/construction/rcd/arcd/mattermanipulator/admin
	name = "subspace matter manipulator"
	desc = "Holding this fabulous piece of legally distinct technology fills you with a sense of determination. Works at range, and can deconstruct reinforced walls."
	icon = 'modular_nova/master_files/icons/obj/tools.dmi'
	icon_state = "rcd"
	worn_icon_state = "RCD"
	max_matter = INFINITY
	matter = INFINITY
	delay_mod = 0.1
	construction_upgrades = RCD_ALL_UPGRADES & ~RCD_UPGRADE_SILO_LINK
	w_class = WEIGHT_CLASS_TINY

//RCD Disks - What the fuck is this code man
//Placeholder spot to put an admin RCD disk when I eventually get around to fixing upstream

//Admin Rapid Lighting Device
//code\game\objects\items\rcd\RLD.dm
//todo:subspace icons
/obj/item/construction/rld/admin
	name = "subspace rapid lighting device"
	desc = "A device used to rapidly provide lighting sources to an area. Reload with iron, plasteel, glass or compressed matter cartridges."
	icon = 'icons/obj/tools.dmi'
	icon_state = "rld"
	worn_icon_state = "RPD"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	matter = INFINITY
	max_matter = INFINITY
	construction_upgrades = RCD_UPGRADE_SILO_LINK
	w_class = WEIGHT_CLASS_TINY

//Debug Emag & Doorjack
//There is already a 'bluespace emag' but its pretty ugly, so I'll just do my own quick pallete swap icons
//todo:icon variants
//code\game\objects\items\emags.dm
/obj/item/card/emag/admin
	name = "subspace emag-doorjack"
	desc = "It's a card with a magnetic strip attached to some circuitry that hurts to look at. Don't wave this at anything you care about."
	icon_state = "emag"
	worn_icon_state = "emag"
	prox_check = FALSE
	type_blacklist = list()
	w_class = WEIGHT_CLASS_TINY

//Admin Light Replacer
//todo:icon variant
//code\game\objects\items\devices\lightreplacer.dm
/obj/item/lightreplacer/blue/admin
	name = "subspace light replacer"
	desc = "A modified light replacer that zaps lights into place by crystallizing your irritation caused by a lack of lux. Oddly, has endless material."
	icon_state = "lightreplacer_blue"
	uses = INFINITY
	max_uses = INFINITY
	w_class = WEIGHT_CLASS_TINY

//Admin Atmos Holofan
//I should probably make a version of this that places tinyfans instead.
//todo:icon variants: obj icon & new forcefield, retexture the engie projector icon for use with the atmos holofan
//code\game\objects\items\holosign_creator.dm
/obj/item/holosign_creator/atmos/admin
	name = "subspace ATMOS holofan projector"
	desc = "A holographic projector that creates holographic barriers that prevent changes in atmosphere conditions. Did you know that right clicking this directly while it is in your active hand can turn on a 'clearview' mode, making the signs unclickable?"
	icon_state = "signmaker_atmos"
	max_signs = INFINITY
	projectable_through = list( /obj )
	w_class = WEIGHT_CLASS_TINY

/obj/structure/holosign/barrier/atmos
	name = "subspace holofirelock"
	desc = "A holographic barrier resembling a firelock. Though it does not prevent solid objects from passing through, gas is kept out."
	icon_state = "holo_firelock"
	base_icon_state = "holo_firelock"
	rad_insulation = RAD_FULL_INSULATION
	resistance_flags = FIRE_PROOF | FREEZE_PROOF

//Debug Forcefield Projector & It's Structure
/obj/item/forcefield_projector/admin
	name = "subspace forcefield projector"
	desc = "An experimental device that can create several forcefields at a distance."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "signmaker_forcefield"
	max_shield_integrity = INFINITY
	shield_integrity = INFINITY
	max_fields = INFINITY
	field_distance_limit = INFINITY
	creation_time = 0 SECONDS
	w_class = WEIGHT_CLASS_TINY

/obj/structure/projected_forcefield/admin
	name = "subspace forcefield"
	desc = "A glowing barrier, generated by a projector nearby. You probably are not going to be able to break this."
	icon = 'icons/effects/effects.dmi'
	icon_state = "forcefield"
	rad_insulation = RAD_FULL_INSULATION
	resistance_flags = INDESTRUCTIBLE
	can_atmos_pass = ATMOS_PASS_NO
	armor_type = /datum/armor/admin/badmin

//Admin Capsules - Capsules to spawn things that players shouldnt be spawning on the regular
//Tiny Fan Capsule
/datum/map_template/shelter/admin/tinyfan
	name = "self-powered tiny fan deployer"
	shelter_id = "capsule_tinyfan"
	description = "It's a self-powered tiny fan packaged with a hyper insulated floor tile."
	mappath = "_maps/nova/capsules/tiny_fan_capsule.dmm"

/obj/item/survivalcapsule/admin/fan
	name = "self-powered tiny fan capsule"
	desc = "Portable, efficient, and packaged with a hyper-insulated tile, it's a wonder we don't let the normal crew access to such a luxurious device. Maybe we should."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	template_id = "capsule_tinyfan"
	used = FALSE

//Debug Plumbing Tool
//todo:variant icon
//code\game\objects\items\rcd\RPLD.dm
/obj/item/construction/plumbing/admin
	name = "subspace omniplumber"//thanks cosmiclaer, cute name
	desc = "An expertly modified RCD outfitted to construct plumbing machinery."
	icon_state = "plumberer2"
	inhand_icon_state = "plumberer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	worn_icon_state = "plumbing"
	icon = 'icons/obj/tools.dmi'
	slot_flags = ITEM_SLOT_BELT
	drop_sound = 'sound/items/handling/tools/rcd_drop.ogg'
	pickup_sound = 'sound/items/handling/tools/rcd_pickup.ogg'
	sound_vary = TRUE
	matter = INFINITY
	max_matter = INFINITY
	construction_upgrades = RCD_UPGRADE_SILO_LINK
	w_class = WEIGHT_CLASS_TINY
///Design types for debug service constructor, I just smushed the two lists together, because no other plumber exists with the full list. why are we like this? is this even all of them?
	var/static/list/admin_design_types = list(
		//Category 1 synthesizers
		"Synthesizers" = list(
			/obj/machinery/plumbing/synthesizer = 1,
			/obj/machinery/plumbing/synthesizer/soda = 1,
			/obj/machinery/plumbing/synthesizer/beer = 1,
			/obj/machinery/plumbing/reaction_chamber = 1,
			/obj/machinery/plumbing/reaction_chamber/chem = 1,
			/obj/machinery/plumbing/buffer = 1,
			/obj/machinery/plumbing/fermenter = 1,
			/obj/machinery/plumbing/grinder_chemical = 1,
			/obj/machinery/plumbing/disposer = 1,
			/obj/machinery/plumbing/liquid_pump = 1,
		),

		//Category 2 distributors
		"Distributors" = list(
			/obj/machinery/duct = 1,
			/obj/machinery/plumbing/layer_manifold = 5,
			/obj/machinery/plumbing/input = 5,
			/obj/machinery/plumbing/filter = 5,
			/obj/machinery/plumbing/splitter = 5,
			/obj/machinery/plumbing/output = 5,
			/obj/machinery/plumbing/output/tap = 5,
			/obj/machinery/plumbing/sender = 20,
		),

		//category 3 storage
		"Storage" = list(
			/obj/machinery/plumbing/bottler = 50,
			/obj/machinery/plumbing/tank = 20,
			/obj/machinery/plumbing/acclimator = 10,
			/obj/machinery/plumbing/buffer = 10,
			/obj/machinery/plumbing/pill_press = 20,
			/obj/machinery/iv_drip/plumbing = 20,
		),

		//category 4 liquids
		"Liquids" = list(
			/obj/structure/drain = 5,
			/obj/machinery/plumbing/floor_pump/input = 20,
			/obj/machinery/plumbing/floor_pump/output = 20,
		),
	)

/obj/item/construction/plumbing/admin/Initialize(mapload)
	plumbing_design_types = admin_design_types

	. = ..()

//Admin Amputation Shears. This is more fun to play with than you might think.
/obj/item/shears/admin
	name = "subspace amputation shears"
	desc = "What, too lazy for player-panel? These blades look sharp enough to cut space-time, they will certainly make quick work of any humanoid."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "shears"
	toolspeed = 0
	w_class = WEIGHT_CLASS_TINY

//Admin Medigun
/obj/item/gun/energy/cell_loaded/medigun/admin
	name = "subspace medigun"
	desc = "VeyMed was not happy with this one, but they didn't get much of a say in it's manufacture. This 'aftermarket' (still manufactured by VeyMed) specification comes loaded with every cell. \
	Test users said the switching was 'cumbersome' and that a 'floating radial' was a cooler choice, but the acquisitions manager lacked ability to describe the design to the producer."
	icon = 'modular_nova/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi'
	icon_state = "medigun"
	inhand_icon_state = "chronogun" // Fits best with how the medigun looks, might be changed in the future
	abstract_type = /obj/item/gun/energy/cell_loaded/medigun
	ammo_type = list(/obj/item/ammo_casing/energy/medical) // The default option that heals oxygen
	w_class = WEIGHT_CLASS_TINY
	cell_type = /obj/item/stock_parts/power_store/cell/medigun
	maxcells = 12 // there are 12 medicells in code at the time of counting
	allowed_cells = list(/obj/item/weaponcell/medical)
	item_flags = null
	gun_flags = null // parent forbids turret
	/// A list that contains the currently installed cells.
	installedcells = list(
		/obj/item/weaponcell/medical/brute/tier_3,
		/obj/item/weaponcell/medical/burn/tier_3,
		/obj/item/weaponcell/medical/toxin/tier_3,
		/obj/item/weaponcell/medical/oxygen/tier_3,
		/obj/item/weaponcell/medical/utility/clotting,
		/obj/item/weaponcell/medical/utility/temperature,
		/obj/item/weaponcell/medical/utility/salve,
	)

/*
* Admin Cells for Cellgun
* I thought about making a spread of admin medicells to replace the hypospray kit, as well as relocation cells to move things around CC
* But after looking through medicell code, I do not want to deal with repacking those procs right now. Maybe later.
*/

// Admin surgery tray, for the new med box
/obj/item/surgery_tray/admin
	name = "technician's surgery tray"
	desc = "Full of things that you will probably want to do surgery with. Objectively a better user experience than the omnitool, which is atrociously out of date."
	w_class = WEIGHT_CLASS_TINY
	starting_items = list(
		/obj/item/reagent_containers/medigel/sterilizine,
		/obj/item/stack/medical/bone_gel,
		/obj/item/stack/medical/wrap/sticky_tape/surgical,
		/obj/item/shears,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/suit/toggle/labcoat/nova/surgical_gown,//Did you know the gowns bypass clothing for surgery, so you dont actually need to look at people naked?
		/obj/item/surgical_drapes,
		/obj/item/scalpel/advanced,
		/obj/item/retractor/advanced,
		/obj/item/cautery/advanced,
		/obj/item/blood_filter/advanced,
	)

// New admin PDA, thank you debug modular computer for existing.
// deadmonwonderland requested this one
// code\modules\modular_computers\computers\item\pda.dm
/obj/item/modular_computer/pda/admin
	name = "technician's PDA"
	device_theme = PDA_THEME_SPOOKY
	max_capacity = INFINITY
	hardware_flag = PROGRAM_ALL//This might cause issues? Set to PROGRAM_PDA if it do
// contained_item = list( /obj/item/gun/energy/meteorgun/pen ) // static lists SUCK
	inserted_item = /obj/item/gun/energy/meteorgun/pen
	long_ranged = TRUE
	allow_chunky = TRUE
	stored_paper = 10
	max_paper = INFINITY
	light_power = 10
	light_range = 10
	light_angle = 360
	w_class = WEIGHT_CLASS_TINY

//I will wait for someone with more knowledge than me to tell me the correct way to smoosh these procs together
/obj/item/modular_computer/pda/admin/Initialize(mapload)
	starting_programs += subtypesof(/datum/computer_file/program)
	return ..()

/obj/item/modular_computer/pda/admin/Initialize(mapload)
	. = ..()
	internal_cell = new /obj/item/stock_parts/power_store/cell/infinite
	emag_act(forced = TRUE)//auto-emags our pda, oh wow so nice
	var/datum/computer_file/program/themeify/theme_app = locate() in stored_files
	if(theme_app)
		for(var/theme_key in GLOB.pda_name_to_theme - GLOB.default_pda_themes)
			LAZYADD(theme_app.imported_themes, theme_key)
	var/datum/computer_file/program/messenger/msg = locate() in stored_files
	if(msg)
		msg.invisible = TRUE//'UHHH HELLO, ADMIN? WHY CAN I TEXT YOU? DID YOU MEAN TO DO THAT? ARE YOU REAL?'

/obj/item/modular_computer/pda/admin/get_messenger_ending()
	return "Sent from the space between timelines, narratively null."

// Admin laser pointer, because the infinite laser pointer isn't good enough.
// The code for these things is kinda unnervingly long.
// I wanted to add two state changes where you can do serious, legitimate damage with it, like its a hitscan beam weapon, one that just burns and the other that just melts and destroys stuff, but thats beyond my ability to cobble together at the moment
/obj/item/laser_pointer/admin
	name = "subspace laser pointer"
	desc = "It's a fidget toy with a warning label, describing why you should definitely avoid pointing this rapidly enough for the universe to 'ratelimit' you, whatever that means. \
	Turning it over, you notice a crudely hand-etched representation of a crying cyborg."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "pointer"
	w_class = WEIGHT_CLASS_TINY
	effectchance = 100
	energy = INFINITY
	max_energy = INFINITY
	max_range = INFINITY
	pointer_icon_state = "purple_laser" // Icon for the laser, affects both the laser dot and the laser pointer itself, as it shines a laser on the item itself. Something silly could be done here.

// Hahahaha ahh....
/obj/item/laser_pointer/admin/Initialize(mapload)
	. = ..()
	diode = new /obj/item/stock_parts/micro_laser/quadultra
	crystal_lens = new /obj/item/stack/ore/bluespace_crystal/refined

// Admin Reagent Containers
//todo:/obj/item/stack/medical/synth_repair adaptions for admemes
// code\modules\reagents\reagent_containers.dm
//Admeme syringe with included syringe gun interactions. Seems like a horrible thing to leave laying around when assaulting the Crew, but, you're a badmin, what do you care?
// Did you know syringes have a baked in time process? Right into the proc, in a do after? Not affected by tool speed or anything. :)
//todo:icon variant
//code\modules\reagents\reagent_containers\syringes.dm
/obj/item/reagent_containers/syringe/admin
	name = "subspace syringe"
	desc = "A curiously dense feeling, yet near weightless, syringe. A flat purple crystal is installed where the needle would normally be, and you can glimpse extreme distances peeking at it. \
	A small adjustor dial surrounds an activator button on the side of the barrel, replacing the plunger. The form factor appears to match Nanotrasen specifications."
	icon_state = "piercing_0"
	inhand_icon_state = "piercing_0"
	base_icon_state = "piercing"
	volume = 1000
	possible_transfer_amounts = list(1, 5, 10, 25, 100, 1000)
	inject_flags = INJECT_CHECK_PENETRATE_THICK
	armour_penetration = 100
	dart_insert_casing_icon_state = "overlay_syringe_piercing"
	dart_insert_projectile_icon_state = "overlay_syringe_piercing_proj"
	embed_type = /datum/embedding/syringe/piercing

/datum/embedding/syringe/admin
	embed_chance = 100
	fall_chance = 0
	pain_stam_pct = 0
	transfer_per_second = 1000

// Admin patches, the reagent container variety. I probably won't use these in favor of the /obj/item/stack/medical ones, but, I'll make these exist anyways for funsies
//todo:icon variant
//code\modules\reagents\reagent_containers\patch.dm
/obj/item/reagent_containers/applicator/patch/admin
	name = "subspace patch"
	desc = "A chemical patch for touch based applications. The material feels gooey and elastic in your hand."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "bandaid_blank"
	volume = 1000
	apply_method = "apply"
	embed_type = /datum/embedding/med_patch/admin
	application_delay = 0 SECONDS
	self_delay = 0 SECONDS

/obj/item/reagent_containers/applicator/patch/admin/instant
	name = "subspace patch - instant"
	desc = parent_type::desc + " You can't quite explain it, but you can just tell this stuff moves oddly"
	embed_type = /datum/embedding/med_patch/admin/instant

// Did you know patches are embeds? I didnt! It kind of makes sense but WOW do I hate that.
/datum/embedding/med_patch/admin
	embed_chance = 100//This used to be 10. That means normal med_patches have a 10% chance to stick to someone when thrown. Neat!
	transfer_per_second = 1//used to be 0.75. Round number good, unga.

// Variant which delivers all of the patch's contents at once
/datum/embedding/med_patch/admin/instant
	transfer_per_second = /obj/item/reagent_containers/applicator/patch/admin::volume

//Admin pills. Pills here. Get your pills here.
//code\modules\reagents\reagent_containers\pill.dm
/obj/item/reagent_containers/applicator/pill/admin
	name = "subspace shard"
	desc = "A small pill shaped shard of stabilized and crystallized subspace. Its texture is like porous volcanic rock, even though you can't see any of that porosity visibly. You feel compelled to swallow it."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "pill"
	inhand_icon_state = "pill"
	worn_icon_state = "nothing"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	volume = 1000
	/// How many "layers" we have remaining. Each layer equates to 1 second of digestion -> var/layers_remaining = 3. This PRETTY COOL VARIABLE is used almost exclusively by unit tests. Very sad stuff.

//like adderall XR, yeah? extended release. theoretical pill to shove into people for plotarmor or other extremely heinous purposes
/obj/item/reagent_containers/applicator/pill/admin/xr
	name = "subspace shard"
	desc = "A slightly smaller pill shaped shard of stabilized and crystallized subspace. This one feels pliable, like putty, but there is a foreign grit that leaves you feeling uneasy. You feel compelled to swallow it."
	volume = 600
	layers_remaining = 600

// Admin watering can
// Adminordrazine can be used for botanical work, did you know?
/obj/item/reagent_containers/cup/watering_can/advanced/admin
	name = "subspace botanical can"
	desc = "A gardening can embedded with technology that leaves you with a dull pain in your head. An ominous purple crystal wobbles and glimmers from inside the device, golden fluid leaking from momentarily visible pores like bubbling lava. \
	You suddenly find yourself afraid of spilling the contents."
	icon_state = "adv_watering_can"
	inhand_icon_state = "adv_watering_can"
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 1000)
	refill_rate = 100
	refill_reagent = /datum/reagent/medicine/adminordrazine

// admin slimes stuff? dark cerulean regenerative

// /obj/item/reagent_containers/cooler_jug - code\modules\reagents\reagent_containers\cooler_jug.dm - admin cooler jug.
// /obj/item/reagent_containers/condiment/pack - code\modules\reagents\reagent_containers\condiment.dm - i want to make go gurt tubes...
// /obj/item/reagent_containers/cup/beaker - code\modules\reagents\reagent_containers\cups\_cup.dm - subspace beaker, try and make state change for bonus features
// /obj/item/inhaler & /obj/item/reagent_containers/inhaler_canister - code\modules\reagents\reagent_containers\inhaler.dm - might not do anything with this

// New Admin chems, this is going in its own page later
// code\modules\reagents\chemistry\reagents\medicine_reagents.dm
// todo: blood stabilizer, rad clear, purger. I need to go reference the full_heal globals page for making the different varieties of adminordrazine, and probably just make NEW adminordrazine to go along with the new injectors
/datum/reagent/medicine/adminordrazine/subspace //An OP chemical for admins
	name = "Subspace Condensate"
	description = "The visual consistency of this material is best compared to oobleck. If you're fast enough, you can tear bits off of the mass before it returns to a thin slurry which drips through your fingers."
	color = "#E0BB00" //golden for the gods
	taste_description = "badmins"
	chemical_flags = REAGENT_DEAD_PROCESS
	metabolized_traits = list(TRAIT_ANALGESIA)
	/// Flags to fullheal every metabolism tick code\__DEFINES\mobs.dm line 1006
	full_heal_flags = ~(HEAL_ADMIN|HEAL_BRUTE|HEAL_BURN|HEAL_TOX|HEAL_RESTRAINTS|HEAL_ALL_REAGENTS|HEAL_ORGANS)

// New Admin Injectors, to cut down on medbox spawns. Slime Jelly as your All-Heal option through the combat hypokit is cruel and unusual punishment by way of blorbo destruction.
// Funny for upstream, less funny here where these tools are used to assist players
// todo: probably like six unique icons? maybe ill look for a unique new model base
// I can see myself making a big pile of these, so, lets make an admin empty
/obj/item/reagent_containers/hypospray/combat/nanites
	name = "experimental combat stimulant injector"
	desc = "A modified air-needle autoinjector for use in combat situations. Prefilled with experimental medical nanites and a stimulant for rapid healing and a combat boost."
	inhand_icon_state = "nanite_hypo"
	icon_state = "nanite_hypo"
	base_icon_state = "nanite_hypo"
	volume = 100
	list_reagents = list(/datum/reagent/medicine/adminordrazine/quantum_heal = 80, /datum/reagent/medicine/synaptizine = 20)

/obj/item/reagent_containers/hypospray/combat/nanites/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

//Admin Multitool! Did you know that the check to show wire results is actually in a terrifying proc found in code\datums\wires\_wires.dm at line 269. Both the multitool and the blueprints dont give quirks or traits, they are directly checked for
//todo variant icon
/obj/item/multitool/abductor/admin
	name = "subspace attenuated multitool"
	desc = "Beautiful engineering. Pocket blueprints."
