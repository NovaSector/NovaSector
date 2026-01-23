// Peacekeeper jumpsuit
/obj/item/clothing/under/sol_peacekeeper
	name = "sol peacekeeper uniform"
	desc = "A military-grade uniform with military grade comfort (none at all), often seen on \
		SolFed's various peacekeeping forces, and usually alongside a blue helmet."
	icon = 'modular_nova/modules/goofsec/icons/obj/uniforms.dmi'
	icon_state = "peacekeeper"
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/uniforms.dmi'
	worn_icon_digi = 'modular_nova/modules/goofsec/icons/mob/uniforms_digi.dmi'
	worn_icon_state = "peacekeeper"
	armor_type = /datum/armor/clothing_under/rank_security
	inhand_icon_state = null
	has_sensor = HAS_SENSORS
	random_sensor = FALSE

// EMT jumpsuit
/obj/item/clothing/under/sol_emt
	name = "sol emergency medical uniform"
	desc = "A copy of SolFed's peacekeeping uniform, recolored and re-built with paramedics in mind."
	icon = 'modular_nova/modules/goofsec/icons/obj/uniforms.dmi'
	icon_state = "emt"
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/uniforms.dmi'
	worn_icon_digi = 'modular_nova/modules/goofsec/icons/mob/uniforms_digi.dmi'
	worn_icon_state = "emt"
	armor_type = /datum/armor/clothing_under/rank_medical
	inhand_icon_state = null
	has_sensor = HAS_SENSORS
	random_sensor = FALSE

// SolFed 911 Marshal Uniform
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
	random_sensor = FALSE

// SolFed 911 Atmos Uniform
/obj/item/clothing/under/solfed/emergencyfire
	name = "\improper SolFed emergency atmospherics uniform"
	desc = "An official Sol Federation emergency response uniform, denoting members of their Station Breach Control teams and protecting them from atmospheric or fire hazards."
	icon_state = "atmosrescue"
	armor_type = /datum/armor/clothing_under/atmos_adv

// SolFed 911 EMT Uniform
/obj/item/clothing/under/solfed/emergencymed
	name = "\improper SolFed emergency paramedic uniform"
	desc = "An official Sol Federation emergency response uniform, denoting members of their paramedical Trauma Teams and protecting them from viral or chemical hazards."
	icon_state = "medrescue"

// Federation Officer (Official)
/obj/item/clothing/under/solfed/officer
	name = "\improper SolFed high-ranking official uniform"
	desc = "A uniform worn by high ranking officials of the Sol Federation Armed Forces."
	icon_state = "solfed_official"

// Federation Enlisted (Non Marine | Official)
/obj/item/clothing/under/solfed/officer_lowrnk
	name = "\improper SolFed low-ranking official uniform"
	desc = "A uniform worn by low ranking officials of the Sol Federation Armed Forces."
	icon_state = "solfed_enl"

// Federation Civil Services Official
/obj/item/clothing/under/solfed/official_civil
	name = "\improper SolFed civil services uniform"
	desc = "A uniform worn by officials of the Sol Federation's Civil Services Division."
	icon_state = "solfed_civil"

// Federation Social Services Official
/obj/item/clothing/under/solfed/official_social
	name = "\improper SolFed social services uniform"
	desc = "A uniform worn by officials of the Sol Federation's Social Services Division."
	icon_state = "solfed_social"

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

// SolFed flak jacket, for marshals
/obj/item/clothing/suit/armor/vest/sol
	name = "'Gordyn' flak vest"
	desc = "A light armored jacket common on SolFed personnel who need armor, but find a full vest \
		too impractical or unneeded."
	icon = 'modular_nova/modules/goofsec/icons/obj/uniforms.dmi'
	icon_state = "flak"
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/uniforms.dmi'
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

/obj/item/clothing/accessory/nova/solfedribbon/rank2
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank2"
	post_init_icon_state = "star_arr_ribbon_2"

/obj/item/clothing/accessory/nova/solfedribbon/rank3
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank3"
	post_init_icon_state = "star_sw_ribbon_1"

/obj/item/clothing/accessory/nova/solfedribbon/rank4
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank4"
	post_init_icon_state = "star_sw_ribbon_2"

/obj/item/clothing/accessory/nova/solfedribbon/rank5
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank5"
	post_init_icon_state = "star_ribbon_1"

/obj/item/clothing/accessory/nova/solfedribbon/rank6
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank6"
	post_init_icon_state = "star_ribbon_2"

/obj/item/clothing/accessory/nova/solfedribbon/rank7
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank7"
	post_init_icon_state = "star_ribbon_3"

/obj/item/clothing/accessory/nova/solfedribbon/rank8
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank8"
	post_init_icon_state = "arr_ribbon_1"

/obj/item/clothing/accessory/nova/solfedribbon/rank9
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank8"
	post_init_icon_state = "arr_ribbon_2"

/obj/item/clothing/accessory/nova/solfedribbon/rank10
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank9"
	post_init_icon_state = "arr_ribbon_3"

/obj/item/clothing/accessory/nova/solfedribbon/rank11
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank10"
	post_init_icon_state = "sw_ribbon_1"

/obj/item/clothing/accessory/nova/solfedribbon/rank12
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank11"
	post_init_icon_state = "sw_ribbon_2"

/obj/item/clothing/accessory/nova/solfedribbon/rank13
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank12"
	post_init_icon_state = "sw_ribbon_3"

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
		/obj/item/clothing/accessory/nova/solfedribbon/rank2 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank3 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank4 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank5 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank6 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank7 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank8 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank9 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank10 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank11 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank12 = 4,
		/obj/item/clothing/accessory/nova/solfedribbon/rank13 = 4,
		/obj/item/clothing/under/solfed/officer = 4,
		/obj/item/clothing/under/solfed/officer_lowrnk = 4,
		/obj/item/clothing/under/solfed/official_civil = 4,
		/obj/item/clothing/under/solfed/official_social = 4,
		/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official = 8,

		/obj/item/storage/box/flashbangs = 2,
		/obj/item/storage/box/handcuffs = 4,
		/obj/item/storage/box/nri_flares = 16,
	)

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
	radio_talk_sound = 'modular_nova/modules/radiosound/sound/radio/security.ogg'

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

/obj/item/encryptionkey/headset_solfed/squadleader
	name = "\improper SolFed grand encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/squadleader"
	post_init_icon_state = "cypherkey_syndicate"
	greyscale_config = /datum/greyscale_config/encryptionkey_syndicate
	greyscale_colors = "#ebebeb#2b2793"

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
