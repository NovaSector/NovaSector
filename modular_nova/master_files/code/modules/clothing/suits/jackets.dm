// Towa's Croptop Bomber Jacket (DarkRilo)

/obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket
	name = "croptop bomber jacket"
	desc = "This stylish jacket, often worn by folk who have a good sense of style is in fact warm despite it being a crop top."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket"
	inhand_icon_state = null
	body_parts_covered = CHEST
	post_init_icon_state = "croptop_bomber_base"
	base_icon_state = "croptop_bomber_base"
	greyscale_config = /datum/greyscale_config/croptop_bomber_jacket
	greyscale_config_worn = /datum/greyscale_config/croptop_bomber_jacket/worn
	greyscale_colors = "#227EFE#E5F0EA#B8BB59#FF0000"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/croptop_bomber_jacket)

/datum/atom_skin/croptop_bomber_jacket/apply(atom/apply_to, mob/user)
	. = ..()
	if(isitem(apply_to)) // The toggle_icon component is evil. that's all.
		var/obj/item/item_applied_to = apply_to
		var/obj/item/greyscale_item = greyscale_item_path
		item_applied_to.icon_state = greyscale_item::post_init_icon_state
		item_applied_to.post_init_icon_state = greyscale_item::post_init_icon_state
		item_applied_to.base_icon_state = greyscale_item::base_icon_state

/obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/stripe
	icon_state = "/obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/stripe"
	post_init_icon_state = "croptop_bomber_stripe"
	base_icon_state = "croptop_bomber_stripe"

/obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/badge
	icon_state = "/obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/badge"
	post_init_icon_state = "croptop_bomber_badge"
	base_icon_state = "croptop_bomber_badge"

/obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/plain
	icon_state = "/obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/plain"
	post_init_icon_state = "croptop_bomber_plain"
	base_icon_state = "croptop_bomber_plain"

// Atom skins

/datum/atom_skin/croptop_bomber_jacket
	abstract_type = /datum/atom_skin/croptop_bomber_jacket
	greyscale_item_path = /obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket

/datum/atom_skin/croptop_bomber_jacket/base
	preview_name = "Croptop Bomber Jacket"
	new_icon_state = "croptop_bomber_base"

/datum/atom_skin/croptop_bomber_jacket/plain
	preview_name = "Croptop Bomber Jacket Plain"
	new_icon_state = "croptop_bomber_plain"
	greyscale_item_path = /obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/plain

/datum/atom_skin/croptop_bomber_jacket/stripe
	preview_name = "Croptop Bomber Jacket Stripe"
	new_icon_state = "croptop_bomber_stripe"
	greyscale_item_path = /obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/stripe

/datum/atom_skin/croptop_bomber_jacket/badge
	preview_name = "Croptop Bomber Jacket Badge"
	new_icon_state = "croptop_bomber_badge"
	greyscale_item_path = /obj/item/clothing/suit/toggle/jacket/croptop_bomber_jacket/badge
