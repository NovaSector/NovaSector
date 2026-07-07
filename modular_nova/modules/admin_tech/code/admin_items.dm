// Need to make a wand that uses the above to proc and apply to something.
//! Admeme bags. Better than a trash bag, better than a pouch, cooler than your belt, and comes totally empty.
//! These will let you quickly spawn in, grab a pile of leftovers from something like a body respawn, and poof out, destroying all of it quickly.
//! Sprite redits to CEV-ERIS, y'all really fucked with this one, it has no reason to look this cool.
//! TODO:
//! - pickup people or machines with it too? wouldn't that be cool
/* Magic macro that we cant get working. Commented trails sitting about the document.
#define ADMIN_ITEM_VARS(path) ##path {\
	w_class = WEIGHT_CLASS_TINY; \
	slot_flags = ITEM_SLOT_ADMIN; \
	resistance_flags = INDESTRUCTIBLE; \
	obj_flags = ADMIN_OBJ_FLAGS; \
}\
// Thank you to sammy for the above insanity. That's called a macro! This is applied through ADMIN_ITEM_VARS(path) under each item, and applies our unique obj flags for admin types without having to update the three hundred items in here. See under /obj/item/storage/bag/admin for example usage.
*/
/*
	add_filter("admin_active_item", 1, outline_filter(1, "#cc00ff", OUTLINE_SQUARE))
	game_plane_master_controller.remove_filter("admin_active_item")
*/
//! - click interaction inspects
/*
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
*/

/*
Admin Variants of Common Tools
*/
// Engie Tools
// TODO: desc
/obj/item/crowbar/power/alien/admin
	name = "subspace jaws of life"
	desc = "A set of jaws of life, compressed through the magic of science and augmented with alien technology. \
		Depending on the installed hardlight emitter, it can pry or cut by itself, without any effort required."
	usesound = 'sound/items/weapons/sonic_jackhammer.ogg'
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.1
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/crowbar/power/alien/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: desc
/obj/item/screwdriver/power/alien/admin
	name = "subspace hand drill"
	desc = "A powered hand drill, augmented with alien technology. \
		Depending on the installed hardlight emitter, it can drive screws or turn bolts with little to no effort."
	usesound = 'sound/items/pshoom/pshoom.ogg'
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.1
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/screwdriver/power/alien/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: desc
/obj/item/weldingtool/advanced/admin
	name = "subspace welding tool"
	desc = "A modern, experimental welding tool combined with an alien welding tool's generation methods, it never runs out of fuel and works almost as fast."
	icon = 'modular_nova/modules/mapping/icons/obj/items/advancedtools.dmi'
	icon_state = "welder"
	toolspeed = 0.1
	light_system = NO_LIGHT_SUPPORT
	light_range = 0
	change_icons = 0
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/weldingtool/advanced/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Medical Tools
/obj/item/scalpel/advanced/alien/admin
	name = "subspace scalpel"
	desc = "An advanced scalpel which uses laser technology, augmented with alien technology, \
		to cut tissue or saw through denser material, like bone."
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.1
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/scalpel/advanced/alien/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: desc
/obj/item/retractor/advanced/alien/admin
	name = "subspace mechanical pinches"
	desc = "An agglomerate of rods and gears, augmented with alien technology, \
		to clamp or retract tissue."
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.1
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/retractor/advanced/alien/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: desc
/obj/item/cautery/advanced/alien/admin
	name = "subspace searing tool"
	desc = "An advanced compact laser projector, augmented with alien technology, \
		for medical applications such as cauterizing tissue or drilling bone."
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.1
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/cautery/advanced/alien/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: desc
/obj/item/blood_filter/advanced/alien/admin
	name = "subspace medical combitool"
	desc = "A confusing combination of a blood filter and bonesetter, augmented with alien technology, \
		for filtering blood and tending to bones, including treating fractures even without surgical intervention."
	icon = 'modular_nova/modules/alien_hybrid_tools/icons/tools.dmi'
	toolspeed = 0.1
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/blood_filter/advanced/alien/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Your best friend for cleanup
// TODO: Update descs and worn sprites
/obj/item/storage/bag/admin
	name = "bluespace pocket"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "blue-pocket"
	worn_icon_state = "null"
	storage_type = /datum/storage/admin/bag
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/storage/bag/admin)

// First usage of the admin manufacturing company, to specifically denote items added through this module.
/obj/item/storage/bag/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/storage/bag/admin/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-Shift-Click to qDel all contents.")

/obj/item/storage/bag/admin/click_ctrl_shift(mob/user)
	if(!user.client?.holder)
		return CLICK_ACTION_BLOCKING
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	for(var/obj/item/stored_item in inv_grab)
		qdel(stored_item)

/obj/item/storage/bag/admin/subspace
	name = "subspace pocket"
	desc = parent_type::desc + " This advanced version fills you with a sense of dread when you open it and peer inside."
	icon_state = "sub-pocket"
	storage_type = /datum/storage/admin/bag/subspace

/// Separate type to put inside of other atoms. Will probably not be droppable by default.
/obj/item/storage/subspace_pouch
	name = "subspace pouch"
	desc = span_notice("Click to open the pouch.")
	icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	icon_state = "storage_pouch_icon"
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_state = "storage_pouch_icon"
	anchored = 1
	storage_type = /datum/storage/admin
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/storage/subspace_pouch)

/obj/item/storage/subspace_pouch/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/// Opens the bag on click. Considering it's already anchored, this makes it function similar to how ghosts can open all nested inventories
/obj/item/storage/subspace_pouch/attack_hand(mob/user, list/modifiers)
	. = ..()
	atom_storage.show_contents(user)

/// The sheetsnatcher extreme is really ugly, misses features, and misses materials. Let's make our own.
/// Using a construction bag as our base, instead of the sheetsnatcher.
/// I can probably adapt the BST-BRPED manufacturing function to this, but for now, an improvement is better than nothing.
/obj/item/storage/bag/construction/admin
	name = "bluespace construction bag"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials. \
		Peeking inside the pocket, cherenkov-esque radiation illuminates a mass of materials and supplies."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "blue-bag"
	worn_icon_state = "null" // Don't fuck with my drip
	storage_type = /datum/storage/admin/bag
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/storage/bag/construction/admin)

/obj/item/storage/bag/construction/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/storage/bag/admin/examine(mob/user)
	. = ..()
	. += span_notice("Alt-Right-Click to repopulate the bag contents. Ctrl-Click to qDel all contents.")

/// Clears the bag
/obj/item/storage/bag/construction/admin/click_ctrl_shift(mob/user)
	if(!user.client?.holder)
		return CLICK_ACTION_BLOCKING
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	for(var/obj/item/stored_item in inv_grab)
		qdel(stored_item)
	return

/// Refreshes the bag's contents
/obj/item/storage/bag/construction/admin/item_ctrl_click(mob/user)
	if(!user.client?.holder)
		return CLICK_ACTION_BLOCKING
	var/list/inv_grab = atom_storage.return_inv(FALSE)
	for(var/obj/item/stored_item in inv_grab)
		qdel(stored_item)
	PopulateContents()
	return

/obj/item/storage/bag/construction/admin/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stack/rods = 50,// amount should be null if it should spawn with the type's default amount
		/obj/item/stack/rods/lava/thirty = null,
		/obj/item/stack/rods/shuttle/fifty = null,
		/obj/item/stack/sheet/iron/fifty = null,
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
		/obj/item/stack/sheet/hot_ice = 50,
		/obj/item/stack/circuit_stack/full = null,
	)
	for(var/obj/item/stack/stack_type as anything in items_inside)
		var/amt = items_inside[stack_type]
		new stack_type(src, amt, FALSE)

/obj/item/storage/bag/construction/admin/subspace
	name = "subspace construction bag"
	desc = "An artisinally crafted pocket liner utilizing advanced technologies, techniques, and materials. \
	Peeking inside the pocket, cherenkov-esque radiation illuminates a mass of materials and supplies."
	icon_state = "sub-bag"

// Badmin pinpointer. The bool lets you find people, even if they aren't wearing clothes, as long as you share a z-layer
// The lack of adaption of the Lifeline PDA app to these pinpointers is just disappointing. These are objectively worse when compared to lifeline.
/obj/item/pinpointer/crew/admin//code\game\objects\items\pinpointer.dm
	name = "subspace target locator"
	desc = "A sleek handheld tablet with a complex looking antennae."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-sniffer"//you like sniffing subs, dont you
	ignore_suit_sensor_level = TRUE
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/pinpointer/crew/admin)

/obj/item/pinpointer/crew/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Tech's Disruptor - its a fischer but with every flavor of phasing on the projectile
// Sometimes you need something to just not work for a moment. You could just use buildmode, sure.
// to-do: integrate various state application modes, such as remote emag and similar. Make this the utility version of the subspace rifle, instead of the fisher as it currently is. integrate radial, consider common state applications, and make projectiles to fit.
// Techs do Infiltration and Lights testing.
/obj/projectile/energy/fisher/admin//Passes essentially everything, make sure you click on what you want to disable directly
	projectile_phasing = PASSTABLE | PASSMOB | PASSMACHINE | PASSSTRUCTURE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSDOORS

