//DEFAULT NECK ITEMS OVERRIDE//
/obj/item/clothing/neck
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/greyscaled
	name = "Antique Short Cloak"
	desc = "For the love of the game."

	icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/greyscaled"

	post_init_icon_state = "shortcloak"
	greyscale_config = /datum/greyscale_config/antique_short_cloak
	greyscale_config_worn = /datum/greyscale_config/antique_short_cloak/worn
	greyscale_colors = "#787878#252525#CCCED1"
	flags_1 = IS_PLAYER_COLORABLE_1
