
//Admeme bags. Better than a trash bag, better than a pouch, cooler than your belt, and comes totally empty.
//Sprite Credits to CEV-ERIS, y'all really fucked with this one, it has no reason to look this cool
//These will let you quickly spawn in, grab a pile of leftovers from something like a body respawn, and poof out, destroying all of it quickly
//todo: pickup people or machines with it too? wouldn't that be cool.
//todo: click interaction inspects
//check admin_datums for the storage datum for this
/obj/item/storage/bag/admin
	name = "bluespace pocket"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "blue-pocket"
	worn_icon_state = "null"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_BELT | ITEM_SLOT_BACK//I know someone will want a backpack with no worn icon so here shut up in advance
	storage_type = /datum/storage/admin/bag

/obj/item/storage/bag/admin/click_ctrl_shift(mob/user)
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	for(var/obj/item/stored_item in inv_grab)
		qdel(stored_item)
	return

/obj/item/storage/bag/admin/subspace
	name = "subspace pocket"
	desc = parent_type::desc + "This advanced version fills you with a sense of dread when you open it and peer inside."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "sub-pocket"
	worn_icon_state = "null"
	storage_type = /datum/storage/admin/bag/badmin

// Seperate storage to put inside of things that you dont want to be removed from
// This is meant to be spawned inside of other storages. Will stick to your paw like glue.
/obj/item/storage/subspace_pouch
	icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
	name = "subspace pouch"
	desc = span_notice("Click to open the pouch.")
	icon_state = "storage_pouch_icon"
	worn_icon_state = "storage_pouch_icon"
	w_class = WEIGHT_CLASS_TINY
	anchored = 1//Dont want people taking it out with their hands
	storage_type = /datum/storage/admin

//Opens the bag on click - considering it's already anchored, this makes it function similar to how ghosts can open all nested inventories
/obj/item/storage/subspace_pouch/attack_hand(mob/user, list/modifiers)
	. = ..()
	atom_storage.show_contents(user)

// The sheetsnatcher extreme is really ugly, misses features, and misses materials. Lets make our own.
// Using a construction bag as our base, instead of the sheetsnatcher.
// I can probably adapt the BST-BRPED manufacturing function to this, but for now, an improvement is better than nothing
// todo: descriptions and inspects
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

// Clears the bag
/obj/item/storage/bag/construction/admin/click_alt_secondary(mob/user)
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	for(var/obj/item/stored_item in inv_grab)
		qdel(stored_item)
	return

// Refreshes the bag contents
/obj/item/storage/bag/construction/admin/click_ctrl_shift(mob/user)
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	for(var/obj/item/stored_item in inv_grab)
		qdel(stored_item)
	PopulateContents()
	return

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
// todo: the 'more stuff' statement from above??? we definitely will need to offset atom generation by interact for this one, but, we can do a subtype check for sheets
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
//to-do: integrate various state application modes, such as remote emag and similar. Make this the utility version of the subspace rifle, instead of the fisher as it currently is. integrate radial, consider common state applications, and make projectiles to fit.
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
// code\game\objects\items\credit_holochip.dm
/obj/item/holochip/fiftythousand
	name = "unusually dense holochip"
	desc = "Oh lawd she thicc."
	credits = 50000

// Subspace boxcutter to replace the BST's energy axe.
// Tool mode / weapon mode alt hold state, weapon mode should have built in anti-drop + high destruction coef + rwall destruction abilities
// weapon + metal hydrogen fire axe inspired
// todo: channeled gutting / organ carving ability, steal the channel attack from extinguishers
// "only if it can unbox people and just dumps human skin on the floor and all their organs"
/// obj/item/boxcutter
// code\game\objects\objs.dm & code\game\objects\items.dm

