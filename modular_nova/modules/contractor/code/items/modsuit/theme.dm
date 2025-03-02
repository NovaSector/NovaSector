/datum/mod_theme/contractor
	name = "contractor"
	desc = "A MODSuit developed as a joint venture of Cybersun Industries and the Gorlex Marauders; standard-issue for Syndicate contractors."
	extended_desc = "A rare departure from the Syndicate's usual color scheme, the Contractor MODsuit is produced and manufactured \
		for specialty contractors, built for travelling and fighting light, providing no encumberance when deactivated, but slight encumberance otherwise. \
		The external plating is composed of streamlined layers of shaped plastitanium and composite ceramic, \
		while the undersuit is lined with an ablative kevlar hybrid weave to provide ample protection to the user where the plating doesn't. \
		Unfortunately, the sacrifices made for a lightweight build mean that it is slightly less armored than its crimson siblings. \
		In addition, it has an integrated chameleon system, allowing you to disguise the suit while undeployed. \
		A small tag hangs off of it, reading 'Property of the Gorlex Marauders, with assistance from Cybersun Industries. \
		All rights reserved, tampering with suit will void warranty.'"
	default_skin = "contractor"
	armor_type = /datum/armor/mod_theme_contractor
	resistance_flags = FIRE_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_deployed = 0.5
	ui_theme = "syndicate"
	inbuilt_modules = list(/obj/item/mod/module/armor_booster/contractor, /obj/item/mod/module/chameleon/contractor)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/energy/sword,
		/obj/item/shield/energy,
	)
	variants = list(
		"contractor" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/contractor/icons/modsuit.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/contractor/icons/worn_modsuit.dmi',
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

/datum/armor/mod_theme_contractor
	melee = 15
	bullet = 20
	laser = 15
	energy = 15
	bomb = 35
	bio = 100
	fire = 80
	acid = 90
	wound = 25
