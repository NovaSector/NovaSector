/obj/item/clothing/neck/cloak/hos/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak_blue"

/datum/atom_skin/security_cape
	abstract_type = /datum/atom_skin/security_cape

/datum/atom_skin/security_cape/black
	preview_name = "Black Variant"
	new_icon_state = "cape_black"

/datum/atom_skin/security_cape/red
	preview_name = "Red Variant"
	new_icon_state = "cape_red"

/datum/atom_skin/security_cape/blue
	preview_name = "Blue Variant"
	new_icon_state = "cape_blue"

/datum/atom_skin/security_cape/white
	preview_name = "White Variant"
	new_icon_state = "cape_white"

/obj/item/clothing/neck/security_cape
	name = "security cape"
	desc = "A fashionable cape worn by security officers."
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cape_black"
	inhand_icon_state = "" //no unique inhands
	///Decides the shoulder it lays on, false = RIGHT, TRUE = LEFT
	var/swapped = FALSE

/obj/item/clothing/neck/security_cape/Initialize(mapload)
	. = ..()
	if(type == /obj/item/clothing/neck/security_cape) // Prevent its armplate subtype from adding this
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_cape)

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

/datum/atom_skin/security_gauntlet
	abstract_type = /datum/atom_skin/security_gauntlet

/datum/atom_skin/security_gauntlet/black
	preview_name = "Black Variant"
	new_icon_state = "armplate_black"

/datum/atom_skin/security_gauntlet/red
	preview_name = "Red Variant"
	new_icon_state = "armplate_red"

/datum/atom_skin/security_gauntlet/blue
	preview_name = "Blue Variant"
	new_icon_state = "armplate_blue"

/datum/atom_skin/security_gauntlet/capeless
	preview_name = "Capeless Variant"
	new_icon_state = "armplate"

/obj/item/clothing/neck/security_cape/armplate
	name = "security gauntlet"
	desc = "A fashionable full-arm gauntlet worn by security officers. The gauntlet itself is made of plastic, and provides no protection, but it looks cool as hell."
	icon_state = "armplate_black"

/obj/item/clothing/neck/security_cape/armplate/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_gauntlet)
