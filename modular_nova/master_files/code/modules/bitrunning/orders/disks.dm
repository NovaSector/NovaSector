// removes the nerf in virtual space
/obj/item/dualsaber/green/bitrunning
	block_chance = 75

// gives them the de-nerfed dual saber
/obj/item/bitrunning_disk/item/tier3/Initialize(mapload)
	. = ..()

	selectable_items -= list(
		/obj/item/dualsaber/green,
	)
	selectable_items += list(
		/obj/item/dualsaber/green/bitrunning,
	)

/obj/item/storage/toolbox/guncase/wt550
	name = "\improper WT-550 gun case"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/wt550
	extra_to_spawn = /obj/item/ammo_box/magazine/wt550m9
