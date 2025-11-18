/obj/item/clothing/neck/cloak/hos/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak_blue"

/obj/item/clothing/neck/security_cape
	name = "security cape"
	desc = "A fashionable cape worn by security officers."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cape_black"
	inhand_icon_state = "" //no unique inhands
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "cape_black",
			RESKIN_WORN_ICON_STATE = "cape_black"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "cape_red",
			RESKIN_WORN_ICON_STATE = "cape_red"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "cape_blue",
			RESKIN_WORN_ICON_STATE = "cape_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "cape_white",
			RESKIN_WORN_ICON_STATE = "cape_white"
		),
	)
	///Decides the shoulder it lays on, false = RIGHT, TRUE = LEFT
	var/swapped = FALSE

/obj/item/clothing/neck/security_cape/armplate
	name = "security gauntlet"
	desc = "A fashionable full-arm gauntlet worn by security officers. The gauntlet itself is made of plastic, and provides no protection, but it looks cool as hell."
	icon_state = "armplate_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "armplate_black",
			RESKIN_WORN_ICON_STATE = "armplate_black"
		),
		"Red Variant" = list(
			RESKIN_ICON_STATE = "armplate_red",
			RESKIN_WORN_ICON_STATE = "armplate_red"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "armplate_blue",
			RESKIN_WORN_ICON_STATE = "armplate_blue"
		),
		"Capeless Variant" = list(
			RESKIN_ICON_STATE = "armplate",
			RESKIN_WORN_ICON_STATE = "armplate"
		),
	)

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