/obj/item/ammo_casing/energy/fisher/admin
	projectile_type = /obj/projectile/energy/fisher/admin
	e_cost = 0

//code\modules\projectiles\guns\energy\recharge.dm
/obj/item/gun/energy/recharge/fisher/admin
	name = "subspace disruptor"
	icon_state = "protolaser"
	suppressed = SUPPRESSED_QUIET
	recharge_time = 0.25 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/fisher/admin)
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/gun/energy/recharge/fisher/admin)

/obj/item/gun/energy/recharge/fisher/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// We need updated money for the debug box. Space cash is not splittable, and spawning 10 stacks of 5000 credits is not an ok solution to that problem
// code\game\objects\items\credit_holochip.dm
/obj/item/holochip/fiftythousand
	name = "unusually dense holochip"
	desc = "Oh lawd she thicc."
	credits = 50000
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/holochip/fiftythousand)

/obj/item/holochip/fiftythousand/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Debug Global Access Door Remote
// code\game\objects\items\tools\control_wand.dm
/obj/item/door_remote/admin
	name = "subspace door remote"
	desc = "This remote controls airlocks through narrative will alone. Also comes emagged, did you know that you can emag door remotes?"
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	department = "subspace"
	region_access = REGION_ALL_GLOBAL
	owner_trim = /datum/id_trim/admin/subspace
	our_domain = list( /area )
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS | EMAGGED

/obj/item/door_remote/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Should handle the icon switching.
/obj/item/door_remote/admin/update_icon_state()
	icon_state = "[base_icon_state]_[department]_[mode]"
	return ..()

// New admin RCD, but using the cooler RCD type. Did you know that there already exists a decently superior alternative to the /obj/item/construction/rcd/combat/admin?
// It was /obj/item/construction/rcd/arcd and for whatever reason this unused one had the potential to be better. But wasn't used.
// modular_nova\master_files\code\game\objects\items\RCD.dm
// code\game\objects\items\rcd\RCD.dm
/obj/item/construction/rcd/arcd/mattermanipulator/admin
	name = "subspace matter manipulator"
	desc = "Holding this fabulous piece of legally distinct technology fills you with a sense of determination. Works at range, and can deconstruct reinforced walls."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-manipulator"
	max_matter = INFINITY
	matter = INFINITY
	delay_mod = 0.1
	construction_upgrades = RCD_ALL_UPGRADES & ~RCD_UPGRADE_SILO_LINK
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/construction/rcd/arcd/mattermanipulator/admin)

/obj/item/construction/rcd/arcd/mattermanipulator/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// RCD Disks - What the fuck is this code man
// Placeholder spot to put an admin RCD disk when I eventually get around to fixing upstream

// Admin Rapid Lighting Device
// code\game\objects\items\rcd\RLD.dm
/obj/item/construction/rld/admin
	name = "subspace rapid lighting device"
	desc = "A device used to rapidly provide lighting sources to an area. Reload with iron, plasteel, glass or compressed matter cartridges."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-rld"
	worn_icon_state = "RPD"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	matter = INFINITY
	max_matter = INFINITY
	construction_upgrades = RCD_UPGRADE_SILO_LINK
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/construction/rld/admin)

/obj/item/construction/rld/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Debug Emag & Doorjack
// There is already a 'bluespace emag' but its pretty ugly, so I'll just do my own quick pallete swap icons
// code\game\objects\items\emags.dm
/obj/item/card/emag/admin
	name = "subspace emag-doorjack"
	desc = "It's a card with a magnetic strip attached to some circuitry that hurts to look at. Don't wave this at anything you care about."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-emag"
	worn_icon_state = "emag"
	prox_check = FALSE//makes wireless. be careful
	type_blacklist = list()//this is the crucial change to restore global emag function
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/card/emag/admin)

/obj/item/card/emag/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Admin Light Replacer
// code\game\objects\items\devices\lightreplacer.dm
/obj/item/lightreplacer/blue/admin
	name = "subspace light replacer"
	desc = "A modified light replacer that zaps lights into place by crystallizing your irritation caused by a lack of lux. Oddly, has endless material."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-lamp-replacer"
	uses = INFINITY
	max_uses = INFINITY
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/lightreplacer/blue/admin)

/obj/item/lightreplacer/blue/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Admin Atmos Holofan
// I should probably make a version of this that places tinyfans instead.
// code\game\objects\items\holosign_creator.dm
/obj/item/holosign_creator/atmos/admin
	name = "subspace ATMOS holofan projector"
	desc = "A holographic projector that creates holographic barriers that prevent changes in atmosphere conditions. Did you know that right clicking this directly while it is in your active hand can turn on a 'clearview' mode, making the signs unclickable?"
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-projector-atmos"
	max_signs = INFINITY
	projectable_through = list( /obj )
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/holosign_creator/atmos/admin)

/obj/item/holosign_creator/atmos/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/structure/holosign/barrier/atmos
	name = "subspace holofirelock"
	desc = "A holographic barrier resembling a firelock. Though it does not prevent solid objects from passing through, gas is kept out."
	icon_state = "holo_firelock"
	base_icon_state = "holo_firelock"
	rad_insulation = RAD_FULL_INSULATION
	resistance_flags = FIRE_PROOF | FREEZE_PROOF

/obj/structure/holosign/barrier/atmos/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Debug Forcefield Projector & It's Structure
/obj/item/forcefield_projector/admin
	name = "subspace forcefield projector"
	desc = "An experimental device that can create several forcefields at a distance."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-projector-forcefield"
	max_shield_integrity = INFINITY
	shield_integrity = INFINITY
	max_fields = INFINITY
	field_distance_limit = INFINITY
	creation_time = 0 SECONDS
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/forcefield_projector/admin)

/obj/item/forcefield_projector/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/structure/projected_forcefield/admin
	name = "subspace forcefield"
	desc = "A glowing barrier, generated by a projector nearby. You probably are not going to be able to break this."
	icon = 'icons/effects/effects.dmi'
	icon_state = "forcefield"
	rad_insulation = RAD_FULL_INSULATION
	resistance_flags = INDESTRUCTIBLE
	can_atmos_pass = ATMOS_PASS_NO
	armor_type = /datum/armor/admin/badmin

/obj/structure/projected_forcefield/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Admin Capsules - Capsules to spawn things that players shouldnt be spawning on the regular
// Tiny Fan Capsule
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
	template_id = "capsule_tinyfan"
	used = FALSE
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/survivalcapsule/admin/fan)

/obj/item/survivalcapsule/admin/fan/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Debug Plumbing Tool
// code\game\objects\items\rcd\RPLD.dm
/obj/item/construction/plumbing/admin
	name = "subspace omniplumber"//thanks cosmiclaer, cute name
	desc = "An expertly modified RCD outfitted to construct plumbing machinery."
	icon_state = "plumberer2"
	inhand_icon_state = "plumberer_sci"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	worn_icon_state = "plumbing"
	icon = 'icons/obj/tools.dmi'
	drop_sound = 'sound/items/handling/tools/rcd_drop.ogg'
	pickup_sound = 'sound/items/handling/tools/rcd_pickup.ogg'
	sound_vary = TRUE
	matter = INFINITY
	max_matter = INFINITY
	construction_upgrades = RCD_UPGRADE_SILO_LINK
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
// Design types for debug service constructor, I just smushed the two lists together, because no other plumber exists with the full list. why are we like this? is this even all of them?
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
//ADMIN_ITEM_VARS(/obj/item/construction/plumbing/admin)

/obj/item/construction/plumbing/admin/Initialize(mapload)
	plumbing_design_types = admin_design_types
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)
	. = ..()

// Admin Amputation Shears. This is more fun to play with than you might think.
/obj/item/shears/admin
	name = "subspace amputation shears"
	desc = "What, too lazy for player-panel? These blades look sharp enough to cut space-time, they will certainly make quick work of any humanoid."
	icon = 'icons/obj/medical/surgery_tools.dmi'
	icon_state = "shears"
	toolspeed = 0
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/shears/admin)

/obj/item/shears/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Admin Medigun
// TODO: So the cycling on medicell guns suck. And we won't actually need to insert new cells into this. So make a new modular rifle that only shoots medicell projectiles, and use this icon for it
// TODO: sprites
/obj/item/gun/energy/cell_loaded/medigun/admin
	name = "subspace medigun"
	desc = "VeyMed was not happy with this one, but they didn't get much of a say in it's manufacture. This 'aftermarket' (still manufactured by VeyMed) specification comes loaded with every cell. \
		Test users said the switching was 'cumbersome' and that a 'floating radial' was a cooler choice, but the acquisitions manager lacked ability to describe the design to the producer."
	icon = 'modular_nova/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi'
	icon_state = "medigun"
	inhand_icon_state = "chronogun"
	abstract_type = /obj/item/gun/energy/cell_loaded/medigun
	ammo_type = list(/obj/item/ammo_casing/energy/medical)
	cell_type = /obj/item/stock_parts/power_store/cell/medigun
	pin = /obj/item/firing_pin/admin
	maxcells = 13
	allowed_cells = list(/obj/item/weaponcell/medical)
	item_flags = null
	gun_flags = null
	can_install_cells = TRUE
	can_remove_cells = TRUE
	starting_cells = list(
		/obj/item/weaponcell/medical/brute/tier_3,
		/obj/item/weaponcell/medical/burn/tier_3,
		/obj/item/weaponcell/medical/toxin/tier_3,
		/obj/item/weaponcell/medical/oxygen/tier_3,
		/obj/item/weaponcell/medical/utility/clotting,
		/obj/item/weaponcell/medical/utility/temperature,
		/obj/item/weaponcell/medical/utility/salve,
	)
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/gun/energy/cell_loaded/medigun/admin)