// Debug Global Access Door Remote
// code\game\objects\items\tools\control_wand.dm
// todo:subspace icon variant, and maybe, fix this lazy behavior where emagging removes the useful screen-mode shit.
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
//todo:icon variants, fix blacklist issues
//code\game\objects\items\emags.dm
/obj/item/card/emag/admin
	name = "subspace emag-doorjack"
	desc = "It's a card with a magnetic strip attached to some circuitry that hurts to look at. Don't wave this at anything you care about."
	icon_state = "emag"
	worn_icon_state = "emag"
	prox_check = FALSE//makes wireless. be careful
	type_blacklist = list()//this is the crucial change to restore global emag function
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
//Did you know syringes have a baked in time for their action? Right into the proc, in a do after? Not affected by tool speed or anything. :)
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
	inject_flags = INJECT_CHECK_PENETRATE_THICK | NO_REACT
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
	self_consuming = TRUE
	metabolized_traits = list(TRAIT_ANALGESIA)
	/// Flags to fullheal every metabolism tick code\__DEFINES\mobs.dm line 1022
	full_heal_flags = ~(HEAL_BRUTE|HEAL_BURN|HEAL_TOX|HEAL_OXY|HEAL_STAM|HEAL_LIMBS|HEAL_ORGANS|HEAL_TRAUMAS|HEAL_ALL_REAGENTS|HEAL_NEGATIVE_DISEASES|HEAL_TEMP|HEAL_BLOOD|HEAL_STATUS|HEAL_CC_STATUS|HEAL_RESTRAINTS)

// New Admin Injectors, to cut down on medbox spawns. Slime Jelly as your All-Heal option through the combat hypokit is cruel and unusual punishment by way of blorbo destruction.
// Funny for upstream, less funny here where these tools are used to assist players
// todo: probably like six unique icons? maybe ill look for a unique new model base
// I can see myself making a big pile of these, so, lets make an admin empty
/obj/item/reagent_containers/hypospray/combat/subspace
	name = "subspace combat injector"
	desc = "A modified air-needle autoinjector for use in combat situations. Prefilled with experimental medical nanites and a stimulant for rapid healing and a combat boost."
	inhand_icon_state = "nanite_hypo"
	icon_state = "nanite_hypo"
	base_icon_state = "nanite_hypo"
	volume = 100
	list_reagents = list(/datum/reagent/medicine/adminordrazine/subspace = 100)

/obj/item/reagent_containers/hypospray/combat/nanites/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

// todo: the width of the spray, tile collision logic for the spray, and the spray tool speed are embedded in the ranged attack proc on the parent, and should be revisited in the future
// todo: icon
/obj/item/extinguisher/subspace
	name = "subspace extinguisher"
	desc = "A tiny fire extinguisher, designed for putting out small fires. It feels like it has an infinite amount of water. How you can tell this, you aren't sure."
	icon_state = "mini_extinguisher"
	max_water = INFINITY
	starting_water = TRUE
	chem = /datum/reagent/water
	refilling = FALSE
	/// Maximum distance launched water will travel.
	power = 10
	/// By default, turfs picked from a spray are random, set to TRUE to make it always have at least one water effect per row.
	precision = TRUE
	/// Sets the cooling_temperature of the water reagent datum inside of the extinguisher when it is refilled.
	cooling_power = 10

// Balls. Empty the stored balls in a directed space.
// todo: cap charge? it spams chat. also fix the ctrl click interact
/obj/item/pneumatic_cannon/subspace
	name = "subspace ballmatter mass projector"
	desc = "A subspace condensant powered cannon that can fire any object loaded into it. Also contains a shard of the elusive Ballmatter, which can be attenuated to different spherical wavelengths."
	w_class = WEIGHT_CLASS_BULKY
	force = 8 //Very heavy
	attack_verb_continuous = list("bludgeons", "smashes", "beats")
	attack_verb_simple = list("bludgeon", "smash", "beat")
	icon = 'icons/obj/weapons/pneumaticCannon.dmi'
	icon_state = "pneumaticCannon"
	inhand_icon_state = "bulldog"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	maxWeightClass = 20
	/// How powerful the cannon is - higher pressure = more gas but more powerful throws
	pressure_setting = 2
	/// Additional multiplier that adjusts how much farther thrown objects can travel.
	range_multiplier = 3
	/// Allows you to hold down LMB to continuously fire.
	automatic = FALSE
	/// Determines if a pneumatic cannon needs an air tank to fire. False for things like the pie cannons.
	needs_air = FALSE
	clumsyCheck = FALSE
	///Leave as null to allow all. Otherwise whitelists what can be inserted into the cannon.
	allowed_typecache = null
	charge_amount = 1
	charge_ticks = 1
	selfcharge = TRUE
	fire_sound = 'sound/items/weapons/sonic_jackhammer.ogg'
	spin_item = TRUE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	charge_type = /obj/item/toy/tennis/rainbow

