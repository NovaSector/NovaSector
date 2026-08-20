/datum/crafting_recipe/satchelholding
	name = "Satchel of Holding"
	reqs = list(
		/obj/item/satchel_of_holding_inert = 1,
		/obj/item/assembly/signaler/anomaly/bluespace = 1,
	)
	result = /obj/item/storage/backpack/holding/satchel
	category = CAT_CLOTHING

/obj/item/storage/backpack/holding/satchel
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3)

/datum/crafting_recipe/duffelholding
	name = "Duffel Bag of Holding"
	reqs = list(
		/obj/item/duffel_of_holding_inert = 1,
		/obj/item/assembly/signaler/anomaly/bluespace = 1,
	)
	result = /obj/item/storage/backpack/holding/duffel
	category = CAT_CLOTHING

/obj/item/storage/backpack/holding/duffel
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3)