/obj/item/gun/energy/cell_loaded/medigun/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)



/*
* Admin Cells for Cellgun
* I thought about making a spread of admin medicells to replace the hypospray kit, as well as relocation cells to move things around CC
* But after looking through medicell code, I do not want to deal with repacking those procs right now. Maybe later.
*/

// Admin surgery tray, for the new med box
/obj/item/surgery_tray/admin
	name = "technician's surgery tray"
	desc = "Full of things that you will probably want to do surgery with. Objectively a better user experience than the omnitool, which is atrociously out of date."
	starting_items = list(
		/obj/item/reagent_containers/medigel/sterilizine,
		/obj/item/stack/medical/bone_gel,
		/obj/item/stack/medical/wrap/sticky_tape/surgical,
		/obj/item/shears,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/suit/toggle/labcoat/nova/surgical_gown,//Did you know the gowns bypass clothing for surgery, so you dont actually need to look at people naked?
		/obj/item/surgical_drapes,
		/obj/item/scalpel/advanced/alien/admin,
		/obj/item/retractor/advanced/alien/admin,
		/obj/item/cautery/advanced/alien/admin,
		/obj/item/blood_filter/advanced/alien/admin,
	)
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/surgery_tray/admin)

/obj/item/surgery_tray/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// New admin PDA, thank you debug modular computer for existing.
// deadmonwonderland requested this one
// TODO: select a different sprite
// code\modules\modular_computers\computers\item\pda.dm
/obj/item/modular_computer/pda/admin
	name = "subspace PDA"
	desc = "An unassuming and oddly heavy PDA."
	device_theme = PDA_THEME_SPOOKY
	max_capacity = INFINITY
	hardware_flag = PROGRAM_ALL//This might cause issues? Set to PROGRAM_PDA if it do
	inserted_item = /obj/item/gun/magic/subspace/dagenblicky
	long_ranged = TRUE
	allow_chunky = TRUE
	stored_paper = 10
	max_paper = INFINITY
	light_power = 10
	light_range = 10
	light_angle = 360
	w_class = WEIGHT_CLASS_TINY
	slot_flags = list(ITEM_SLOT_ADMIN, ITEM_SLOT_ID)
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/modular_computer/pda/admin)

// Sets up PDA details and other small things.
/obj/item/modular_computer/pda/admin/Initialize(mapload)
	starting_programs += subtypesof(/datum/computer_file/program)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)
	internal_cell = new /obj/item/stock_parts/power_store/cell/infinite//is no kill pda now wow
	emag_act(forced = TRUE)//auto-emags our pda, oh wow so nice
	var/datum/computer_file/program/themeify/theme_app = locate() in stored_files
	if(theme_app)//Gives a theme
		for(var/theme_key in GLOB.pda_name_to_theme - GLOB.default_pda_themes)
			LAZYADD(theme_app.imported_themes, theme_key)
	var/datum/computer_file/program/messenger/msg = locate() in stored_files
	if(msg)
		msg.invisible = TRUE//'UHHH HELLO, ADMIN? WHY CAN I TEXT YOU? DID YOU MEAN TO DO THAT? ARE YOU REAL?'

/obj/item/modular_computer/pda/admin/get_messenger_ending()
	return "Sent from the space between timelines, narratively null."

// Handles item swapping from its internal storage
/obj/item/modular_computer/pda/admin/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(.)
		return .
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	if(inserted_item)
		swap_pen(user, tool)//'pens'
	else
		balloon_alert(user, "inserted [tool]")
		inserted_item = tool
		playsound(src, 'sound/machines/pda_button/pda_button1.ogg', 50, TRUE)
	return ITEM_INTERACT_SUCCESS

// Makes it ever so slightly clearer whats going on here
/obj/item/modular_computer/pda/admin/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!. && !inserted_item && istype(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "Insert [held_item]"
		. = CONTEXTUAL_SCREENTIP_SET
	return . || NONE

// TODO: sprites
// Admin laser pointer, because the infinite laser pointer isn't good enough.
// The code for these things is kinda unnervingly long.
/obj/item/laser_pointer/admin
	name = "subspace laser pointer"
	desc = "It's a fidget toy with a warning label, describing why you should definitely avoid pointing this rapidly enough for the universe to 'ratelimit' you, whatever that means. \
		Turning it over, you notice a crudely hand-etched representation of a crying cyborg."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "pointer"
	effectchance = 100
	energy = INFINITY
	max_energy = INFINITY
	max_range = INFINITY
	pointer_icon_state = "purple_laser" // Icon for the laser, affects both the laser dot and the laser pointer itself, as it shines a laser on the item itself. Something silly could be done here.
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
	/// Current firing mode. "normal" just does the usual fidget-toy pointer stuff. "burn" and "melt" are legitimate hitscan damage modes, cycled via ctrl-click.
	var/beam_mode = "normal"
//ADMIN_ITEM_VARS(/obj/item/laser_pointer/admin)

// sets up our pointer to not be shit
/obj/item/laser_pointer/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)
	diode = new /obj/item/stock_parts/micro_laser/quadultra
	crystal_lens = new /obj/item/stack/ore/bluespace_crystal/refined

/obj/item/laser_pointer/admin/examine(mob/user)
	. = ..()
	. += span_notice("It's currently set to [beam_mode == "normal" ? "harmless pointer" : "[beam_mode] beam"] mode. Ctrl-click to cycle modes.")

/// Cycles between the harmless pointer, a burning hitscan beam, and a melting/destroying hitscan beam.
/obj/item/laser_pointer/admin/item_ctrl_click(mob/user)
	if(!user.client?.holder)
		return NONE
	switch(beam_mode)
		if("normal")
			beam_mode = "burn"
			balloon_alert(user, "mode: burn")
		if("burn")
			beam_mode = "melt"
			balloon_alert(user, "mode: melt")
		if("melt")
			beam_mode = "normal"
			balloon_alert(user, "mode: harmless pointer")
	return CLICK_ACTION_SUCCESS

/obj/item/laser_pointer/admin/laser_act(atom/target, mob/living/user, list/modifiers)
	if(beam_mode == "normal")
		return ..() // fidget toy behavior, unchanged
	if(!ISADVANCEDTOOLUSER(user))
		to_chat(user, span_warning("You don't have the dexterity to do this!"))
		return
	if(HAS_TRAIT(user, TRAIT_CHUNKYFINGERS))
		to_chat(user, span_warning("Your fingers can't press the button!"))
		return
	add_fingerprint(user)
	Beam(target, icon_state = "purple_beam", time = 5)
	switch(beam_mode)
		if("burn")
			user.visible_message(span_danger("[user] scorches [target] with [src]!"), span_danger("You scorch [target] with [src]!"))
			log_combat(user, target, "scorched with an admin laser pointer", src)
			if(isliving(target))
				var/mob/living/burning_target = target
				burning_target.apply_damage(50, BURN)
				burning_target.adjust_fire_stacks(3)
				burning_target.ignite_mob()
			else
				EX_ACT(target, EXPLODE_LIGHT)
		if("melt")
			user.visible_message(span_danger("[user] melts [target] with [src]!"), span_danger("You melt [target] with [src]!"))
			log_combat(user, target, "melted with an admin laser pointer", src)
			if(isliving(target))
				var/mob/living/melting_target = target
				melting_target.apply_damage(200, BURN)
				melting_target.adjust_fire_stacks(10)
				melting_target.ignite_mob()
			else
				EX_ACT(target, EXPLODE_DEVASTATE)

// Admin Reagent Containers
// code\modules\reagents\reagent_containers.dm
// Admeme syringe with included syringe gun interactions. Seems like a horrible thing to leave laying around when assaulting the Crew, but, you're a badmin, what do you care?
// Did you know syringes have a baked in time for their action? Right into the proc, in a do after? Not affected by tool speed or anything. :)
// TODO: sprites
// code\modules\reagents\reagent_containers\syringes.dm
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
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/reagent_containers/syringe/admin)

/obj/item/reagent_containers/syringe/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/datum/embedding/syringe/admin
	embed_chance = 100
	fall_chance = 0
	pain_stam_pct = 0
	transfer_per_second = 1000

// Admin patches, the reagent container variety. I probably won't use these in favor of the /obj/item/stack/medical ones, but, I'll make these exist anyways for funsies
// TODO: sprites
// code\modules\reagents\reagent_containers\patch.dm
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
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/reagent_containers/applicator/patch/admin)

