//DEFAULT NECK ITEMS OVERRIDE//
/obj/item/clothing/neck
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/greyscaled
	name = "Antique Short Cloak"
	desc = "An antique, fluffy shortcloak... not sure why its so puffy and short."

	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/greyscaled"

	post_init_icon_state = "shortcloak"
	greyscale_config = /datum/greyscale_config/antique_short_cloak
	greyscale_config_worn = /datum/greyscale_config/antique_short_cloak/worn
	greyscale_colors = "#787878#252525#CCCED1"
	body_parts_covered = NECK
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/greyscaled/seecloak
	name = "Antique Seecloak"
	desc = "For the love of the game."

	icon_state = "/obj/item/clothing/neck/greyscaled/seecloak"
	post_init_icon_state = "seecloak"

	greyscale_config = /datum/greyscale_config/antique_seecloak
	greyscale_config_worn = /datum/greyscale_config/antique_seecloak/worn
	greyscale_colors = "#EDFFA4#6BB7A0"
	body_parts_covered = NECK|HAND_LEFT|ARM_LEFT|CHEST

/obj/item/clothing/neck/greyscaled/matroncloak
	name = "Antique Matron Cloak"
	desc = "For the love of the game."

	icon_state = "/obj/item/clothing/neck/greyscaled/matroncloak"
	post_init_icon_state = "matroncloak"

	greyscale_config = /datum/greyscale_config/antique_matroncloak
	greyscale_config_worn = /datum/greyscale_config/antique_matroncloak/worn
	greyscale_colors = "#787878#252525#CCCED1"
	body_parts_covered = NECK|HAND_LEFT|ARM_LEFT|CHEST

/obj/item/clothing/neck/greyscaled/xylixcloak
	name = "Antique Xylix Cloak"
	desc = "For the love of the game."

	icon_state = "/obj/item/clothing/neck/greyscaled/xylixcloak"
	post_init_icon_state = "xylixcloak"

	greyscale_config = /datum/greyscale_config/antique_xylixcloak
	greyscale_config_worn = /datum/greyscale_config/antique_xylixcloak/worn
	greyscale_colors = "#787878#252525#CCCED1"
	body_parts_covered = NECK|HAND_LEFT|CHEST
