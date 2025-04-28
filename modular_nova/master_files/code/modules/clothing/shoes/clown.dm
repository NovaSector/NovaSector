// NO CLOWN CYTOLOGY
/obj/item/clothing/shoes/clown_shoes/Initialize(mapload)
	. = ..()

	RemoveElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0)