/obj/item/reagent_containers/applicator/patch/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

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

// Admin pills. Pills here. Get your pills here.
// code\modules\reagents\reagent_containers\pill.dm
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
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
	/// How many "layers" we have remaining. Each layer equates to 1 second of digestion -> var/layers_remaining = 3. This PRETTY COOL VARIABLE is used almost exclusively by unit tests. Very sad stuff.
//ADMIN_ITEM_VARS(/obj/item/reagent_containers/applicator/pill/admin)

/obj/item/reagent_containers/applicator/pill/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// like adderall XR, yeah? extended release. theoretical pill to shove into people for plotarmor or other extremely heinous purposes
/obj/item/reagent_containers/applicator/pill/admin/xr
	name = "gel encapsulated subspace shard"
	desc = "A slightly smaller pill shaped shard of stabilized and crystallized subspace. This one feels pliable, like putty, but there is a foreign grit that leaves you feeling uneasy. You feel compelled to swallow it."
	volume = 600
	layers_remaining = 600

// Admin watering can
// Adminordrazine can be used for botanical work, did you know?
// TODO: sprites
/obj/item/reagent_containers/cup/watering_can/advanced/admin
	name = "subspace botanical can"
	desc = "A gardening can embedded with technology that leaves you with a dull pain in your head. An ominous purple crystal wobbles and glimmers from inside the device, golden fluid leaking from momentarily visible pores like bubbling lava. \
	You suddenly find yourself afraid of spilling the contents."
//	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
//	icon_state = "adv_watering_can"
//	inhand_icon_state = "adv_watering_can"
	volume = 1000
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 1000)
	refill_rate = 100
	refill_reagent = /datum/reagent/medicine/adminordrazine
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/reagent_containers/cup/watering_can/advanced/admin)

/obj/item/reagent_containers/cup/watering_can/advanced/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// New Admin chems, this is going in its own page later
// code\modules\reagents\chemistry\reagents\medicine_reagents.dm
// Attempts to improve on adminordrazine
/datum/reagent/medicine/adminordrazine/subspace
	name = "Subspace Condensate"
	description = "The visual consistency of this material is best compared to oobleck. If you're fast enough, you can tear bits off of the mass before it returns to a thin slurry which drips through your fingers."
	color = "#ff00ea" //golden for the gods
	taste_description = "badmins"
	chemical_flags = REAGENT_DEAD_PROCESS
	self_consuming = TRUE
	metabolized_traits = list(TRAIT_ANALGESIA)
	/// Flags to fullheal every metabolism tick code\__DEFINES\mobs.dm line 1022
	full_heal_flags = ~(HEAL_BRUTE|HEAL_BURN|HEAL_TOX|HEAL_OXY|HEAL_STAM|HEAL_LIMBS|HEAL_ORGANS|HEAL_TRAUMAS|HEAL_ALL_REAGENTS|HEAL_NEGATIVE_DISEASES|HEAL_TEMP|HEAL_BLOOD|HEAL_STATUS|HEAL_CC_STATUS|HEAL_RESTRAINTS)
	var/back_from_the_dead = FALSE
	/// List of trait buffs to give to the affected mob, and remove as needed.
	var/static/list/trait_buffs = list(
		TRAIT_NOCRITDAMAGE,
		TRAIT_NOCRITOVERLAY,
		TRAIT_NODEATH,
		TRAIT_NOHARDCRIT,
		TRAIT_NOSOFTCRIT,
		TRAIT_STABLEHEART,
		TRAIT_NO_OXYLOSS_PASSOUT,
	)

// Adapting Penthrite / Nooart concepts. Guts the 'balance' of the original code to keep the revival functions.
/datum/reagent/medicine/adminordrazine/subspace/on_mob_dead(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	affected_mob.add_traits(trait_buffs, type)
	affected_mob.set_stat(CONSCIOUS) //This doesn't touch knocked out
	affected_mob.updatehealth()
	affected_mob.update_sight()
	REMOVE_TRAIT(affected_mob, TRAIT_KNOCKEDOUT, STAT_TRAIT)
	REMOVE_TRAIT(affected_mob, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT) //Because these are normally updated using set_health() - but we don't want to adjust health, and the addition of NOHARDCRIT blocks it being added after, but doesn't remove it if it was added before
	REMOVE_TRAIT(affected_mob, TRAIT_KNOCKEDOUT, OXYLOSS_TRAIT) //As above, removes unconsciousness if it was added before the reagent was administered
	affected_mob.set_resting(FALSE) //Please get up, no one wants a deaththrows juggernaught that lies on the floor all the time
	affected_mob.SetAllImmobility(0)
	affected_mob.grab_ghost(force = FALSE) //Shoves them back into their freshly reanimated corpse.
	back_from_the_dead = TRUE
	affected_mob.emote("gasp")
	affected_mob.playsound_local(affected_mob, 'sound/effects/health/fastbeat.ogg', 65)

/datum/reagent/medicine/adminordrazine/subspace/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!back_from_the_dead)
		return
	//Following is for those brought back from the dead only
	var/creation_impurity = 1 - creation_purity
	REMOVE_TRAIT(affected_mob, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT)
	REMOVE_TRAIT(affected_mob, TRAIT_KNOCKEDOUT, OXYLOSS_TRAIT)
	for(var/datum/wound/iter_wound as anything in affected_mob.all_wounds)
		iter_wound.adjust_blood_flow(4 * creation_impurity * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(20 * creation_impurity * metabolization_ratio * seconds_per_tick, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_organ_loss(ORGAN_SLOT_HEART, 4 * ((1 + creation_impurity) * metabolization_ratio * seconds_per_tick), required_organ_flag = affected_organ_flags)
	if(affected_mob.health < HEALTH_THRESHOLD_CRIT)
		affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/nooartrium)
	if(affected_mob.health < HEALTH_THRESHOLD_FULLCRIT)
		affected_mob.add_actionspeed_modifier(/datum/actionspeed_modifier/nooartrium)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

// Clean procs
/datum/reagent/medicine/adminordrazine/subspace/on_mob_delete(mob/living/carbon/affected_mob)
	. = ..()

// Do literally nothing for overdose. At least for now
/datum/reagent/medicine/adminordrazine/subspace/overdose_start(mob/living/carbon/affected_mob, metabolization_ratio)
	. = ..()

/datum/reagent/medicine/adminordrazine/subspace/proc/remove_buffs(mob/living/carbon/affected_mob)
	affected_mob.remove_traits(trait_buffs, type)
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/nooartrium)
	affected_mob.remove_actionspeed_modifier(/datum/actionspeed_modifier/nooartrium)
	affected_mob.update_sight()

// New Admin Injectors, to cut down on medbox spawns. Slime Jelly as your All-Heal option through the combat hypokit is cruel and unusual punishment by way of blorbo destruction.
// Funny for upstream, less funny here where these tools are used to assist players
// TODO: probably like six unique icons? maybe ill look for a unique new model base
// I can see myself making a big pile of these, so, lets make an admin empty
/obj/item/reagent_containers/hypospray/combat/subspace
	name = "subspace combat injector"
	desc = "A modified air-needle autoinjector for use in combat situations. Prefilled with experimental medical nanites and a stimulant for rapid healing and a combat boost."
	inhand_icon_state = "nanite_hypo"
	icon_state = "nanite_hypo"
	base_icon_state = "nanite_hypo"
	volume = 1000
	list_reagents = list(/datum/reagent/medicine/adminordrazine/subspace = 1000)
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/reagent_containers/hypospray/combat/subspace)

/obj/item/reagent_containers/hypospray/combat/subspace/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/reagent_containers/hypospray/combat/nanites/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

// Super extinguisher
/obj/item/extinguisher/subspace
	name = "subspace extinguisher"
	desc = "A tiny fire extinguisher, designed for putting out small fires. It feels like it has an infinite amount of water. How you can tell this, you aren't sure."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "extinguisher0"
	base_icon_state = "extinguisher0"
	sprite_name = "extinguisher0"
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
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/extinguisher/subspace)

/obj/item/extinguisher/subspace/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: sprites, fix the loader still
// Balls. Empty the stored balls in a directed space.
/obj/item/pneumatic_cannon/subspace
	name = "subspace ballmatter mass projector"
	desc = "A subspace condensant powered cannon that can fire any object loaded into it. Also contains a shard of the elusive Ballmatter, which can be attenuated to different spherical wavelengths."
	force = 8
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
	selfcharge = FALSE // We spawn a fresh ball right before firing instead of stockpiling them - see Fire().
	fire_sound = 'sound/items/weapons/sonic_jackhammer.ogg'
	spin_item = TRUE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	charge_type = /obj/item/toy/tennis/rainbow
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/pneumatic_cannon/subspace)

/obj/item/pneumatic_cannon/subspace/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/pneumatic_cannon/subspace/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-Click to attune to a different ball type. Currently attuned to [charge_type ? initial(charge_type.name) : "nothing"].")

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

