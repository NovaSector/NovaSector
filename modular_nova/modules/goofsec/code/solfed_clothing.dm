/obj/item/clothing/neck/mantle/solfed
	name = "\improper Sol Federation mantle"
	desc = "A mantle made with state of the art light up lining to allow easy spotting of downed Solfed personnel in hostile environments. It also looks nice to wear."
	icon = 'modular_nova/modules/goofsec/icons/obj/neck.dmi'
	icon_state = "recovermantle"
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/neck.dmi'
	worn_icon_state = "recovermantle"
	armor_type = /datum/armor/clothing_under/rank_security

/obj/item/clothing/neck/mantle/solfed/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/// SolFed Accessories
/obj/item/clothing/accessory/nova/solfedribbon
	name = "\improper SolFed rank ribbon"
	desc = "An average military ribbon."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon"
	post_init_icon_state = "star_arr_ribbon_1"
	greyscale_colors = "#FFD700"
	greyscale_config = /datum/greyscale_config/solfedribbons
	greyscale_config_worn = /datum/greyscale_config/solfedribbons/worn
	minimize_when_attached = TRUE
	unique_reskin = list(
		"Default" = "star_arr_ribbon_1",
		"Alt 1" = "star_arr_ribbon_2",
		"Alt 2" = "star_sw_ribbon_1",
		"Alt 3" = "star_sw_ribbon_2",
		"Alt 4" = "star_ribbon_1",
		"Alt 5" = "star_ribbon_2",
		"Alt 6" = "star_ribbon_3",
		"Alt 7" = "arr_ribbon_1",
		"Alt 8" = "arr_ribbon_2",
		"Alt 9" = "arr_ribbon_3",
		"Alt 10" = "sw_ribbon_1",
		"Alt 11" = "sw_ribbon_2",
		"Alt 12" = "sw_ribbon_3",
	)

/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official
	name = "\improper SolFed Official neckpin"
	desc = "A special golden neckpin to show true loyalty to the Federation."
	greyscale_colors = "#ffff66#0099ff"

/obj/machinery/vending/access/solfed
	name = "\improper Solfed Outfitting Station"
	desc = "A vending machine for specialised clothing for members of the Federation."
	product_ads = "File paperwork in style!;Glory To the Federation!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!;Remember Its not a crime to be fashionable!"
	icon = 'modular_nova/modules/command_vendor/icons/vending.dmi'
	icon_state = "solfeddrobe"
	icon_deny = "solfeddrobe-deny"
	light_mask = "wardrobe-light-mask"
	vend_reply = "Thank you for using the CommDrobe!"
	auto_build_products = TRUE
	payment_department = null
	shut_up = TRUE

	refill_canister = /obj/item/vending_refill/wardrobe/solfed_wardrobe
	light_color = COLOR_BRIGHT_BLUE

/obj/item/vending_refill/wardrobe/solfed_wardrobe
	machine_name = "SolfedDrobe"

/obj/machinery/vending/access/solfed/build_access_list(list/access_lists)
	access_lists[ACCESS_CENT_CAPTAIN] = list(
		// Solfed has CC and station AA but this is the highest access possible so no one but feds can get it. Hopefully
		/obj/item/clothing/accessory/nova/solfedribbon = 4,
		/obj/item/clothing/under/solfed/official = 4,
		/obj/item/clothing/under/solfed/official = 4,
		/obj/item/clothing/under/solfed/official = 4,
		/obj/item/clothing/under/solfed/official = 4,
		/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official = 8,

		/obj/item/storage/box/flashbangs = 2,
		/obj/item/storage/box/handcuffs = 4,
		/obj/item/storage/box/nri_flares = 16,
	)

/*
	Encryption Keys
*/

/obj/item/encryptionkey/headset_solfed/headset_solfed
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	icon = 'icons/map_icons/items/_item.dmi'

/obj/item/encryptionkey/headset_solfed/atmos
	name = "\improper SolFed adv. atmos encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/atmos"
	post_init_icon_state = "cypherkey_medical"
	greyscale_config = /datum/greyscale_config/encryptionkey_medical
	greyscale_colors = "#ebebeb#2b2793"

/obj/item/encryptionkey/headset_solfed/sec
	name = "\improper SolFed adv. Security encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/sec"
	post_init_icon_state = "cypherkey_medical"
	greyscale_config = /datum/greyscale_config/encryptionkey_medical
	greyscale_colors = "#ebebeb#2b2793"

/obj/item/encryptionkey/headset_solfed/med
	name = "\improper SolFed adv. Medical encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/med"
	post_init_icon_state = "cypherkey_medical"
	greyscale_config = /datum/greyscale_config/encryptionkey_medical
	greyscale_colors = "#ebebeb#2b2793"

/obj/item/encryptionkey/headset_solfed/squadleader
	name = "\improper SolFed grand encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/squadleader"
	post_init_icon_state = "cypherkey_syndicate"
	greyscale_config = /datum/greyscale_config/encryptionkey_syndicate
	greyscale_colors = "#ebebeb#2b2793"

/*
	Headsets
*/

/obj/item/radio/headset/headset_solfed/atmos
	name = "\improper SolFed adv. atmos headset"
	desc = "A headset used by the Solar Federation response teams."
	icon_state = "med_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/atmos

/obj/item/radio/headset/headset_solfed/sec
	name = "\improper SolFed adv. Security headset"
	desc = "A headset used by the Solar Federation response teams."
	icon_state = "med_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/sec

/obj/item/radio/headset/headset_solfed/med
	name = "\improper SolFed adv. Medical headset"
	desc = "A headset used by the Solar Federation response teams."
	icon_state = "med_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/med

/obj/item/radio/headset/headset_solfed/officials
	name = "\improper SolFed Officials Headset"
	icon_state = "com_headset"
	worn_icon_state = "com_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/squadleader

/obj/item/radio/headset/headset_solfed/espatier
	name = "\improper SolFed Espatier headset"
	desc = "A headset used by the Solar Federation espatiers."
	icon_state = "com_headset_alt"
	worn_icon_state = "com_headset_alt"
	keyslot = /obj/item/encryptionkey/headset_solfed/sec

/obj/item/radio/headset/headset_solfed/espatier/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/headset_solfed/espatier/corpsman
	name = "\improper Solfed Espatier Corpsman Headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/med

/obj/item/radio/headset/headset_solfed/espatier/engineer
	name = "\improper Solfed Espatier Engineer Headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/atmos

/obj/item/radio/headset/headset_solfed/espatier/squadleader
	name = "\improper Solfed Espatier Squadleader Headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/squadleader


/obj/item/storage/belt/military/solfed
	name = "solfed chest rig"
	desc = "A set of tactical webbing worn by federal military personnel."
	storage_type = /datum/storage/military_belt/solfed

/datum/storage/military_belt/solfed
	max_specific_storage = WEIGHT_CLASS_NORMAL

/obj/item/storage/belt/military/solfed/PopulateContents()
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/melee/baton/security/loaded(src)
