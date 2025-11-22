// SolFed 911 Marshal Uniform | The root of all things good aand evil
/obj/item/clothing/under/solfed
	name = "\improper SolFed marshal's uniform"
	desc = "A modernization of the SolFed's peacekeeping uniform, modernized and refurbished to feel fashionable yet functional in its new modern setting, tailored for federal personnel."
	icon = 'modular_nova/modules/goofsec/icons/obj/uniforms.dmi'
	icon_state = "solpolice"
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/uniforms.dmi'
	worn_icon_digi = 'modular_nova/modules/goofsec/icons/mob/uniforms_digi.dmi'
	inhand_icon_state = null
	armor_type = /datum/armor/clothing_under/rank_security
	has_sensor = HAS_SENSORS
	sensor_mode = SENSOR_COORDS

// Peacekeeper Jumpsuit
/obj/item/clothing/under/solfed/sol_peacekeeper
	name = "sol peacekeeper uniform"
	desc = "A military-grade uniform with military grade comfort (none at all), often seen on \
		SolFed's various peacekeeping forces, and usually alongside a blue helmet."
	icon_state = "peacekeeper"
	worn_icon_state = "peacekeeper"

// EMT jumpsuit
/obj/item/clothing/under/solfed/sol_emt
	name = "sol emergency medical uniform"
	desc = "A copy of SolFed's peacekeeping uniform, recolored and re-built with paramedics in mind."
	icon_state = "emt"
	worn_icon_state = "emt"
	armor_type = /datum/armor/clothing_under/rank_medical

// SolFed 911 EMT Uniform
/obj/item/clothing/under/solfed/sol_emt/emergencymed
	name = "\improper SolFed emergency paramedic uniform"
	desc = "An official Sol Federation emergency response uniform, denoting members of their paramedical Trauma Teams and protecting them from viral or chemical hazards."
	icon_state = "medrescue"
	worn_icon_state = "medrescue"

// SolFed 911 Atmos Uniform
/obj/item/clothing/under/solfed/emergencyfire
	name = "\improper SolFed emergency atmospherics uniform"
	desc = "An official Sol Federation emergency response uniform, denoting members of their Station Breach Control teams and protecting them from atmospheric or fire hazards."
	icon_state = "atmosrescue"
	worn_icon_state = "atmosrescue"
	armor_type = /datum/armor/clothing_under/atmos_adv

///Federation Officials Uniforms (Identified by stripe and band) || Similar to Civ, but Armored
/obj/item/clothing/under/solfed/official
	name = "\improper SolFed Official Uniform"
	desc = "A uniform worn by officials of the Sol Federation's Civil Services Division."

	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/official"
	post_init_icon_state = "uniform"

	greyscale_colors = "#41579A#39393F"
	greyscale_config = /datum/greyscale_config/solfed_off_reg
	greyscale_config_worn = /datum/greyscale_config/solfed_off_reg/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_off_reg/worn/digi

	can_adjust = FALSE

/obj/item/clothing/under/solfed/official/hoodie
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/official/hoodie"

	greyscale_config = /datum/greyscale_config/solfed_off_hoodie
	greyscale_config_worn = /datum/greyscale_config/solfed_off_hoodie/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_off_hoodie/worn/digi

/obj/item/clothing/under/solfed/official/puffy
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/official/puffy"

	greyscale_config = /datum/greyscale_config/solfed_off_puffy
	greyscale_config_worn = /datum/greyscale_config/solfed_off_puffy/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_off_puffy/worn/digi

/obj/item/clothing/under/solfed/official/twopart
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/official/twopart"

	greyscale_config = /datum/greyscale_config/solfed_off_twopart
	greyscale_config_worn = /datum/greyscale_config/solfed_off_twopart/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_off_twopart/worn/digi





///Civilian Variants of the SolFed Officials (Lacking Armbands, Patches, Stripes)
/obj/item/clothing/under/solfed/civil
	name = "SolFed Civilian Uniform"
	desc = "A standard civilian outfit for any fresh spacetiding citizen of the great Sol Federation..."

	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/civil"
	post_init_icon_state = "uniform"

	greyscale_colors = "#41579A#39393F"
	greyscale_config = /datum/greyscale_config/solfed_civ_reg
	greyscale_config_worn = /datum/greyscale_config/solfed_civ_reg/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_civ_reg/worn/digi

	armor_type = /datum/armor/none

	can_adjust = FALSE

	unique_reskin = list(
		"default" = "uniform",
		"puffy pants" = "uniform_alt_1",
	)

