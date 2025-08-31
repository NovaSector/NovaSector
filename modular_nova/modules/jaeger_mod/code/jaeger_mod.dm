/datum/mod_theme/jaeger_med
	name = "modular infantry"
	desc = "A medium Infantry-pattern Jaeger/MOD power-assisted combat exoskeleton designed for use in non-vacuum environments."
	extended_desc = "A second-and-a-half generation exoskeleton somewhere between unassisted combat exoskeletons and proper modular suits, \
		the Jaeger/MOD series of power-assisted combat exoskeletons is an odd middle child in military-funded pursuits of personal protection. \
		Thanks to continued long-term support, Jaeger/MOD exoskeletons are compatible with most, if not all, MOD modules compliant with \
		current attachment standards, in return for no longer supporting attachments \
		from previous generations of combat exoskeletons... and not being spaceproof.<br><br>\
		The JAEGER/MOD|INFT/M Infantry-pattern exoskeleton features a sealed helmet with \
		integrated ballistic visor and moderate full-body armor. \
		The medium armor load does allow for some supplementary module installation \
		compared to its more heavily armored brethren, but less than lighter models."
	default_skin = "infantry"
	armor_type = /datum/armor/mod_theme_infantry
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	siemens_coefficient = 0.25
	complexity_max = DEFAULT_MAX_COMPLEXITY - 5
	slowdown_deployed = 0.25 // todo servo module that reduces slowdown to 0 but increases power draw
	inbuilt_modules = list() // servo module, user-config insignia
	variants = list(
		"infantry" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/jaeger_mod/icons/obj/infantry.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/jaeger_mod/icons/obj/infantry.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSEYES|HEADCOVERSMOUTH|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_infantry
	melee = 40
	bullet = 50
	laser = 30
	energy = 40
	bomb = 40
	bio = 50
	fire = 50
	acid = 60
	wound = 20

/obj/item/mod/control/pre_equipped/jaeger_med
	theme = /datum/mod_theme/jaeger_med
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/quick_cuff,
	)

/*
tgmc medium armor values: (MELEE = 45, BULLET = 65, LASER = 65, ENERGY = 55, BOMB = 50, BIO = 50, FIRE = 50, ACID = 55)
/datum/armor/suit_armor
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/datum/armor/armor_bulletproof
	melee = 15
	bullet = 60
	laser = 10
	energy = 10
	bomb = 40
	fire = 50
	acid = 50
	wound = 20
*/
