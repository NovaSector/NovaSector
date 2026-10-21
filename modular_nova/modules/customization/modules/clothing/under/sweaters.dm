/datum/atom_skin/cableknit_sweater
	abstract_type = /datum/atom_skin/cableknit_sweater
	greyscale_item_path = /obj/item/clothing/under/sweater

/datum/atom_skin/cableknit_sweater/turtleneck
	preview_name = "Turtleneck"
	new_icon_state = "cableknit_sweater"

/datum/atom_skin/cableknit_sweater/keyhole
	preview_name = "Keyhole"
	new_icon_state = "keyhole_sweater"

/datum/atom_skin/cableknit_sweater/cleavage
	preview_name = "Neckless"
	new_icon_state = "cleavage_sweater"

/datum/atom_skin/cableknit_sweater/croptop
	preview_name = "Crop Top"
	new_icon_state = "croptop_sweater"

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

/obj/item/clothing/under/sweater/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/cableknit_sweater)