/* All of this code is broken for some reason, I spent hours trying to fix it and I just cannot figure out why. The sbmp can just launch the best balls, for now.
GLOBAL_LIST_INIT(subspace_ballmatter_spheres, list(
		"Tennis" = /obj/item/toy/tennis,
		"Red" = /obj/item/toy/tennis/red,
		"Yellow" = /obj/item/toy/tennis/yellow,
		"Green" = /obj/item/toy/tennis/green,
		"Cyan" = /obj/item/toy/tennis/cyan,
		"Blue" = /obj/item/toy/tennis/blue,
		"Purple" = /obj/item/toy/tennis/purple,
		"Rainbow" = /obj/item/toy/tennis/rainbow,
		"Beach" = /obj/item/toy/beach_ball,
		"Base" = /obj/item/toy/beach_ball/baseball,
		"Basket" = /obj/item/toy/basketball,
		"Dodge" = /obj/item/toy/dodgeball,
		"Eight" = /obj/item/toy/eightball,
		"Snow" = /obj/item/toy/snowball,
		"Dough" = /obj/item/food/dough,
))

/obj/item/pneumatic_cannon/subspace/item_ctrl_click(mob/user)
	// Ask the user what they want to make, or if they want to clear the storage.
	var/pick_a_sphere = tgui_input_list(user, "Tune the Subspace Ballmatter", "Ballmatter", "Clear All", GLOB.subspace_ballmatter_spheres)
// If they didn't cancel out of the list selection, we do things.  Clear-all removes all items, auto-clear destroys left-overs after upgrades, and everything else is pretty self-explanatory.
	if(isnull(pick_a_sphere))
		return
	if(pick_a_sphere == "Clear All")
		var/list/inv_grab = atom_storage.return_inv(FALSE)
		for(var/obj/item/stored_item in inv_grab)
			qdel(stored_item)
		charge_type = null
		return
	if(pick_a_sphere in GLOB.subspace_ballmatter_spheres)
		charge_type = GLOB.subspace_ballmatter_spheres[pick_a_sphere]
	return CLICK_ACTION_SUCCESS
*/

// Consumes the job locker module, originally made by carpotoxin/honkpocket, because we use the code for a debug job locker spawn beacon.
// Creates a beacon that can spawn a locker with the items of a specified job. The locker spawns when the beacon is activated, and the locker type is determined by the beacon's internal list of locker paths, which is populated by the admin who holds it.
/obj/item/choice_beacon/job_locker
	name = "job locker beacon"
	desc = "A beacon which summons a locker with a job's items, what more is there to tell."
	company_source = "Nanotrasen"
	var/locker_path = list()

/obj/item/choice_beacon/job_locker/generate_display_names()
	if(!locker_path)
		return
	var/locker_list = list()
	for(var/obj/structure/closet/secure_closet/path as anything in locker_path)
		locker_list[initial(path.name)] = path
	return locker_list

// The beacon is a debug variant which has access to all lockers in the game, for reasons.
/obj/item/choice_beacon/job_locker/debug
	name = "debug job locker beacon"
	company_source = /obj/item/choice_beacon::company_source
	uses = INFINITY

/obj/item/choice_beacon/job_locker/debug/generate_display_names()
	var/locker_list = list()
	for(var/obj/structure/closet/secure_closet/path as anything in subtypesof(/obj/structure/closet/secure_closet))
		locker_list[initial(path.name)] = path
	return locker_list

// Spawn all the vendors that you want.
// todo: This really isn't a great debug tool at the moment, as it uses a radial menu to select the vendor you want to spawn, which is really clunky with the number of vendors in the game, but, it works for now.
// Also it has a limited list. Better than nothing, but still not finished.
// Maybe I'll make a tguilist for it later.
/obj/item/summon_beacon/vendors/debug
	name = "debug vendor beacon"
	desc = "Delivers a Vendor via orbital drop with patented Donk Co. SafeTec Technology!"
	uses = INFINITY

