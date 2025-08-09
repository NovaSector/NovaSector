/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/m60
	name = "\improper M60 Machine Gun"
	desc = "A heavily modified gun based off of an already insanely heavily modified gun- this m60, per say, \
		is not a real m60 machine gun but instead it appears to be a heavily modified l6 saw modified to accept the insane ammo type of .50."
	accepted_magazine_type = /obj/item/ammo_box/magazine/mmg_box
	projectile_damage_multiplier = 2.5
	recoil = 1

/obj/item/gun/ballistic/automatic/sniper_rifle/lahti
	name = "\improper Lahti L-39"
	desc = "The Lahti L-39, now manufactured in space with better materials making it more portable and reliable- still loaded in the same massive cartridge, \
		this thing was made to go through a tank and come out the other end- imagine what it could do to an exosuit, there's also a completely useless sight which is totally obstructed by the magazine."
	icon = 'modular_nova/modules/awaymissions_nova/heretic/lahtil39.dmi'
	icon_state = "lahtil"
	inhand_icon_state = "sniper"
	worn_icon_state = "sniper"
	mag_display = FALSE
	recoil = 15
	fire_sound_volume = 200
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/lahtimagazine
	fire_delay = 8 SECONDS
	slowdown = 2

/obj/item/ammo_box/magazine/lahtimagazine
	name = "\improper Lahti sniper rounds (20x138mm)"
	desc = "A 20x138mm magazine suitable ammo for anti kaiju-rifles."
	icon_state = ".50mag"
	base_icon_state = ".50mag"
	ammo_type = /obj/item/ammo_casing/mm20x138
	max_ammo = 9
	caliber = CALIBER_50BMG

/obj/item/ammo_casing/mm20x138
	name = "20x138mm bullet casing"
	desc = "A 20x138mm bullet casing."
	caliber = CALIBER_50BMG
	projectile_type = /obj/projectile/bullet/mm20x138
	icon_state = ".50"
	newtonian_force = 1.5

/obj/projectile/bullet/mm20x138
	name ="20x138mm bullet"
	speed = 3.5
	range = 400 // Enough to travel from one corner of the Z to the opposite corner and then some.
	damage = 200
	paralyze = 100
	dismemberment = 50
	catastropic_dismemberment = TRUE
	armour_penetration = 50
	ignore_range_hit_prone_targets = TRUE

/obj/item/gun/ballistic/automatic/wt550/p90
	name = "\improper FN P90"
	desc = "The FN P90 is a fast fire rate personal defense weapon, the bullets it shoots are small but what it lacks in damage it more than makes up for in penetration and fire rate."
	icon = 'modular_nova/modules/awaymissions_nova/heretic/p90.dmi'
	icon_state = "p90"
	w_class = WEIGHT_CLASS_NORMAL
	inhand_icon_state = "m90"
	accepted_magazine_type = /obj/item/ammo_box/magazine/p90_mag
	burst_delay = 2
	burst_fire_selection = 1
	burst_size = 10
	firing_burst = 1
	can_suppress = FALSE
	mag_display = FALSE
	mag_display_ammo = FALSE
	empty_indicator = TRUE

/obj/item/ammo_box/magazine/p90_mag
	name = "p90 toploader magazine"
	desc = "A 5.7x28mm magazine."
	icon_state = "46x30mmt-20"
	base_icon_state = "46x30mmt-20"
	ammo_type = /obj/item/ammo_casing/mm57x28
	max_ammo = 50
	caliber = CALIBER_46X30MM

/obj/item/ammo_casing/mm57x28
	name = "5.7x28mm bullet casing"
	desc = "A 5.7x28mmmm bullet casing."
	caliber = CALIBER_46X30MM
	projectile_type = /obj/projectile/bullet/mm57x28
	icon_state = "s-casing"
	base_icon_state = "ammo"
	newtonian_force = 0.1

/obj/projectile/bullet/mm57x28
	name ="5.7x28mm bullet"
	speed = 3.5
	range = 30
	damage = 8
	armour_penetration = 50

/obj/item/gun/energy/shrink_ray/one_shot
	name = "shrink ray blaster"
	desc = "This is a piece of frightening alien tech that enhances the magnetic pull of atoms in a localized space to temporarily make an object shrink. \
		That or it's just space magic. Either way, it shrinks stuff, This one is jerry-rigged to work with a non alien cell. It still recharges though."
	ammo_type = list(/obj/item/ammo_casing/energy/shrink/worse)

/obj/item/ammo_casing/energy/shrink/worse
	projectile_type = /obj/projectile/magic/shrink/alien
	select_name = "shrink ray"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE)
