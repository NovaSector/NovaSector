/datum/mod_theme/loader
	slot_flags = ITEM_SLOT_BELT
	inbuilt_modules = list(
		/obj/item/mod/module/hydraulic,
		/obj/item/mod/module/clamp/loader,
		/obj/item/mod/module/magnet,
		/obj/item/mod/module/storage/civilian,
	)

/datum/mod_theme/civilian
	slot_flags = ITEM_SLOT_BELT
	inbuilt_modules = list(/obj/item/mod/module/storage/civilian)


/// FOR MODSUIT DIGI SKINS GO TO THIS FILE!
// modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing_mutant.dmi

/datum/mod_theme/syndicate/deepspace
	name = "deepspace"
	default_skin = "deepspace"
	variants = list(
		"deepspace" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"synditech" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"enforcer" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"cybersun" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/mod_theme/elite/admiral
	name = "admiral"
	default_skin = "admiral"
	variants = list(
		"admiral" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		), "admiral-cybersun" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/mod_theme/security
	variants = list(
		"security" = list(
				MOD_ICON_OVERRIDE = 'icons/obj/clothing/modsuit/mod_clothing.dmi',
				MOD_WORN_ICON_OVERRIDE = 'icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH,
				SEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"bluesec" = list(
				MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
				MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH,
				SEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/mod_theme/safeguard
	variants = list(
		"safeguard" = list(
				MOD_ICON_OVERRIDE = 'icons/obj/clothing/modsuit/mod_clothing.dmi',
				MOD_WORN_ICON_OVERRIDE = 'icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"blue-safeguard" = list(
				MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
				MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/mod_theme/frontier_colonist
	name = "frontier hazard protective"
	desc = "An unusual design of suit, in reality being no more than a slim underlayer with a built-in coat and sealed helmet."
	extended_desc = "The pinnacle of cheap frontier technology. Suits like this are usually not unified in design \
		though are common in frontier settlements with less than optimal infrastructure. As with most unofficial \
		designs, there are flaws and no single one is perfect, but they achieve a singular goal and that is the \
		important part. Suits such as these are made specifically for the rare emergency that creates a hazard \
		environment that other equipment just can't quite handle. Often, these suits are able to protect their users \
		from not only electricity, but also temperature differences, and especially pressure ones. It will not, \
		however, protect you from yourself."

	default_skin = "colonist"
	armor_type = /datum/armor/colonist_hazard
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY - 8 // Just enough to fit the kinesis module, for the deadspace larp.
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.3
	slowdown_deployed = 0
	slot_flags = ITEM_SLOT_BELT
	inbuilt_modules = list(
		/obj/item/mod/module/storage/civilian,
		/obj/item/mod/module/joint_torsion/permanent
	)
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/flashlight,
		/obj/item/gun,
		/obj/item/melee,
		/obj/item/tank/internals,
		/obj/item/storage/belt/holster,
		/obj/item/construction,
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/storage/medkit,
	)
	variants = list(
		"colonist" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/mod_theme/voskhod
	name = "refitted voskhod"
	desc = "A Heliostatic Coalition standard-issue heavy duty suit, designed for fortified positions operation and humanitarian aid."
	extended_desc = "A more expensive, yet more versatile replacement of the dated Voskhod powered armor, designed by the Magellanic Economic Corporate Union researchers \
		in collaboration with and for the needs of the Heliostatic Coalition. An efficient implementation of mixed exoskeletons in between and underneath its armor plating \
		allows for an unprecedented level of protection through an overly abundant use of durathread-backed plasteel plating; and the remnant materials of its predecessor allow for \
		a dubiously efficient dissipation of any stray photon ray or a concentrated laser, were one to get hit by them. The suit's infamous autoparamedical systems \
		are also fully present - or their chemical synthesizing part, consisting of a thin web of subdermal autoinjectors, reaction cameras and tubes lined through the \
		insulation material - leading into its control unit where the relevant synthesis proceeds, mainly out of raw materials of the pharmaceutical industry; \
		omnizine's older brother, protozine. The sight of a white-and-green juggernaut is the one that instills many fears into numerous pirates; earning it the reputation of a peacekeeper \
		and a niche amongst the rimworld population."
	default_skin = "voskhod"
	armor_type = /datum/armor/mod_theme_voskhod
	complexity_max = DEFAULT_MAX_COMPLEXITY //Five of which is occupied by the in-builts, thus it's closer to 10
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	inbuilt_modules = list(
		/obj/item/mod/module/status_readout/operational/voskhod,
		/obj/item/mod/module/auto_doc,
	)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"voskhod" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_voskhod
	melee = 30
	bullet = 40
	laser = 20
	energy = 30
	bomb = 30
	bio = 30
	fire = 80
	acid = 85
	wound = 20

/datum/mod_theme/tarkon
	name = "tarkon"
	desc = "A Tarkon Industries general protection suit, designed for port security and general EVA situations."
	extended_desc = "A fourth-generation modular protection suit outfitted by Tarkon Industries, This suit is a safety \
		standard for employees undertaking atmos-sensitive tasks. Offering enough protection against impacts to mitigate \
		most damage from cave-ins, its design has already been credited with saving dozens of employees from hazardous and unpredictable \
		situations in both organic and inorganic forms."
	default_skin = "tarkon"
	armor_type = /datum/armor/mod_theme_tarkon
	complexity_max = DEFAULT_MAX_COMPLEXITY + 5
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	inbuilt_modules = list(/obj/item/mod/module/magboot/advanced)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"tarkon" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				UNSEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_INVISIBILITY = HIDEHAIR|HIDEEYES|HIDESNOUT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_tarkon
	melee = 25
	bullet = 15
	laser = 20
	energy = 15
	bomb = 10
	bio = 100
	fire = 100
	acid = 25
	wound = 10

/////////// Prototype Hauler Suit
/datum/mod_theme/prototype/hauler
	name = "Prototype: Hauler"
	desc = "Bulky and quite heavy, this prototype modular suit has seemingly been modified quite a bit with additional supports \
		to distribute its weight. The servos there within have been modified to handle the additional stress, though the looseness \
		of the wiring necessitated a rubber-lined internal insulation layer."
	inbuilt_modules = list()
	charge_drain = DEFAULT_CHARGE_DRAIN * 3
	siemens_coefficient = 0
	slowdown_deployed = 1

/datum/mod_theme/blueshield
	name = "praetorian"
	desc = "A prototype of the Magnate-class suit issued to station Blueshields, still boasting exceptional protection worthy of an honor guard."
	extended_desc = "A prototype of the Magnate-class suit issued for use with the station Blueshields, \
		it boasts the exceptional protection of its successor, while sacrificing some of the module capacity.\
		All of the protection of the Magnate, with none of the comfort! The visor uses blue-light to obscure \
		the face of its wearer, adding to its imposing figure. Compared to the sleek and luxurious design \
		that came after it, this suit does nothing to hide its purpose, the reinforced plating layered \
		over the insulated inner armor granting it protection against corrosive liquids, explosive blasts, \
		fires, electrical shocks, and contempt from the rest of the crew."

	default_skin = "praetorian"
	armor_type = /datum/armor/mod_theme_security
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	slowdown_deployed = 0.5
	allowed_suit_storage = list(
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	variants = list(
		"souless" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"artificial" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"praetorian" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/mod_theme/interdyne
	variants = list(
		"interdyne" = list(
				MOD_ICON_OVERRIDE = 'icons/obj/clothing/modsuit/mod_clothing.dmi',
				MOD_WORN_ICON_OVERRIDE = 'icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"dyne-guardian" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"dyne-doctor" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		)
	)

/datum/mod_theme/interdyne/nerfed
	armor_type = /datum/armor/mod_theme_interdyne/nerfed
	slowdown_deployed = 0.25
	allowed_suit_storage = list(
		/obj/item/assembly/flash,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/restraints/handcuffs,
		/obj/item/sensor_device,
		/obj/item/shield/energy,
		/obj/item/stack/medical,
		/obj/item/storage/bag/bio,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/pill_bottle,
	)

/datum/armor/mod_theme_interdyne/nerfed
	melee = 5
	bullet = 5
	laser = 5
	energy = 5
	bomb = 10
	bio = 100
	fire = 60
	acid = 75
	wound = 5

// 1 2 3 4 marine corps marine corps

/datum/mod_theme/marines
	name = "marine"
	desc = "Developed by Nanotrasen in collaboration with multiple high-profile contractors, this specialized suit is made for high-intensity combat."
	extended_desc = "A black and blue suit of Nanotrasen design made to be utilized by corporate space marines \
		in active combat situations where standard gear won't cut it. Lightweight composite armor plating over \
		a strong exoskeleton ensures that no speed is sacrificed for protection, and a variety of unique \
		modules keep the wearer efficient during active combat situations. When response teams fail, \
		you're the backup's backup - the desperate measures."
	default_skin = "marine"
	armor_type = /datum/armor/mod_theme_marines
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	resistance_flags = FIRE_PROOF|ACID_PROOF
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_deployed = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 10 //drr drr drr
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/gun/ballistic,
		/obj/item/melee/breaching_hammer,
	)
	variants = list(
		"marine" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi',
			MOD_DIGITIGRADE_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing_mutant.dmi',
			MOD_SNOUT_ICON_OVERRIDE = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing_mutant.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|FLASH_PROTECTION_WELDER,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_marines
	melee = 50
	bullet = 50
	laser = 50
	energy = 50
	bomb = 50
	bio = 100
	fire = 100
	acid = 50
	wound = 20

/datum/mod_theme/marines/damaged //'worn down' nerfed version - better than sec, worse than captain
	desc = "Developed by Nanotrasen in collaboration with multiple high-profile contractors, \
	this specialized suit was made for high-intensity combat. This one, however, has lost quite \
	a bit of intended functionality over the time it's been abandoned."
	armor_type = /datum/armor/mod_theme_security //less armor
	atom_flags = NONE //not explosion proof
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT //not 100% fireproof
	slowdown_deployed = 0.5 //has a slowdown (equal to sec MOD)
	complexity_max = DEFAULT_MAX_COMPLEXITY + 2 //just below antag MODs rather than on-par with admin ones

/datum/mod_theme/marines/noboost /// Marine modsuit that doenst allow you to put an armor booster in it. This makes it better than a base security hardsuit while worse than the HoS's and Captains- assuming those two have boosters in them.
	desc = "Developed by Nanotrasen in collaboration with multiple high-profile contractors, this specialized suit was made for high-intensity combat. This one doesnt allow for an armor booster."

/obj/item/mod/control/pre_equipped/marine
	theme = /datum/mod_theme/marines
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/power_kick,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/springlock/contractor,
		/obj/item/mod/module/dna_lock, //in lieu of req_access
		/obj/item/mod/module/visor/sechud, //for identifying teammates also in suits
	)
	default_pins = list(
		/obj/item/mod/module/holster,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/power_kick,
	)

/obj/item/mod/control/pre_equipped/marine/engineer //smartgunner version of modsuit, with less versatile modules but the ALMIGHTY SMARTGUN
	theme = /datum/mod_theme/marines
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/visor/sechud,
		/obj/item/mod/module/smartgun/marines,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/smartgun/marines,
	)

/obj/item/mod/control/pre_equipped/marine/damaged //'worn down' version, with less armor and no ERT/antag modules
	theme = /datum/mod_theme/marines/damaged
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	//removed modules: noslip, powerkick, megaphone
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/springlock/contractor,
		/obj/item/mod/module/dna_lock, //in lieu of req_access
		/obj/item/mod/module/visor/sechud, //for identifying teammates also in suits
	)
	default_pins = list(
		/obj/item/mod/module/holster,
		/obj/item/mod/module/jetpack,
	)

/obj/item/mod/control/pre_equipped/marine/noboost
	theme = /datum/mod_theme/marines/noboost
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/welding/noboost,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/power_kick,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/springlock/contractor,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/visor/sechud,
	)
	default_pins = list(
		/obj/item/mod/module/holster,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/power_kick,
	)
