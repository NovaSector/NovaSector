// The sheetsnatcher extreme is really ugly, misses features, and misses materials. Lets make our own.
// Using a construction bag as our base, instead of the sheetsnatcher.
// I can probably adapt the BST-BRPED manufacturing function to this, but for now, an improvement is better than nothing
/obj/item/storage/bag/construction/debug//code\game\objects\items\storage\bags.dm
	name = "subspace construction pouch"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials. \
	Peeking inside the pocket, cherenkov-esque radiation illuminates a mass of materials and supplies."
	icon = 'modular_nova/master_files/icons/obj/tools.dmi'
	icon_state = "subspace_bag"
	worn_icon_state = null//Dont fuck with my drip, todo: make drip-pouch worn visible
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	slot_flags = ITEM_SLOT_POCKETS//pockets only >:(
	storage_type = /datum/storage/bag/construction/debug

/obj/item/storage/bag/construction/debug/PopulateContents()
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
		/obj/item/stack/sheet/mineral/uranium = 20,// "Only 20 uranium 'cause of radiation"
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

// Debug Encryption Key and Headset, still manually populates the channel list because I am not a real coder, just a denthead
/obj/item/encryptionkey/debug
	name = "\proper the subspace encryption key"
	desc = "Holding and looking at this little chip fills you with a sense of existential dread. The taste of metaknowledge fills your mouth. \
		It tastes salty. Like tears. Why do you know what tears taste like? \
		You're a badmin, of course you know what tears taste like. Those of your coworkers taste better."
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/heads/captain"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	post_init_icon_state = "cypherkey_cube"
	channels = list(RADIO_CHANNEL_COMMAND = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SERVICE = 1, RADIO_CHANNEL_AI_PRIVATE = 1, RADIO_CHANNEL_CENTCOM = 1, RADIO_CHANNEL_CTF_BLUE = 1, RADIO_CHANNEL_CTF_GREEN = 1, RADIO_CHANNEL_CTF_RED = 1, RADIO_CHANNEL_CTF_YELLOW = 1, RADIO_CHANNEL_CYBERSUN = 1, RADIO_CHANNEL_ENTERTAINMENT = 1, RADIO_CHANNEL_FACTION = 1, RADIO_CHANNEL_GUILD = 1, RADIO_CHANNEL_INTERDYNE = 1, RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_TARKON = 1, RADIO_CHANNEL_SYNDICATE = 1, RADIO_CHANNEL_UPLINK = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2b2793#dca01b"

/obj/item/radio/headset/debug
	name = "\improper subspace bowman headset"
	desc = "You can hear all of them. All oF THEM. THE VOICES. SO MANY VOICES. AAAAAAAAAA-"
	icon_state = "cent_headset_alt"
	worn_icon_state = "cent_headset_alt"
	keyslot2 = null
	keyslot = /obj/item/encryptionkey/debug
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	w_class = WEIGHT_CLASS_TINY

/obj/item/radio/headset/headset_debug/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)

// New admin undersuit
// todo: BST, CC Variants, Casualmin Variants, or.... Maybe we setup skins for this?
/obj/item/clothing/under/misc/sst_suit
	name = "subspace skinsuit"
	desc = "A perfectly tailored and customized skin suit made specifically for this technician. \
	Composed of experimental textiles, and assembled with the legendary Bluespace Sewing Machine, it fits the body with perfect comfort, and carries an air of security."
	icon = 'modular_nova/master_files/icons/obj/clothing/under/akula.dmi'
	icon_state = "default"
	inhand_icon_state = null
	worn_icon = 'modular_nova/modules/modular_items/icons/akulasuit.dmi'
	worn_icon_state = "default"
	can_adjust = FALSE//admin techs should NEVER be on sensors
	resistance_flags = FIRE_PROOF | ACID_PROOF
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/debug
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT

/obj/item/clothing/under/misc/adminsuit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -25)

