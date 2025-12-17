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
	desc = "A robust garrison cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'
	icon_state = "garrison_black"
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/security_garrison/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_garrison_cap)

/datum/atom_skin/security_cap
	abstract_type = /datum/atom_skin/security_cap

/datum/atom_skin/security_cap/black
	preview_name = "Black Variant"
	new_icon_state = "security_cap_black"

/datum/atom_skin/security_cap/blue
	preview_name = "Blue Variant"
	new_icon_state = "security_cap_blue"

/datum/atom_skin/security_cap/white
	preview_name = "White Variant"
	new_icon_state = "security_cap_white"

/obj/item/clothing/head/security_cap
	name = "security cap"
	desc = "A robust cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_cap_black"
	armor_type = /datum/armor/head_helmet
	strip_delay = 60
	dog_fashion = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/security_cap/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_cap)

/obj/item/clothing/head/beret/sec/nova
	icon_state = "/obj/item/clothing/head/beret/sec/nova"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#3F3C40#375989"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/head_helmet

/obj/item/clothing/head/beret/sec/navywarden/nova
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	icon_state = "/obj/item/clothing/head/beret/sec/navywarden/nova"
	post_init_icon_state = "beret_badge_fancy_twist"
	greyscale_config = /datum/greyscale_config/beret_badge_fancy
	greyscale_config_worn = /datum/greyscale_config/beret_badge_fancy/worn
	greyscale_colors = "#3f6e9e#FF0000#00AEEF"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/hats_warden

/datum/atom_skin/police_patrol_cap
	abstract_type = /datum/atom_skin/police_patrol_cap

/datum/atom_skin/police_patrol_cap/blue
	preview_name = "Blue"
	new_icon_state = "policeofficercap"

/datum/atom_skin/police_patrol_cap/sillitoe
	preview_name = "Sillitoe"
	new_icon_state = "policetrafficcap"

/datum/atom_skin/police_patrol_cap/black
	preview_name = "Black"
	new_icon_state = "policeofficerpatrolcap"

/datum/atom_skin/police_patrol_cap/policecadetcap
	preview_name = "Cadet"
	new_icon_state = "policecadetcap"

/obj/item/clothing/head/hats/warden/police/patrol
	name = "police patrol cap"
	desc = "A dark colored hat with a silver badge, for the officer interested in style."
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policeofficerpatrolcap"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/head_helmet

/obj/item/clothing/head/hats/warden/police/patrol/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/police_patrol_cap)
