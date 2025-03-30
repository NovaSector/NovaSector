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
	desc = "A robust garrison cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'
	icon_state = "garrison_black"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "garrison_black",
			RESKIN_WORN_ICON_STATE = "garrison_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "garrison_blue",
			RESKIN_WORN_ICON_STATE = "garrison_blue"
		),
	)

/obj/item/clothing/head/security_cap
	name = "security cap"
	desc = "A robust cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_cap_black"
	uses_advanced_reskins = TRUE
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	dog_fashion = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "security_cap_black",
			RESKIN_WORN_ICON_STATE = "security_cap_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_cap_blue",
			RESKIN_WORN_ICON_STATE = "security_cap_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_cap_white",
			RESKIN_WORN_ICON_STATE = "security_cap_white"
		),
	)

/obj/item/clothing/head/beret/sec/nova
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	icon_state = "beret_badge"
	greyscale_colors = "#3F3C40#375989"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/head_helmet

/obj/item/clothing/head/beret/sec/navywarden/nova
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	greyscale_config = /datum/greyscale_config/beret_badge_fancy
	greyscale_config_worn = /datum/greyscale_config/beret_badge_fancy/worn
	greyscale_colors = "#3f6e9e#FF0000#00AEEF"
	icon_state = "beret_badge_fancy_twist"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/hats_warden

/obj/item/clothing/head/hats/warden/police/patrol
	name = "police patrol cap"
	desc = "A dark colored hat with a silver badge, for the officer interested in style."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policeofficerpatrolcap"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/head_helmet
	unique_reskin = list(
		"Blue" = "policeofficercap",
		"Sillitoe" = "policetrafficcap",
		"Black" = "policeofficerpatrolcap",
		"Cadet" = "policecadetcap",
	)
