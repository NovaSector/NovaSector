/obj/item/gun/energy/shrink_ray/one_shot
	name = "shrink ray blaster"
	desc = "This is a piece of frightening alien tech that enhances the magnetic pull of atoms in a localized space to temporarily make an object shrink. \
		That or it's just space magic. Either way, it shrinks stuff, This one is jerry-rigged to work with a non alien cell. It still recharges though."
	ammo_type = list(/obj/item/ammo_casing/energy/shrink/worse)

/obj/item/ammo_casing/energy/shrink/worse
	projectile_type = /obj/projectile/magic/shrink/alien
	select_name = "shrink ray"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE)
