/obj/item/mod/control/pre_equipped/moonlight
	theme = /datum/mod_theme/moonlight
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/storage,
		/obj/item/mod/module/tether,
	)
	default_pins = list(
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/tether,
	)

/datum/mod_theme/moonlight
	name = "moonlight"
	desc = "A suit with roots deep in spacer culture, no two are identical in construction and each is personalized for its own user."
	extended_desc = "A wide helmet for seeing much as possible, and a build that affords the highest flexibility \
		possible. A practical design that, much like the crab, most deep spacers' suits end up evolving towards. \
		Your suit is, of course, one of the most important things you can own as a spacer. This leads to many being \
		personalized and decorated extensively."
	default_skin = "moonlight"
	ui_theme = "neutral"
	armor_type = /datum/armor/mod_theme_moonlight
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0.25
	complexity_max = DEFAULT_MAX_COMPLEXITY - 3 // 12
	charge_drain = DEFAULT_CHARGE_DRAIN * 0.8
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/flashlight,
		/obj/item/gun,
		/obj/item/melee,
		/obj/item/tank/internals,
		/obj/item/storage/belt/holster,
		/obj/item/construction,
		/obj/item/fireaxe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/storage/medkit,
	)
	variants = list(
		"moonlight" = list(
			MOD_ICON_OVERRIDE = 'modular_doppler/special_modsuits/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_doppler/special_modsuits/icons/mod_worn.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
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

/obj/item/mod/control/pre_equipped/orbiter
	theme = /datum/mod_theme/orbiter
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/storage,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/clamp,
	)
	default_pins = list(
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/tether,
	)

/datum/mod_theme/orbiter
	name = "orbiter"
	desc = "A heavy suit often used in orbital mining operations or Jovian fuel collection."
	extended_desc = "While lighter suits are often preferred in orbit, many types of work simply demand \
		something heavier. Featuring a large monocular camera for vision, and heavier plating than your average \
		spacer's suit, this type makes you at least feel safer between the ten-thousand ton spinning balls of rock."
	default_skin = "orbiter"
	ui_theme = "neutral"
	armor_type = /datum/armor/mod_theme_orbiter
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0.25
	slowdown_deployed = 1.25
	complexity_max = DEFAULT_MAX_COMPLEXITY
	charge_drain = DEFAULT_CHARGE_DRAIN
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/flashlight,
		/obj/item/gun,
		/obj/item/melee,
		/obj/item/tank/internals,
		/obj/item/storage/belt/holster,
		/obj/item/construction,
		/obj/item/fireaxe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/storage/medkit,
	)
	variants = list(
		"orbiter" = list(
			MOD_ICON_OVERRIDE = 'modular_doppler/special_modsuits/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_doppler/special_modsuits/icons/mod_worn.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
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

/datum/armor/mod_theme_moonlight
	melee = ARMOR_LEVEL_TINY
	bullet = ARMOR_LEVEL_TINY
	laser = ARMOR_LEVEL_WEAK
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	bio = 100
	fire = 100
	acid = ARMOR_LEVEL_MID
	wound = WOUND_ARMOR_WEAK

/datum/armor/mod_theme_orbiter
	melee = ARMOR_LEVEL_WEAK + 10
	bullet = ARMOR_LEVEL_WEAK
	laser = ARMOR_LEVEL_WEAK
	energy = ARMOR_LEVEL_WEAK
	bomb = ARMOR_LEVEL_MID
	bio = 100
	fire = 100
	acid = ARMOR_LEVEL_MID
	wound = WOUND_ARMOR_STANDARD