/// Spawns a single fresh ball of charge_type immediately before firing, so nothing sits stockpiled in the cannon between shots.
/obj/item/pneumatic_cannon/subspace/Fire(mob/living/user, atom/target)
	if(!charge_type)
		to_chat(user, span_warning("\The [src] isn't attuned to project any spherical matter. Ctrl-click it to pick a ball first."))
		return
	if(!length(loadedItems)) // Don't spawn extras on top of a leftover ball if a prior attempt got interrupted before it fired.
		fill_with_type(charge_type, charge_amount)
	return ..()

/obj/item/pneumatic_cannon/subspace/item_ctrl_click(mob/user)
	// Ask the user what they want to attune the cannon to, or if they want to clear anything left loaded.
	var/list/choices = GLOB.subspace_ballmatter_spheres.Copy()
	choices += "Clear All"
	var/pick_a_sphere = tgui_input_list(user, "Tune the Subspace Ballmatter", "Ballmatter", choices)
	// If they didn't cancel out of the list selection, we do things. Clear-all removes anything currently loaded, and everything else attunes the cannon to a new ball type.
	if(isnull(pick_a_sphere))
		return
	if(pick_a_sphere == "Clear All")
		for(var/obj/item/stored_item as anything in loadedItems.Copy())
			qdel(stored_item)
		charge_type = null
		return CLICK_ACTION_SUCCESS
	if(pick_a_sphere in GLOB.subspace_ballmatter_spheres)
		// Clear out any leftover ball from the old selection so the chamber always gets refilled with the new type on the next shot.
		for(var/obj/item/stored_item as anything in loadedItems.Copy())
			qdel(stored_item)
		charge_type = GLOB.subspace_ballmatter_spheres[pick_a_sphere]
	return CLICK_ACTION_SUCCESS

// Consumes the job locker module, originally made by carpotoxin/honkpocket, because we use the code for a debug job locker spawn beacon.
// Creates a beacon that can spawn a locker with the items of a specified job. The locker spawns when the beacon is activated, and the locker type is determined by the beacon's internal list of locker paths, which is populated by the admin who holds it.
/obj/item/choice_beacon/job_locker
	name = "job locker beacon"
	desc = "A beacon which summons a locker with a job's items, what more is there to tell."
	company_source = "Nanotrasen"
	var/locker_path = list()
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/choice_beacon/job_locker)

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
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/choice_beacon/job_locker/debug)

/obj/item/choice_beacon/job_locker/debug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/choice_beacon/job_locker/debug/generate_display_names()
	var/locker_list = list()
	for(var/obj/structure/closet/secure_closet/path as anything in subtypesof(/obj/structure/closet/secure_closet))
		locker_list[initial(path.name)] = path
	return locker_list

// Spawn all the vendors that you want.
// TODO: This really isn't a great debug tool at the moment, as it uses a radial menu to select the vendor you want to spawn, which is really clunky with the number of vendors in the game, but, it works for now.
// Also it has a limited list. Better than nothing, but still not finished.
// Maybe I'll make a tguilist for it later.
/obj/item/summon_beacon/vendors/debug
	name = "debug vendor beacon"
	desc = "Delivers a Vendor via orbital drop with patented Donk Co. SafeTec Technology!"
	uses = INFINITY
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/summon_beacon/vendors/debug)

/obj/item/summon_beacon/vendors/debug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// It is time we create something terrible; a multicolor-pen-wand/gun that shoots anti-tank rounds. And also is an edagger. Fun admin-pda pen slot filler.
/*
/obj/item/gun/energy/meteorgun/pen
/obj/item/pen/edagger
/obj/item/gun/magic/wand/anti_tank
/obj/item/gun/ballistic/automatic/lahti
*/
// First lets make a new base that we might use again later. At minimum, it'll be a good blank to throw shit onto.
/obj/item/gun/magic/subspace
	name = "subspace wand"
	desc = "That's not magic, that's a gun in the shape of a stick."
	w_class = WEIGHT_CLASS_TINY
	can_muzzle_flash = FALSE
	clumsy_check = FALSE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	pin = /obj/item/firing_pin/admin
	pinless = TRUE
	school = SCHOOL_UNSET
	antimagic_flags = null
	max_charges = INFINITY
	charges = INFINITY
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/gun/magic/subspace)

/obj/item/gun/magic/subspace/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: sprites
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
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
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

//Setup our blicky
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

// Our transform to make it a dagger, stolen code
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

// Adjacency checks
/obj/item/gun/magic/subspace/dagenblicky/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.Adjacent(interacting_with))
		return NONE
	return ..()

// This is where the pen itself actually exists.
/obj/item/gun/magic/subspace/dagenblicky/get_writing_implement_details()
	if (HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return null
	return list(
		interaction_mode = MODE_WRITING,
		font = font,
		color = colour,
		use_bold = FALSE,
	)

// Only allows firing in gun mode
/obj/item/gun/magic/subspace/dagenblicky/can_shoot()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return FALSE
	return ..()

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

// DING DING DING DING NO FUN ALLOWED
// Creates a firing pin which checks for ACTUAL admin rights. If none, fails to fire. This will effectively brick anything you stick it into. Spawns into admin equipment by default.
// Instant swap and unremovable statuses means you can lockout whatever you want.
/obj/item/firing_pin/admin
	name = "subspace firing pin"
	desc = "A small authentication device, to be inserted into a firearm receiver to allow operation. Central Command's Technicians have had their bodies attenuated in a way that can be sampled with 'simple' technology."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-firing-pin"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	attack_verb_continuous = list("pokes")
	attack_verb_simple = list("poke")
	fail_message = "not an admin!"
	force_replace = TRUE
	pin_hot_swappable = FALSE
	pin_removable = FALSE
	default_pin_auth = TRUE
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/firing_pin/admin)

/obj/item/firing_pin/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/firing_pin/admin/pin_auth(mob/living/user)
	. = ..()
	if(check_rights_for(CLIENT_FROM_VAR(user), R_ADMIN))
		return TRUE
	return FALSE

// Subspace beakers. Horrifying volume contents.
/obj/item/reagent_containers/cup/beaker/admin
	name = "subspace beaker"
	desc = "Tilting this from side to side is like looking into a tear in reality. It looks bottomless."
	abstract_type = /obj/item/reagent_containers/cup
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1, 5, 10, 50, 100)
	volume = 250000//Lets be a LITTLE sane about this.
	initial_reagent_flags = OPENCONTAINER | DUNKABLE
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-beaker"
	reagent_container_liquid_sound = SFX_DEFAULT_LIQUID_SLOSH
	/// Like Edible's food type, what kind of drink is this?
	drink_type = NONE
	/// How much we drink at once, shot glasses drink more.
	gulp_size = 5
	/// Whether the 'bottle' is made of glass or not so that milk cartons dont shatter when someone gets hit by it.
	isGlass = FALSE
	/// Whether to allow heating up the contents with a source of flame.
	heatable = TRUE
	/// Can we put a lid on this container?
	can_lid = TRUE
	/// If TRUE, after we finish drinking, we try to drink again after do_after
	loop_drink = TRUE
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

// Reactionless subspace beaker
/obj/item/reagent_containers/cup/beaker/admin/noreact
	name = "stasis subspace beaker"
	desc = "A reactionless version of the bottomless beaker."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-beaker-noreact"
	initial_reagent_flags = OPENCONTAINER | NO_REACT | DUNKABLE

// TODO: Cute smol sprite for this
// The reasonable to use beaker.
/obj/item/reagent_containers/cup/beaker/admin/small
	name = "fun sized subspace beaker"
	desc = "Tilting this little thing from side to side is like looking into a tear in reality. It looks like it could hold an incredible amount of fluid.\
	It might fill you with fear, but awwwwh look at it, its so cute! Imagine doing shots with this."
	volume = 1000//Small but still strong. Tame as it'll be used elsewhere for technical purposes.

// Reactionless smol-big beaker
/obj/item/reagent_containers/cup/beaker/admin/small/noreact
	name = "fun sized stasis subspace beaker"
	desc = "A statis variant of the adorably sized version of the bottomless beaker."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-beaker-noreact"
	initial_reagent_flags = OPENCONTAINER | NO_REACT | DUNKABLE

// TODO: sprites
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
	base_pixel_x = 0
	pixel_x = 0
	max_syringes = 10
	force = 0
	pin = /obj/item/firing_pin/admin
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/gun/syringe/admin)

/obj/item/gun/syringe/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: sprites.
// TODO: consider splitting the demo mod into an actual demolition tool, and just have this be a tool for easy mob launching, with selectable force instead
// default demo mod with this force ALMOST totally cracks a standard fulltile r-window. this is a 'soft demolition' tool, to 'soften' up the environment without utterly destroying it.
/obj/item/melee/baseball_bat/admin
	name = "subspace baseball bat"
	desc = "There ain't a skull in the league that can withstand a nuclear bomb on a stick."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "sub-bat"
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
	/// Are we able to do a homerun?
	homerun_able = TRUE
	/// Are we ready to do a homerun?
	homerun_ready = TRUE
	/// Can we launch mobs thrown at us away?
	mob_thrower = TRUE
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/melee/baseball_bat/admin)

