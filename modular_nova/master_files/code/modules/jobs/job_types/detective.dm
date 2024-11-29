// Moves PDA to left pocket, gives them a holster in their belt slot
/datum/outfit/job/detective
	belt = /obj/item/storage/belt/holster/detective/full
	l_pocket = /obj/item/modular_computer/pda/detective // ORIGINAL: /obj/item/toy/crayon/white
	r_pocket = /obj/item/clothing/accessory/badge/holo/detective // ORIGINAL: /obj/item/lighter
	pda_slot = ITEM_SLOT_LPOCKET

/datum/outfit/job/detective/New()
	. = ..()
	backpack_contents -= /obj/item/storage/box/evidence
	backpack_contents += list(/obj/item/pinpointer/crew = 1)
