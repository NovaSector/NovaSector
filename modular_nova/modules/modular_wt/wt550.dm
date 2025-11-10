/obj/item/gun/ballistic/automatic/wt550
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/wt550m9/rub
	name = "\improper WT-550 magazine (4.6x30mm rubber)"
	desc = "A top-loading 4.6x30mm magazine, specifically to carry less than lethal ammo."
	ammo_band_color = "#2596be"
	ammo_type = /obj/item/ammo_casing/c46x30mm/rubber

/obj/item/ammo_casing/c46x30mm/rubber
	name = "4.6x30mm rubber bullet casing"
	desc = "A 4.6x30mm rubber bullet casing. It is less lethal. Were you expecting some great insight?"
	projectile_type = /obj/projectile/bullet/c46x30mm/rubber

/obj/projectile/bullet/c46x30mm/rubber
	name = "4.6x30mm rubber bullet"
	damage = 5
	stamina = 20
	wound_bonus = -10
	ricochets_max = 2
	ricochet_incidence_leeway = 0
	ricochet_chance = 70
	ricochet_decay_damage = 0.7
	sharpness = NONE

/obj/item/storage/toolbox/ammobox/wt550
	name = "ammo box (wt-550)"
	desc = "If the label's accurate, this contains 'Standerd Capacity Ammo Full Size Ammo Capacity Magazine Shoot Gun For Wt-550 Gun Rifle Security BEST PRICE'."

/obj/item/storage/toolbox/ammobox/wt550/PopulateContents()
	for(var/i in 1 to 6)
		var/glib = pick(/obj/item/ammo_box/magazine/wt550m9, /obj/item/ammo_box/magazine/wt550m9/rub, /obj/item/ammo_box/magazine/wt550m9/wtic, /obj/item/ammo_box/magazine/wt550m9/wtap)
		new glib(src)
