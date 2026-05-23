/obj/item/organ/eyes/nova
	abstract_type = /obj/item/organ/eyes/nova
	eye_icon = 'modular_nova/modules/organs/icons/eyes.dmi'
	blink_animation = FALSE

/obj/item/organ/eyes/robotic/nova
	abstract_type = /obj/item/organ/eyes/robotic/nova
	eye_icon = 'modular_nova/modules/organs/icons/eyes.dmi'
	blink_animation = FALSE

/obj/item/organ/eyes/nova/insect
	name = "insect eyes"
	desc = "Prettier than moff eyes."
	eye_icon_state = "insect"
	pupils_name = "ommatidia"

/datum/augment_item/organ/eyes/insect
	name = "Insect eyes"
	path = /obj/item/organ/eyes/nova/insect

/obj/item/organ/eyes/robotic/nova/insect
	name = "robotic insect eyes"
	desc = "Prettier than robotic moff eyes."
	eye_icon_state = "insect"
	pupils_name = "ommatidia"

/datum/augment_item/organ/eyes/cybernetic/insect
	name = "Cybernetic insect eyes"
	path =/obj/item/organ/eyes/robotic/nova/insect
