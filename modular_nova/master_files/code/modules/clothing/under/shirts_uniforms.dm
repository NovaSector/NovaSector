/// Base File for all base nova uniforms
/obj/item/clothing/under/greyscale
	icon = 'modular_nova/master_files/icons/obj/clothing/under/shorts_pants_shirts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts_digi.dmi'
	/// Assumes false just in case. Add can_adjust = TRUE to your entry when you want it to be adjustable
	can_adjust = FALSE

/*
*	Attire that is uniforms,
*/

/obj/item/clothing/under/greyscale/turtleneck
	name = "turtleneck"
	desc = "A rather comfortable turtleneck, keeping you comfortable through its robust threads."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/turtleneck"
	post_init_icon_state = "turtleneck"
	greyscale_config = /datum/greyscale_config/turtlenecks
	greyscale_config_worn = /datum/greyscale_config/turtlenecks/worn
	greyscale_config_worn_digi = /datum/greyscale_config/turtlenecks/worn/digi
	greyscale_colors = "#787878#252525"
	can_adjust = TRUE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/greyscale/turtleneck/skirt
	name = "Skirtleneck"
	desc = "A rather comfortable skirtleneck, keeping you comfortable through its robust threads"
	icon_state = "/obj/item/clothing/under/greyscale/turtleneck/skirt"
	post_init_icon_state = "skirtleneck"

/obj/item/clothing/under/greyscale/gorkas
	name = "gorka"
	desc = "A somewhat comfortable gorka, just as comfortable as a regular jumpsuit but having a unique design."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/gorkas"
	post_init_icon_state = "gags_gorka"
	greyscale_config = /datum/greyscale_config/gorkas
	greyscale_config_worn = /datum/greyscale_config/gorkas/worn
	greyscale_config_worn_digi = /datum/greyscale_config/gorkas/worn/digi
	greyscale_colors = "#787878#252525"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/greyscale/overalls
	name = "overalls"
	desc = "Overalls designed to be comfortable, and keep you from getting wet, while only one of those is true, its still nice to have."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/overalls"
	post_init_icon_state = "overalls"
	greyscale_config = /datum/greyscale_config/sus_overalls
	greyscale_config_worn = /datum/greyscale_config/sus_overalls/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sus_overalls/worn/digi
	greyscale_colors = "#787878#252525#CCCED1"
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = TRUE

/obj/item/clothing/under/greyscale/overalls/skirt
	name = "skirt overalls"
	desc = "Overalls designed to be comfortable, and keep you from getting wet, while only one of those is true, its still nice to have."
	icon_state = "/obj/item/clothing/under/greyscale/overalls/skirt"
	post_init_icon_state = "overalls_skirt"