/obj/item/clothing/under/solfed/civil/hoodie
	name = "SolFed Civilian Hoodie"
	icon_state = "/obj/item/clothing/under/solfed/civilian/hoodie"

	greyscale_config = /datum/greyscale_config/solfed_civ_hoodie
	greyscale_config_worn = /datum/greyscale_config/solfed_civ_hoodie/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_civ_hoodie/worn/digi

/obj/item/clothing/under/solfed/civil/puffy
	name = "SolFed Civilian Puffy Uniform"
	icon_state = "/obj/item/clothing/under/solfed/civilian/puffy"

	greyscale_config = /datum/greyscale_config/solfed_civ_puffy
	greyscale_config_worn = /datum/greyscale_config/solfed_civ_puffy/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_civ_puffy/worn/digi

/obj/item/clothing/under/solfed/civil/twopart
	name = "SolFed Civilian Two Part Uniform"
	icon_state = "/obj/item/clothing/under/solfed/civilian/twopart"

	greyscale_config = /datum/greyscale_config/solfed_civ_twopart
	greyscale_config_worn = /datum/greyscale_config/solfed_civ_twopart/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfed_civ_twopart/worn/digi

/*

SOLFED ARMOR VALUES!

*/

// Regular armor resistances (NT Security ERT Protection Grade But Sidegrade [Boosted armor, no eva])
/datum/armor/clothing_under/solfed_response_standard
	melee = 50
	bullet = 50
	laser = 50
	energy = 50
	bomb = 50
	bio = 25
	fire = 25
	acid = 25
	wound = 30

// Grand Response armor resistances (NT Asset Protection Grade But Sidegrade [Boosted armor, no eva])
/datum/armor/clothing_under/solfed_response_grand
	melee = 80
	bullet = 80
	laser = 70
	energy = 60
	bomb = 80
	bio = 20
	fire = 50
	acid = 50
	wound = 45

// Sol Federation Combat Helmet
/obj/item/clothing/head/helmet/solfed
	name = "\improper SolFed MK I Combat helmet"
	desc = "A robust Sol Federation helmet designed with an integrated light to provide vision to the brave marines on the front line, and annoyingly no strap. It feels cheep \
	it feels mass produced, its perfect for missions that are of lower grade threats."
	icon_state = "icons/map_icons/clothing/head/_head"
	post_init_icon_state = "mark_one_helmet"
	worn_icon_state = "mark_one_helmet"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	armor_type = /datum/armor/clothing_under/solfed_response_standard

	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 1
	light_color = "#fff9f3"
	light_on = FALSE

	greyscale_config = /datum/greyscale_config/solfed_goggles
	greyscale_config_worn = /datum/greyscale_config/solfed_goggles/worn
	greyscale_colors = "#808080"
	unique_reskin = null
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)
	clothing_flags = SNUG_FIT

	/// Default state for the light
	var/on = FALSE
	/// Just to spite Ian (Also because I cannot be bothered to make a doggo version)
	dog_fashion = null

/obj/item/clothing/head/helmet/solfed/mk2
	name = "\improper SolFed MK II Combat helmet"
	desc = "A much more robust Sol Federation helmet than the MK I, coming with its signature integrated light from its older counterpart but also with more heavier protection. \
	this time with a strap!"
	icon_state = "icons/map_icons/clothing/head/_head"
	post_init_icon_state = "mark_two_helmet"
	worn_icon_state = "mark_two_helmet"
	armor_type = /datum/armor/clothing_under/solfed_response_grand

// Toggle state for the helmet light
/obj/item/clothing/head/helmet/solfed/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)

// Toggle state for the light ON
/obj/item/clothing/head/helmet/solfed/proc/turn_on(mob/user)
	set_light_on(TRUE)

// Toggle state for the light OFF
/obj/item/clothing/head/helmet/solfed/proc/turn_off(mob/user)
	set_light_on(FALSE)

/obj/item/clothing/head/helmet/solfed/attack_self(mob/living/user)
	toggle_helmet_light(user)

// SolFed flak jacket, for civilian use
/obj/item/clothing/suit/armor/vest/sol
	name = "'Gordyn' flak vest"
	desc = "A light armored jacket common on SolFed personnel who need armor, but find a full vest \
		too impractical or unneeded."
	icon = 'modular_nova/modules/goofsec/icons/obj/suits.dmi'
	icon_state = "flak"
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/suits.dmi'
	worn_icon_digi = 'modular_nova/modules/goofsec/icons/mob/suits_digi.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	dog_fashion = null

