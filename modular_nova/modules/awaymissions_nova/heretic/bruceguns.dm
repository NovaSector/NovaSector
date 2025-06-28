/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/m60
	name = "M60 Machine Gun"
	desc = "A heavily modified gun based off of an already insanely heavily modified gun- this m60, pey say, is not a real m60 machine gun but instead it appears to be a heavily modified l6 saw modified to accept the insane ammo type of .50"
	accepted_magazine_type = /obj/item/ammo_box/magazine/mmg_box
	projectile_damage_multiplier = 2

/obj/item/gun/ballistic/automatic/sniper_rifle/lahti
	name = "Lahiti L-39"
	desc = "The lahiti L-39, now manufactured in space with better materials making it more portable and reliable- still loaded in the same massive cartridge, this thing was made to go through a tank and come out the other end- imagine what it could do to an exosuit."
	icon = 'modular_nova\modules\awaymissions_nova\heretic\lahtil39.dmi'
	mag_display = FALSE
	recoil = 10
	fire_sound_volume = 200
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/lahtimagazine
	fire_delay = 8 SECONDS

/obj/item/ammo_box/magazine/lahtimagazine
	name = "anti-materiel sniper rounds (.50 BMG)"
	desc = "A 20x138mm magazine suitable ammo for anti kaiju-rifles."
	icon_state = ".50mag"
	base_icon_state = ".50mag"
	ammo_type = /obj/item/ammo_casing/20x138
	max_ammo = 8
	caliber = CALIBER_50BMG

/obj/item/ammo_casing/20x138
	name = "20x138mm bullet casing"
	desc = "A 20x138mm bullet casing."
	caliber = CALIBER_50BMG
	projectile_type = /obj/projectile/bullet/20x138
	icon_state = ".50"
	newtonian_force = 1.5

/obj/projectile/bullet/20x138
	name ="20x138mm bullet"
	speed = 3.5
	range = 400 // Enough to travel from one corner of the Z to the opposite corner and then some.
	damage = 150
	paralyze = 100
	dismemberment = 50
	catastropic_dismemberment = TRUE
	armour_penetration = 50
	ignore_range_hit_prone_targets = TRUE
	///Determines object damage.
	object_damage = 200
	///Determines how much additional damage the round does to mechs.
	mecha_damage = 15
