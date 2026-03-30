//todo:subspace boxcutter, bluespace trashbag / pocket, incorporeal movement / jaunt on visor using the voidling effect
// The sheetsnatcher extreme is really ugly, misses features, and misses materials. Lets make our own.
// Using a construction bag as our base, instead of the sheetsnatcher.
// I can probably adapt the BST-BRPED manufacturing function to this, but for now, an improvement is better than nothing
/obj/item/storage/bag/construction/admin//code\game\objects\items\storage\bags.dm
	name = "subspace construction pouch"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials. \
	Peeking inside the pocket, cherenkov-esque radiation illuminates a mass of materials and supplies."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "subspace_bag"
	worn_icon_state = "null"//Dont fuck with my drip, todo: make drip-pouch worn visible
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	slot_flags = ITEM_SLOT_POCKETS//pockets only >:(
	storage_type = /datum/storage/bag/construction/admin

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
		/obj/item/stack/sheet/mineral/uranium = 50,
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
		/obj/item/stack/sheet/copporcitite = 50,
		/obj/item/stack/sheet/cobolterium = 50,
		/obj/item/stack/sheet/pizza/fifty = 50,
		/obj/item/stack/sheet/spaceship = 50,
		/obj/item/stack/sheet/spaceshipglass = 50,
		/obj/item/stack/circuit_stack/full = null,
	)
	for(var/obj/item/stack/stack_type as anything in items_inside)
		var/amt = items_inside[stack_type]
		new stack_type(src, amt, FALSE)

// Badmin pinpointer. The bool lets you find people, even if they aren't wearing clothes, as long as you share a z-layer
/obj/item/pinpointer/crew/admin//code\game\objects\items\pinpointer.dm
	name = "subspace target locator"
	desc = "A sleek handheld tablet with a complex looking antennae."
	icon = 'modular_nova/modules/admin_tech/icons/obj/tools.dmi'
	icon_state = "sub-sniffer"//you like sniffing subs, dont you
	ignore_suit_sensor_level = TRUE
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//Tech's Disruptor - its a fischer but with every flavor of phasing
//Sometimes you need something to just not work for a moment
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
//		/obj/item/boxcutter

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

//Debug RCD, but using the cooler RCD type. Did you know that there already exists a decently superior alternative to the /obj/item/construction/rcd/combat/admin?
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

//RCD Disks - What the fuck is this code man
//Placeholder spot to put an admin RCD disk when I eventually get around to fixing upstream

//Debug Rapid Lighting Device
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

//Debug Light Replacer
//todo:icon variant
//code\game\objects\items\devices\lightreplacer.dm
/obj/item/lightreplacer/blue/admin
	name = "subspace light replacer"
	desc = "A modified light replacer that zaps lights into place by crystallizing your irritation caused by a lack of lux. Oddly, has endless material."
	icon_state = "lightreplacer_blue"
	uses = INFINITY
	max_uses = INFINITY

//Debug Atmos Holofan
//I should probably make a version of this that places tinyfans instead.
//todo:icon variants: obj icon & new forcefield, retexture the engie projector icon for use with the atmos holofan
//code\game\objects\items\holosign_creator.dm
/obj/item/holosign_creator/atmos/admin
	name = "subspace ATMOS holofan projector"
	desc = "A holographic projector that creates holographic barriers that prevent changes in atmosphere conditions."
	icon_state = "signmaker_atmos"
	max_signs = INFINITY
	projectable_through = list( /obj )

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
	name = "subspace plumbing constructor"
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
///Design types for debug service constructor, I just smushed the two lists together
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

//Debug Amputation Shears
/obj/item/shears/admin
	name = "subspace amputation shears"
	desc = "What, too lazy for player-panel? These blades look sharp enough to cut space-time, they will certainly make quick work of any humanoid."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "shears"
	toolspeed = 0
