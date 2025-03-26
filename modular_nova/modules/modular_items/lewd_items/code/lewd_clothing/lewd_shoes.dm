/// Sprite doesn't visually represent the verticality correctly but the description at time of rewrite implied this was the 'intended' item?? idk. just going with it
/obj/item/clothing/shoes/ballet_heels
	name = "ballet heels"
	desc = "Restrictive, knee-high heels. Unfathomably difficult to walk in."
	icon_state = "balletheels"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	greyscale_colors = "#383840"
	greyscale_config = /datum/greyscale_config/ballet_heel
	greyscale_config_worn = /datum/greyscale_config/ballet_heel/worn
	greyscale_config_worn_digi = /datum/greyscale_config/ballet_heel/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/shoes/ballet_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_nova/modules/modular_items/lewd_items/sounds/highheel1.ogg' = 1, 'modular_nova/modules/modular_items/lewd_items/sounds/highheel2.ogg' = 1), 70)

/obj/item/clothing/shoes/ballet_heels/domina_heels
	name = "dominant heels"
	desc = "A pair of aesthetically pleasing heels."
	icon_state = "dominaheels"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null

/*
*	LATEX SOCKS
*/

/obj/item/clothing/shoes/latex_socks
	name = "latex socks"
	desc = "A pair of shiny, split-toe socks made of some strange material."
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "latex_socks"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	greyscale_colors = "#383840"
	greyscale_config = /datum/greyscale_config/latex_socks
	greyscale_config_worn = /datum/greyscale_config/latex_socks/worn
	greyscale_config_worn_digi = /datum/greyscale_config/latex_socks/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
