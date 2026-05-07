/obj/item/clothing/head/helmet/sec/white
	icon = 'modular_nova/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "security_helmet"
	base_icon_state = "security_helmet"
	actions_types = list(/datum/action/item_action/toggle)
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION
	flags_cover = parent_type::flags_cover | PEPPERPROOF
	dog_fashion = null

/obj/item/clothing/head/helmet/sec/white/click_alt(mob/user)
	. = ..()
	if (flipped_visor)
		flags_cover &= ~PEPPERPROOF
	else
		flags_cover |= PEPPERPROOF

/datum/atom_skin/security_garrison_cap
	abstract_type = /datum/atom_skin/security_garrison_cap

/datum/atom_skin/security_garrison_cap/black
	preview_name = "Black Variant"
	new_icon_state = "garrison_black"

/datum/atom_skin/security_garrison_cap/blue
	preview_name = "Blue Variant"
	new_icon_state = "garrison_blue"

/obj/item/clothing/head/security_garrison
	name = "security garrison cap"
	desc = "A robust garrison cap with the nanotrasen insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'
	icon_state = "garrison_black"
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/security_garrison/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_garrison_cap)

/obj/item/clothing/head/security_cap
	name = "security cap"
	desc = "A robust cap with the Nanotrasen insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/depgag_cap"
	post_init_icon_state = "depgag_cap"
	greyscale_config = /datum/greyscale_config/depgag_cap
	greyscale_config_worn = /datum/greyscale_config/depgag_cap/worn
	greyscale_colors = "#A52F29#EBEBEB#A52F29"
	armor_type = /datum/armor/cosmetic_sec
	strip_delay = 60
	dog_fashion = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
/*
/obj/item/clothing/head/security_cap/blue
	icon_state = "/obj/item/clothing/head/security_cap/blue"
	greyscale_colors = "#3F6E9E#EBEBEB#3F6E9E"

/obj/item/clothing/head/security_cap/white
	icon_state = "/obj/item/clothing/head/security_cap/white"
	greyscale_colors = "#EBEBEB#EBEBEB#39393F"

/obj/item/clothing/head/security_cap/black
	icon_state = "/obj/item/clothing/head/security_cap/black"
	greyscale_colors = "#39393F#EBEBEB#39393F"
*/
/obj/item/clothing/head/beret/sec/nova
	icon_state = "/obj/item/clothing/head/beret/sec/nova"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#A52F29#EBEBEB"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/head_helmet

/obj/item/clothing/head/beret/sec/nova/blue
	icon_state = "/obj/item/clothing/head/beret/sec/nova/blue"
	greyscale_colors = "#3F6E9E#EBEBEB"

/obj/item/clothing/head/beret/sec/nova/white
	icon_state = "/obj/item/clothing/head/beret/sec/nova/white"
	greyscale_colors = "#EBEBEB#39393F"

/obj/item/clothing/head/beret/sec/nova/black
	icon_state = "/obj/item/clothing/head/beret/sec/nova/black"
	greyscale_colors = "#39393F#EBEBEB"

/obj/item/clothing/head/beret/sec/navywarden/nova
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	icon_state = "/obj/item/clothing/head/beret/sec/navywarden/nova"
	post_init_icon_state = "beret_badge_fancy_twist"
	greyscale_config = /datum/greyscale_config/beret_badge_fancy
	greyscale_config_worn = /datum/greyscale_config/beret_badge_fancy/worn
	greyscale_colors = "#3f6e9e#FF0000#00AEEF"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/hats_warden

/obj/item/clothing/head/hats/warden/police/patrol
	name = "police patrol cap"
	desc = "A dark colored hat with a silver badge, for the officer interested in style."
	post_init_icon_state = "depgag_patrol_cap"
	icon_state = "/obj/item/clothing/head/hats/warden/police/patrol"
	greyscale_config = /datum/greyscale_config/depgag_patrol_cap
	greyscale_config_worn = /datum/greyscale_config/depgag_patrol_cap/worn
	greyscale_colors = "#A52F29#39393F"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/head_helmet

/obj/item/clothing/head/hats/warden/police/patrol/blue
	icon_state = "/obj/item/clothing/head/hats/warden/police/patrol/blue"
	greyscale_colors = "#3F6E9E#EBEBEB"

/obj/item/clothing/head/hats/warden/police/patrol/white
	icon_state = "/obj/item/clothing/head/hats/warden/police/patrol/white"
	greyscale_colors = "#EBEBEB#39393F"

/obj/item/clothing/head/hats/warden/police/patrol/black
	icon_state = "/obj/item/clothing/head/hats/warden/police/patrol/black"
	greyscale_colors = "#39393F#EBEBEB"