// Hey check out this cancerous atompath.
// Squishes together Syndie Thermal Xrays, Debug Goggles, and the Engine Admin glasses.
// The one set of lenses to rule them all
// TODO:fix loss of vision flags when cycling goggle states
/obj/item/clothing/glasses/meson/engine/admin/debug//code\modules\clothing\glasses\engine_goggles.dm & code\modules\clothing\glasses\_glasses.dm
	name = "subspace contacts"
	desc = "One of Central Command's best kept secrets, resting on the eyes of many of its officers, operatives, and technicians."
	desc_controls = "Ctrl click to toggle xray and thermals."
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "contacts"
	inhand_icon_state = "contacts"
	worn_icon_state = "null"//TODO: Parent atom has update_appearance() in a proc, so either I figure out how to negate that or I have to recreate the proc-chain
	flags_cover = GLASSESCOVERSEYES
	flash_protect = FLASH_PROTECTION_WELDER
	lighting_cutoff = LIGHTING_CUTOFF_HIGH
	glass_colour_type = FALSE
//	vision_flags = SEE_TURFS | SEE_MOBS | SEE_OBJS
	clothing_traits = list(
		TRAIT_REAGENT_SCANNER,
		TRAIT_MADNESS_IMMUNE,
		TRAIT_MEDICAL_HUD,
		TRAIT_SECURITY_HUD,
		TRAIT_DIAGNOSTIC_HUD,
		TRAIT_BOT_PATH_HUD,
	)
	var/xray = TRUE//starts enabled
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP


//I am sorry for I must initialize and recreate procs or the drip will suffer, these goggles are too ugly
/obj/item/clothing/glasses/meson/engine/admin/debug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -15)

//Please stop updating icon states, youre ugly
/obj/item/clothing/glasses/meson/engine/admin/debug/update_icon_state()
	return

/obj/item/clothing/glasses/meson/engine/admin/debug/click_ctrl(mob/user)
	if(!ishuman(user))
		return CLICK_ACTION_BLOCKING
	if(xray)
		vision_flags &= ~(SEE_TURFS|SEE_MOBS|SEE_OBJS)
		detach_clothing_traits(TRAIT_XRAY_VISION)
	else
		vision_flags |= (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		attach_clothing_traits(TRAIT_XRAY_VISION)
	xray = !xray
	var/mob/living/carbon/human/human_user = user
	human_user.update_sight()
	return CLICK_ACTION_SUCCESS

//Debug magbooties
/obj/item/clothing/shoes/magboots/advance/debug//code\modules\clothing\shoes\magboots.dm
	name = "subspace magboots"
	desc = "Exotic hand manufactured booties made of the finest alloys the Frontier has to offer. The bluespace crystals powering each boot gleam threateningly."
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/debug
	icon = 'modular_nova/master_files/icons/obj/clothing/shoes.dmi'
	base_icon_state = "submag"
	icon_state = "submag0"// My first icon, I am very sorry. This should probably be replaced, but watch it just stick around for a long time.
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/feet.dmi'
	slowdown_active = -0.25
	magpulse_fishing_modifier = 10
	fishing_modifier = 10

/obj/item/clothing/shoes/magboots/advance/debug/Initialize(mapload)// Give them pockets, damnit
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/debug)
	AddElement(/datum/element/ignites_matches)

//Subspace gloves
/obj/item/clothing/gloves/tackler/debug
	name = "subspace gloves"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. It's covered in stickers of butt-bots."
//	icon = 'modular_nova/master_files/icons/obj/clothing/shoes.dmi'
	icon_state = "wizard"
//	worn_icon = 'modular_nova/master_files/icons/mob/clothing/feet.dmi'
	siemens_coefficient = 0
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	clothing_traits = list(TRAIT_FAST_CUFFING)
	armor_type = /datum/armor/debug/badmin

/obj/item/clothing/gloves/tackler/debug/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/kaza_ruk)

// Badmin pinpointer. The bool lets you find people, even if they aren't wearing clothes, as long as you share a z-layer
/obj/item/pinpointer/crew/debug//code\game\objects\items\pinpointer.dm
	name = "subspace target locator"
	desc = "A sleek handheld tablet with a complex looking antennae."
	icon_state = "pinpointer_sniffer"
	ignore_suit_sensor_level = TRUE
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//Tech's Disruptor - its a fischer but with every flavor of phasing
//Sometimes you need something to just not work for a moment
//to-do:steal code from /obj/projectile/beam/emitter/hitscan/psy to make this a depression pistol when shooting a mob with a disruptor.
//Techs do Infiltration and Lights testing.
/obj/projectile/energy/fisher/debug//Passes essentially everything, make sure you click on what you want to disable directly
	projectile_phasing = PASSTABLE | PASSMOB | PASSMACHINE | PASSSTRUCTURE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSDOORS

