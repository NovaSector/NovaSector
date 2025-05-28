/obj/item/clothing/mask/muzzle/ballgag
	name = "ball gag"
	desc = "Prevents the wearer from speaking."
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks_muzzled.dmi'
	greyscale_colors = "#383840#dc7ef4"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/ballgag"
	post_init_icon_state = "ballgag"
	greyscale_config = /datum/greyscale_config/ball_gag
	greyscale_config_worn = /datum/greyscale_config/ball_gag/worn
	greyscale_config_worn_muzzled = /datum/greyscale_config/dorms_mask/worn/muzzled
	flags_1 = IS_PLAYER_COLORABLE_1
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/muzzle/ballgag/choking
	name = "phallic ball gag"
	desc = "Prevents the wearer from speaking, as well as making breathing harder."
	worn_icon_state = "ballgag"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/ballgag/choking"
	post_init_icon_state = "chokegag_small"
	greyscale_config = /datum/greyscale_config/ball_gag/choke_gag
	unique_reskin = list(
		"Small" = "chokegag_small",
		"Medium" = "chokegag_medium",
		"Large" = "chokegag_large",
	)
	obj_flags = INFINITE_RESKIN

/obj/item/clothing/mask/muzzle/ring
	name = "ring gag"
	desc = "A mouth wrap seemingly designed to hold the mouth open."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_masks.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks_muzzled.dmi'
	icon_state = "ringgag"
