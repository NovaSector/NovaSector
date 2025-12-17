// NOVA MODULE IC-SPAWNING https://github.com/Skyrat-SS13/Skyrat-tg/pull/104
// Debug Datums
// Debug Storage Datums. Need more slots? Raise the number on max_total_storage and max_slots symmetrically
/datum/storage/debug
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = WEIGHT_CLASS_GIGANTIC * 28
	max_slots = 28
	allow_big_nesting = TRUE

/datum/storage/box/debug// Overwrites the original debug box datum to be more sane / match our other debug storage
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = WEIGHT_CLASS_GIGANTIC * 28
	max_slots = 28
	allow_big_nesting = TRUE

///Debug construction bag
/datum/storage/bag/construction/debug
	allow_big_nesting = TRUE
	max_slots = 99
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = 6769

/datum/armor/debug//No one is invincible.
	melee = 95
	melee = 95
	laser = 95
	energy = 95
	bomb = 95
	bio = 95
	fire = 98
	acid = 98

/datum/armor/debug/badmin//I'm serious, this isnt enough to save your un-robust ass.
	melee = 100
	melee = 100
	laser = 100
	energy = 100
	bomb = 100
	bio = 100
	fire = 100
	acid = 100

// Debug Items //
// Debug Boxes
// Box with a shitload of space
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
	new	/obj/item/card/emag(src)
	new	/obj/item/construction/rcd/combat/admin(src)
	new	/obj/item/stack/spacecash/c10000(src)
	new	/obj/item/clothing/glasses/meson/engine/admin(src)
	new	/obj/item/clothing/glasses/thermal/xray(src)
	new	/obj/item/summon_beacon/gas_miner/expanded/debug(src)
	new	/obj/item/choice_beacon/job_locker/debug(src)
	new	/obj/item/modular_computer/debug(src)
	new	/obj/item/debug/omnitool(src)
	new	/obj/item/debug/omnitool/item_spawner(src)
	new /obj/item/geiger_counter(src)
	new	/obj/item/flashlight/emp/debug(src)
	new	/obj/item/clothing/ears/earmuffs/debug(src)
	new	/obj/item/gps/visible_debug(src)
	new /obj/item/survivalcapsule/fishing/hacked(src)
	new	/obj/item/multitool/field_debug(src)
	new	/obj/item/camera/spooky/badmin(src)
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
	new	/obj/item/storage/fancy/cigarettes/cigpack_syndicate(src)
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
		/obj/item/autosurgeon/toolset=1,
		/obj/item/clothing/gloves/chief_engineer=1,
		/obj/item/screwdriver/power=1,
		/obj/item/inducer=1,
		/obj/item/inducer/empty=1,
		/obj/item/multitool/abductor=1,
		/obj/item/clothing/glasses/meson/engine/admin=1,
		/obj/item/stock_parts/power_store/battery/infinite=7,
		/obj/item/stock_parts/power_store/cell/infinite=7,
		/obj/item/mod/core/infinite=3,
		/obj/item/stack/cable_coil=4,
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
	new	/obj/item/healthanalyzer/advanced(src)
	new	/obj/item/pinpointer/crew/debug(src)
	new /obj/item/sensor_device(src)
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

// The sheetsnatcher extreme is really ugly, misses features, and misses materials. Lets make our own.
// Using a construction bag as our base, instead of the sheetsnatcher.
// I can probably adapt the BST-BRPED manufacturing function to this, but for now, an improvement is better than nothing
/obj/item/storage/bag/construction/debug
	name = "subspace construction pouch"
	desc = "A hand manufactured pocket liner made with disturbingly advanced technologies. \
	Peeking inside the pocket, cherenkov-esque radiation illuminates a mass of materials and supplies."
	icon = 'modular_nova/master_files/icons/obj/tools.dmi'
	icon_state = "subspace_bag"
	worn_icon_state = null//Dont fuck with my drip, todo: make drip-pouch worn visible
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	slot_flags = ITEM_SLOT_POCKETS//pocket only
	storage_type = /datum/storage/bag/construction/debug