/obj/item/ammo_casing/energy/fisher/debug
	projectile_type = /obj/projectile/energy/fisher/debug
	e_cost = 0

//code\modules\projectiles\guns\energy\recharge.dm
/obj/item/gun/energy/recharge/fisher/debug
	name = "subspace disruptor"
	w_class = WEIGHT_CLASS_TINY
	suppressed = SUPPRESSED_QUIET
	recharge_time = 0.25 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/fisher/debug)

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

// Bussy berets, using an old CC beret with built in greyscaling as our foundation
/obj/item/clothing/head/helmet/space/beret/debug//code\modules\clothing\spacesuits\specialops.dm
	name = "tech's beret"
	desc = "An armored beret commonly used by administratively deployed techs. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#303030ff#FFCE5B"
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT
	armor_type = /datum/armor/debug
	resistance_flags = FIRE_PROOF | ACID_PROOF
	hair_mask = /datum/hair_mask/standard_hat_middle

/obj/item/clothing/head/helmet/space/beret/debug/bst
	name = "bluespace tech's beret"
	desc = "An armored beret commonly used by special operations officers. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#00289F#FFCE5B"

/obj/item/clothing/head/helmet/space/beret/debug/sst
	name = "subspace tech's beret"
	desc = "An armored beret commonly used by special operations officers. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#C68EEF#FFCE5B"

// Flannel armor. Fight me.
/obj/item/clothing/suit/toggle/jacket/nova/flannel/gags/debug//modular_nova\modules\customization\modules\clothing\under\utility_port\suits_port.dm
	armor_type = /datum/armor/debug
	name = "tech's flannel"
	desc = "Why'd you grab this one from the wardrobe? We have nicely colored ones, you know."
	greyscale_colors = "#303030ff"

/obj/item/clothing/suit/toggle/jacket/nova/flannel/gags/bst
	name = "bluespace tech's flannel"
	desc = "An armored beret commonly used by administratively deployed techs. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#00289F"

/obj/item/clothing/suit/toggle/jacket/nova/flannel/gags/sst
	name = "subspace tech's flannel"
	desc = "An armored beret commonly used by administratively deployed techs. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#C68EEF"

//Debug Gas Mask
//Creates a new debug filter
//code\modules\clothing\masks\gas_filter.dm
/obj/item/gas_filter/debug
	filter_status = 1000
	filter_strength_high = 10
	filter_efficiency = 1
	high_filtering_gases = list(
		/datum/gas/bz,
		/datum/gas/carbon_dioxide,
		/datum/gas/freon,
		/datum/gas/goblin,
		/datum/gas/halon,
		/datum/gas/healium,
		/datum/gas/hypernoblium,
		/datum/gas/miasma,
		/datum/gas/nitrous_oxide,
		/datum/gas/plasma,
		/datum/gas/proto_nitrate,
		/datum/gas/tritium,
		/datum/gas/zauker,
		)

//code\modules\clothing\masks\gasmask.dm
//TODO:bst/sst/cc icon variants
/obj/item/clothing/mask/gas/atmos/debug
	name = "subspace gas mask"
	desc = "A proprietary filtration mask which route gasses that CentCom deems toxic directly into the space between dimensions.\
	Wasteful? Totally. Convenient? Extremely."
	icon_state = "gas_atmos"
	inhand_icon_state = "gas_atmos"
	armor_type = /datum/armor/debug
	resistance_flags = FIRE_PROOF
	max_filters = 10
	starting_filter_type = /obj/item/gas_filter/debug
	fishing_modifier = 0

//Debug Global Access Door Remote
//code\game\objects\items\tools\control_wand.dm
//todo:subspace icon variant
/obj/item/door_remote/debug
	name = "subspace door remote"
	desc = "This remote controls airlocks through narrative will alone. Also comes emagged, did you know that you can emag door remotes?"
	department = "omni"
	region_access = REGION_ALL_GLOBAL
	owner_trim = /datum/id_trim/admin/sst
	our_domain = list( /area )
	obj_flags = EMAGGED

//Debug RCD, but using the cooler RCD type. Did you know that there already exists a decently superior alternative to the /obj/item/construction/rcd/combat/admin?
//It was /obj/item/construction/rcd/arcd and for whatever reason this unused one had the potential to be better. But wasn't used.
//modular_nova\master_files\code\game\objects\items\RCD.dm
//code\game\objects\items\rcd\RCD.dm
//todo:subspace icons
/obj/item/construction/rcd/arcd/mattermanipulator/debug
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
//code\game\machinery\computer\buildandrepair.dm:330 - Furnishing?

