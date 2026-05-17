/obj/item/clothing/neck/cloak/hos/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak_blue"

/obj/item/clothing/neck/security_cape
	inhand_icon_state = "" //no unique inhands
	///Decides the shoulder it lays on, false = RIGHT, TRUE = LEFT
	var/swapped = FALSE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/security_cape/shoulder
	name = "guard cape"
	desc = "A fashionable cape worn by guards."
	icon_state = "/obj/item/clothing/neck/security_cape/shoulder"
	post_init_icon_state = "depgag_cape"
	greyscale_config = /datum/greyscale_config/depgag_cape
	greyscale_config_worn = /datum/greyscale_config/depgag_cape/worn
	greyscale_colors = "#A52F29#39393F"

/obj/item/clothing/neck/security_cape/shoulder/blue
	icon_state = "/obj/item/clothing/neck/security_cape/shoulder/blue"
	greyscale_colors = "#3F6E9E#39393F"

/obj/item/clothing/neck/security_cape/click_alt(mob/user)
	swapped = !swapped
	to_chat(user, span_notice("You swap which arm [src] will lay over."))
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/neck/security_cape/update_appearance(updates)
	. = ..()
	if(swapped)
		worn_icon_state = icon_state
	else
		worn_icon_state = "[icon_state]_left"

	usr.update_worn_neck()

/obj/item/clothing/neck/security_cape/armplate
	name = "guard gauntlet"
	desc = "A fashionable full-arm gauntlet worn by guards. The gauntlet itself is made of plastic, and provides no protection, but it looks cool as hell."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "armplate"

/obj/item/clothing/neck/security_cape/armplate_caped
	name = "caped guard gauntlet"
	desc = "A fashionable full-arm gauntlet worn by guards. The gauntlet itself is made of plastic, and provides no protection, but it looks cool as hell."
	icon_state = "/obj/item/clothing/neck/security_cape/armplate_caped"
	post_init_icon_state = "depgag_gauntlet"
	greyscale_config = /datum/greyscale_config/depgag_caped_gauntlet
	greyscale_config_worn = /datum/greyscale_config/depgag_caped_gauntlet/worn
	greyscale_colors = "#A52F29"

/obj/item/clothing/neck/security_cape/armplate_caped/blue
	icon_state = "/obj/item/clothing/neck/security_cape/armplate_caped/blue"
	greyscale_colors = "#3F6E9E"
