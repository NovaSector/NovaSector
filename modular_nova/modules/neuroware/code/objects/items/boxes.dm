/obj/item/storage/box/flat/neuroware
	name = "neuroware chip case"
	desc = "A cheap cardboard case optimal for carrying up to five neuroware chips."
	icon = 'modular_nova/modules/neuroware/icons/box.dmi'
	icon_state = "neuroware_case"
	w_class = WEIGHT_CLASS_SMALL
	illustration = null
	foldable_result = null

/obj/item/storage/box/flat/neuroware/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 5
	atom_storage.set_holdable(/obj/item/disk/neuroware)

/obj/item/storage/box/flat/neuroware/happiness/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/disk/neuroware/happiness(src)

/obj/item/storage/box/flat/neuroware/mindbreaker/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/disk/neuroware/mindbreaker(src)

/obj/item/storage/box/flat/neuroware/space_drugs/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/disk/neuroware/space_drugs(src)

/obj/item/storage/box/flat/neuroware/synaptizine/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/disk/neuroware/synaptizine(src)

/obj/item/storage/box/flat/neuroware/thc/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/disk/neuroware/thc(src)

// Lewd neurowares

/obj/item/storage/box/flat/neuroware/crocin/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/disk/neuroware/crocin(src)

/obj/item/storage/box/flat/neuroware/hexacrocin/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/disk/neuroware/hexacrocin(src)

/obj/item/storage/box/flat/neuroware/camphor/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/disk/neuroware/camphor(src)

/obj/item/storage/box/flat/neuroware/pentacamphor/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/disk/neuroware/pentacamphor(src)
