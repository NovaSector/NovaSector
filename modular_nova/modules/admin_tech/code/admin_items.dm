// The sheetsnatcher extreme is really ugly, misses features, and misses materials. Lets make our own.
// Using a construction bag as our base, instead of the sheetsnatcher.
// I can probably adapt the BST-BRPED manufacturing function to this, but for now, an improvement is better than nothing
/obj/item/storage/bag/construction/debug//code\game\objects\items\storage\bags.dm
	name = "subspace construction pouch"
	desc = "A hand manufactured pocket liner assembled with disturbingly advanced technologies and materials. \
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
		/obj/item/stack/rods/fifty = null,// amount should be null if it should spawn with the type's default amount
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
		/obj/item/stack/sheet/mineral/bananium/five = 10,
		/obj/item/stack/sheet/mineral/wood/fifty = null,
		/obj/item/stack/sheet/plastic/fifty = null,
		/obj/item/stack/sheet/runed_metal/fifty = null,
		/obj/item/stack/sheet/mineral/abductor = 50,
		/obj/item/stack/sheet/mineral/sandstone/thirty = null,
		/obj/item/stack/sheet/cardboard/fifty = null,
		/obj/item/stack/sheet/leather/five = 10,
		/obj/item/stack/sheet/hairlesshide = 50,
		/obj/item/stack/sheet/hot_ice = 50,
		/obj/item/stack/sheet/mineral/sandbags/fifty = null,
		/obj/item/stack/sheet/cloth/ten = 5,
		/obj/item/stack/cable_coil = MAXCOIL,
	)
	for(var/obj/item/stack/stack_type as anything in items_inside)
		var/amt = items_inside[stack_type]
		new stack_type(src, amt, FALSE)

// Debug Encryption Key and Headset, still manually populates the channel list because denthead
/obj/item/encryptionkey/debug
	name = "\proper the subspace encryption key"
	desc = "Holding and looking at this little chip fills you with a sense of existential dread. The taste of metaknowledge fills your mouth. \
		It tastes salty. Like tears. Why do you know what tears look like? \
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
// todo: BST, CC Variants, Casualmin Variants, or.... Maybe we setup altstates for this?
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
	AddComponent(/datum/component/adjust_fishing_difficulty, -25)

// Hey check out this cancerous atompath.
// Squishes together Syndie Thermal Xrays, Debug Goggles, and the Engine Admin glasses.
// The one set of lenses to rule them all
// TODO:fix loss of vision flags when cycling goggle states
/obj/item/clothing/glasses/meson/engine/admin/debug//code\modules\clothing\glasses\engine_goggles.dm
	name = "subspace contacts"
	desc = "One of Central Command's best kept secrets, resting on the eyes of many of its officers, operatives, and technicians."
	desc_controls = "Ctrl click to toggle xray and thermals."
//	icon = 'icons/obj/devices/syndie_gadget.dmi'
//	icon_state = "contacts"
//	inhand_icon_state = "contacts"
	worn_icon_state = null//TODO: Parent atom has update_appearance() in a proc, so either I figure out how to negate that or I have to recreate the proc-chain
	flags_cover = GLASSESCOVERSEYES
	flash_protect = FLASH_PROTECTION_WELDER
	lighting_cutoff = LIGHTING_CUTOFF_HIGH
	glass_colour_type = FALSE
	vision_flags = SEE_TURFS | SEE_MOBS | SEE_OBJS
	clothing_traits = list(
		TRAIT_REAGENT_SCANNER,
		TRAIT_MADNESS_IMMUNE,
		TRAIT_MEDICAL_HUD,
		TRAIT_SECURITY_HUD,
		TRAIT_DIAGNOSTIC_HUD,
		TRAIT_BOT_PATH_HUD,
	)
	var/xray = FALSE
	pickup_sound = SFX_GOGGLES_PICKUP
	drop_sound = SFX_GOGGLES_DROP
	equip_sound = SFX_GOGGLES_EQUIP

/obj/item/clothing/glasses/meson/engine/admin/debug/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/adjust_fishing_difficulty, -15)

