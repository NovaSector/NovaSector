/datum/design/hypovial
	name = "Hypovial"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/reagent_containers/cup/vial/small
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/medbay_equip/New()
	unlocked_designs += list(
		/datum/design/hypovial,
	)
	return ..()

/// Large hypovials
/datum/design/hypovial/large
	name = "Large Hypovial"
	materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/reagent_containers/cup/vial/large

/datum/design/hypokit
	name = "Hypospray Case"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/storage/hypospraykit/empty
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/// Hyposprays
/datum/design/hypokit/deluxe
	name = "Deluxe Hypospray Case"
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 6,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
	)
	build_path = /obj/item/storage/hypospraykit/cmo/empty

/datum/design/hypomkii
	name = "Hypospray Mk. II"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/hypospray/mkii
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/medbay_equip_adv/New()
	unlocked_designs += list(
		/datum/design/hypokit/deluxe,
		/datum/design/hypomkii/piercing,
	)
	return ..()

/datum/design/hypomkii/deluxe
	name = "Hypospray Mk. II Deluxe Upgrade"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/device/custom_kit/deluxe_hypo2
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/alien/surgery/New()
	unlocked_designs += list(
		/datum/design/hypomkii/deluxe,
	)
	return ..()

/datum/design/hypomkii/piercing
	name = "Hypospray Mk. II Advanced"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/hypospray/mkii/piercing
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL


/// For reasons unknown, pens are included as an autolathe design here, in the hypospray module of all places.
/// I'm not touching this unless a maint asks me to because it feels weird and haunted, like the picture of a potato that bricks Source if you remove it.
/datum/design/pen
	name = "Pen"
	build_type = AUTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/pen
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC,
	)

/obj/item/pen
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT)

/obj/item/thermometer/pen
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
