//Not a maid, yeah. I dont care, it's going with the other lewd stuff, and there WONT be a whole new file just for it.
/obj/item/clothing/under/costume/bunnylewd
	name = "bunny suit"
	desc = "A pin-up staple."
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	greyscale_colors = "#383840#FFFFFF"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/bunnylewd"
	post_init_icon_state = "bunnysuit"
	greyscale_config = /datum/greyscale_config/bunnysuitlewd
	greyscale_config_worn = /datum/greyscale_config/bunnysuitlewd/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN
	can_adjust = TRUE
	alt_covers_chest = FALSE


/obj/item/clothing/under/costume/bunnylewd/white
	name = "white bunny suit"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	icon_state = "whitebunnysuit"
	can_adjust = FALSE
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	post_init_icon_state = null
