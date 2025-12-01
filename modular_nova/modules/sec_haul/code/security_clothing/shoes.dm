/datum/atom_skin/security_jackboots
	abstract_type = /datum/atom_skin/security_jackboots

/datum/atom_skin/security_jackboots/blue_trim
	preview_name = "Blue-Trimmed Variant"
	new_icon_state = "security_boots"

/datum/atom_skin/security_jackboots/white_trim
	preview_name = "White-Trimmed Variant"
	new_icon_state = "security_boots_white"

/datum/atom_skin/security_jackboots/fullwhite
	preview_name = "Full White Variant"
	new_icon_state = "security_boots_fullwhite"

/obj/item/clothing/shoes/jackboots/sec/blue
	icon_state = "security_boots"
	icon = 'modular_nova/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/feet.dmi'

/obj/item/clothing/shoes/jackboots/sec/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_jackboots)
