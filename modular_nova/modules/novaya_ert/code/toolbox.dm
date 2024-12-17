/obj/item/storage/toolbox/ammobox/full
	var/amount = 0 ///Amount of mags/casings/clips we spawn in.

/obj/item/storage/toolbox/ammobox/full/PopulateContents()
	if(!isnull(ammo_to_spawn))
		for(var/i in 1 to amount)
			new ammo_to_spawn(src)

/obj/item/storage/toolbox/ammobox/full/sakhno
	name = "ammo box (sakhno)"
	desc = "If the label's accurate, it probably contains stripper clips for the Sakhno precision rifle or variants."
	ammo_to_spawn = /obj/item/ammo_box/strilka310
	amount = 7

/obj/item/storage/toolbox/ammobox/full/lanca
	name = "ammo box (lanca)"
	desc = "If the label's accurate, it should probably contain magazines for the Lanca battle rifle."
	ammo_to_spawn = /obj/item/ammo_box/magazine/lanca
	amount = 7

/obj/item/storage/toolbox/ammobox/full/nri_smg
	name = "ammo box (miecz)"
	desc = "If the label's accurate, it should probably contain magazines for the Miecz submachine gun."
	ammo_to_spawn = /obj/item/ammo_box/magazine/miecz
	amount = 7

/obj/item/storage/toolbox/ammobox/full/l6_saw
	name = "ammo box (l6 saw)"
	desc = "If the label's accurate, it should probably contain box magazines for the L6 squad automatic weapon."
	ammo_to_spawn = /obj/item/ammo_box/magazine/m7mm
	amount = 7

/obj/item/storage/toolbox/ammobox/full/aps
	name = "ammo box (stechkin aps)"
	desc = "If the label's accurate, it should probably contain magazines for the Stechkin APS machine pistol."
	ammo_to_spawn = /obj/item/ammo_box/magazine/m9mm_aps
	amount = 7
