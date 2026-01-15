/datum/mod_theme/paragon
	name = "tarkon"
	desc = "Blah blah yap yap"
	extended_desc = "If you see this it worked"
	default_skin = "paragon"
	armor_type = /datum/armor/mod_theme_paragon
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	slowdown_deployed = 0.5
	allowed_suit_storage = list(
		/obj/item/crowbar/power/paramedic,
		/obj/item/defibrillator/compact,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/sensor_device,
		/obj/item/stack/medical,
		/obj/item/storage/bag/bio,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/pill_bottle,
	)
	variants = list(
		"paragon" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/donator/obj/clothing/modsuit.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/donator/mob/clothing/modsuit.dmi',
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

/datum/armor/mod_theme_paragon
	melee = 25
	bullet = 15
	laser = 20
	energy = 15
	bomb = 10
	bio = 100
	fire = 100
	acid = 25
	wound = 10