/obj/item/melee/baseball_bat/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/melee/baseball_bat/admin/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-Click to set the demolition modifier. Currently [demolition_mod].")

// Neato demo-mod selector. Easy to adapt code for modifying variables on items.
/obj/item/melee/baseball_bat/admin/item_ctrl_click(mob/user)
	var/new_demo_mod = tgui_input_number(user, "Set demolition modifier", "Demolition Modifier", demolition_mod, 100, 0, round_value = FALSE)
	if(isnull(new_demo_mod))
		return
	demolition_mod = new_demo_mod
	to_chat(user, span_notice("\The [src]'s demolition modifier is now [demolition_mod]."))
	return CLICK_ACTION_SUCCESS

// Of course I had to make a new pulse rifle.
// The new heavy pulse
/obj/projectile/beam/pulse/heavy
	name = "heavy pulse"
	icon_state = "u_laser"
	damage = 100
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_GREEN
	tracer_type = /obj/effect/projectile/tracer/pulse
	muzzle_type = /obj/effect/projectile/muzzle/pulse
	impact_type = /obj/effect/projectile/impact/pulse
	wound_bonus = 50

// Casing for the above beam
/obj/item/ammo_casing/energy/laser/pulse/heavy
	projectile_type = /obj/projectile/beam/pulse/heavy
	e_cost = LASER_SHOTS(200, STANDARD_CELL_CHARGE * 40)
	select_name = "ANNIHILATE"
	fire_sound = 'sound/items/weapons/pulse.ogg'
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/blue
	muzzle_flash_color = LIGHT_COLOR_GREEN

// New Pulse Gun
/obj/item/gun/energy/pulse/destroyer/annihilator
	name = "pulse annhilator"
	desc = "An extreme-duty energy rifle built for pure destruction."
	worn_icon_state = "pulse"
	cell_type = /obj/item/stock_parts/power_store/cell/infinite
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse/heavy)
	pin = /obj/item/firing_pin/admin
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/gun/energy/pulse/destroyer/annihilator/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/gun/energy/pulse/destroyer/annihilator/attack_self(mob/living/user)
	to_chat(user, span_danger("[src.name] has three settings, and they are all ANNIHILATE."))

// Modular Admin Rifle. Another heretical creation.
// TODO: sprites, make and adjust speech json, adjust fire modes for damage, fix double fire that its inheriting for w/e reason
// TODO: find out why it's firing twice. probably the subtype gun we used
/obj/item/gun/energy/modular_laser_rifle/carbine/admin
	name = "\improper subspace carbine"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/saibasan/guns32x.dmi'
	icon_state = "hoshi_kill"
	inhand_icon_state = "hoshi_kill"
	worn_icon_state = "hoshi_kill"
	base_icon_state = "hoshi"
	charge_sections = 3
	burst_size = 1
	cell_type = /obj/item/stock_parts/power_store/cell/infinite
	ammo_type = list(/obj/item/ammo_casing/energy/cybersun_small_hellfire)
	pin = /obj/item/firing_pin/admin
	SET_BASE_PIXEL(0, 0)
	weapon_weight = WEAPON_LIGHT
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
			/datum/laser_weapon_mode/admin/gravity,
	)
	default_selected_mode = "Disturb"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
//ADMIN_ITEM_VARS(/obj/item/gun/energy/modular_laser_rifle/carbine/admin)

/obj/item/gun/energy/modular_laser_rifle/admin/emp_act(severity)
	. = ..()
	speak_up("emp", TRUE) // She gets very upset if you emp her

// This might not be possible? With the elements
/obj/item/gun/energy/modular_laser_rifle/admin/Initialize(mapload)
	. = ..()
	chat_color = "#cd4456"
	chat_color_darkened = process_chat_color("#cd4456", sat_shift = 0.85, lum_shift = 0.85)
	last_charge = cell.charge
	tracked_soulcatcher = AddComponent(/datum/component/soulcatcher/modular_laser)
	create_weapon_mode_stuff()
	voice = null

/obj/item/gun/energy/modular_laser_rifle/carbine/admin/init_manufacturer_examine()
    AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: base firing mode needs no damage but inflicts hallucinations / causes people to collapse and freakout / causes traumas
// icons\obj\weapons\guns\projectiles.dmi icon arcane_barrage
// candidate for base: /obj/projectile/beam/mindflayer
/obj/item/ammo_casing/energy/mindflayer/admin
	projectile_type = /obj/projectile/beam/mindflayer
	select_name = "Fourth Wall"
	fire_sound = 'sound/items/weapons/laser.ogg'

/obj/projectile/beam/mindflayer/admin
	name = "fourth wall blast"
	damage = 0

/obj/projectile/beam/mindflayer/admin/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/human_hit = target
		human_hit.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20)
		human_hit.adjust_hallucinations(60 SECONDS)

// Base datum for our new weapon
// Fire mode to be used against idiot players interfering with you. Gives medical something to do.
/datum/laser_weapon_mode/admin
	/// What name does this weapon mode have? Will appear in the weapon's radial menu
	name = "Disturb"
	/// What casing does this variant of weapon use?
	casing = /obj/item/ammo_casing/energy/mindflayer/admin
	/// What icon_state does this weapon mode use?
	weapon_icon_state = "kill"
	/// How many charge sections does this variant of weapon have? This is used for deciding icon states to don't be dumb.
	charge_sections = 3
	/// What is the shot cooldown this variant applies to the weapon?
	shot_delay = 0.1 SECONDS
	/// What json string do we check for when making chat messages with this mode?
	json_speech_string = "disturb"
	/// What do we change the gun's runetext color to when applied
	gun_runetext_color = "#cd4456"
	/// Keeps track of the autofire component for deleting later
	var/datum/component/automatic_fire/autofire_component

// This is where we add fun laser mode stuff to each mode. If we do. If not, do nothing
/datum/laser_weapon_mode/admin/apply_to_weapon(obj/item/gun/energy/applied_gun)
	// autofire_component = applied_gun.AddComponent(/datum/component/automatic_fire, shot_delay)

// If you ever add something to the weapon, you will probably want to remove it when youre done with the mode, or it sticks to it the gun permanently
/datum/laser_weapon_mode/admin/remove_from_weapon(obj/item/gun/energy/applied_gun)
	// QDEL_NULL(autofire_component)

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
/datum/laser_weapon_mode/admin/sniper
	name = "Marksman"
	casing = /obj/item/ammo_casing/energy/mm20x138
	weapon_icon_state = "kill"
	json_speech_string = "sniper"
	gun_runetext_color = "#7a0bb7"
	/// Keeps track of the scope component for deleting later
	var/datum/component/scope/scope_component

// Another attempt at the energy based anti tank shot
/obj/item/ammo_casing/energy/mm20x138
	name = "20x138mm bullet casing"
	desc = "A 20x138mm bullet casing."
	projectile_type = /obj/projectile/bullet/mm20x138
	icon_state = ".50"
	newtonian_force = 1.5

/datum/laser_weapon_mode/admin/sniper/apply_to_weapon(obj/item/gun/energy/applied_gun)
	scope_component = applied_gun.AddComponent(/datum/component/scope, 3)

/datum/laser_weapon_mode/admin/sniper/remove_from_weapon(obj/item/gun/energy/applied_gun)
	QDEL_NULL(scope_component)

// The new super-heavy
/obj/projectile/beam/pulse
	name = "pulse"
	icon_state = "u_laser"
	damage = 50
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	tracer_type = /obj/effect/projectile/tracer/pulse
	muzzle_type = /obj/effect/projectile/muzzle/pulse
	impact_type = /obj/effect/projectile/impact/pulse
	wound_bonus = 10

/obj/projectile/beam/pulse/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if (!QDELETED(target) && (isturf(target) || isstructure(target)))
		if(isobj(target))
			SSexplosions.med_mov_atom += target
		else
			SSexplosions.medturf += target

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

// Comes in useful more than you think
/datum/laser_weapon_mode/admin/ion
	name = "Ion"
	casing = /obj/item/ammo_casing/energy/ion
	weapon_icon_state = "kill"
	json_speech_string = "ion"
	gun_runetext_color = "#7a0bb7"

// TODO: finish this and confirm it works
// dismemberment and mining mode
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

// Currently copied directly from the carbine and subtyped for later editing
// TODO: finish this one, it isnt even integrated atm
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

// Dune-esque energy shields.
// This one can be used for high importance CC people
/obj/item/clothing/accessory/energy_shield/admin
	name = "\improper centcom tactical shield projector"
	desc = "A military-spec energy shield designed for Central Command Officials."
	max_shield_health = 250
	recharge_delay = 4 SECONDS
	recharge_rate = 16
	shield_color = "#15ff00"
	max_armor_class = 200
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/clothing/accessory/energy_shield/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Unrealistic shield
/obj/item/clothing/accessory/energy_shield/admin/bluespace
	name = "\improper bluespace shield projector"
	desc = "A cutting edge energy shield designed for Central Command's technicians."
	max_shield_health = 1000
	recharge_delay = 2 SECONDS
	recharge_rate = 64
	shield_color = "#000fda"
	max_armor_class = 200

