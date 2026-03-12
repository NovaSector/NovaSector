/datum/atom_skin/blastwave_uniform
	abstract_type = /datum/atom_skin/blastwave_uniform

/datum/atom_skin/blastwave_uniform/purple
	preview_name = "Default (Purple)"
	new_icon_state = "blastwave_uniform"

/datum/atom_skin/blastwave_uniform/red
	preview_name = "Red"
	new_icon_state = "blastwave_uniform_r"

/datum/atom_skin/blastwave_uniform/green
	preview_name = "Green"
	new_icon_state = "blastwave_uniform_g"

/datum/atom_skin/blastwave_uniform/blue
	preview_name = "Blue"
	new_icon_state = "blastwave_uniform_b"

/datum/atom_skin/blastwave_uniform/yellow
	preview_name = "Yellow"
	new_icon_state = "blastwave_uniform_y"

/obj/item/clothing/under/blastwave
	name = "blastwave uniform"
	desc = "An utilitarian uniform of rugged warfare."
	icon = 'modular_nova/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "blastwave_uniform"
	can_adjust = FALSE

/obj/item/clothing/under/blastwave/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/blastwave_uniform)
