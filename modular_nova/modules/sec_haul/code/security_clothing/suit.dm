/obj/item/clothing/suit/armor/vest/alt/sec/depgag_vest
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/armor/vest/alt/sec/sec_depgag"
	post_init_icon_state = "depgag_vest"
	greyscale_config = /datum/greyscale_config/depgag_vest
	greyscale_config_worn = /datum/greyscale_config/depgag_vest/worn
	greyscale_colors = "#BAEA3E#EBEBEB"
	flags_1 = NONE

/obj/item/clothing/suit/armor/vest/alt/sec/depgag_vest_slim
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/armor/vest/alt/sec/sec_depgag_slim"
	post_init_icon_state = "depgag_vest_slim"
	greyscale_config = /datum/greyscale_config/depgag_vest_slim
	greyscale_config_worn = /datum/greyscale_config/depgag_vest_slim/worn
	greyscale_colors = "#BAEA3E#EBEBEB"
	flags_1 = NONE

/obj/item/clothing/suit/armor/vest/depgag_hazard
	name = "high vis armored vest"
	desc = "Oi bruv, you got a loicence for that?"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/armor/vest/depgag_hazard"
	post_init_icon_state = "depgag_hazard"
	greyscale_config = /datum/greyscale_config/depgag_hazard
	greyscale_config_worn = /datum/greyscale_config/depgag_hazard/worn
	greyscale_colors = "#BAEA3E#EBEBEB"
	flags_1 = NONE

/obj/item/clothing/suit/armor/vest/depgag_hazard/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "zipper")

/obj/item/clothing/suit/armor/vest/secjacket/depgag
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/armor/vest/secjacket/depgag"
	post_init_icon_state = "depgag_hazard_jacket"
	greyscale_config = /datum/greyscale_config/depgag_hazard_jacket
	greyscale_config_worn = /datum/greyscale_config/depgag_hazard_jacket/worn
	greyscale_colors = "#BAEA3E#EBEBEB#EBEBEB"
	flags_1 = NONE

/obj/item/clothing/suit/armor/vest/secjacket/depgag/white
	icon_state = "/obj/item/clothing/suit/armor/vest/secjacket/depgag/white"
	greyscale_colors = "#A52F29#EBEBEB#EBEBEB"

/obj/item/clothing/suit/armor/vest/secjacket/depgag/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "zipper")

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/bomber
	name = "security bomber jacket"
	desc = "A comfortable jacket in security red. Probably against uniform regulations."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/bomber"
	post_init_icon_state = "depgag_bomber"
	greyscale_config = /datum/greyscale_config/depgag_bomber
	greyscale_config_worn = /datum/greyscale_config/depgag_bomber/worn
	greyscale_colors = "#A52F29#39393F"
	flags_1 = NONE

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket
	name = "vested security jacket"
	desc = "The company standard armor now with a stylish unzipped jacket stitched in for when you don't think you'll get shot!"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket"
	post_init_icon_state = "depgag_vested_jacket"
	greyscale_config = /datum/greyscale_config/depgag_vested_jacket
	greyscale_config_worn = /datum/greyscale_config/depgag_vested_jacket/worn
	greyscale_colors = "#A52F29#39393F#39393F"
	flags_1 = NONE
/*
/obj/item/clothing/suit/hooded/wintercoat/security/depgag/vested_jacket/blue
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/vested_jacket/blue"
	greyscale_colors = "#3F6E9E#39393F#39393F"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/vested_jacket/white
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/vested_jacket/white"
	greyscale_colors = "#EBEBEB#39393F#39393F"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/vested_jacket/black
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/vested_jacket/black"
	greyscale_colors = "#39393F#39393F#EBEBEB"
*/
/obj/item/clothing/suit/hooded/wintercoat/security/depgag
	name = "security winter coat"
	desc = "An armour-padded winter coat. It glitters with a mild ablative coating and a robust air of authority."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag"
	post_init_icon_state = "depgag_winter_coat"
	hood_down_overlay_suffix = ""
	greyscale_config = /datum/greyscale_config/depgag_winter_coat
	greyscale_config_worn = /datum/greyscale_config/depgag_winter_coat/worn
	greyscale_colors = "#A52F29#CEC8BF#39393F#39393F"
	flags_1 = NONE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	hoodtype = /obj/item/clothing/head/hooded/winterhood/depgag
	var/hood_up = FALSE

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/blue
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/blue"
	greyscale_colors = "#3F6E9E#CEC8BF#39393F#39393F"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/white
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/white"
	greyscale_colors = "#EBEBEB#CEC8BF#39393F#39393F"

/obj/item/clothing/suit/hooded/wintercoat/security/depgag/black
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/depgag/black"
	greyscale_colors = "#39393F#CEC8BF#39393F#EBEBEB"

/// Called when the hood is worn
/obj/item/clothing/suit/hooded/wintercoat/security/depgag/on_hood_up(obj/item/clothing/head/hooded/hood)
	hood_up = TRUE

/// Called when the hood is hidden
/obj/item/clothing/suit/hooded/wintercoat/security/depgag/on_hood_down(obj/item/clothing/head/hooded/hood)
	hood_up = FALSE

//In case colors are changed after initialization
/obj/item/clothing/suit/hooded/wintercoat/security/depgag/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()

	if(!hood)
		return

	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

//But also keep old method in case the hood is (re-)created later
/obj/item/clothing/suit/hooded/wintercoat/security/depgag/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

/obj/item/clothing/head/hooded/winterhood/depgag
	greyscale_config = /datum/greyscale_config/winter_hood
	greyscale_config_worn = /datum/greyscale_config/winter_hood/worn


/*
*	WARDEN
*/

/obj/item/clothing/suit/armor/vest/warden/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "vest_warden"

/*
*	Head of Security
*/

/obj/item/clothing/suit/armor/hos/hos_formal/black
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hosformal_black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