// SolFed Heavy Armor for Marines
/obj/item/clothing/suit/armor/vest/sol/marine
	name = "\improper 'Hephaestus' light armor"
	desc = "Through space, snow, oceans, painful hills and terrain, the 'Hephaestus' light armor is one of the Sol Federation's most unique combat vests, \
	used in the older days during the war of the rimworlds, its proven useful but outdated."
	icon_state = "icons/map_icons/clothing/suit/_suit"
	post_init_icon_state = "hephaestus"
	worn_icon_state = "hephaestus"
	armor_type = /datum/armor/clothing_under/solfed_response_standard
	greyscale_config = /datum/greyscale_config/vestcam
	greyscale_config_worn = /datum/greyscale_config/vestcam/worn
	greyscale_colors = "#4d4d4d"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/sol/marine/mk2
	name = "\improper 'Hercules' heavy armor"
	desc = "Through space, snow, oceans, painful hills and terrain, the 'Hercules' heavy armor is the Sol Federation's most versatile and robust heavily armored vest and padding, \
		to protect its marines from the most dangerous of threats in the most alien of environments."
	icon_state = "icons/map_icons/clothing/suit/_suit"
	post_init_icon_state = "hercules"
	worn_icon_state = "hercules"
	worn_icon_digi = "hercules"
	armor_type = /datum/armor/clothing_under/solfed_response_grand
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

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

/// SolFed Goggles
/obj/item/clothing/glasses/sunglasses/solfed
	name = "robust military goggles"
	desc = "A strangely old technology modernized to be much more robust in the modern day."
	icon_state = "/obj/item/clothing/glasses/sunglasses/solfed"
	post_init_icon_state = "federal_goggles"
	greyscale_config = /datum/greyscale_config/solfed_goggles
	greyscale_config_worn = /datum/greyscale_config/solfed_goggles/worn
	greyscale_colors = "#4d4d4d"
	glass_colour_type = /datum/client_colour/glass_colour/gray

// SolFed Espatier Standard
/obj/item/clothing/under/solfed/marines
	name = "\improper SolFed Espatier uniform"
	desc = "A camouflage uniform for members of the SolFed Espatier Corps, typically serving as Starfleet (SFSF) and Space Guard (SFSG) shipboard security. \
		They additionally fill the role of simple space-borne infantry, earning the nickname of \"Space Marines\" from many spacers."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/marines"
	post_init_icon_state = "solfed_camo"
	worn_icon_state = "solfed_camo"
	worn_icon_digi = "solfed_camo"
	greyscale_config = /datum/greyscale_config/solfedcamo
	greyscale_config_worn = /datum/greyscale_config/solfedcamo/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfedcamo/worn/digi
	greyscale_colors = "#4d4d4d#333333#292929"
	can_adjust = FALSE

/obj/item/clothing/under/solfed/marines/squadleader
	icon_state = "/obj/item/clothing/under/solfed/marines/squadleader"
	post_init_icon_state = "solfed_camo_squadlead"
	worn_icon_state = "solfed_camo_squadlead"
	worn_icon_digi = "solfed_camo_squadlead"

/obj/item/clothing/under/solfed/marines/paramedic
	icon_state = "/obj/item/clothing/under/solfed/marines/paramedic"
	post_init_icon_state = "solfed_camo_paramed"
	worn_icon_state = "solfed_camo_paramed"
	worn_icon_digi = "solfed_camo_paramed"

/obj/item/clothing/under/solfed/marines/smartgunner
	icon_state = "/obj/item/clothing/under/solfed/marines/smartgunner"
	post_init_icon_state = "solfed_camo_smartgun"
	worn_icon_state = "solfed_camo_smartgun"
	worn_icon_digi = "solfed_camo_smartgun"

/obj/item/clothing/under/solfed/marines/specialist
	icon_state = "/obj/item/clothing/under/solfed/marines/specialist"
	post_init_icon_state = "solfed_camo_specialist"
	worn_icon_state = "solfed_camo_specialist"
	worn_icon_digi = "solfed_camo_specialist"

/obj/item/clothing/under/solfed/marines/engineer
	icon_state = "/obj/item/clothing/under/solfed/marines/engineer"
	post_init_icon_state = "solfed_camo_engie"
	worn_icon_state = "solfed_camo_engie"
	worn_icon_digi = "solfed_camo_engie"

/obj/item/clothing/under/solfed/marines/assault
	icon_state = "/obj/item/clothing/under/solfed/marines/assault"
	post_init_icon_state = "solfed_camo_assault"
	worn_icon_state = "solfed_camo_assault"
	worn_icon_digi = "solfed_camo_assault"
	greyscale_colors = "#FFFFFF#CBCDD1#8C92A5"

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
		/obj/item/clothing/under/solfed/officer = 4,
		/obj/item/clothing/under/solfed/officer_lowrnk = 4,
		/obj/item/clothing/under/solfed/official_civil = 4,
		/obj/item/clothing/under/solfed/official_social = 4,
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
