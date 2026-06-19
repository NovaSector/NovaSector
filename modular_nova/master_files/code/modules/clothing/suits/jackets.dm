//Towa's Croptop Bomber Jacker (DarkRilo)
/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket
	name = "\improper Croptop Bomber Jacket"
	desc = "This stylish jacket, often worn by folk who have a good sense of style is in fact warm despite it being a crop top."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket"
	inhand_icon_state = null
	body_parts_covered = CHEST
	post_init_icon_state = "croptop_bomber_base"
	greyscale_config = /datum/greyscale_config/croptopbomberjacket
	greyscale_config_worn = /datum/greyscale_config/croptopbomberjacket/worn
	greyscale_colors = "#227EFE#E5F0EA#B8BB59#FF0000"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/croptopbomberjacket)

/datum/atom_skin/croptopbomberjacket
	abstract_type = /datum/atom_skin/croptopbomberjacket
	greyscale_item_path = /obj/item/clothing/suit/toggle/jacket/croptopbomberjacket

/datum/atom_skin/croptopbomberjacket/croptop_bomber_base_alt
	preview_name = "CropTop Bomber Jacker (Alt)"
	new_icon_state = "croptop_bomber_base_alt"

//Croptop Jacket Alt Stripe

/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_stripe
	name = "\improper Croptop Bomber Jacket Stripe"
	desc = "This stylish jacket, often worn by folk who have a good sense of style is in fact warm despite it being a crop top."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_stripe"
	inhand_icon_state = null
	body_parts_covered = CHEST
	post_init_icon_state = "croptop_bomber_stripe"
	greyscale_config = /datum/greyscale_config/croptopbomberjacket_stripe
	greyscale_config_worn = /datum/greyscale_config/croptopbomberjacket_stripe/worn
	greyscale_colors = "#227EFE#E5F0EA#B8BB59"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_stripe/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/croptopbomberjacket_stripe)

/datum/atom_skin/croptopbomberjacket_stripe
	abstract_type = /datum/atom_skin/croptopbomberjacket_stripe
	greyscale_item_path = /obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_stripe

/datum/atom_skin/croptopbomberjacket_stripe/croptop_bomber_stripe_alt
	preview_name = "CropTop Bomber Jacker (Alt)"
	new_icon_state = "croptop_bomber_stripe_t"

//Croptop Jacket Alt Badge

/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_badge
	name = "\improper Croptop Bomber Jacket Badge"
	desc = "This stylish jacket, often worn by folk who have a good sense of style is in fact warm despite it being a crop top."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_badge"
	inhand_icon_state = null
	body_parts_covered = CHEST
	post_init_icon_state = "croptop_bomber_badge"
	greyscale_config = /datum/greyscale_config/croptopbomberjacket_badge
	greyscale_config_worn = /datum/greyscale_config/croptopbomberjacket_badge/worn
	greyscale_colors = "#227EFE#E5F0EA#FF0000"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_badge/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/croptopbomberjacket_badge)

/datum/atom_skin/croptopbomberjacket_badge
	abstract_type = /datum/atom_skin/croptopbomberjacket_badge
	greyscale_item_path = /obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_badge

/datum/atom_skin/croptopbomberjacket_badge/croptop_bomber_base_alt
	preview_name = "CropTop Bomber Jacker (Alt)"
	new_icon_state = "croptop_bomber_badge_t"

//Croptop Jacket Alt Plain

/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_plain
	name = "\improper Croptop Bomber Jacket Plain"
	desc = "This stylish jacket, often worn by folk who have a good sense of style is in fact warm despite it being a crop top."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_plain"
	inhand_icon_state = null
	body_parts_covered = CHEST
	post_init_icon_state = "croptop_bomber_plain"
	greyscale_config = /datum/greyscale_config/croptopbomberjacket_plain
	greyscale_config_worn = /datum/greyscale_config/croptopbomberjacket_plain/worn
	greyscale_colors = "#227EFE#E5F0EA"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_plain/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/croptopbomberjacket_plain)

/datum/atom_skin/croptopbomberjacket_plain
	abstract_type = /datum/atom_skin/croptopbomberjacket_plain
	greyscale_item_path = /obj/item/clothing/suit/toggle/jacket/croptopbomberjacket_plain

/datum/atom_skin/croptopbomberjacket_plain/croptop_bomber_base_alt
	preview_name = "CropTop Bomber Jacker (Alt)"
	new_icon_state = "croptop_bomber_plain_t"
