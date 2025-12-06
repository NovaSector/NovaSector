/*
*	Overrides some of the security items, giving them more reskin options while avoiding needless conflict or bloat.
*/

/*
* ACCESSORIES
*/
// For consistency with other armbands
/obj/item/clothing/accessory/armband/nonsec
	desc = "An armband, worn to signify proficiency in a skill or association with a department. This one is red."

/*
* BELTS + HOLSTER
*/
/datum/atom_skin/security_belt
	abstract_type = /datum/atom_skin/security_belt

/datum/atom_skin/security_belt
	preview_name = "Basic Variant"
	new_icon_state = "security"

/datum/atom_skin/security_belt/black
	preview_name = "Black Variant"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	new_icon_state = "belt_black"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'

/datum/atom_skin/security_belt/blue
	preview_name = "Blue Variant"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	new_icon_state = "belt_blue"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'

/datum/atom_skin/security_belt/white
	preview_name = "White Variant"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	new_icon_state = "belt_white"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'

/obj/item/storage/belt/security

/obj/item/storage/belt/security/Initialize(mapload)
	. = ..()
	if(type == /obj/item/storage/belt/security || type == /obj/item/storage/belt/security/full) // Exact-type only, don't dupe this on subtypes
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_belt)

/datum/atom_skin/security_webbing
	abstract_type = /datum/atom_skin/security_webbing

/datum/atom_skin/security_webbing/basic
	preview_name = "Basic Variant"
	new_icon_state = "securitywebbing"

/datum/atom_skin/security_webbing/red
	preview_name = "Red Variant"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	new_icon_state = "red_webbing"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'

/datum/atom_skin/security_webbing/blue
	preview_name = "Blue Variant"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	new_icon_state = "blue_webbing"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'

/obj/item/storage/belt/security/webbing

/obj/item/storage/belt/security/webbing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_webbing)

/obj/item/storage/belt/holster
	desc = "A rather plain but still cool looking holster that can hold a handgun and some ammo."

/datum/storage/holster
	max_slots = 3
	max_total_storage = WEIGHT_CLASS_NORMAL + (WEIGHT_CLASS_SMALL * 2) // gun and 2 ammo
	// following "one gun per storage" is taken from secbelts, see modular_nova\master_files\code\game\objects\items\storage\belt.dm
	// shhhould this be a component?
	var/list/limited_hold_types = list(
		/obj/item/gun,
	)
	/// how many restricted items do we already have stored in this belt
	var/limited_held = 0
	/// how many restricted items do we want to keep, at maximum, in this belt
	var/max_limited_store = 1
	rustle_sound = 'modular_nova/modules/sec_haul/sound/holsterin.ogg'
	remove_rustle_sound = 'modular_nova/modules/sec_haul/sound/holsterout.ogg'

/datum/storage/holster/handle_enter(datum/source, obj/item/arrived)
	. = ..()
	if(is_type_in_list(arrived, limited_hold_types))
		limited_held++

/datum/storage/holster/handle_exit(datum/source, obj/item/gone)
	. = ..()
	if(is_type_in_list(gone, limited_hold_types))
		playsound(parent, 'modular_nova/modules/sec_haul/sound/holsterout.ogg', 50, rustle_vary, -5)
		limited_held = max(limited_held - 1, 0)

/datum/storage/holster/can_insert(obj/item/to_insert, mob/user, messages, force)
	. = ..()
	if(is_type_in_list(to_insert, limited_hold_types) && (limited_held >= max_limited_store))
		user.balloon_alert(user, "no suitable space!")
		return FALSE

/datum/storage/holster/energy
	max_slots = 3 // 2 guns and a cell but the cell is handled in a weird way
	max_limited_store = 2 // you only have 2 slots but you might as well be able to hold 2 eguns, y'know
	max_total_storage = (WEIGHT_CLASS_NORMAL * 2) + WEIGHT_CLASS_SMALL
	/// Typecache of things we can charge. If anything we insert is of these types, start processing our parent for charging.
	var/static/list/charge_typecache = typecacheof(list(
		/obj/item/gun/energy,
		/obj/item/ammo_box/magazine/recharge,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman,
		/obj/item/gun/ballistic/automatic/pistol/plasma_thrower,
	))
	/// Typecache of things we ignore when doing an empty check. Because of how get_all_contents and variants includes the source, includes the holster type itself.
	var/static/list/empty_check_typecache = typecacheof(list(
		/obj/item/storage/belt/holster/energy,
		/obj/item/stock_parts/power_store/cell,
	))

