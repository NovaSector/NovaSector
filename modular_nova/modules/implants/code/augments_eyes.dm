/obj/item/organ/eyes/night_vision/cyber
	name = "nightvision eyes"
	icon = 'modular_nova/modules/implants/icons/chest_modular.dmi' //All in the chest implants .dmi
	icon_state = "eyes_nvcyber"
	desc = "A pair of eyes with built-in nightvision optics, with the additional bonus of being rad as hell."
	eye_color_left = "#0ffc03"
	eye_color_right = "#ff2700"
	organ_flags = ORGAN_ROBOTIC
	low_light_cutoff = list(0, 15, 20)
	medium_light_cutoff = list(0, 20, 35)
	high_light_cutoff = list(0, 40, 50)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT)
