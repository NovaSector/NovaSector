/obj/item/storage/belt/military/assault/full/m44a

/obj/item/storage/belt/military/assault/full/m44a/PopulateContents()
	return flatten_quantified_list(list(
		/obj/item/ammo_box/magazine/m44a = 6,
	))

/obj/item/ammo_box/advanced/s12gauge/buckshot/marine
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/survival/engineer/marine
	name = "military survival box"
	desc = "A box issued to Nanotrasen space marines, containing field essentials. This one is labelled to contain an extended-capacity tank."
	illustration = "extendedtank"
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi

/obj/item/storage/box/survival/engineer/marine/PopulateContents()
	..()
	. += /obj/item/storage/crayons //absolutely required
