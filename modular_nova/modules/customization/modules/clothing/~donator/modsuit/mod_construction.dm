//This file and folder is only for donation modsuits.
//Follow the same methods below and make sure that 'icon_state' label as [YOUR_SUIT_NAME_HERE]-plating.
//The game will load it but will not load the icon as it will label it as [YOUR_SUIT_NAME_HERE]-plating. Unsure why, best guess is due to TG modsuit code
//It will take the name variable from mod_theme.dm and merge it with a static "plating" thus the icon_state naming.
//DO: Coolsuit-plating.
//DONT: Coolsuit-box / coolsuit-box-plating / coolsuit.
//Make sure that your plating .dmi icon is also labeled the same way.
//Remember to add your MODsuit variables in ~donator\modsuit\mod_theme.dm.
// -- Rilomatic - 15th January 2026

//Limitations - Entombed MODsuits - Logic wise we can't take off the suit, nor we can craft a new entomed suit / crafting recipe might kill the player
//									Best choice is to use skin_applier - View Akari Modsuit (Entombed) for code in:
//									modular_nova\modules\customization\modules\clothing\~donator\donator_items.dm
// -- Rilomatic - 16th January 2026

// == SKIN_APPLIER ==
// To Isolate skin from being shared. Include this in your skin_applier
//
//	var/datum/mod_theme/[YOUR_SUIT_NAME_HERE] = new mod.theme.type
//	[YOUR_SUIT_NAME_HERE].variants = mod.theme.variants.Copy()
//	mod.theme = [YOUR_SUIT_NAME_HERE]

// To change the name and description of modsuit with a skin_applier.
// mod.name =
// mod.desc =
// -- Rilomatic - 29th January 2026

// Line 29 - 73 -- Needed for modsuit to work as a modsuit or prepare to hear runtime meows
/obj/item/mod/control/donor
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	/// The skin we apply to the suit, defaults to the default_skin of the theme.
	var/applied_skin
	/// The MOD core we apply to the suit.
	var/applied_core = /obj/item/mod/core/standard
	/// The cell we apply to the core. Only applies to standard core suits.
	var/applied_cell = /obj/item/stock_parts/power_store/cell/super
	/// List of modules we spawn with.
	var/list/applied_modules = list()
	/// Modules that we pin when the suit is installed for the first time, for convenience, can be applied or theme inbuilt modules.
	var/list/default_pins = list()

/obj/item/mod/control/donor/Initialize(mapload, new_theme, new_skin, new_core)
	// Create instance copy from the TYPE definition, not the instance variable
	var/list/new_pins = list()
	for(var/module_to_pin in initial(default_pins))
		new_pins[module_to_pin] = list()
	default_pins = new_pins

	if(!new_skin)
		new_skin = applied_skin
	if(!new_core)
		new_core = new applied_core(src)
		if(istype(new_core, /obj/item/mod/core/standard))
			var/obj/item/mod/core/standard/cell_core = new_core
			if(applied_cell)
				cell_core.cell = new applied_cell()
	. = ..()
	for(var/module_type in applied_modules)
		var/obj/item/mod/module/new_module = new module_type(src)
		install(new_module)

/obj/item/mod/control/donor/set_wearer(mob/living/carbon/human/user)
	. = ..()
	if(!wearer)
		return
	var/wearer_ref = REF(wearer)
	for(var/obj/item/mod/module/module in modules)
		var/list/pinned_list = default_pins[module.type]
		if(!pinned_list) //this module isnt meant to be pinned by default
			continue
		if(wearer_ref in pinned_list) //if we already had pinned once to this user, don care anymore
			continue
		pinned_list += wearer_ref
		module.pin(wearer)

/obj/item/mod/control/donor/uninstall(obj/item/mod/module/old_module, deleting)
	. = ..()
	default_pins -= old_module.type

//Kaynite Donor Item

//Adding paragon as a object - Needed for crafting recipe
/obj/item/mod/control/donor/paragon
	theme = /datum/mod_theme/paragon
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/health_analyzer,
		/obj/item/mod/module/injector,
	)

//Plating - Constuction from scratch
/obj/item/mod/construction/plating/paragon
	name = "\improper Paragon Plating"
	desc = "A sturdy black storage container wrapped with yellow tape label 'VOID IF TEMPERED, DO NOT PAINT OVER LABEL.” Barcodes, manufacturing details, and safety warnings are stenciled along its sides. \
		Within the box contains several conversion parts packed neatly within shape foam, a distinctive glass like helmet visor made out of synthetic crystal laminate with electrical polarized lens matrix, and a manual with detailed instruction \
		necessary to create the Paragon MODsuit."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "paragon-plating"
	theme = /datum/mod_theme/paragon

