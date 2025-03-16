/obj/item/clothing/mask/ballgag
	name = "ball gag"
	desc = "Prevents the wearer from speaking."
	icon = 'local/icons/lewd/obj/clothing/masks.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/masks.dmi'
	icon_state = "ballgag"
	greyscale_colors = "#383840#dc7ef4"
	greyscale_config = /datum/greyscale_config/ball_gag
	greyscale_config_worn = /datum/greyscale_config/ball_gag/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/gas/ballgag/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/muffles_speech)

/// SHOG TODO: choking gags

/obj/item/clothing/mask/ballgag/choking
	name = "phallic ball gag"
	desc = "Prevents the wearer from speaking, as well as making breathing harder."
	icon_state = "chokegag"
	greyscale_config = /datum/greyscale_config/ballgag/choking_small /// SHOG TODO - merge these into one config, add unique_reskin()
