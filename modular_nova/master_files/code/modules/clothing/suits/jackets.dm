//Towa's Croptop Bomber Jacker (DarkRilo)
/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket
	name = "\improper Croptop Bomber Jacket"
	desc = "Placeholder"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket"
	inhand_icon_state = null
	body_parts_covered = CHEST
	post_init_icon_state = "croptop_bomber_base"
	greyscale_config = /datum/greyscale_config/croptopbomberjacket
	greyscale_config_worn = /datum/greyscale_config/croptopbomberjacket/worn
	greyscale_colors = "#424242#424242#424242#424242"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/croptopbomberjacket)

/datum/atom_skin/croptopbomberjacket
	abstract_type = /datum/atom_skin/croptopbomberjacket
	greyscale_item_path = /obj/item/clothing/suit/toggle/jacket/croptopbomberjacket

/datum/atom_skin/croptopbomberjacket/croptop_bomber_base_alt
	preview_name = "CropTop Bomber Jacker (Alt)"
	new_icon_state = "croptop_bomber_base_alt"
