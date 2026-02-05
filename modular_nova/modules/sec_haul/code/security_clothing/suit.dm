/obj/item/clothing/suit/armor/vest/alt/sec/secarmor
	name = "security armor"
	desc = "A standalone vest of armor to compliment your uniform."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/armor/vest/alt/sec/secarmor"
	post_init_icon_state = "secarmor"
	greyscale_config = /datum/greyscale_config/secarmor
	greyscale_config_worn = /datum/greyscale_config/secarmor/worn
	greyscale_colors = "#212022#A52F29"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/armor/vest/brit
	name = "high vis armored vest"
	desc = "Oi bruv, you got a loicence for that?"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hazardbg"
	worn_icon_state = "hazardbg"

/obj/item/clothing/suit/armor/vest/brit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "zipper")

/obj/item/clothing/suit/armor/vest/vested_jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "zipper")

/datum/atom_skin/vested_jacket
	abstract_type = /datum/atom_skin/vested_jacket/red

/datum/atom_skin/vested_jacket/red
	preview_name = "Red Variant"
	new_icon_state = "vested_jacket"

/datum/atom_skin/vested_jacket/blue
	preview_name = "Blue Variant"
	new_icon_state = "vested_jacket_blue"

/datum/atom_skin/vested_jacket/white
	preview_name = "White Variant"
	new_icon_state = "vested_jacket_white"

/datum/atom_skin/vested_jacket/black
	preview_name = "Black Variant"
	new_icon_state = "vested_jacket_black"

/obj/item/clothing/suit/armor/vest/vested_jacket
	name = "vested security jacket"
	desc = "The company standard armor now with a stylish zipper jacket stitched in for when you don't think you'll get shot!"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "vested_jacket"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS

/obj/item/clothing/under/rank/security/nova/skirt/plain/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/vested_jacket/red)

/obj/item/clothing/suit/hooded/wintercoat/security/thick
	name = "security winter coat"
	desc = "An armor-padded winter coat. It glitters with a mild ablative coating and a robust air of authority."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/security/thick"
	post_init_icon_state = "coatwinter"
	hood_down_overlay_suffix = ""
	greyscale_config = /datum/greyscale_config/security_winter_coat
	greyscale_config_worn = /datum/greyscale_config/security_winter_coat/worn
	greyscale_colors = "#A52F29#B89E8D#212022"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/sec_hood
	flags_1 = IS_PLAYER_COLORABLE_1

//In case colors are changed after initialization
/obj/item/clothing/suit/hooded/wintercoat/security/thick/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1,4)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.
	hood.update_slot_icon()

//But also keep old method in case the hood is (re-)created later
/obj/item/clothing/suit/hooded/wintercoat/security/thick/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1,4)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

/obj/item/clothing/head/hooded/winterhood/sec_hood
	name = "tailored winter coat hood"
	desc = "A heavy jacket hood made from 'synthetic' animal furs, with custom colors."
	greyscale_config = /datum/greyscale_config/security_hoods
	greyscale_config_worn = /datum/greyscale_config/security_hoods/worn

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