/obj/item/storage/bag/construction/debug/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stack/rods/fifty = null,// amount should be null if it should spawn with the type's default amount
		/obj/item/stack/sheet/iron/fifty = null,
		/obj/item/stack/rods/lava = 50,
		/obj/item/stack/rods/shuttle = 50,
		/obj/item/stack/sheet/glass/fifty = null,
		/obj/item/stack/sheet/rglass/fifty = null,
		/obj/item/stack/sheet/mineral/plasma = 50,
		/obj/item/stack/sheet/plasteel/fifty = null,
		/obj/item/stack/sheet/plasmaglass/fifty = null,
		/obj/item/stack/sheet/plasmarglass/fifty = null,
		/obj/item/stack/sheet/mineral/titanium/fifty = null,
		/obj/item/stack/sheet/titaniumglass/fifty = null,
		/obj/item/stack/sheet/mineral/plastitanium = 50,
		/obj/item/stack/sheet/plastitaniumglass/fifty = null,
		/obj/item/stack/sheet/mineral/gold = 50,
		/obj/item/stack/sheet/mineral/silver = 50,
		/obj/item/stack/sheet/mineral/uranium = 20,// "Only 20 uranium 'cause of radiation"
		/obj/item/stack/sheet/mineral/diamond = 50,
		/obj/item/stack/sheet/bluespace_crystal = 50,
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
		/obj/item/stack/cable_coil = 100,
	)
	for(var/obj/item/stack/stack_type as anything in items_inside)
		var/amt = items_inside[stack_type]
		new stack_type(src, amt, FALSE)

// Debug magbooties
// Give them pockets, damnit
/obj/item/clothing/magboots/advance/debug/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	AddElement(/datum/element/ignites_matches)

/obj/item/clothing/shoes/magboots/advance/debug
	name = "subspace magboots"
	desc = "Exotic hand manufactured booties made of the finest alloys the Frontier has to offer. The bluespace crystals powering each boot gleam threateningly."
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/debug
	base_icon_state = "submag"
	icon_state = "submag0"// My first icon, I am very sorry. This should probably be replaced, but watch it just stick around for a long time.
	slowdown_active = -0.25
	magpulse_fishing_modifier = 10
	fishing_modifier = 10

// Debug Encryption Key and Headset
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

// Hey check out this cancerous atompath.
// Squishes together Syndie Thermal Xrays, Debug Goggles, and the Engine Admin glasses.
// The one set of lenses to rule them all
/obj/item/clothing/glasses/meson/engine/admin/debug
	name = "subspace contacts"
	desc = "One of Central Command's best kept secrets, resting on the eyes of many of its officers, operatives, and technicians."
	desc_controls = "Ctrl click to toggle xray and thermals."
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "contacts"
	inhand_icon_state = "contacts"
	worn_icon_state = null
	flags_cover = GLASSESCOVERSEYES
	flash_protect = FLASH_PROTECTION_WELDER
	lighting_cutoff = LIGHTING_CUTOFF_HIGH
	glass_colour_type = FALSE
	vision_flags = SEE_TURFS
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

/obj/item/clothing/glasses/meson/engine/admin/debug/click_ctrl(mob/user)
	if(!ishuman(user))
		return CLICK_ACTION_BLOCKING
	if(xray)
		vision_flags &= ~SEE_TURFS|SEE_MOBS|SEE_OBJS
		detach_clothing_traits(TRAIT_XRAY_VISION)
	else
		vision_flags |= SEE_TURFS|SEE_MOBS|SEE_OBJS
		attach_clothing_traits(TRAIT_XRAY_VISION)
	xray = !xray
	var/mob/living/carbon/human/human_user = user
	human_user.update_sight()
	return CLICK_ACTION_SUCCESS

// Badmin pinpointer. The bool lets you find people, even if they aren't wearing clothes, as long as you share a z-layer
/obj/item/pinpointer/crew/debug
	name = "target locator"
	desc = "A sleek handheld tablet with a complex looking antennae."
	icon_state = "pinpointer_sniffer"
	ignore_suit_sensor_level = FALSE
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

// Bluespace Techs do Infiltration and Lights testing
/obj/projectile/energy/fisher/debug
	projectile_phasing = PASSTABLE | PASSMOB | PASSMACHINE | PASSSTRUCTURE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSDOORS

/obj/item/ammo_casing/energy/fisher/debug
	projectile_type = /obj/projectile/energy/fisher/debug
	e_cost = 0