//Debug Rapid Lighting Device
//code\game\objects\items\rcd\RLD.dm
//todo:subspace icons
/obj/item/construction/rld/debug
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
/obj/item/card/emag/debug
	name = "subspace emag-doorjack"
	desc = "It's a card with a magnetic strip attached to some circuitry that hurts to look at. Don't wave this at anything you care about."
	icon_state = "emag"
	worn_icon_state = "emag"
	prox_check = FALSE
	type_blacklist = list()

//Debug Light Replacer
//todo:icon variant
//code\game\objects\items\devices\lightreplacer.dm
/obj/item/lightreplacer/blue/debug
	name = "subspace light replacer"
	desc = "A modified light replacer that zaps lights into place by crystallizing your irritation caused by a lack of lux. Oddly, has endless material."
	icon_state = "lightreplacer_blue"
	uses = INFINITY
	max_uses = INFINITY

//Debug Atmos Holofan
//I should probably make a version of this that places tinyfans instead.
//todo:icon variants: obj icon & new forcefield, retexture the engie projector icon for use with the atmos holofan
//code\game\objects\items\holosign_creator.dm
/obj/item/holosign_creator/atmos/debug
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
/obj/item/forcefield_projector/debug
	name = "subspace forcefield projector"
	desc = "An experimental device that can create several forcefields at a distance."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "signmaker_forcefield"
	max_shield_integrity = INFINITY
	shield_integrity = INFINITY
	max_fields = INFINITY
	field_distance_limit = INFINITY
	creation_time = 0 SECONDS

