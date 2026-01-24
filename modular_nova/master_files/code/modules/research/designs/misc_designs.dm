/datum/design/monkey_helmet
	name = "Monkey Mind Magnification Helmet"
	desc = "A fragile, circuitry embedded helmet for boosting the intelligence of a monkey to a higher level."
	id = "monkey_helmet"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/clothing/head/helmet/monkey_sentience
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_SCIENCE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/plumbing_eng
	name = "Engineering Plumbing Constructor"
	desc = "A type of plumbing constructor designed to manipulate fluid."
	id = "plumbing_eng"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 40,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/construction/plumbing/engineering
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_ENGINEERING,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/smartdartgun
	name = "Medical SmartDart Gun"
	desc = "An adjusted version of the medical syringe gun that only allows SmartDarts to be chambered."
	id = "smartdartgun"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/gun/syringe/smartdart
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/anesthetic_machine
	name = "Anesthetic Machine Parts Kit"
	desc = "All-in-one kit containing the parts to create a portable anesthetic stand, tank not included."
	id = "anesthetic_machine"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/anesthetic_machine_kit
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/vox_gas_filter
	name = "Vox Gas Filter"
	id = "vox_gas_filter"
	build_type = PROTOLATHE | AUTOLATHE | COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/gas_filter/vox
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS_EQUIPMENT
	)
	departmental_flags = ALL

/datum/design/d2
	name = "D2 Die"
	id = "d2"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/dice/d2
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)

/datum/design/d4
	name = "D4 Die"
	id = "d4"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/dice/d4
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)

/datum/design/d6
	name = "D6 Die"
	id = "d6"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/dice/d6
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)

/datum/design/d8
	name = "D8 Die"
	id = "d8"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/dice/d8
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)

/datum/design/d10
	name = "D10 Die"
	id = "d10"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/dice/d10
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)

/datum/design/d00
	name = "D00 Die"
	id = "d00"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/dice/d00
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)


/datum/design/d12
	name = "D12 Die"
	id = "d12"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/dice/d12
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)

/datum/design/d20
	name = "D20 Die"
	id = "d20"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/dice/d20
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)

/datum/design/fudge
	name = "Fudge Die"
	id = "fudge"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.2)
	build_path = /obj/item/dice/fudge
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)

/datum/design/d100
	name = "D100 Die"
	id = "d100"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.4) //Uses more plastic, because it's a chunky boy.
	build_path = /obj/item/dice/d100
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)