//Skinapplier - For pre-equipped MODsuits
/obj/item/mod/skin_applier/paragon
	name = "\improper Homo Ludens Parts kit 'Paragon'"
	desc = "A sturdy black storage container wrapped with yellow tape label 'VOID IF TEMPERED, DO NOT PAINT OVER LABEL.” Barcodes, manufacturing details, and safety warnings are stenciled along its sides. \
		Within the box contains several conversion parts packed neatly within shape foam, a distinctive glass like helmet visor made out of synthetic crystal laminate with electrical polarized lens matrix, and a manual with detailed instruction \
		necessary to create the Paragon MODsuit."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "paragon-plating"
	skin = "paragon"
	var/list/variant_data = list(
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
	)

/obj/item/mod/skin_applier/paragon/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/item/mod/control/pre_equipped/medical))
		return ..()
	var/obj/item/mod/control/mod = interacting_with
	if(skin in mod.theme.variants)
		return ..()
	//Skin Isolation from being shared.
	var/datum/mod_theme/paragon = new mod.theme.type
	paragon.variants = mod.theme.variants.Copy()
	mod.theme = paragon
	mod.theme.variants[skin] = variant_data
	//Changes pre-equip modsuit name and description to custom.
	mod.name = "\improper Homo Ludens Modsuit 'Paragon'"
	mod.desc = "This semi-artisanal, bleeding edge MODsuit is a symbol of exemplary performance, \
				amplifying the speciality of the user through its durable carapace and a wide variety of utilities, both offensive and defensive."
	return ..()

// Bonkaitheroris (Bonkai) Donor Item

//Adding jumper as a object - Needed for crafting recipe
/obj/item/mod/control/donor/jumper
	theme = /datum/mod_theme/jumper
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/pepper_shoulders,
		/obj/item/mod/module/criminalcapture,
		/obj/item/mod/module/quick_cuff,
		/obj/item/mod/module/headprotector,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
	)

/obj/item/mod/construction/plating/jumper
	name = "\improper PA-4 MK-7 J.S supply crate"
	desc = "A crate made mostly of titanium with handles on the side to carry. It seems to be pressure sealed and the lid seems to be hydraulically assisted. \
		The inside of the crate opens up and folds out to display an entire toolkit with all the essentials to convert most armor \
		into a Mark 7 PA-7 Variant Jump suit. This crate seems to have the emblem relating to a certain Commando... \
		Perhaps you should return it to the owner where you found it, if you can even lift it."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	icon_state = "jumper-plating"
	theme = /datum/mod_theme/jumper

/obj/item/mod/skin_applier/jumper
	name = "\improper PA-4 MK-7 J.S supply crate"
	desc = "A crate made mostly of titanium with handles on the side to carry. \
			It seems to be pressure sealed and the lid seems to be hydraulically assisted. \
			The inside of the crate opens up and folds out to display an entire toolkit with all the essentials to convert most armor into a Mark 7 PA-7 Variant Jump suit. \
			This crate seems to have the emblem relating to a certain Commando... Perhaps you should return it to the owner where you found it, if you can even lift it."
	icon = 'modular_nova/master_files/icons/donator/obj/custom.dmi'
	lefthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_nova/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "jumper-plating"
	skin = "jumper"
	var/list/variant_data = list(
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
	)

/obj/item/mod/skin_applier/jumper/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/item/mod/control/pre_equipped/security))
		return ..()
	var/obj/item/mod/control/mod = interacting_with
	if(skin in mod.theme.variants)
		return ..()
	var/datum/mod_theme/jumper = new mod.theme.type
	jumper.variants = mod.theme.variants.Copy()
	mod.theme = jumper
	mod.theme.variants[skin] = variant_data
	mod.name = "\improper PA-4 MK-7 J.S 'Jumper'"
	mod.desc = "A rugged combat MODsuit optimized for shock deployment and urban warfare. \
				Featuring reinforced armor segments, integrated life-support, and modular hardpoints, \
				it prioritizes endurance and flexibility over excess weight, ensuring consistent performance under extreme conditions"
	return ..()

//samman166 Donor Items

/obj/item/mod/skin_applier/akari
	name = "nanite MODsuit refitter"
	desc = "A small kit full of nanites designed to refit a MODsuit to Akari's personal design. Only compatible with fused MODsuits due to the refit's reliance on a symbiote."
	icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	icon_state = "skinapplier"
	skin = "akari"
	var/list/variant_data = list(
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
	)

/obj/item/mod/skin_applier/akari/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/item/mod/control/pre_equipped/entombed))
		return ..()
	var/obj/item/mod/control/mod = interacting_with
	if(skin in mod.theme.variants)
		return ..()
	var/datum/mod_theme/akari = new mod.theme.type
	akari.variants = mod.theme.variants.Copy()
	mod.theme = akari
	mod.theme.variants[skin] = variant_data
	return ..()