// It is time we create something terrible; a multicolor-pen-wand/gun that shoots anti-tank rounds. And also is an edagger. Fun admin-pda pen slot filler.
/*
/obj/item/gun/energy/meteorgun/pen
/obj/item/pen/edagger
/obj/item/gun/magic/wand/anti_tank
/obj/item/gun/ballistic/automatic/lahti
*/
// First lets make a new base that we might use again later. At minimum, it'll be a good blank to throw shit onto.
/obj/item/gun/magic/subspace/
	name = "subspace wand"
	desc = "That's not magic, that's a gun in the shape of a stick."
	w_class = WEIGHT_CLASS_TINY
	can_muzzle_flash = FALSE
	clumsy_check = FALSE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	//todo: admin firing pin
	pin = /obj/item/firing_pin/magic
	pinless = TRUE
	school = SCHOOL_UNSET
	antimagic_flags = null
	max_charges = INFINITY
	charges = INFINITY

// todo: sprites, add trigger guard, add minimum interact range, fix insertion on admin pda
/obj/item/gun/magic/subspace/dagenblicky
	name = "subspace mass projector pen"
	desc = "The pen is still mightier than a 20x138mm."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "digging_pen"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	fire_sound = 'sound/items/weapons/emitter.ogg'
	attack_verb_continuous = list("slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts") //these won't show up if the pen is off
	attack_verb_simple = list("slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_POINTY
	armour_penetration = 20
	exposed_wound_bonus = 10
	item_flags = NO_BLOOD_ON_ITEM
	light_system = OVERLAY_LIGHT
	light_range = 1.5
	light_power = 1.3
	light_color = "#FA8282"
	light_on = FALSE
	about_to_shoot_inside_mail_text = "It's humming with energy!"
	pitch_with_charges = TRUE
	ammo_type = /obj/item/ammo_casing/mm20x138
	can_hold_up = TRUE
	var/colour = COLOR_PURPLE_GRAY //what colour the ink is!
	var/degrees = 67
	var/font = PEN_FONT
	var/requires_gravity = TRUE
	/// The real name of our item when extended.
	var/hidden_name = "subspace energy dagger"
	/// The real desc of our item when extended.
	var/hidden_desc = "Visceral."
	/// The real icons used when extended.
	var/hidden_icon = "edagger"
	var/list/alt_continuous = list("stabs", "pierces", "shanks")
	var/list/alt_simple = list("stab", "pierce", "shank")
	/// If this pen can be clicked in order to retract it
	var/can_click = TRUE

/obj/item/gun/magic/subspace/dagenblicky/proc/create_transform_component()
	AddComponent( \
		/datum/component/transforming, \
		force_on = 18, \
		throwforce_on = 35, \
		throw_speed_on = 4, \
		sharpness_on = SHARP_EDGED, \
		w_class_on = WEIGHT_CLASS_NORMAL, \
		inhand_icon_change = FALSE, \
	)

/obj/item/gun/magic/subspace/dagenblicky/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5, TRAIT_TRANSFORM_ACTIVE)
	AddComponent(/datum/component/butchering, \
	speed = 6 SECONDS, \
	butcher_sound = 'sound/items/weapons/blade1.ogg', \
	)
	if (!can_click)
		return
	create_transform_component()
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/gun/magic/subspace/dagenblicky/get_writing_implement_details()
	if (HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return null
	return list(
		interaction_mode = MODE_WRITING,
		font = font,
		color = colour,
		use_bold = FALSE,
	)

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Handles swapping their icon files to edagger related icon files -
 * as they're supposed to look like a normal pen.
 */
/obj/item/gun/magic/subspace/dagenblicky/proc/on_transform(obj/item/source, mob/user, active)
	if(active)
		name = hidden_name
		desc = hidden_desc
		icon_state = hidden_icon
		inhand_icon_state = hidden_icon
		lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
		righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
		set_embed(/datum/embedding/edagger_active)
	else
		name = initial(name)
		desc = initial(desc)
		icon_state = initial(icon_state)
		inhand_icon_state = initial(inhand_icon_state)
		lefthand_file = initial(lefthand_file)
		righthand_file = initial(righthand_file)
		set_embed(embed_type)

	if(user)
		balloon_alert(user, "[hidden_name] [active ? "active" : "concealed"]")
	playsound(src, active ? 'sound/items/weapons/saberon.ogg' : 'sound/items/weapons/saberoff.ogg', 5, TRUE)
	set_light_on(active)
	return COMPONENT_NO_DEFAULT_MESSAGE

/* Holding this here for now in case I want to make this more interesting.
/datum/embedding/edagger_active
	embed_chance = 100
*/

// todo: sprites
/obj/item/firing_pin/admin
	name = "subspace firing pin"
	desc = "A small authentication device, to be inserted into a firearm receiver to allow operation. Central Command's Technicians have had their bodies attenuated in a way that can be sampled with 'simple' technology."
	icon = 'icons/obj/devices/gunmod.dmi'
	icon_state = "firing_pin_ayy"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	obj_flags = null
	attack_verb_continuous = list("pokes")
	attack_verb_simple = list("poke")
	fail_message = "not an admin!"
	force_replace = TRUE
	pin_hot_swappable = FALSE
	pin_removable = FALSE
	default_pin_auth = TRUE

/obj/item/firing_pin/admin/pin_auth(mob/living/user)
	if(check_rights_for(holder, R_ADMIN))
		return TRUE
	return FALSE

// todo: sprites, reagent selector, utilize laser gun code to create and load syringes based on reagent selector, or create a reagent_container within contents which can be fed chems to fill syringes with.
/obj/item/gun/syringe/admin
	name = "subspace syringe projector"
	desc = "A modification of the syringe gun design to be more compact and use a rotating cylinder to store up to ten syringes."
	icon_state = "rapidsyringegun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "syringegun"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	worn_icon_state = "gun"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE | ITEM_SLOT_POCKETS | ITEM_SLOT_BACK
	base_pixel_x = 0
	pixel_x = 0
	max_syringes = 10
	force = 0

// todo: sprites. demo mod with this force ALMOST totally cracks a standard fulltile r-window. this is a 'soft demolition' tool, to 'soften' up the environment without utterly destroying it.
// todo: add input popup for demo modifier.
/obj/item/melee/baseball_bat/admin
	name = "subspace baseball bat"
	desc = "There ain't a skull in the league that can withstand a nuclear bomb on a stick."
	icon = 'icons/obj/weapons/bat.dmi'
	icon_state = "baseball_bat"
	inhand_icon_state = "baseball_bat"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 48
	wound_bonus = 10
	throwforce = 48
	demolition_mod = 5
	attack_verb_continuous = list("beats", "smacks")
	attack_verb_simple = list("beat", "smack")
	resistance_flags = null
	w_class = WEIGHT_CLASS_TINY
	/// Are we able to do a homerun?
	homerun_able = TRUE
	/// Are we ready to do a homerun?
	homerun_ready = TRUE
	/// Can we launch mobs thrown at us away?
	mob_thrower = TRUE

// Modular Admin Rifle. Another heretical creation.
// todo: sprites, make and adjust speech json, adjust fire modes for damage
/obj/item/gun/energy/modular_laser_rifle/carbine/admin
	name = "\improper modular subspace rifle"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/saibasan/guns32x.dmi'
	icon_state = "hoshi_kill"
	inhand_icon_state = "hoshi_kill"
	worn_icon_state = "hoshi_kill"
	base_icon_state = "hoshi"
	charge_sections = 3
	cell_type = /obj/item/stock_parts/power_store/cell/infinite
	ammo_type = list(/obj/item/ammo_casing/energy/cybersun_small_hellfire)
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	SET_BASE_PIXEL(0, 0)
	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_TINY
	weapon_mode_options = list(
			/datum/laser_weapon_mode/admin,
			/datum/laser_weapon_mode/admin/destroyer_pulse,
			/datum/laser_weapon_mode/admin/event_horizon,
			/datum/laser_weapon_mode/admin/sniper,
			/datum/laser_weapon_mode/admin/ebow,
			/datum/laser_weapon_mode/admin/instakill,
			/datum/laser_weapon_mode/admin/xray,
			/datum/laser_weapon_mode/admin/super_disabler,
			/datum/laser_weapon_mode/admin/meteor,
			/datum/laser_weapon_mode/admin/ion,
			/datum/laser_weapon_mode/admin/plasmacutter,
			/datum/laser_weapon_mode/admin/gravity
	)
	default_selected_mode = "Disturb"
//	speech_json_file = SHORT_MOD_LASER_SPEECH
	lore_blurb = "The Hoshi carbine is the latest line of man-portable Marsian weapons platforms from \
		Cybersun Industries.<br><br>\
		Like her older sister weapon, the Hyeseong rifle, CI used funding aid provided by SolFed \
		to develop a portable weapon fueled by a proprietary generator rumored to be fueled by superstable plasma. \
		A lithe and mobile weapon, the Hoshi stars in close-quarters battle, trickshots, and area-of-effect blasts, \
		at the cost of longer-ranged combat performance.<br><br>\
		Her onboard machine intelligence, at first devised to support the operator and manage the internal reactor, \
		was originally shipped with a more energetic personality—since influenced by 'negligence' \
		from users in wiping the intelligence's memory before resale or transport."

/obj/item/gun/energy/modular_laser_rifle/admin/emp_act(severity)
	. = ..()
	speak_up("emp", TRUE) // She gets very upset if you emp her

// todo: base firing mode needs no damage but inflicts hallucinations / causes people to collapse and freakout / causes traumas
// icons\obj\weapons\guns\projectiles.dmi icon arcane_barrage
// candidate for base: /obj/projectile/beam/mindflayer
/obj/item/ammo_casing/energy/mindflayer/admin
	projectile_type = /obj/projectile/beam/mindflayer
	select_name = "Fourth Wall"
	fire_sound = 'sound/items/weapons/laser.ogg'

/obj/projectile/beam/mindflayer/admin
	name = "fourth wall blast"

/obj/projectile/beam/mindflayer/admin/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/human_hit = target
		human_hit.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20)
		human_hit.adjust_hallucinations(60 SECONDS)

