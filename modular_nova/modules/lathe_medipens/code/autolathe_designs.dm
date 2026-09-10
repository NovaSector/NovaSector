// Basetype for developer usage only. Shouldn't be visible ingame.
/datum/design/medipen
	abstract_type = /datum/design/medipen
	name = "Medipen Basetype"
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
	build_path = /obj/item/reagent_containers/hypospray/medipen/universal

/datum/design/medipen/universal_lowpressure
	name = "Universal Low-Pressure Medipen"
	build_path = /obj/item/reagent_containers/hypospray/medipen/universal/lowpressure

/datum/design/medipen/epinephrine
	name = "Epinephrine Medipen"
	build_path = /obj/item/reagent_containers/hypospray/medipen/empty

/datum/design/medipen/atropine
	name = "Atropine Medipen"
	build_path = /obj/item/reagent_containers/hypospray/medipen/atropine/empty

/datum/design/medipen/salbutamol
	name = "Salbutamol Medipen"
	build_path = /obj/item/reagent_containers/hypospray/medipen/salbutamol/empty

/datum/design/medipen/oxandrolone
	name = "Oxandrolone Medipen"
	build_path = /obj/item/reagent_containers/hypospray/medipen/oxandrolone/empty

/datum/design/medipen/salacid
	name = "Salicylic Acid Medipen"
	build_path = /obj/item/reagent_containers/hypospray/medipen/salacid/empty

/datum/design/medipen/penacid
	name = "Pentetic Acid Medipen"
	build_path = /obj/item/reagent_containers/hypospray/medipen/penacid/empty
