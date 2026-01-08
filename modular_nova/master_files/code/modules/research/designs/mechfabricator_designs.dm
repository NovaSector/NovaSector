/datum/design/modlink_scryer
	// use the loaded modlink scryer object to have the frequency set to NT upon creation
	build_path = /obj/item/clothing/neck/link_scryer/loaded

/datum/design/mod_plating/security
	name = "MOD Security Plating"
	id = "mod_plating_security"
	build_path = /obj/item/mod/construction/plating/security
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*3,
		/datum/material/uranium =SHEET_MATERIAL_AMOUNT,
		/datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	research_icon_state = "security-plating"

// Protean Servo Module
/datum/design/module/mod_protean_servo
	name = "Protean Servo Module"
	id = "mod_protean_servo"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/mod/module/protean_servo
	category = list(
		RND_CATEGORY_MODSUIT_MODULES + RND_SUBCATEGORY_MODSUIT_MODULES_GENERAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