// Base datum for our new weapon
// Fire mode to be used against idiot players interfering with you. Gives medical something to do.
// todo: see above for the projectile itself. this has a lot of potential but needs better considerations that the mindflayer bolt. also its causing damage for some reason. infact all of these are causing additional burn damage. maybe look into that, dumbass
/datum/laser_weapon_mode/admin
	/// What name does this weapon mode have? Will appear in the weapon's radial menu
	name = "Disturb"
	/// What casing does this variant of weapon use?
	casing = /obj/item/ammo_casing/energy/mindflayer/admin
	/// What icon_state does this weapon mode use?
	weapon_icon_state = "kill"
	/// How many charge sections does this variant of weapon have?
	charge_sections = 10
	/// What is the shot cooldown this variant applies to the weapon?
	shot_delay = 0 SECONDS
	/// What json string do we check for when making chat messages with this mode?
	json_speech_string = "disturb"
	/// What do we change the gun's runetext color to when applied
	gun_runetext_color = "#cd4456"

// /obj/item/gun/energy/pulse/destroyer, an admin classic
/datum/laser_weapon_mode/admin/destroyer_pulse
	name = "Destruction Pulse"
	casing = /obj/item/ammo_casing/energy/laser/pulse
	weapon_icon_state = "kill"
	json_speech_string = "shotgun"
	gun_runetext_color = "#7a0bb7"