/obj/item/gun/energy/recharge/fisher/debug
	w_class = WEIGHT_CLASS_TINY
	suppressed = SUPPRESSED_QUIET
	recharge_time = 0.25 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/fisher/debug)

// Legacy armor, but keeping it for now
/obj/item/clothing/suit/armor/vest/debug
	name = "\improper subspace vest"
	desc = "A sleek piece of armour designed for Bluespace agents."
	armor_type = /datum/armor/debug
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

// Nova Bluespace Tech Modsuits //
// Debug Modules
/obj/item/mod/module/energy_shield/debug
	shield_icon = "love_hearts"//We can remove this later but for now it makes me happy

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
/obj/item/mod/control/pre_equipped/subspace
	theme = /datum/mod_theme/administrative
	starting_frequency = MODLINK_FREQ_CENTCOM
	applied_core = /obj/item/mod/core/infinite
	applied_modules = list(
		/obj/item/mod/module/hearing_protection,
		/obj/item/mod/module/storage/debug,
		/obj/item/mod/module/infiltrator/debug,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/energy_shield/debug,
		/obj/item/mod/module/plasma_stabilizer,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/mouthhole,
		/obj/item/mod/module/quick_carry/advanced,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/stealth/ninja,
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
// Empty variant
/obj/item/storage/belt/utility/debug
	name = "\improper subspace utility belt"
	w_class = WEIGHT_CLASS_TINY
	storage_type = /datum/storage/debug
	desc = "This bad boy can fit all your bus in one place."
	icon = 'modular_nova/modules/bluespace_admin/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = 'modular_nova/modules/bluespace_admin/icons/mob/belt.dmi'
	worn_icon_state = "admeme_satchel"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

// Yes hello I would like some actual tools in a debug outfit's belt
/obj/item/storage/belt/utility/debug/bst
	name = "Bluespace Technician's subspace utility belt"
	w_class = WEIGHT_CLASS_TINY
	storage_type = /datum/storage/debug
	desc = "THE bus bag."
	icon = 'modular_nova/modules/bluespace_admin/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = 'modular_nova/modules/bluespace_admin/icons/mob/belt.dmi'
	worn_icon_state = "admeme_satchel"

/obj/item/storage/belt/utility/debug/bst/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/abductor(src)
	new /obj/item/multitool/abductor(src)
	new /obj/item/analyzer/ranged(src)
	new /obj/item/storage/part_replacer/bluespace/tier4/bst(src)
	new /obj/item/construction/rcd/arcd/mattermanipulator(src)
	new /obj/item/pipe_dispenser/bluespace(src)
	new /obj/item/rpd_upgrade/unwrench(src)
	new /obj/item/construction/rtd/admin(src)
	new /obj/item/rwd/admin(src)
	new /obj/item/teleport_rod/admin(src)
	new /obj/item/lightreplacer/blue(src)
	new	/obj/item/holosign_creator/atmos(src)
	new	/obj/item/forcefield_projector(src)
	new /obj/item/toy/crayon/spraycan/infinite(src)
	new /obj/item/bodybag/bluespace(src)
	new /obj/item/melee/skateboard/hoverboard/admin(src)
	new /obj/item/mop/advanced(src)
	new	/obj/item/gun/energy/recharge/fisher/debug(src)
	new	/obj/item/fishing_rod/telescopic/master(src)
	new	/obj/item/gps(src)
	new	/obj/item/construction/rld(src)
	new /obj/item/storage/bag/trash/bluespace(src)
	new	/obj/item/hand_labeler(src)
	new	/obj/item/universal_scanner(src)
	new	/obj/item/construction/plumbing(src)
	new	/obj/item/blueprints(src)

/obj/item/storage/box/debug/power/PopulateContents()
	var/static/items_inside = list(
		/obj/item/autosurgeon/toolset = 1,
		/obj/item/clothing/gloves/chief_engineer = 1,
		/obj/item/screwdriver/power = 1,
		/obj/item/inducer = 1,
		/obj/item/inducer/empty = 1,
		/obj/item/multitool/abductor = 1,
		/obj/item/clothing/glasses/meson/engine/admin = 1,
		/obj/item/stock_parts/power_store/battery/infinite = 7,
		/obj/item/stock_parts/power_store/cell/infinite = 7,
		/obj/item/mod/core/infinite = 3,
		/obj/item/stack/cable_coil = 4,
		)
	generate_items_inside(items_inside, src)

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

//Bluespace Technician Outfit, used with the icspawning quick button
/datum/outfit/admin/bst
	name = "Bluespace Tech (MODsuit)"
	uniform = /obj/item/clothing/under/misc/adminsuit
	suit = /obj/item/clothing/suit/armor/vest/debug
	suit_store = /obj/item/tank/internals/emergency_oxygen/double
	ears = /obj/item/radio/headset/debug
	neck = /obj/item/clothing/neck/necklace/memento_mori
	gloves = /obj/item/clothing/gloves/kaza_ruk/combatglovesplus
	belt = /obj/item/storage/belt/utility/debug/bst
	shoes = /obj/item/clothing/shoes/magboots/advance/debug
	mask = /obj/item/clothing/mask/gas/atmos
	id = /obj/item/card/id/advanced/debug/bst
	box = /obj/item/storage/box/debug/tools
	l_pocket = /obj/item/door_remote/omni//TODO:Subspace variant
	r_pocket = /obj/item/storage/bag/construction/debug
	back = /obj/item/mod/control/pre_equipped/subspace
	backpack_contents = list(
		/obj/item/storage/box/debug/care_package = 1,
		/obj/item/storage/box/debug/power = 1,
		/obj/item/storage/box/debug/medical = 1,
		/obj/item/melee/energy/axe = 1,
		/obj/item/gun/energy/pulse/destroyer = 1,//TODO:Subspace variant, modular rifle
		/obj/item/boxcutter = 1,//TODO:Subspace variant
		/obj/item/gun/energy/taser/debug = 1,
		/obj/item/gun/magic/hook/debug = 1,
		/obj/item/storage/part_replacer/bluespace/tier4/bst = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/gun/magic/wand/safety/debug = 1,
	)
	belt_contents = list()

//Bluespace Technician Outfit, used with the icspawning quick button
/datum/outfit/admin/sst
	name = "Subspace Tech (MODsuit)"
	uniform = /obj/item/clothing/under/misc/adminsuit
	suit = /obj/item/clothing/suit/armor/vest/debug
	suit_store = /obj/item/tank/internals/emergency_oxygen/double
	ears = /obj/item/radio/headset/debug
	neck = /obj/item/clothing/neck/necklace/memento_mori
	gloves = /obj/item/clothing/gloves/kaza_ruk/combatglovesplus
	belt = /obj/item/storage/belt/utility/debug/bst
	shoes = /obj/item/clothing/shoes/magboots/advance/debug
	mask = /obj/item/clothing/mask/gas/atmos
	id = /obj/item/card/id/advanced/debug/bst
	box = /obj/item/storage/box/debug/tools
	l_pocket = /obj/item/door_remote/omni//TODO:Subspace variant
	r_pocket = /obj/item/storage/bag/construction/debug
	back = /obj/item/mod/control/pre_equipped/subspace
	backpack_contents = list(
		/obj/item/storage/box/debug/care_package = 1,
		/obj/item/storage/box/debug/power = 1,
		/obj/item/storage/box/debug/medical = 1,
		/obj/item/melee/energy/axe = 1,
		/obj/item/gun/energy/pulse/destroyer = 1,//TODO:Subspace variant, modular rifle
		/obj/item/boxcutter = 1,//TODO:Subspace variant
		/obj/item/gun/energy/taser/debug = 1,
		/obj/item/gun/magic/hook/debug = 1,
		/obj/item/storage/part_replacer/bluespace/tier4/bst = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/gun/magic/wand/safety/debug = 1,
	)
	belt_contents = list()

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
	else if(spawn_selection == "Infinite Megacell")
		atom_storage.attempt_insert(new /obj/item/stock_parts/power_store/battery/infinite(src), user, TRUE)
	else if(spawn_selection == "Infinite Power Cell")
		atom_storage.attempt_insert(new /obj/item/stock_parts/power_store/cell/infinite(src), user, TRUE)
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

// Legacy Debug items
/obj/item/clothing/shoes/combat/debug // This was made for a reason, I'm not going to question it
	w_class = WEIGHT_CLASS_TINY // tiny ahh feet

/obj/item/gun/energy/taser/debug
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/debug)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_casing/energy/electrode/debug
	e_cost = LASER_SHOTS(1000, STANDARD_CELL_CHARGE)



