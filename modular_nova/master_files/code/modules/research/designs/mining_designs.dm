/datum/design/bsc_nt
	name = "NT BSC Refinery Box"
	id = "bsc_nt"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3
	)
	build_path = /obj/item/flatpacked_machine/boulder_collector/nt
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MINING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

/datum/design/board/lrm
	name = "Linked Retrieval Matrix Board"
	id = "lrm_board"
	build_type = COLONY_FABRICATOR | PROTOLATHE | AWAY_LATHE | AUTOLATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT,)
	build_path = /obj/item/circuitboard/machine/lrm
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
