/obj/item/clothing/under/sweater
	name = "cableknit sweater"
	desc = "Why trade style for comfort? Now you can go commando down south and still be cozy up north."
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/sweater"
	post_init_icon_state = "cableknit_sweater"
	greyscale_config = /datum/greyscale_config/cableknit_sweater
	greyscale_config_worn = /datum/greyscale_config/cableknit_sweater/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/cableknit_sweater/worn/teshari
	greyscale_colors = "#b2a484"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = TRUE
	flags_1 = IS_PLAYER_COLORABLE_1
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/sweater/black
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/sweater"
	post_init_icon_state = "cableknit_sweater"
	name = "black cableknit sweater"
	greyscale_colors = "#4f4f4f"

/obj/item/clothing/under/sweater/red
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/sweater"
	post_init_icon_state = "cableknit_sweater"
	name = "red cableknit sweater"
	greyscale_colors = "#9a0000"

/obj/item/clothing/under/sweater/keyhole
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/sweater"
	post_init_icon_state = "cableknit_sweater"
	name = "keyhole sweater"
	desc = "So let me get this straight. They cut cleavage out of something meant to keep you warm..? Why? \"Now you can go commando down south and be freezing cold on your chest\" isn't a good motto!"
	greyscale_colors = "#c5699c"