// This belongs here, you cannot convince me otherwise.
/datum/laser_weapon_mode/admin/event_horizon
	name = "Black Hole"
	casing = /obj/item/ammo_casing/energy/event_horizon
	weapon_icon_state = "kill"
	json_speech_string = "blackhole"
	gun_runetext_color = "#7a0bb7"
	var/datum/component/scope/scope_component

/datum/laser_weapon_mode/admin/event_horizon/apply_to_weapon(obj/item/gun/energy/applied_gun)
	scope_component = applied_gun.AddComponent(/datum/component/scope, 3)

/datum/laser_weapon_mode/admin/event_horizon/remove_from_weapon(obj/item/gun/energy/applied_gun)
	QDEL_NULL(scope_component)

// Exists more for the component, but this is supposed to be a lahti
// todo: seems to not like it being a literal bullet. make an even more ridiculous destroyer pulse shot and stick it here
/datum/laser_weapon_mode/admin/sniper
	name = "Marksman"
	casing = /obj/item/ammo_casing/mm20x138
	weapon_icon_state = "kill"
	json_speech_string = "sniper"
	gun_runetext_color = "#7a0bb7"
	/// Keeps track of the scope component for deleting later
	var/datum/component/scope/scope_component

/datum/laser_weapon_mode/admin/sniper/apply_to_weapon(obj/item/gun/energy/applied_gun)
	scope_component = applied_gun.AddComponent(/datum/component/scope, 3)