/datum/storage/holster/energy/onegun
	max_slots = 2 // 1 gun and 1 cell
	max_limited_store = 1 // as above, 1 gun
	max_total_storage = WEIGHT_CLASS_NORMAL + WEIGHT_CLASS_SMALL

/datum/storage/holster/energy/handle_enter(datum/source, obj/item/arrived)
	. = ..()
	// if the inserted item is in the chargable typecache, start processing
	if(is_type_in_typecache(arrived, charge_typecache))
		START_PROCESSING(SSobj, parent)

/datum/storage/holster/energy/handle_exit(datum/source, obj/item/gone)
	. = ..()
	// if whatever's left is not in the charging typecache (e.g. the cell), do nothing
	if(!is_type_in_typecache(gone, charge_typecache))
		return
	// if we still have things in here, assume we're still capable of charging things
	if(length(parent.get_all_contents_ignoring(empty_check_typecache)))
		return
	STOP_PROCESSING(SSobj, parent)

/obj/item/storage/belt/holster/detective
	name = "detective's holster"
	desc = "A holster able to carry handguns and extra ammo, thanks to an additional hand-sewn pouch. WARNING: Badasses only."

/datum/storage/holster/detective
	max_slots = 4
	max_total_storage = WEIGHT_CLASS_NORMAL + (WEIGHT_CLASS_SMALL * 3) // gun and 3 ammo

///Enables you to quickdraw weapons from security holsters
/datum/storage/holster/open_storage(mob/to_show, can_reach_target)
	var/atom/resolve_parent = parent
	if(!resolve_parent)
		return
	if(isobserver(to_show))
		show_contents(to_show)
		return

	if(!resolve_parent.IsReachableBy(to_show))
		resolve_parent.balloon_alert(to_show, "can't reach!")
		return FALSE

	if(!isliving(to_show) || to_show.incapacitated)
		return FALSE

	var/obj/item/gun/gun_to_draw = locate() in real_location
	if(!gun_to_draw)
		return ..()
	resolve_parent.add_fingerprint(to_show)
	INVOKE_ASYNC(to_show, TYPE_PROC_REF(/mob, put_in_hands), gun_to_draw)
	to_show.visible_message(span_warning("[to_show] draws [gun_to_draw] from [resolve_parent]!"), span_notice("You draw [gun_to_draw] from [resolve_parent]."))

/*
* GLASSES
*/
/datum/atom_skin/security_hudglasses
	abstract_type = /datum/atom_skin/security_hudglasses
	new_icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'

/datum/atom_skin/security_hudglasses/red
	preview_name = "Red HUD"
	new_icon = 'icons/obj/clothing/glasses.dmi'
	new_icon_state = "securityhud"
	new_worn_icon = 'icons/mob/clothing/eyes.dmi'

/datum/atom_skin/security_hudglasses/blue
	preview_name = "Blue HUD"
	new_icon_state = "security_hud"

/obj/item/clothing/glasses/hud/security

/obj/item/clothing/glasses/hud/security/Initialize(mapload)
	. = ..()
	if(type == /obj/item/clothing/glasses/hud/security) // Don't allow duping this on subtypes
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_hudglasses)

/obj/item/clothing/glasses/hud/security/sunglasses
	can_reskin = FALSE

/obj/item/clothing/glasses/hud/security/prescription
	can_reskin = FALSE

/datum/atom_skin/security_hud_sunglasses
	abstract_type = /datum/atom_skin/security_hud_sunglasses

/datum/atom_skin/security_hud_sunglasses/dark
	preview_name = "Dark-Tint Blue Sunglasses"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	new_icon_state = "security_hud_blue_black"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'

/datum/atom_skin/security_hud_sunglasses/light
	preview_name = "Light-Tint Blue Sunglasses"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	new_icon_state = "security_hud_blue"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'

/obj/item/clothing/glasses/hud/security/sunglasses/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "security_hud_blue_black"
	worn_icon_state = "security_hud_blue_black"
	can_reskin = TRUE

/obj/item/clothing/glasses/hud/security/sunglasses/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_hud_sunglasses)

/obj/item/clothing/glasses/hud/security/night
	can_reskin = FALSE

/datum/atom_skin/security_eyepatch
	abstract_type = /datum/atom_skin/security_eyepatch

/datum/atom_skin/security_eyepatch/red
	preview_name = "Red Eyepatches"
	new_icon_state = "hudpatch"

/datum/atom_skin/security_eyepatch/blue
	preview_name = "Blue Eyepatches"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	new_icon_state = "hudpatch"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	can_reskin = TRUE

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_eyepatch)

