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
			RESKIN_ICON_STATE = "security",
			RESKIN_WORN_ICON_STATE = "security"
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

/datum/storage/holster/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	. = ..()
	if(length(holdables))
		set_holdable(holdables)
		return

	set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/food/grown/banana,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/ballistic/rifle/boltaction, //fits if you make it an obrez
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/e_gun/hos,
		// NOVA EDIT ADDITION START
		/obj/item/ammo_box/magazine, // Just magazine, because the sec-belt can hold these aswell
		/obj/item/ammo_box/speedloader,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/glock,
		// NOVA EDIT ADDITION END
	))

/obj/item/storage/belt/holster/detective
	name = "detective's holster"
	desc = "A holster able to carry handguns and extra ammo, thanks to an additional hand-sewn pouch. WARNING: Badasses only."

/datum/storage/holster/detective
	max_slots = 4

/datum/storage/holster/detective/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	holdables = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/ammo_box/magazine/m9mm, // Pistol magazines.
		/obj/item/ammo_box/magazine/m9mm_aps,
		/obj/item/ammo_box/magazine/m10mm,
		/obj/item/ammo_box/magazine/m45,
		/obj/item/ammo_box/magazine/m50,
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box/speedloader, // Speedloaders, which includes stripper clips on a technicality.
		/obj/item/ammo_box/magazine/toy/pistol,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/e_gun/hos,
		/obj/item/gun/ballistic/rifle/boltaction, //fits if you make it an obrez
		// NOVA EDIT ADDITION START
		/obj/item/ammo_box/magazine,
		/obj/item/food/grown/banana,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/glock,
		// NOVA EDIT ADDITION END
	)

	return ..()

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
	attempt_remove(gun_to_draw, get_turf(to_show))
	playsound(resolve_parent, 'modular_nova/modules/sec_haul/sound/holsterout.ogg', 50, TRUE, -5)
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

/obj/item/clothing/gloves/krav_maga/sec
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