/datum/laser_weapon_mode/admin/sniper/remove_from_weapon(obj/item/gun/energy/applied_gun)
	QDEL_NULL(scope_component)

/datum/laser_weapon_mode/admin/ebow
	name = "Energy Bow"
	casing = /obj/item/ammo_casing/energy/bolt
	weapon_icon_state = "kill"
	json_speech_string = "ebow"
	gun_runetext_color = "#7a0bb7"

// Megafauna solutions
/datum/laser_weapon_mode/admin/instakill
	name = "Instakill"
	casing = /obj/item/ammo_casing/energy/instakill
	weapon_icon_state = "kill"
	json_speech_string = "instakill"
	gun_runetext_color = "#7a0bb7"

// Functional testing
/datum/laser_weapon_mode/admin/xray
	name = "X-Ray"
	casing = /obj/item/ammo_casing/energy/xray
	weapon_icon_state = "kill"
	json_speech_string = "xray"
	gun_runetext_color = "#7a0bb7"

// Meme disabler projectile setup for the mode
/obj/projectile/beam/disabler/admin
	name = "subspace disabler beam"
	icon_state = "omnilaser"
	damage = 100
	damage_type = STAMINA
	armor_flag = ENERGY
	hitsound = 'sound/items/weapons/sear_disabler.ogg'
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	tracer_type = /obj/effect/projectile/tracer/disabler
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	impact_type = /obj/effect/projectile/impact/disabler

// Casing for meme disabler
/obj/item/ammo_casing/energy/disabler/admin
	projectile_type = /obj/projectile/beam/disabler/admin
	select_name = "disable"
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)
	fire_sound = 'sound/items/weapons/taser2.ogg'
	harmful = FALSE
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/blue
	muzzle_flash_color = LIGHT_COLOR_CYAN

// For testing resistances, really.
/datum/laser_weapon_mode/admin/super_disabler
	name = "Super Disabler"
	casing = /obj/item/ammo_casing/energy/disabler/admin
	weapon_icon_state = "kill"
	json_speech_string = "super_disabler"
	gun_runetext_color = "#7a0bb7"

// I find the meteor pen really funny if you didn't notice
/datum/laser_weapon_mode/admin/meteor
	name = "Meteor"
	casing = /obj/item/ammo_casing/energy/meteor
	weapon_icon_state = "kill"
	json_speech_string = "meteor"
	gun_runetext_color = "#7a0bb7"

/datum/laser_weapon_mode/admin/ion
	name = "Ion"
	casing = /obj/item/ammo_casing/energy/ion
	weapon_icon_state = "kill"
	json_speech_string = "ion"
	gun_runetext_color = "#7a0bb7"

/obj/projectile/plasma/admin
	name = "plasma sear"
	icon_state = "plasmacutter"
	damage_type = BURN
	armor_flag = ENERGY
	damage = 5
	range = 10
	dismemberment = 100
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	mine_range = 67

/obj/item/ammo_casing/energy/plasma/admin
	projectile_type = /obj/projectile/plasma/admin
	select_name = "plasma burst"
	fire_sound = 'sound/items/weapons/plasma_cutter.ogg'
	delay = 0
	e_cost = 0

/datum/laser_weapon_mode/admin/plasmacutter
	name = "Excision"
	casing = /obj/item/ammo_casing/energy/plasma/admin
	weapon_icon_state = "kill"
	json_speech_string = "plasmacutter"
	gun_runetext_color = "#7a0bb7"

