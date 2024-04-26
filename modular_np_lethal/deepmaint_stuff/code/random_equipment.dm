/obj/item/storage/belt/military/nri/captain/lethalstation

/obj/item/storage/belt/military/nri/captain/lethalstation/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 5

/obj/item/storage/backpack/duffelbag/syndie/nri/captain/lethal

/obj/item/storage/backpack/duffelbag/syndie/nri/captain/lethal/Initialize(mapload)
	. = ..()
	atom_storage.silent = FALSE

// Tarkon gun but it does less damage
/obj/item/gun/ballistic/automatic/m6pdw
	projectile_damage_multiplier = 0.75

// Tarkon gun but it spawns with ammo
/obj/item/gun/ballistic/automatic/m6pdw/spawns_with_ammo
	spawnwithmagazine = TRUE
