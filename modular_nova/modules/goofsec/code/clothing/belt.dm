/obj/item/storage/belt/military/solfed
	name = "solfed chest rig"
	desc = "A set of tactical webbing worn by federal military personnel."
	storage_type = /datum/storage/military_belt/solfed

/datum/storage/military_belt/solfed
	max_specific_storage = WEIGHT_CLASS_NORMAL

/obj/item/storage/belt/military/solfed/PopulateContents()
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle/standard(src)
	new /obj/item/melee/baton/security/loaded(src)
