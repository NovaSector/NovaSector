/datum/design/stasisbag_longterm
	name = "Long-Term Stasis Bodybag"
	desc = "A long-term stasis body bag, powered by integrated stasis technology. It can hold only one body, but it prevents decay. \
		The reinforced materials and improved stasis generator prevents it from falling apart easily."
	id = "stasisbag"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/bodybag/stasis_longterm
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
