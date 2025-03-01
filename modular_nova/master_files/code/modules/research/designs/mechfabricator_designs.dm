/datum/design/modlink_scryer
	// use the loaded modlink scryer object to have the frequency set to NT upon creation
	build_path = /obj/item/clothing/neck/link_scryer/loaded

/datum/design/module/retractplates
	name = "Retractive Plates Module"
	id = "mod_retract_plates"
	materials = list(
		/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	build_path = /obj/item/mod/module/armor_booster/retractplates
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_SECURITY,
	)
