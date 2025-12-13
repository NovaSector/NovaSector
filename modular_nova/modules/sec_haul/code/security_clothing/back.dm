/datum/atom_skin/security_backpack_blue
	abstract_type = /datum/atom_skin/security_backpack_blue

/datum/atom_skin/security_backpack_blue/black
	preview_name = "Black Variant"
	new_icon_state = "backpack_security_black"

/datum/atom_skin/security_backpack_blue/white
	preview_name = "White Variant"
	new_icon_state = "backpack_security_white"

/obj/item/storage/backpack/security/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "backpack_security_black"
	inhand_icon_state = "backpack_security_black"

/obj/item/storage/backpack/security/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_backpack_blue)

/datum/atom_skin/security_satchel_blue
	abstract_type = /datum/atom_skin/security_satchel_blue

/datum/atom_skin/security_satchel_blue/black
	preview_name = "Black Variant"
	new_icon_state = "satchel_security_black"

/datum/atom_skin/security_satchel_blue/white
	preview_name = "White Variant"
	new_icon_state = "satchel_security_white"

/obj/item/storage/backpack/satchel/sec/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "satchel_security_black"
	inhand_icon_state = "satchel_security_black"

/obj/item/storage/backpack/satchel/sec/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_satchel_blue)

/datum/atom_skin/security_duffelbag_black
	abstract_type = /datum/atom_skin/security_duffelbag_black

/datum/atom_skin/security_duffelbag_black/black
	preview_name = "Black Variant"
	new_icon_state = "duffel_security_black"

/datum/atom_skin/security_duffelbag_black/white
	preview_name = "White Variant"
	new_icon_state = "duffel_security_white"

/obj/item/storage/backpack/duffelbag/sec/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "duffel_security_black"
	inhand_icon_state = "duffel_security_black"

/obj/item/storage/backpack/duffelbag/sec/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_duffelbag_black)

/datum/atom_skin/security_messenger_blue
	abstract_type = /datum/atom_skin/security_messenger_blue

/datum/atom_skin/security_messenger_blue/black
	preview_name = "Black Variant"
	new_icon_state = "messenger_security_black"

/datum/atom_skin/security_messenger_blue/white
	preview_name = "White Variant"
	new_icon_state = "messenger_security_white"

/obj/item/storage/backpack/messenger/sec/blue
	icon_state = "messenger_security_black"
	inhand_icon_state = "messenger_security_black"
	icon = 'modular_nova/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'

/obj/item/storage/backpack/messenger/sec/blue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_messenger_blue)
