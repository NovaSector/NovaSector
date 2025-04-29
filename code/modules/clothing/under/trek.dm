//Just some alt-uniforms themed around Star Trek - Pls don't sue, Mr Roddenberry ;_;

/obj/item/clothing/under/trek
	can_adjust = FALSE
	icon = 'icons/obj/clothing/under/trek.dmi'
	worn_icon = 'icons/mob/clothing/under/trek.dmi'

/*
*	The Original Series (Technically not THE original because these have a black undershirt while the very-original didn't but IDC)
*/
/obj/item/clothing/under/trek/command
	name = "command uniform"
	desc = "An outdated uniform worn by command officers."
	inhand_icon_state = "y_suit"
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/command" //Shirt has gold wrist-bands
	post_init_icon_state = "trek_tos_com"
	greyscale_config = /datum/greyscale_config/trek
	greyscale_config_worn = /datum/greyscale_config/trek/worn
	greyscale_colors = "#fab342"

/obj/item/clothing/under/trek/engsec
	name = "engsec uniform"
	desc = "An outdated uniform worn by engineering/security officers."
	inhand_icon_state = "r_suit"
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/engsec" //Tucked-in shirt
	post_init_icon_state = "trek_tos_sec"
	greyscale_config = /datum/greyscale_config/trek
	greyscale_config_worn = /datum/greyscale_config/trek/worn
	greyscale_colors = "#B72B2F"

/obj/item/clothing/under/trek/medsci
	name = "medsci uniform"
	desc = "An outdated worn by medical/science officers."
	inhand_icon_state = "b_suit"
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/medsci"
	post_init_icon_state = "trek_tos"
	greyscale_config = /datum/greyscale_config/trek
	greyscale_config_worn = /datum/greyscale_config/trek/worn
	greyscale_colors = "#5FA4CC"

/*
*	The Next Generation
*/
/obj/item/clothing/under/trek/command/next
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/command" //Technically TNG had Command wearing red, but bc gold is closer to command roles for SS13 we're taking some liberties
	post_init_icon_state = "trek_tos_com"

/obj/item/clothing/under/trek/engsec/next
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/engsec"
	post_init_icon_state = "trek_tos_sec"

/obj/item/clothing/under/trek/medsci/next
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/medsci"
	post_init_icon_state = "trek_tos"

/*
*	Voyager
*/
/obj/item/clothing/under/trek/command/voy
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/command" //Same point applies as TNG
	post_init_icon_state = "trek_tos_com"

/obj/item/clothing/under/trek/engsec/voy
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/engsec"
	post_init_icon_state = "trek_tos_sec"

/obj/item/clothing/under/trek/medsci/voy
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/medsci"
	post_init_icon_state = "trek_tos"

/*
*	Enterprise
*/
/obj/item/clothing/under/trek/command/ent
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/command"
	post_init_icon_state = "trek_tos_com"
	//Greyscale sprite note, the base of it can't be greyscaled lest I make a whole new .json, but the color bands are greyscale at least.
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/trek/engsec/ent
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/engsec"
	post_init_icon_state = "trek_tos_sec"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/trek/medsci/ent
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/trek/medsci"
	post_init_icon_state = "trek_tos"
	inhand_icon_state = "bl_suit"

//Q
/obj/item/clothing/under/trek/q
	name = "french marshall's uniform"
	desc = "Something about this uniform feels off..."
	icon_state = "trek_Q"
	inhand_icon_state = "r_suit"
