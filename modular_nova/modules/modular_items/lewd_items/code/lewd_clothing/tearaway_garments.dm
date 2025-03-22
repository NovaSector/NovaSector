/obj/item/clothing/under/tearaway_garments
	name = "tearaway attire"
	desc = "A two-piece set that leaves little to the imagination."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	icon_state = "stripper"
	greyscale_colors = "#383840#dc7ef4"
	greyscale_config = /datum/greyscale_config/tearaway_garments
	greyscale_config_worn = /datum/greyscale_config/tearaway_garments/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	can_adjust = FALSE
	gender = PLURAL

/obj/item/clothing/under/tearaway_garments/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL
