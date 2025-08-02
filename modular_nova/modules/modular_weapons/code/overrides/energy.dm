/obj/item/gun/energy/laser
	name = "laser carbine"
	desc = "The Allstar Lasers Star Combat 1, or \"Allstar SC-1\",\
		is a basic, energy-based laser carbine that fires concentrated beams of light which pass through glass and thin metal."
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/energy/laser/hellgun
	name = "hellfire laser carbine"
	desc = "The Allstar Lasers Star Combat Heavy, or \"Allstar SC-H\", \
		is a relic of a weapon, built before Allstar began installing regulators on their laser weaponry. \
		This pattern of laser gun became infamous for the gruesome burn wounds it caused, \
		and was quietly pushed to the sidelines once it began to affect Allstar's reputation."

/obj/item/gun/energy/laser/carbine
	name = "laser auto-carbine"
	desc = "The Allstar Lasers Star Combat 1-Auto, or \"Allstar SC-1A\", \
		is an basic energy-based laser auto-carbine that rapidly fires weakened, concentrated beams of light which pass through glass and thin metal."

/obj/item/gun/energy/e_gun
	name = "energy carbine"
	desc = "The Allstar Lasers Star Combat 2, or \"Allstar SC-2\", \
		is a basic hybrid energy carbine with two settings: disable and kill."
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/energy/e_gun/advtaser
	w_class = WEIGHT_CLASS_NORMAL
	custom_price = PAYCHECK_CREW * 5

/obj/item/ammo_casing/energy/laser
	projectile_type = /obj/projectile/beam/laser
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)
	// up from LASER_SHOTS(12, STANDARD_CELL_CHARGE)
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/hellfire
	projectile_type = /obj/projectile/beam/laser/hellfire
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)
	// up from LASER_SHOTS(10, STANDARD_CELL_CHARGE)
	select_name = "maim"

/obj/item/ammo_casing/energy/lasergun
	e_cost = LASER_SHOTS(25, STANDARD_CELL_CHARGE)
	// up from LASER_SHOTS(16, STANDARD_CELL_CHARGE)

/obj/item/stock_parts/power_store/cell/mini_egun
	maxcharge = STANDARD_CELL_CHARGE * 0.75
	// up from STANDARD_CELL_CHARGE * 0.6
