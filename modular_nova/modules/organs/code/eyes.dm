/obj/item/organ/eyes/neweyespack // You can create new eyes here. Modify eyes.dmi in icon folder
	name = "new eyes pack eyes"
	desc = "If you see this item, report to maintainer"
	eye_icon = 'modular_nova/modules/organs/icons/eyes.dmi'
	blink_animation = FALSE

/obj/item/organ/eyes/robotic/neweyespack // You can create new eyes here. This one is for robotic versions. Modify eyes.dmi in icon folder
	name = "robotic new eyes pack eyes"
	desc = "If you see this item, report to maintainer"
	eye_icon = 'modular_nova/modules/organs/icons/eyes.dmi'
	blink_animation = FALSE

/obj/item/organ/eyes/neweyespack/insect
	name = "insect eyes"
	desc = "Prettier than moff eyes"
	eye_icon_state = "insect"
	pupils_name = "there is no pupils"

/datum/augment_item/organ/eyes/insect
	name = "insect eyes"
	path = /obj/item/organ/eyes/neweyespack/insect

/obj/item/organ/eyes/robotic/neweyespack/insect
	name = "robotic insect eyes"
	desc = "Prettier than robotic moff eyes"
	eye_icon_state = "insect"
	pupils_name = "there is no pupils"

/datum/augment_item/organ/eyes/cyberinsect
	name = "Cybernetic insect eyes"
	path = /obj/item/organ/eyes/robotic/neweyespack/insect
