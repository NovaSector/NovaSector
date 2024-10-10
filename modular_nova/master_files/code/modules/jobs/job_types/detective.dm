// Moves PDA to left pocket, gives them a holster in their belt slot
/datum/outfit/job/detective
	belt = /obj/item/storage/belt/holster/detective/full
	l_pocket = /obj/item/modular_computer/pda/detective // ORIGINAL: /obj/item/toy/crayon/white
	r_pocket = /obj/item/clothing/accessory/badge/holo/detective // ORIGINAL: /obj/item/lighter
	backpack_contents = list(
		/obj/item/detective_scanner = 1,
		/obj/item/pinpointer/crew = 1, // NEW
		/obj/item/melee/baton = 1,
		// REMOVE: /obj/item/storage/box/evidence = 1,
	)
	pda_slot = ITEM_SLOT_LPOCKET
