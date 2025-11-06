/obj/item/clothing/under/sweater
	name = "cableknit sweater"
	desc = "Why trade style for comfort? Now you can go commando down south and still be cozy up north."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
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
	unique_reskin = list(
		"Turtleneck" = "cableknit_sweater",
		"Keyhole" = "keyhole_sweater",
		"Neckless" = "cleavage_sweater",
		"Crop Top" = "croptop_sweater",
	)
