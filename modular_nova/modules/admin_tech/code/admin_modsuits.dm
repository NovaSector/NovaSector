// Nova Bluespace Tech Modsuits //
// Debug Modules
/obj/item/mod/module/energy_shield/debug
	shield_icon = "none"
	max_charges = 10
	recharge_start_delay = 5
	charge_increment_delay = 0.5 SECONDS
	charge_recovery = 10
	block_overwhelming_attacks = TRUE

/obj/item/mod/module/infiltrator/debug//Users of this module cannot be inspected, also acts as a weldshield
	incompatible_modules = null

//Modsuit storage modules create their own storage datums, and dont reference a storage datum type
/obj/item/mod/module/storage/admin
	name = "MOD subspace storage module"
	desc = "A storage system developed by CentCom, these compartments employ \
		miniaturized bluespace pockets for the ultimate in storage technology; regardless of the weight of objects put inside."
	icon_state = "storage_large"
	storage_type = /datum/storage/admin

//New and Improved BST Plates, overwriting the old
/datum/mod_theme/bluespace
	name = "bluespace"
	desc = "A suit made of metallic bluespace crystals. Wait, what? Really?"
	extended_desc = "Yeah, okay, I guess you can call that an event. What I consider an event is something actually \
		fun and engaging for the players- instead, most were sitting out, dead or gibbed, while the lucky few got to \
		have all the fun. If this continues to be a pattern for your \"events\" (Admin Abuse) \
		there will be an admin complaint. You have been warned."
	default_skin = "bluespace"
	armor_type = /datum/armor/admin
	resistance_flags = INDESTRUCTIBLE|LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	complexity_max = 1000
	charge_drain = DEFAULT_CHARGE_DRAIN * 0
	siemens_coefficient = 0
	slowdown_deployed = 0
	activation_step_time = MOD_ACTIVATION_STEP_TIME * 0.01
	hearing_protection = EAR_PROTECTION_FULL
	allowed_suit_storage = list(
		/obj/item,
	)
	variants = list(
		"bluespace" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/obj/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/mob/mod_clothing.dmi',
//			MOD_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/obj/clothing/modsuit/mod_clothing.dmi',
//			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/mob/clothing/modsuit/mod_clothing.dmi',
//			MOD_DIGITIGRADE_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/mob/clothing/modsuit/mod_clothing_mutant.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

//New Bluespace Tech Modsuit
/obj/item/mod/control/pre_equipped/bluespace
	theme = /datum/mod_theme/bluespace
	starting_frequency = MODLINK_FREQ_CENTCOM
	applied_core = /obj/item/mod/core/infinite
	applied_modules = list(
		/obj/item/mod/module/storage/admin,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/stealth/ninja,
		/obj/item/mod/module/quick_carry/advanced,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/anomaly_locked/kinesis/admin,
		/obj/item/mod/module/shove_blocker,
		/obj/item/mod/module/quick_cuff,
	)
	default_pins = list(
		/obj/item/mod/module/stealth/ninja,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/anomaly_locked/kinesis/admin,
	)


//Subspace plates
/datum/mod_theme/subspace
	name = "subspace"
	desc = "A suit made of the condensed essence of suffering caused by thousands of ahelps."
	extended_desc = "Yeah, okay, I guess you can call that an event. What I consider an event is something actually \
		fun and engaging for the players- instead, most were sitting out, dead or gibbed, while the lucky few got to \
		have all the fun. If this continues to be a pattern for your \"events\" (Admin Abuse) \
		there will be an admin complaint. You have been warned."
	default_skin = "subspace"
	armor_type = /datum/armor/admin/badmin
	resistance_flags = INDESTRUCTIBLE|LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	complexity_max = 1000
	charge_drain = DEFAULT_CHARGE_DRAIN * 0
	siemens_coefficient = 0
	slowdown_deployed = 0
	activation_step_time = MOD_ACTIVATION_STEP_TIME * 0.01
	hearing_protection = EAR_PROTECTION_FULL
	allowed_suit_storage = list(
		/obj/item,
	)
	variants = list(
		"subspace" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/obj/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/mob/mod_clothing.dmi',
//			MOD_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/obj/clothing/modsuit/mod_clothing.dmi',
//			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/mob/clothing/modsuit/mod_clothing.dmi',
//			MOD_DIGITIGRADE_ICON_OVERRIDE = 'modular_nova/modules/admin_tech/icons/mob/clothing/modsuit/mod_clothing_mutant.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

//The Subspace Technician's Modsuit. Lots of frills.
/obj/item/mod/control/pre_equipped/subspace
	theme = /datum/mod_theme/subspace
	starting_frequency = MODLINK_FREQ_CENTCOM
	applied_core = /obj/item/mod/core/infinite
	applied_modules = list(
		/obj/item/mod/module/storage/admin,
		/obj/item/mod/module/infiltrator/debug,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/energy_shield/debug,
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
		/obj/item/mod/module/timeline_jumper,
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
