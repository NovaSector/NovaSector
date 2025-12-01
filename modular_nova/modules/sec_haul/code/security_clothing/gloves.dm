/datum/atom_skin/sec_gloves_white
	abstract_type = /datum/atom_skin/sec_gloves_white

/datum/atom_skin/sec_gloves_white/black
	preview_name = "Black Variant"
	new_icon_state = "gloves_black"

/datum/atom_skin/sec_gloves_white/blue
	preview_name = "Blue Variant"
	new_icon_state = "gloves_blue"

/datum/atom_skin/sec_gloves_white/white
	preview_name = "White Variant"
	new_icon_state = "gloves_white"

/obj/item/clothing/gloves/color/black/security/white
	icon = 'modular_nova/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "gloves_white"

/obj/item/clothing/gloves/color/black/security/white/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/sec_gloves_white)
