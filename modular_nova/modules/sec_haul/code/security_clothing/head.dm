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

/obj/item/clothing/head/security_garrison
	name = "security garrison cap"
	desc = "A robust garrison cap with the nanotrasen insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "/obj/item/clothing/head/depgag_cap"
	post_init_icon_state = "depgag_garrison"
	greyscale_config = /datum/greyscale_config/depgag_garrison
	greyscale_config_worn = /datum/greyscale_config/depgag_garrison/worn
	greyscale_colors = "#A52F29"
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/ushanka/sec/red
	icon_state = "/obj/item/clothing/head/costume/ushanka/sec/red"
	greyscale_colors = "#C7B08B#A52F29"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/ushanka/sec/blue
	icon_state = "/obj/item/clothing/head/costume/ushanka/sec/blue"
	greyscale_colors = "#C7B08B#3F6E9E"
	flags_1 = IS_PLAYER_COLORABLE_1

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
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/security_cap/blue
	icon_state = "/obj/item/clothing/head/security_cap/blue"
	greyscale_colors = "#3F6E9E#EBEBEB#3F6E9E"

/obj/item/clothing/head/beret/sec/depgag
	icon_state = "/obj/item/clothing/head/beret/sec/depgag"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#A52F29#EBEBEB"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/beret/sec/depgag/blue
	icon_state = "/obj/item/clothing/head/beret/sec/depgag/blue"
	greyscale_colors = "#3F6E9E#EBEBEB"

/obj/item/clothing/head/hats/warden/police/patrol
	name = "guard patrol cap"
	desc = "A dark colored hat with a silver badge, for the officer interested in style."
	post_init_icon_state = "depgag_patrol_cap"
	icon_state = "/obj/item/clothing/head/hats/warden/police/patrol"
	greyscale_config = /datum/greyscale_config/depgag_patrol_cap
	greyscale_config_worn = /datum/greyscale_config/depgag_patrol_cap/worn
	greyscale_colors = "#39393F#A52F29"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/head_helmet
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/hats/warden/police/patrol/blue
	icon_state = "/obj/item/clothing/head/hats/warden/police/patrol/blue"
	greyscale_colors = "#39393F#3F6E9E"

/obj/item/clothing/head/beret/sec/navywarden/nova
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	icon_state = "/obj/item/clothing/head/beret/sec/navywarden/nova"
	post_init_icon_state = "beret_badge_fancy_twist"
	greyscale_config = /datum/greyscale_config/beret_badge_fancy
	greyscale_config_worn = /datum/greyscale_config/beret_badge_fancy/worn
	greyscale_colors = "#3f6e9e#FF0000#00AEEF"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/hats_warden
