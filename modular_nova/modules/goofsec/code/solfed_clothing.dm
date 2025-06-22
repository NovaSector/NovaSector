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

// Sol Federation Combat Helmet
/obj/item/clothing/head/helmet/solfed
	name = "\improper SolFed Combat helmet"
	desc = "A robust Sol Federation helmet designed with an integrated light to provide vision to the brave marines on the front line."
	icon_state = "icons/map_icons/clothing/head/_head"
	post_init_icon_state = "federal_helmet"
	worn_icon_state = "federal_helmet"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 1
	light_color = "#fff9f3"
	light_on = FALSE
	armor_type = /datum/armor/clothing_under/code_federal_armor
	greyscale_config = /datum/greyscale_config/solfed_goggles
	greyscale_config_worn = /datum/greyscale_config/solfed_goggles/worn
	greyscale_colors = "#808080"
	unique_reskin = null
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)
	clothing_flags = SNUG_FIT
	/// Default state for the light
	var/on = FALSE

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
/obj/item/clothing/suit/armor/vest/det_suit/sol
	name = "'Gordyn' flak vest"
	desc = "A light armored jacket common on SolFed personnel who need armor, but find a full vest \
		too impractical or unneeded."
	icon = 'modular_nova/modules/goofsec/icons/obj/uniforms.dmi'
	icon_state = "flak"
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/uniforms.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// SolFed Heavy Armor for Marines
/obj/item/clothing/suit/armor/vest/det_suit/sol/marine
	name = "\improper 'Hercules' heavy armor"
	desc = "Through space, snow, oceans, painful hills and terrain, the 'Hercules' heavy armor is the Sol Federation's most versatile and robust heavily armored vest and padding, \
		to protect its marines from the most dangerous of threats in the most alien of environments."
	icon_state = "icons/map_icons/clothing/suit/_suit"
	post_init_icon_state = "fedvest"
	worn_icon_state = "fedvest"
	worn_icon_digi = "fedvest"
	armor_type = /datum/armor/clothing_under/code_federal_armor
	greyscale_config = /datum/greyscale_config/vestcam
	greyscale_config_worn = /datum/greyscale_config/vestcam/worn
	greyscale_config_worn_digi = /datum/greyscale_config/vestcam/worn/digi
	greyscale_colors = "#4d4d4d"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/det_suit/sol/marine/desert
	greyscale_colors = "#e0dab7"

/obj/item/clothing/suit/armor/vest/det_suit/sol/marine/winter
	greyscale_colors = "#eaeaea"

/obj/item/clothing/suit/armor/vest/det_suit/sol/marine/ocean
	greyscale_colors = "#53638f"

/obj/item/clothing/suit/armor/vest/det_suit/sol/marine/forest
	greyscale_colors = "#008000"

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

/obj/item/clothing/glasses/sunglasses/solfed/winter
	greyscale_colors = "#eaeaea"

/obj/item/clothing/glasses/sunglasses/solfed/forest
	greyscale_colors = "#008000"

/obj/item/clothing/glasses/sunglasses/solfed/ocean
	greyscale_colors = "#53638f"

/obj/item/clothing/glasses/sunglasses/solfed/desert
	greyscale_colors = "#e8dd9b"

// Marine armor resistances (NT Asset Protection Grade But Sidegrade)
/datum/armor/clothing_under/code_federal_armor
	melee = 80
	bullet = 80
	laser = 70
	energy = 60
	bomb = 80
	bio = 20
	fire = 50
	acid = 50
	wound = 45

// SolFed Marines Standard
/obj/item/clothing/under/solfed/marines
	name = "\improper SolFed marine uniform"
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

/obj/item/clothing/under/solfed/marines/winter
	greyscale_colors = "#eaeaea#5f5f5f#969696"

/obj/item/clothing/under/solfed/marines/forest
	greyscale_colors = "#008000#663300#333333"

/obj/item/clothing/under/solfed/marines/ocean
	greyscale_colors = "#53638f#374c75#145779"

/obj/item/clothing/under/solfed/marines/desert
	greyscale_colors = "#e8dd9b#d6c76d#afa984"

// SolFed Espirator
/obj/item/clothing/under/solfed/espirator
	name = "\improper SolFed Espirator uniform"
	desc = "" //IDK what an Espirator is you've gotta fill this out LOL
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/solfed/espirator"
	post_init_icon_state = "solfed_camo"
	worn_icon_state = "solfed_camo"
	worn_icon_digi = "solfed_camo"
	greyscale_config = /datum/greyscale_config/solfedsimplecamo
	greyscale_config_worn = /datum/greyscale_config/solfedsimplecamo/worn
	greyscale_config_worn_digi = /datum/greyscale_config/solfedsimplecamo/worn/digi
	greyscale_colors = "#808080#333333"
	inhand_icon_state = null
	has_sensor = HAS_SENSORS
	random_sensor = FALSE
	can_adjust = FALSE

/obj/item/clothing/under/solfed/espirator/winter
	greyscale_colors = "#ffffff#c0c0c0"

/obj/item/clothing/under/solfed/espirator/forest
	greyscale_colors = "#7fc57f#008000"

/obj/item/clothing/under/solfed/espirator/desert
	greyscale_colors = "#e8dd9b#888157"

/obj/item/clothing/under/solfed/espirator/ocean
	greyscale_colors = "#92a2d2#53638f"

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
	post_init_icon_state = "arr_ribbon_2"

/obj/item/clothing/accessory/nova/solfedribbon/rank9
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank9"
	post_init_icon_state = "arr_ribbon_3"

/obj/item/clothing/accessory/nova/solfedribbon/rank10
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank10"
	post_init_icon_state = "sw_ribbon_1"

/obj/item/clothing/accessory/nova/solfedribbon/rank11
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank11"
	post_init_icon_state = "sw_ribbon_2"

/obj/item/clothing/accessory/nova/solfedribbon/rank12
	icon_state = "/obj/item/clothing/accessory/nova/solfedribbon/rank12"
	post_init_icon_state = "sw_ribbon_3"

/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed/official
	name = "\improper SolFed Official neckpin"
	desc = "A special golden neckpin to show true loyalty to the Federation."
	greyscale_colors = "#ffff66#0099ff"
