/obj/item/clothing/under/greyscale
	icon = 'modular_nova/master_files/icons/obj/clothing/under/shorts_pants_shirts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts_digi.dmi'
	// Defaults to FALSE for this type because greyscale items are less commonly adjustable
	can_adjust = FALSE

/*
*	This file is for things that are recolorable and/or mix-and-match. Things like Jeans, T-Shirts, Skirts.
*	Basically the hope is that items here will reuse component icons that already exist in the .dmis where possible.
*
*	(Do not put items here that are too specific. These should generally be generic, customizable uniforms.)
*	These will likely fit in the CASUALWEAR loadout category.
*/

/obj/item/clothing/under/greyscale/turtleneck
	name = "turtleneck with pants"
	desc = "A rather comfortable turtleneck worn with pants. Talk about robust threads."
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
	name = "turtleneck with skirt"
	desc = "A rather comfortable turtleneck worn with a skirt. A skirtleneck, if you would."
	icon_state = "/obj/item/clothing/under/greyscale/turtleneck/skirt"
	post_init_icon_state = "skirtleneck"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/greyscale/gorkas
	name = "gorka jumpsuit"
	desc = "A somewhat comfortable gorka, as comfy as a regular jumpsuit but with a more unique design."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/greyscale/gorkas"
	post_init_icon_state = "gags_gorka"
	greyscale_config = /datum/greyscale_config/gorkas
	greyscale_config_worn = /datum/greyscale_config/gorkas/worn
	greyscale_config_worn_digi = /datum/greyscale_config/gorkas/worn/digi
	greyscale_colors = "#787878#252525"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/greyscale/overalls
	name = "turtleneck with overalls"
	desc = "Overalls worn over a turtleneck. A combination providing comfort and coverage... or, at the least, the coverage."
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
	name = "turtleneck with overalls-skirt"
	desc = "An overalls-skirt worn over a turtleneck. A combination providing comfort and coverage... or, at the least- no, wait, this doesn't really provide either."
	icon_state = "/obj/item/clothing/under/greyscale/overalls/skirt"
	post_init_icon_state = "overalls_skirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

	/obj/item/clothing/under/costume/dutch
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/costume/dutch"
	post_init_icon_state = "dutchsuit"
	greyscale_config = /datum/greyscale_config/dutch_outfit
	greyscale_config_worn = /datum/greyscale_config/dutch_outfit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/dutch_outfit/worn/digi
	greyscale_colors = "#333333#f8f8f8#ff0000#ffcc00"
	flags_1 = IS_PLAYER_COLORABLE_1

/*
*	Suit slot clothing.
*/

/obj/item/clothing/suit/costume/pg
	icon = 'icons/map_icons/clothing/suit/costume.dmi'
	icon_state = "/obj/item/clothing/suit/costume/pg"
	post_init_icon_state = "powderganger"
	greyscale_config = /datum/greyscale_config/powderganger
	greyscale_config_worn = /datum/greyscale_config/powderganger/worn
	greyscale_colors = "#76502b#c0c0c0"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/chaplainsuit/monkrobeeast
	icon = 'icons/map_icons/clothing/suit/costume.dmi'
	icon_state = "/obj/item/clothing/suit/chaplainsuit/monkrobeeast"
	post_init_icon_state = "monkrobeeast"
	greyscale_config = /datum/greyscale_config/monkrobeeast
	greyscale_config_worn = /datum/greyscale_config/monkrobeeast/worn
	greyscale_config_worn_digi = /datum/greyscale_config/monkrobeeast/worn/digi
	greyscale_colors = "#EADB83#D98E43#A52F29#212026"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
