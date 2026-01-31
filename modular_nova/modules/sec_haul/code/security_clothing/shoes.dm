/datum/atom_skin/security_jackboots
	abstract_type = /datum/atom_skin/security_jackboots

/datum/atom_skin/security_jackboots/red
	preview_name = "Red Variant"
	new_icon_state = "securityboots"

/datum/atom_skin/security_jackboots/blue
	preview_name = "Blue Variant"
	new_icon_state = "securityboots_blue"

/datum/atom_skin/security_jackboots/white
	preview_name = "White Variant"
	new_icon_state = "securityboots_white"

/datum/atom_skin/security_jackboots/black
	preview_name = "Black Variant"
	new_icon_state = "securityboots_black"

/obj/item/clothing/shoes/jackboots/sec/blue
	icon_state = "security_boots"
	icon = 'modular_nova/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/feet.dmi'

/obj/item/clothing/shoes/jackboots/sec/blue/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_jackboots)
