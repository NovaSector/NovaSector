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
/obj/item/storage/belt/security
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Basic Variant" = list(
			RESKIN_ICON_STATE = "security",
			RESKIN_WORN_ICON_STATE = "security"
		),
		"Black Variant" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/belts.dmi',
			RESKIN_ICON_STATE = "belt_black",
			RESKIN_WORN_ICON_STATE = "belt_black",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
		),
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/belts.dmi',
			RESKIN_ICON_STATE = "belt_blue",
			RESKIN_WORN_ICON_STATE = "belt_blue",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
		),
		"White Variant" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/belts.dmi',
			RESKIN_ICON_STATE = "belt_white",
			RESKIN_WORN_ICON_STATE = "belt_white",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
		),
	)

/obj/item/storage/belt/security/webbing
	unique_reskin = list(
		"Basic Variant" = list(
			RESKIN_ICON_STATE = "securitywebbing",
			RESKIN_WORN_ICON_STATE = "securitywebbing"
		),
		"Red Variant" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/belts.dmi',
			RESKIN_ICON_STATE = "red_webbing",
			RESKIN_WORN_ICON_STATE = "red_webbing",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
		),
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/belts.dmi',
			RESKIN_ICON_STATE = "blue_webbing",
			RESKIN_WORN_ICON_STATE = "blue_webbing",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'
		),
	)

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
/obj/item/clothing/glasses/hud/security
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red HUD" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "securityhud",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "securityhud"
		),
		"Blue HUD" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "security_hud",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "security_hud"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses
	unique_reskin = null

/obj/item/clothing/glasses/hud/security/prescription
	unique_reskin = null

/obj/item/clothing/glasses/hud/security/sunglasses/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "security_hud_blue_black"
	worn_icon_state = "security_hud_blue_black"
	unique_reskin = list(
		"Dark-Tint Blue Sunglasses" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "security_hud_blue_black",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "security_hud_blue_black"
		),
		"Light-Tint Blue Sunglasses" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "security_hud_blue",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "security_hud_blue"
		),
	)

/obj/item/clothing/glasses/hud/security/night
	unique_reskin = null

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	unique_reskin = list(
		"Red Eyepatches" = list(
			RESKIN_ICON = 'icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON = 'icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "hudpatch"
		),
		"Blue Eyepatches" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "hudpatch"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/gars
	unique_reskin = list(
		"Red Gars" = list(
			RESKIN_ICON_STATE = "gar_sec",
			RESKIN_WORN_ICON_STATE = "gar_sec"
		),
		"Blue Gars" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/glasses.dmi',
			RESKIN_ICON_STATE = "gar_sec",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/eyes.dmi',
			RESKIN_WORN_ICON_STATE = "gar_sec"
		),
	)
/*
* HEAD
*/

/obj/item/clothing/head/hats/hos/cap
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Cap" = list(
			RESKIN_ICON_STATE = "hoscap",
			RESKIN_WORN_ICON_STATE = "hoscap"
		),
		"Blue Cap" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "hoscap_blue",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "hoscap_blue"
		),
		"Sol Cap" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "policechiefcap",
			RESKIN_WORN_ICON_STATE = "policechiefcap"
		),
		"Sheriff Hat" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "cowboyhat_black",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "cowboyhat_black"
		),
		"Wide Sheriff Hat" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "cowboy_black",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "cowboy_black"
		)
	)

/obj/item/clothing/head/hats/hos/cap/syndicate
	uses_advanced_reskins = FALSE
	unique_reskin = null

/*
* GLOVES
*/

/obj/item/clothing/gloves/tackler/security
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "tackle",
			RESKIN_WORN_ICON_STATE = "tackle"
		),
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/gloves.dmi',
			RESKIN_ICON_STATE = "tackle_blue",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/hands.dmi',
			RESKIN_WORN_ICON_STATE = "tackle_blue"
		),
	)

/obj/item/clothing/gloves/kaza_ruk/sec
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "fightgloves",
			RESKIN_WORN_ICON_STATE = "fightgloves"
		),
		"Blue Variant" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/gloves.dmi',
			RESKIN_ICON_STATE = "fightgloves_blue",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/hands.dmi',
			RESKIN_WORN_ICON_STATE = "fightgloves_blue"
		),
	)

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

/obj/item/clothing/suit/armor/hos
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Greatcoat" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "hos",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "hos"
		),
		"Trenchcoat" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "hostrench",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "hostrench"
		),
		"Trenchcloak" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "trenchcloak",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "trenchcloak"
		),
	)

/obj/item/clothing/suit/armor/hos/trenchcoat/winter
	uses_advanced_reskins = FALSE
	unique_reskin = null

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
