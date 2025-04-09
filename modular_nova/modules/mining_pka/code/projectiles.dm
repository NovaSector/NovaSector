//Accelerator Casing
/obj/item/ammo_casing/energy/kinetic/railgun
	projectile_type = /obj/projectile/kinetic/railgun
	fire_sound = 'sound/items/weapons/beam_sniper.ogg'

/obj/item/ammo_casing/energy/kinetic/repeater
	projectile_type = /obj/projectile/kinetic/repeater
	e_cost = LASER_SHOTS(3, STANDARD_CELL_CHARGE * 0.5)

/obj/item/ammo_casing/energy/kinetic/shotgun
	projectile_type = /obj/projectile/kinetic/shotgun
	pellets = 3
	variance = 50

/obj/item/ammo_casing/energy/kinetic/glock
	projectile_type = /obj/projectile/kinetic/glock

/obj/item/ammo_casing/energy/kinetic/shockwave
	projectile_type = /obj/projectile/kinetic/shockwave
	pellets = 8
	variance = 360
	fire_sound = 'sound/items/weapons/gun/general/cannon.ogg'

/obj/item/ammo_casing/energy/kinetic/m79
	projectile_type = /obj/projectile/bullet/mining_bomb
	e_cost = LASER_SHOTS(2, STANDARD_CELL_CHARGE * 0.5)
	fire_sound = 'sound/items/weapons/gun/general/grenade_launch.ogg'

//Accelerator Projectiles

/obj/projectile/kinetic
	var/mod_mult = 1 // Indicates to which value the damage modkit multiplicates its bonus, useful for multi proyectile pka's where the bonus is otherwise is applied to each proyectile and increases more than intended.

/obj/projectile/kinetic/railgun
	name = "hyper kinetic force"
	damage = 100
	range = 7
	pressure_decrease = 0.10
	speed = 10
	projectile_piercing = PASSMOB

/obj/projectile/kinetic/repeater
	name = "rapid kinetic force"
	damage = 20
	range = 4
	mod_mult = 0.5

/obj/projectile/kinetic/shotgun
	name = "split kinetic force"
	damage = 20
	mod_mult = 0.5

/obj/projectile/kinetic/glock
	name = "light kinetic force"
	damage = 10

/obj/projectile/kinetic/shockwave
	name = "concussive kinetic force"
	range = 1
