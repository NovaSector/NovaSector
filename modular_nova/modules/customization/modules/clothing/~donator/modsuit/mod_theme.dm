//This file and folder is only for donation modsuits.
//If your Donor MODsuit is a reskin of a common MODsuit. Copy the MODsuits attributes from:
//
//modular_nova\master_files\code\modules\mod\mod_theme.dm
//
//If you're trying to make a new modsuit and add in here, be sure to not overpower it.
//
//Make sure the name and other variables are label according to your new modsuit (name, default_skin, [YOUR_SUIT_NAME_HERE] = list)
//MOD_ICON_OVERRIDE and MOD_WORN_ICON_OVERRIDE to the modsuit design you placed in:
//modular_nova/master_files/icons/donator/obj/clothing/modsuit.dmi - Obj
//modular_nova/master_files/icons/donator/mob/clothing/modsuit.dmi - Worn
//
//Besure to add armor value in this file, example: /datum/armor/mod_theme_[YOUR_SUIT_NAME_HERE]
// -- Rilomatic - 16th January 2026

//Kaynite Donor Item

/datum/mod_theme/paragon
	name = "paragon"
	desc = "This semi-artisanal, bleeding edge MODsuit is a symbol of exemplary performance, amplifying the speciality of the user through its durable carapace and a wide variety of utilities, both offensive and defensive."
	extended_desc = "A semi-artisanal, bleeding-edge MODsuit produced by the DeForest Medical Corporation, built upon foundational work by Nakamura Engineering. \
		Designed as a symbol of exemplary performance, the suit amplifies the wearer’s specialty through a durable, \
		acid-resistant carapace and a broad suite of integrated utilities, both offensive and defensive. \
		Advanced filtration and sealing systems render it immune to allergens, airborne toxins, and common pathogens. \
		Its defining strength is speed—high-powered servos and actuators fused into a lightweight carbon-fiber frame allow \
		for exceptional mobility at the cost of minimal armor plating."
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


// Bonkai Donor Item

/datum/mod_theme/jumper
	name = "jumper"
	desc = "An Apadyne Technologies security suit, offering quicker speed at the cost of carrying capacity."
	extended_desc = "An Apadyne Technologies classic, this model of MODsuit has been designed for quick response to \
		hostile situations. These suits have been layered with plating worthy enough for fires or corrosive environments, \
		and come with composite cushioning and an advanced honeycomb structure underneath the hull to ensure protection \
		against broken bones or possible avulsions. The suit's legs have been given more rugged actuators, \
		allowing the suit to do more work in carrying the weight. However, the systems used in these suits are more than \
		a few years out of date, leading to an overall lower capacity for modules."
	default_skin = "jumper"
	armor_type = /datum/armor/mod_theme_jumper
	complexity_max = DEFAULT_MAX_COMPLEXITY - 2
	slowdown_deployed = 0.5
	hearing_protection = EAR_PROTECTION_NORMAL
	allowed_suit_storage = list(
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	variants = list(
		"jumper" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/master_files/icons/donator/obj/clothing/modsuit.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/master_files/icons/donator/mob/clothing/modsuit.dmi',
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

/datum/armor/mod_theme_jumper
	melee = 35
	bullet = 15
	laser = 30
	energy = 40
	bomb = 25
	bio = 100
	fire = 100
	acid = 75
	wound = 20

