/datum/atom_skin/blastwave_suit
	abstract_type = /datum/atom_skin/blastwave_suit

/datum/atom_skin/blastwave_suit/purple
	preview_name = "Default (Purple)"
	new_icon_state = "blastwave_suit"

/datum/atom_skin/blastwave_suit/red
	preview_name = "Red"
	new_icon_state = "blastwave_suit_r"

/datum/atom_skin/blastwave_suit/green
	preview_name = "Green"
	new_icon_state = "blastwave_suit_g"

/datum/atom_skin/blastwave_suit/blue
	preview_name = "Blue"
	new_icon_state = "blastwave_suit_b"

/datum/atom_skin/blastwave_suit/yellow
	preview_name = "Yellow"
	new_icon_state = "blastwave_suit_y"

/obj/item/clothing/suit/blastwave
	name = "blastwave trenchcoat"
	desc = "A generic trenchcoat of the boring wars."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/suit_digi.dmi'
	icon_state = "blastwave_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/blastwave/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blastwave_suit)