///obj/item/clothing/glasses/meson/engine/admin/debug/click_ctrl(mob/user)
//	if(!ishuman(user))
//		return CLICK_ACTION_BLOCKING
//	if(xray)
//		vision_flags &= ~SEE_TURFS|SEE_MOBS|SEE_OBJS
//		detach_clothing_traits(TRAIT_XRAY_VISION)
//	else
//		vision_flags |= SEE_TURFS|SEE_MOBS|SEE_OBJS
//		attach_clothing_traits(TRAIT_XRAY_VISION)
//	xray = !xray
//	var/mob/living/carbon/human/human_user = user
//	human_user.update_sight()
//	return CLICK_ACTION_SUCCESS

// Debug magbooties
/obj/item/clothing/shoes/magboots/advance/debug//code\modules\clothing\shoes\magboots.dm
	name = "subspace magboots"
	desc = "Exotic hand manufactured booties made of the finest alloys the Frontier has to offer. The bluespace crystals powering each boot gleam threateningly."
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/debug
	base_icon_state = "submag"
	icon_state = "submag0"// My first icon, I am very sorry. This should probably be replaced, but watch it just stick around for a long time.
	slowdown_active = -0.25
	magpulse_fishing_modifier = 10
	fishing_modifier = 10

/obj/item/clothing/magboots/advance/debug/Initialize(mapload)// Give them pockets, damnit
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	AddElement(/datum/element/ignites_matches)

// Badmin pinpointer. The bool lets you find people, even if they aren't wearing clothes, as long as you share a z-layer
/obj/item/pinpointer/crew/debug//code\game\objects\items\pinpointer.dm
	name = "target locator"
	desc = "A sleek handheld tablet with a complex looking antennae."
	icon_state = "pinpointer_sniffer"
	ignore_suit_sensor_level = TRUE
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

// Techs do Infiltration and Lights testing
/obj/projectile/energy/fisher/debug//Passes essentially everything, make sure you click on what you want to disable directly
	projectile_phasing = PASSTABLE | PASSMOB | PASSMACHINE | PASSSTRUCTURE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSDOORS

/obj/item/ammo_casing/energy/fisher/debug
	projectile_type = /obj/projectile/energy/fisher/debug
	e_cost = 0

/obj/item/gun/energy/recharge/fisher/debug//code\modules\projectiles\guns\energy\recharge.dm
	w_class = WEIGHT_CLASS_TINY
	suppressed = SUPPRESSED_QUIET
	recharge_time = 0.25 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/fisher/debug)

// We need updated money for the debug box. Space cash is not splittable, and spawning 10 stacks of 5000 credits is not an ok solution to that problem
/obj/item/holochip/fiftythousand//code\game\objects\items\credit_holochip.dm
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
	greyscale_colors = "#0050D5#FFCE5B"

/obj/item/clothing/head/helmet/space/beret/debug/sst
	name = "subspace's beret"
	desc = "An armored beret commonly used by special operations officers. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#C68EEF#FFCE5B"

// Flannel armor. Fight me.
/obj/item/clothing/suit/toggle/jacket/nova/flannel/gags/debug//modular_nova\modules\customization\modules\clothing\under\utility_port\suits_port.dm
	armor_type = /datum/armor/debug
	name = "tech's flannel"
	desc = "Why'd you grab this one from the wardrobe? We have nicely colored ones, you know."
	greyscale_colors = "#303030ff#FFCE5B"

/obj/item/clothing/suit/toggle/jacket/nova/flannel/gags/bst
	name = "bluespace tech's flannel"
	desc = "An armored beret commonly used by administratively deployed techs. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#0050D5"

/obj/item/clothing/suit/toggle/jacket/nova/flannel/gags/sst
	name = "subspace tech's flannel"
	desc = "An armored beret commonly used by administratively deployed techs. Uses advanced force field technology to protect the head from space."
	greyscale_colors = "#C68EEF"

//Creates a new debug filter and gagsable admim bus gasmask
/obj/item/gas_filter/debug//code\modules\clothing\masks\gas_filter.dm
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

//TODO:make gags + variants
/obj/item/clothing/mask/gas/atmos/debug//code\modules\clothing\masks\gasmask.dm
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