/datum/laser_weapon_mode/admin/gravity
	name = "Gravitational Chaos"
	casing = /obj/item/ammo_casing/energy/gravity/chaos
	weapon_icon_state = "kill"
	json_speech_string = "gravity"
	gun_runetext_color = "#7a0bb7"

// Melee mode for the small laser, yeah this one will be weird
/datum/laser_weapon_mode/admin/melee
	name = "Blade"
	// This mode doesn't actually shoot but we gotta have a casing regardless so it doesn't runtime times a million
	// And also so the visuals work :3
	casing = /obj/item/ammo_casing/energy/cybersun_small_blade
	weapon_icon_state = "blade"
	charge_sections = 2
	json_speech_string = "blade"
	gun_runetext_color = "#f8d860"

/datum/laser_weapon_mode/admin/melee/apply_to_weapon(obj/item/gun/energy/modular_laser_rifle/applied_gun)
	playsound(src, 'sound/items/unsheath.ogg', 25, TRUE)
	applied_gun.force = 18
	applied_gun.sharpness = SHARP_EDGED
	applied_gun.exposed_wound_bonus = 10
	applied_gun.disabled_for_other_reasons = TRUE
	applied_gun.attack_verb_continuous = list("slashes", "cuts")
	applied_gun.attack_verb_simple = list("slash", "cut")
	applied_gun.hitsound = 'sound/items/weapons/rapierhit.ogg'

/datum/laser_weapon_mode/admin/melee/remove_from_weapon(obj/item/gun/energy/modular_laser_rifle/applied_gun)
	playsound(src, 'sound/items/sheath.ogg', 25, TRUE)
	applied_gun.force = initial(applied_gun.force)
	applied_gun.sharpness = initial(applied_gun.sharpness)
	applied_gun.exposed_wound_bonus = initial(applied_gun.exposed_wound_bonus)
	applied_gun.disabled_for_other_reasons = FALSE
	applied_gun.attack_verb_continuous = initial(applied_gun.attack_verb_continuous)
	applied_gun.attack_verb_simple = initial(applied_gun.attack_verb_simple)
	applied_gun.hitsound = initial(applied_gun.hitsound)

// Admin lathe
// todo: doesnt open ui, probably because nothing else is setup. the machines exist without issue though, they just don't work.
// todo: sprites, techweb define, flatpacks of common admin machines like the debug chem spawner, etc
// techweb: modular_nova\master_files\code\modules\research\techweb\techweb_types.dm
// machine.dm define w/ nova edit code\__DEFINES\machines.dm
/obj/machinery/rnd/production/colony_lathe/admin
	name = "administrative fabricator"
	desc = "These bad boys are seen just about anywhere someone would want or need to build fast, damn the consequences. \
		That tends to be colonies, especially on dangerous worlds, where the influences of this one machine can be seen \
		in every bit of architecture."
	icon = 'modular_nova/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "colony_lathe"
	base_icon_state = "colony_lathe"
	circuit = null
	production_animation = "colony_lathe_n"
	light_color = LIGHT_COLOR_BRIGHT_YELLOW
	light_power = 5
	allowed_buildtypes = COLONY_FABRICATOR
	speedup_disabled = TRUE
	/// techweb we intend to use for unlocking stuff.
	techweb_path = /datum/techweb/colony_fabricator
	/// The item we turn into when repacked
	repacked_type = /obj/item/flatpacked_machine
	/// The sound loop played while the fabricator is making something
//	var/datum/looping_sound/colony_fabricator_running/soundloop

/obj/item/flatpacked_machine/admin
	name = "flat-packed rapid construction fabricator"
	/// For all flatpacked machines, set the desc to the type_to_deploy followed by ::desc to reuse the type_to_deploy's description
	desc = /obj/machinery/rnd/production/colony_lathe::desc
	icon = 'modular_nova/modules/colony_fabricator/icons/packed_machines.dmi'
	icon_state = "colony_lathe_packed"
	w_class = WEIGHT_CLASS_TINY
	/// What structure is created by this item.
	type_to_deploy = /obj/machinery/rnd/production/colony_lathe
	/// How long it takes to create the structure in question.
	deploy_time = 4 SECONDS
