/obj/item/clothing/under/tearaway_garments
	name = "tearaway attire"
	desc = "A two-piece set that leaves little to the imagination."
	icon = 'local/icons/lewd/obj/clothing/uniform.dmi'
	worn_icon = 'local/icons/lewd/mob/clothing/uniform.dmi'
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
