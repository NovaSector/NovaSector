// Balance pass 6/20/2024

// triples energy mags, doubles marsian mags, doesn't increase flare shot magazine size
//

/obj/item/ammo_casing/energy/laser
	e_cost = LASER_SHOTS(36, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/laser/hellfire
	e_cost = LASER_SHOTS(30, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/lasergun
	e_cost = LASER_SHOTS(48, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/lasergun/carbine
	e_cost = LASER_SHOTS(120, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/tesla_cannon
	e_cost = LASER_SHOTS(99, STANDARD_CELL_CHARGE) //im sick in the head

//esword blockchance nerf, .5 -> .25
/obj/item/melee/energy/sword
	block_chance = 25

//shield blockchance nerf, .5 -> .4
/obj/item/shield
	block_chance = 40

//mantis AP buff from 20->30
/obj/item/melee/implantarmblade
	armour_penetration = 30


/obj/item/wrench/combat
	force = 25 // arent you tired of being nice

/obj/item/katana
	force = 69 // hurt people hurt people
	block_chance = 10 //just dont get hit
