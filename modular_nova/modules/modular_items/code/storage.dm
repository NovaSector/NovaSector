/obj/item/storage/backpack/duffelbag/explorer
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/explorer
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/messenger/explorer
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/messenger/explorer 
	resistance_flags = FIRE_PROOF

/obj/item/storage/fancy/nugget_box
	spawn_count = 7 // Original Value - 6

/obj/item/storage/fancy/nugget_box/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 7 // Original Value - 6
	atom_storage.max_total_storage = WEIGHT_CLASS_TINY * 7

/obj/item/storage/box/bandages/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 14 // Original Value - 7
	atom_storage.max_total_storage = WEIGHT_CLASS_TINY * 14

/obj/item/storage/pill_bottle/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 21 // Original Value - 7
	atom_storage.max_total_storage = WEIGHT_CLASS_TINY * 21
