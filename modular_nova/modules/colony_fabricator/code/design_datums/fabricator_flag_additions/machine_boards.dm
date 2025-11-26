/datum/design/board/hydroponics/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/board/cyborgrecharger/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/board/processor/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/board/suit_storage_unit/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/board/reagentgrinder/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/board/fishing_portal_generator/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

// Turbine Stuff

/datum/design/board/turbine_computer/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/board/turbine_compressor/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/board/turbine_rotor/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/board/turbine_stator/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/turbine_part_compressor/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/turbine_part_stator/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/turbine_part_rotor/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

// Look, its a board, Honestly i think it should go here as most ghost roles planned to use it will have an RCF

/datum/design/board/lrm
	name = "Linked Retrieval Matrix Board"
	id = "lrm"
	build_type = COLONY_FABRICATOR
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT,)
	build_path = /obj/item/circuitboard/machine/lrm
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELEPORT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