// Even more unrealistic shield
/obj/item/clothing/accessory/energy_shield/admin/subspace
	name = "\improper subspace shield projector"
	desc = "A narrative-bending energy shield designed for Central Command's technicians."
	max_shield_health = 10000
	recharge_delay = 0 SECONDS
	recharge_rate = 128
	shield_color = "#cc00ff"
	max_armor_class = 200

// Soap. Amazing
// TODO: sprites
/obj/item/soap/admin
	name = "\improper subspace soap"
	desc = "ACTUALLY the most advanced soap known to mankind. Because it does not actually exist. Where did you get this?"
	icon_state = "soapomega"
	inhand_icon_state = "soapomega"
	worn_icon_state = "soapomega"
	cleanspeed = 0 SECONDS
	uses = INFINITY
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/soap/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)
	AddComponent(/datum/component/slippery, 0) //Negates slippery component

// Admeme mop. There is a funny comment on the parent, originally:
// var/refill_reagent = /datum/reagent/water //Determins what reagent to use for refilling, just in case someone wanted to make a HOLY MOP OF PURGING
// We did finally make the Holy Mop of Purging.
/obj/item/mop/advanced/admin
	name = "HOLY MOP OF PURGING"
	desc = "What, did a priest bless this? Why does it feel like that?"
	max_reagent_volume = 100 // NOVA EDIT - ORIGINAL: 10
	icon_state = "advmop"
	inhand_icon_state = "advmop"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 12
	throwforce = 14
	throw_range = 4
	mopspeed = 0 SECONDS
	refill_enabled = FALSE //Starts disabled.
	refill_rate = 5
	refill_reagent = /datum/reagent/space_cleaner/ez_clean //Determins what reagent to use for refilling, just in case someone wanted to make a HOLY MOP OF PURGING
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/mop/advanced/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// And so we enter the era of hand-held machines.
// Introducing the first, a pocket version of the debug chem synth.
/obj/item/handheld_debug_chem_synth
	name = "subspace chem dispenser"
	desc = "A miniaturized version of the debug chem synthesizer. You can see an ampoule with subspace condensate creeping and sticking around inside it's glass prison. You think its best not to question it."
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "camera_bug"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

	var/obj/item/reagent_containers/beaker
	var/amount = /obj/item/reagent_containers/cup/beaker/admin/small::volume//I find myself dispensing full beakers rather than small drops of them.
	var/temperature = DEFAULT_REAGENT_TEMPERATURE
	var/purity = 100

/obj/item/handheld_debug_chem_synth/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/handheld_debug_chem_synth/examine(mob/user)
	. = ..()
	. += span_notice("Use in hand to open the synthesizer interface.")

/obj/item/handheld_debug_chem_synth/attack_self(mob/user)
	ui_interact(user)

/obj/item/handheld_debug_chem_synth/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChemDebugSynthesizer", name) // reuse the existing tgui interface, narsie bless the work of other people
		ui.open()

/obj/item/handheld_debug_chem_synth/ui_data(mob/user)
	. = ..()
	.["purity"] = purity
	.["temp"] = temperature

// same logic as chem_synthesizer's handle_ui_act, stolen wholesale to fit our needs here
/obj/item/handheld_debug_chem_synth/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("input")
			if(QDELETED(beaker))
				return FALSE

			var/selected_reagent = tgui_input_list(ui.user, "Select reagent", "Reagent", GLOB.name2reagent)
			if(!selected_reagent)
				return FALSE

			var/datum/reagent/input_reagent = GLOB.name2reagent[selected_reagent]
			if(!input_reagent)
				return FALSE

			beaker.add_hiddenprint(ui.user)
			beaker.reagents.add_reagent(input_reagent, amount, reagtemp = temperature, added_purity = (purity / 100))
			return TRUE

		if("makecup")
			if(beaker)
				return
			beaker = new /obj/item/reagent_containers/cup/beaker/admin/small(src)
			visible_message(span_notice("[src] dispenses a bluespace beaker."))
			return TRUE

		if("amount")
			var/input = params["amount"]
			if(isnull(input))
				return FALSE
			input = text2num(input)
			if(isnull(input))
				return FALSE
			amount = input
			return TRUE

		if("temp")
			var/input = params["amount"]
			if(isnull(input))
				return FALSE
			input = text2num(input)
			if(isnull(input))
				return FALSE
			temperature = input
			return TRUE

		if("purity")
			var/input = params["amount"]
			if(isnull(input))
				return FALSE
			input = text2num(input)
			if(isnull(input))
				return FALSE
			purity = input
			return TRUE

		if("eject")
			if(QDELETED(beaker))
				return FALSE
			ui.user.put_in_hands(beaker)
			beaker = null
			return TRUE

	update_appearance()
// Potential beaker insertion handling code? You can't actually stick pre-existing beakers in this rn. This isn't tested yet because it requires fucking with the tsx file which I'm not doing quite yet. SHOULD work if given buttons
// Might try and fix this with an attack instead of adding a button, but, its handheld, this is a bit inconvenient to use, idk what the best playability choice is here.
// Maybe just having the beakers at all is fine, and I can add a click combo to the subspace beaker to just instantly delete it from your hand or something
/*
		if("insert")
			if(!QDELETED(beaker))
				return FALSE // already holding one, eject first
			var/obj/item/reagent_containers/container = ui.user.get_active_held_item()
			if(!istype(container) || !container.is_chem_container())
				return FALSE
			if(!ui.user.can_perform_action(src, ALLOW_SILICON_REACH | FORBID_TELEKINESIS_REACH))
				return FALSE
			if(!ui.user.transferItemToLoc(container, src))
				return FALSE
			beaker = container
			return TRUE
*/

// Holds our info about the beaker itself
/obj/item/handheld_debug_chem_synth/ui_data(mob/user)
	. = list()
	.["amount"] = amount
	.["temp"] = temperature
	.["purity"] = purity

	var/list/beaker_data = null
	if(!QDELETED(beaker))
		beaker_data = list()
		beaker_data["maxVolume"] = beaker.volume
		beaker_data["transferAmounts"] = beaker.possible_transfer_amounts
		beaker_data["pH"] = round(beaker.reagents.ph, 0.01)
		beaker_data["currentVolume"] = round(beaker.reagents.total_volume, CHEMICAL_VOLUME_ROUNDING)
		var/list/beakerContents = list()
		if(length(beaker.reagents.reagent_list))
			for(var/datum/reagent/reagent as anything in beaker.reagents.reagent_list)
				beakerContents += list(list("name" = reagent.name, "volume" = round(reagent.volume, CHEMICAL_VOLUME_ROUNDING)))
		beaker_data["contents"] = beakerContents
	.["beaker"] = beaker_data

// Admin Chem Gun
// Why does the syringe gun exist when this beautiful creation exists. Some might call it balance, I call it hoarding the fun stuff to criminals
/obj/item/gun/chem/admin
	name = "subspace reagent projector"
	desc = "A Central Command modified syringe gun, automatically synthesizes chemical darts, and can be attuned to produce any reagent."
	icon_state = "chemgun"
	inhand_icon_state = "chemgun"
	w_class = WEIGHT_CLASS_NORMAL
	can_muzzle_flash = FALSE
	throw_speed = 3
	throw_range = 7
	force = 4
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	clumsy_check = FALSE
	fire_sound = 'sound/items/syringeproj.ogg'
	time_per_syringe = 5
	syringes_left = 50
	max_syringes = 50
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
	/// How many units of reagent get fired per shot.
	var/reagent_per_shot = 15

/obj/item/gun/chem/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)
	qdel(chambered)
	chambered = new /obj/item/ammo_casing/chemgun/admin(src)

obj/item/gun/chem/admin/examine(mob/user)
	. = ..()
	. += span_notice("Use in hand to synthesize any reagent. Ctrl-Click to set the volume fired per shot. Currently [reagent_per_shot] units.")

/// Lets you instantly (re)attune the gun's reagents to any chemical, at full volume, without needing to physically fill it.
/obj/item/gun/chem/admin/attack_self(mob/user)
	if(!user.client?.holder)
		return
	var/selected_reagent = tgui_input_list(user, "Select reagent", "Reagent", GLOB.name2reagent)
	if(!selected_reagent)
		return
	var/datum/reagent/input_reagent = GLOB.name2reagent[selected_reagent]
	if(!input_reagent)
		return
	reagents.clear_reagents()
	reagents.add_reagent(input_reagent, reagents.maximum_volume)
	to_chat(user, span_notice("\The [src] hums as it synthesizes a fresh batch of [initial(input_reagent.name)]."))

/// Lets you adjust how many units of reagent get fired with each shot.
/obj/item/gun/chem/admin/item_ctrl_click(mob/user)
	if(!user.client?.holder)
		return NONE
	var/new_amount = tgui_input_number(user, "Set reagent volume fired per shot", "Reagent Per Shot", reagent_per_shot, 1000, 1)
	if(isnull(new_amount))
		return
	reagent_per_shot = new_amount
	to_chat(user, span_notice("\The [src] now fires [reagent_per_shot]u of reagent per shot."))
	return CLICK_ACTION_SUCCESS