/obj/structure/projected_forcefield/debug
	name = "subspace forcefield"
	desc = "A glowing barrier, generated by a projector nearby. You probably are not going to be able to break this."
	icon = 'icons/effects/effects.dmi'
	icon_state = "forcefield"
	rad_insulation = RAD_FULL_INSULATION
	resistance_flags = INDESTRUCTIBLE
	can_atmos_pass = ATMOS_PASS_NO
	armor_type = /datum/armor/debug/badmin

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
/obj/item/construction/plumbing/debug
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
	var/static/list/debug_design_types = list(
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

/obj/item/construction/plumbing/debug/Initialize(mapload)
	plumbing_design_types = debug_design_types

	. = ..()

//Debug Amputation Shears
/obj/item/shears/debug
	name = "subspace amputation shears"
	desc = "What, too lazy for player-panel? These blades look sharp enough to cut space-time, they will certainly make quick work of any humanoid."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "shears"
	toolspeed = 0

//Debug & Admin Internals Tanks
//code\game\objects\items\tanks\tank_types.dm
//todo:variant icons
//define TANK_LEAK_PRESSURE (30.*ONE_ATMOSPHERE) = The internal pressure in kPa at which a handheld gas tank begins to take damage.
//So our magic multiplier should be 29! Right. Right???
//Base Debug Tank, probably fucks hard when used with ordnance, I haven't tried and you probably shouldn't try on prod either.
/obj/item/tank/internals/debug
	name = "subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. The longer your gaze lingers, the more unsettled you feel. Somewhere, a scientist yearns to print these. "
	icon_state = "emergency_double"
	inhand_icon_state = "emergency_tank"
	worn_icon_state = "emergency_engi"
	tank_holder_icon_state = "holder_emergency_engi"
	worn_icon = null
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_TINY
	force = 10
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	volume = 490//default tanks are 70, and this is a multiple for some scaling and mixing formulae

/obj/item/tank/internals/debug/populate_gas()
	return//spawns empty

//Normal Internals
//Oxygen - Most things breathe this
/obj/item/tank/internals/debug/oxygen
	name = "oxygen subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a standardized internals information label showing the tank should contain oxygen."
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE

/obj/item/tank/internals/debug/oxygen/populate_gas()
	air_contents.assert_gas(/datum/gas/oxygen)
	air_contents.gases[/datum/gas/oxygen][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Pluoxium - The cooler oxygen
/obj/item/tank/internals/debug/pluoxium
	name = "pluoxium subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a standardized internals information label showing the tank should contain pluoxium."
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE

/obj/item/tank/internals/debug/pluoxium/populate_gas()
	air_contents.assert_gas(/datum/gas/pluoxium)
	air_contents.gases[/datum/gas/pluoxium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Plasma - Plasmama, where have you gone, we miss you
/obj/item/tank/internals/debug/plasma
	name = "plasma subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a standardized internals information label showing the tank should contain plasma."
	distribute_pressure = TANK_PLASMAMAN_RELEASE_PRESSURE

/obj/item/tank/internals/debug/plasma/populate_gas()
	air_contents.assert_gas(/datum/gas/plasma)
	air_contents.gases[/datum/gas/plasma][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Nitrogen - Criminal cats breathe this.
/obj/item/tank/internals/debug/nitrogen
	name = "nitrogen subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a standardized internals information label showing the tank should contain nitrogen."
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE

/obj/item/tank/internals/debug/nitrogen/populate_gas()
	air_contents.assert_gas(/datum/gas/nitrogen)
	air_contents.gases[/datum/gas/nitrogen][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//'Ooops, lots of dust. Dont breathe this!'
//Tritium - Just fuckin' straight radiation.
/obj/item/tank/internals/debug/tritium
	name = "tritium subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a warning label indicating the tank should contain tritium."
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE

/obj/item/tank/internals/debug/tritium/populate_gas()
	air_contents.assert_gas(/datum/gas/tritium)
	air_contents.gases[/datum/gas/tritium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Freon - Funny ice-cycle tank
/obj/item/tank/internals/debug/freon
	name = "freon subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There is a warning label indicating the tank should contain freon."
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE

/obj/item/tank/internals/debug/freon/populate_gas()
	air_contents.assert_gas(/datum/gas/freon)
	air_contents.gases[/datum/gas/freon][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

//Now we get into some gas mixes
//Mixes containing nitrium can be poisonous. The higher the output pressure of a mix with nitrium, the higher the likelihood or rate of poisoning, but the more impactful the boon.
//Robust Mix, courtesy of Zul.
//This will kill you if you leave it running, but it's like stims on demand if you mind the toxin cycle.
/obj/item/tank/internals/debug/mix/juggermol
	name = "'JUGGERMOL' subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. There's a cute sticker applied of a red-haired neko warning you about 'Nitrosyl Plasmide Poisoning', whatever that means."
	distribute_pressure = 23

/obj/item/tank/internals/debug/mix/juggermol/populate_gas()
	air_contents.assert_gases(/datum/gas/pluoxium, /datum/gas/healium, /datum/gas/nitrium)
	air_contents.gases[/datum/gas/pluoxium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.112
	air_contents.gases[/datum/gas/healium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.333
	air_contents.gases[/datum/gas/nitrium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.555

//Anti-conflagratory. Good for firebugs. Doesn't save your clothing.
/obj/item/tank/internals/debug/mix/fusionfur
	name = "'Fusion-Fur' subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. A partially-peeled sticker of a grey-furred anthromorph advertises how well this mix keeps her fur from burning."
	distribute_pressure = 8

/obj/item/tank/internals/debug/mix/fusionfur/populate_gas()
	air_contents.assert_gases(/datum/gas/pluoxium, /datum/gas/halon, /datum/gas/hypernoblium)
	air_contents.gases[/datum/gas/pluoxium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.95
	air_contents.gases[/datum/gas/halon][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.05

//Stupid in a tank. Give one to the clown.
//if you say it bee-zed, the name makes slightly more sense. Feel free to rename this one if you're funnier than me, dear reader.
/obj/item/tank/internals/debug/mix/beeshead
	name = "'Bee's Head' subspace tank"
	desc = "A palm-sized gas tank embedded with an ominous purple crystal. It's covered in stickers of butt-bots."
	icon_state = "emergency_clown"
	inhand_icon_state = "emergency_clown"
	tank_holder_icon_state = "holder_emergency_clown"
	distribute_pressure = 23

/obj/item/tank/internals/debug/mix/beeshead/populate_gas()
	air_contents.assert_gases(/datum/gas/pluoxium, /datum/gas/nitrous_oxide, /datum/gas/bz, /datum/gas/helium)
	air_contents.gases[/datum/gas/pluoxium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.75
	air_contents.gases[/datum/gas/nitrous_oxide][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.05
	air_contents.gases[/datum/gas/bz][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.05
	air_contents.gases[/datum/gas/helium][MOLES] = (29*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * 0.15
