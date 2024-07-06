// Medipen design basetype for developer usage only
/datum/design/medipen
	name = "Medipen"
	id = DESIGN_ID_IGNORE
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.1,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/reagent_containers/hypospray/medipen
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/medipen/universal
	name = "Universal Medipen"
	id = "medipen_universal"
	build_path = /obj/item/reagent_containers/hypospray/medipen/universal

/datum/design/medipen/epinephrine
	name = "Epinephrine Medipen"
	id = "medipen_epinephrine"
	build_path = /obj/item/reagent_containers/hypospray/medipen

/datum/design/medipen/atropine
	name = "Atropine Medipen"
	id = "medipen_atropine"
	build_path = /obj/item/reagent_containers/hypospray/medipen/atropine

/datum/design/medipen/atropine
	name = "Salbutamol Medipen"
	id = "medipen_salbutamol"
	build_path = /obj/item/reagent_containers/hypospray/medipen/salbutamol

/datum/design/medipen/atropine
	name = "Oxandrolone Medipen"
	id = "medipen_oxandrolone"
	build_path = /obj/item/reagent_containers/hypospray/medipen/oxandrolone

/datum/design/medipen/atropine
	name = "Salicylic Acid Medipen"
	id = "medipen_salacid"
	build_path = /obj/item/reagent_containers/hypospray/medipen/salacid

/datum/design/medipen/atropine
	name = "Pentetic Acid Medipen"
	id = "medipen_penacid"
	build_path = /obj/item/reagent_containers/hypospray/medipen/penacid