// New Dart for our chemgun
/obj/projectile/bullet/dart/admin
	name = "subspace chem dart"
	icon_state = "cbbolt"
	damage = 0
	embed_type = null
	shrapnel_type = null
	inject_flags = INJECT_CHECK_PENETRATE_THICK

// The Casing for our dart itself.
/obj/item/ammo_casing/chemgun/admin
	name = "subspace dart synthesiser"
	desc = "A high-power spring, linked to a subspace-fed piercing dart synthesiser."
	projectile_type = /obj/projectile/bullet/dart/admin

// Prepares the casing
/obj/item/ammo_casing/chemgun/admin/ready_proj(atom/target, mob/living/user, quiet, zone_override = "")
	if(!loaded_projectile)
		return
	if(istype(loc, /obj/item/gun/chem/admin))
		var/obj/item/gun/chem/admin/CG = loc//MY SHORTEST VARIABLE YET
		if(CG.syringes_left <= 0)// i dont like it
			return
		CG.reagents.trans_to(loaded_projectile, CG.reagent_per_shot, transferred_by = user)
		loaded_projectile.name = "piercing chemical dart"
		CG.syringes_left--// its too short. size queen vars.
	return ..()

/obj/projectile/bullet/dart/piercing
	inject_flags = INJECT_CHECK_PENETRATE_THICK
// Even more advanced. As if that was possible.
// Riddle me this, batman, if I can analyze gas compositions inside of a pipe from a distance, why can't I health check idiots without the awful modsuit module to do it?
// You can't tell me we have a good reason. Even medhuds have a shit scan. There should really be an on station ranged scanner.
// TODO: make an IC version of this???
/obj/item/healthanalyzer/advanced/admin
	name = "subspace health analyzer"
	icon_state = "health_adv"
	desc = "A hand-held body scanner able to distinguish vital signs of the subject with high accuracy."
	advanced = TRUE
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/healthanalyzer/advanced/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Fuck the original scan, really. I need more detail and less immersion for this thing.
// I might be able to prevent the parent scan from outputting somehow, or with a toggle, but whatever this is significantly better than what we had imo
/obj/item/healthanalyzer/advanced/admin/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(!isliving(interacting_with))// Bail if not body
		return
	admin_diagnostic_scan(interacting_with, user)// Passes the scan to the next proc

// The new diag scan. Puts a block beneath the normal scan with all of the pertinent info without the fluff, as cleanly as we possibly can.
/obj/item/healthanalyzer/advanced/admin/proc/admin_diagnostic_scan(mob/living/target, mob/user)
	var/list/report = list("<span class='info'><b>Diagnostic Addendum for [target] ([round_timestamp()]):</b></span>")

	if(ishuman(target))// Normal damage and organs
		var/mob/living/carbon/human/human_target = target
		for(var/sorted_slot in GLOB.organ_process_order)
			var/obj/item/organ/organ = human_target.get_organ_slot(sorted_slot)
			if(!organ)
				continue
			var/percent = round((organ.damage / organ.maxHealth) * 100, 0.1)
			report += "<span class='info ml-1'>[capitalize(organ.name)]: [percent]% damaged (raw: [organ.damage]/[organ.maxHealth])</span>"

	if(length(target.diseases))// Diseases
		report += "<span class='alert ml-1'>Diseases:</span>"
		for(var/datum/disease/disease as anything in target.diseases)
			report += "<span class='alert ml-2'>&rdsh; [disease.name] (Stage [disease.stage]/[disease.max_stages])</span>"

	if(target.reagents && length(target.reagents.reagent_list))// Reagents
		report += "<span class='notice ml-1'>Reagents:</span>"
		for(var/datum/reagent/reagent as anything in target.reagents.reagent_list)
			report += "<span class='notice ml-2'>&rdsh; [reagent.name]: [round(reagent.volume, 0.1)]u</span>"

	if(target.mind)// If there is a client connected
		report += "<span class='notice ml-1'>Mind: [target.mind.name] (Key: [target.mind.key || "None"])</span>"
		if(length(target.mind.antag_datums))// Bonus check for if there is an antagonist datum in this body.
			report += "<span class='alert ml-1'>Antagonist roles:</span>"
			for(var/datum/antagonist/antag as anything in target.mind.antag_datums)
				report += "<span class='alert ml-2'>&rdsh; [antag.name]</span>"

	report += "<span class='notice ml-1'>Status: [target.stat == CONSCIOUS ? "Conscious" : target.stat == UNCONSCIOUS ? "Unconscious" : target.stat == DEAD ? "Dead" : "Unknown"]</span>"
	if(user.client.holder)// Secures CKEY data behind holder check.
		report += "<span class='notice ml-1'>Client: [target.client ? "Connected ([target.client.ckey])" : "No client attached"]</span>"

	to_chat(user, custom_boxed_message("purplebox_box", report.Join("<br>")))//ourple,,,

// More QOL. Makes it work at range.
// Left click at distance
/obj/item/healthanalyzer/advanced/admin/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom(interacting_with, user, modifiers)

// Right click at distance.
/obj/item/healthanalyzer/advanced/admin/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom_secondary(interacting_with, user, modifiers)

// Chem analyzer with some of the same tuneups as above
/obj/item/ph_meter/admin
	name = "subspace chemical analyzer"
	icon_state = "pHmeter"
	icon = 'icons/obj/medical/chemical.dmi'
	desc = "A hand-held body scanner able to distinguish vital signs of the subject with high accuracy."
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS

/obj/item/ph_meter/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// More QOL. Makes it work at range.
// Left click at distance
/obj/item/ph_meter/admin/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom(interacting_with, user, modifiers)

// Right click at distance.
/obj/item/ph_meter/admin/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom_secondary(interacting_with, user, modifiers)

// I finally have a good idea for the multitool.
// Buffer slots. Hell yeah.
/obj/item/multitool/admin
	name = "subspace multitool"
	desc = "An administrative-grade multitool with a small subspace buffer bank, holding seven buffers instead of one."
	icon = 'modular_nova/modules/admin_tech/icons/admin_items.dmi'
	icon_state = "multitool"
	inhand_icon_state = "multitool"
	apc_scanner = FALSE
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ADMIN
	resistance_flags = INDESTRUCTIBLE
	obj_flags = ADMIN_OBJ_FLAGS
	/// Named buffer slots. Assoc slot_name -> stored buffer datum.
	var/list/buffer_slots
	/// Which slot is currently mirrored into `buffer`.
	var/active_slot = "Slot 1"

/obj/item/multitool/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)
	buffer_slots = list("Slot 1" = null, "Slot 2" = null, "Slot 3" = null, "Slot 4" = null, "Slot 5" = null, "Slot 6" = null, "Slot 7" = null)// seven fits a radial

/obj/item/multitool/admin/examine(mob/user)
	. = ..()
	. += span_notice("Use in hand to select a buffer slot. Currently on [active_slot].")

/obj/item/multitool/admin/Destroy()
	for(var/slot_name in buffer_slots)
		var/datum/stored = buffer_slots[slot_name]
		if(stored)
			UnregisterSignal(stored, COMSIG_QDELETING)
	buffer_slots = null
	return ..()

/obj/item/multitool/admin/examine(mob/user)
	. = ..()
	. += span_notice("Use in hand to switch between its [length(buffer_slots)] buffer slots. Currently on [active_slot].")

/obj/item/multitool/admin/set_buffer(datum/new_buffer)
	. = ..()
	if(buffer_slots[active_slot])
		UnregisterSignal(buffer_slots[active_slot], COMSIG_QDELETING)
	buffer_slots[active_slot] = buffer
	if(buffer)
		RegisterSignal(buffer, COMSIG_QDELETING, PROC_REF(on_slot_buffer_deleted))

/obj/item/multitool/admin/proc/on_slot_buffer_deleted(datum/source)
	SIGNAL_HANDLER
	for(var/slot_name in buffer_slots)
		if(buffer_slots[slot_name] == source)
			buffer_slots[slot_name] = null
	if(buffer == source)
		buffer = null

/obj/item/multitool/admin/attack_self(mob/user, list/modifiers)
	var/list/choices = list()
	for(var/slot_name in buffer_slots)
		var/image/radial_image = image(icon = icon, icon_state = icon_state)
		radial_image.maptext = MAPTEXT("<span style='color:[slot_name == active_slot ? "#00ff00" : "#ffffff"]'>[copytext(slot_name, 6)]</span>")
		choices[slot_name] = radial_image

	var/picked = show_radial_menu(user, src, choices, custom_check = CALLBACK(src, PROC_REF(check_radial_menu), user), require_near = TRUE)
	if(!picked)
		return
	active_slot = picked
	buffer = buffer_slots[active_slot]
	balloon_alert(user, "[picked]: [buffer ? "[buffer]" : "empty"]")

/obj/item/multitool/admin/proc/check_radial_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	if(user.get_active_held_item() != src)
		return FALSE
	return TRUE