/datum/atom_skin/sec_gars
	abstract_type = /datum/atom_skin/sec_gars

/datum/atom_skin/sec_gars/red
	preview_name = "Red Gars"
	new_icon_state = "gar_sec"

/datum/atom_skin/sec_gars/blue
	preview_name = "Blue Gars"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	new_icon_state = "gar_sec"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'

/obj/item/clothing/glasses/hud/security/sunglasses/gars
	can_reskin = TRUE

/obj/item/clothing/glasses/hud/security/sunglasses/gars/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/sec_gars)

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga
	can_reskin = FALSE

/*
* HEAD
*/
/datum/atom_skin/hos_cap
	abstract_type = /datum/atom_skin/hos_cap

/datum/atom_skin/hos_cap
	preview_name = "Red Cap"
	new_icon_state = "hoscap"

/datum/atom_skin/hos_cap/blue
	preview_name = "Blue Cap"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	new_icon_state = "hoscap_blue"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'

/datum/atom_skin/hos_cap/sol
	preview_name = "Sol Cap"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	new_icon_state = "policechiefcap"

/datum/atom_skin/hos_cap/sheriff
	preview_name = "Sheriff Hat"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	new_icon_state = "cowboyhat_black"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'

/obj/item/clothing/head/hats/hos/cap

/obj/item/clothing/head/hats/hos/cap/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_cap)

/obj/item/clothing/head/hats/hos/cap/syndicate
	can_reskin = FALSE

/*
* GLOVES
*/
/datum/atom_skin/tackler_gloves
	abstract_type = /datum/atom_skin/tackler_gloves

/datum/atom_skin/tackler_gloves/red
	preview_name = "Red Variant"
	new_icon_state = "tackle"

/datum/atom_skin/tackler_gloves/blue
	preview_name = "Blue Variant"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/gloves.dmi'
	new_icon_state = "tackle_blue"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/hands.dmi'

/obj/item/clothing/gloves/tackler/security

/obj/item/clothing/gloves/tackler/security/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tackler_gloves)

/datum/atom_skin/sec
	abstract_type = /datum/atom_skin/sec

/datum/atom_skin/sec/fightgloves
	preview_name = "Red Variant"
	new_icon_state = "fightgloves"

/datum/atom_skin/sec/fightgloves_blue
	preview_name = "Blue Variant"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/gloves.dmi'
	new_icon_state = "fightgloves_blue"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/hands.dmi'

/obj/item/clothing/gloves/kaza_ruk/sec

/obj/item/clothing/gloves/kaza_ruk/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tackler_gloves)

/*
* UNDER
*/

/obj/item/clothing/under/rank/security // Digitigrade sprites for sec
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/security_digi.dmi'

/*
* SUITS
*/
/obj/item/clothing/suit/armor/vest/alt/sec
	desc = "A Type-II-NT-P armored vest that provides decent protection against most types of damage."

/datum/atom_skin/hos_coat
	abstract_type = /datum/atom_skin/hos_coat

/datum/atom_skin/hos_coat/greatcoat
	preview_name = "Greatcoat"
	new_icon = 'icons/obj/clothing/suits/armor.dmi'
	new_icon_state = "hos"
	new_worn_icon = 'icons/mob/clothing/suits/armor.dmi'

/datum/atom_skin/hos_coat/trenchcoat
	preview_name = "Trenchcoat"
	new_icon = 'icons/obj/clothing/suits/armor.dmi'
	new_icon_state = "hostrench"
	new_worn_icon = 'icons/mob/clothing/suits/armor.dmi'

/datum/atom_skin/hos_coat/trenchcloak
	preview_name = "Trenchcloak"
	new_icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	new_icon_state = "trenchcloak"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'

/obj/item/clothing/suit/armor/hos
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/hos/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_coat)

/obj/item/clothing/suit/armor/hos/trenchcoat/winter
	can_reskin = FALSE

//Standard Bulletproof Vest
/obj/item/clothing/suit/armor/bulletproof
	desc = "A Type-III-NT-P heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Ablative Armor
/obj/item/clothing/suit/hooded/ablative
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/*
* FEET
*/

//Adds special footstep noises
/obj/item/clothing/shoes/jackboots
	clothing_traits = list(TRAIT_SILENT_FOOTSTEPS) // We have other footsteps.

/obj/item/clothing/shoes/jackboots/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_nova/master_files/sound/effects/footstep1.ogg'=1,'modular_nova/master_files/sound/effects/footstep2.ogg'=1, 'modular_nova/master_files/sound/effects/footstep3.ogg'=1), 100)
