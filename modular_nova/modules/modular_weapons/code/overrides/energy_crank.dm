//This is where we add the crank elements to energy weapons, using a mix of both the musket and hot/cold revolvers as base. You see me using LASER_SHOTS because its a defined function to calculate a fraction of the power cell, in this case, I use it to calculate a 25% recharge.

// Allstar sc1 laser carbine, the allstar sc1 laser auto carbine (/obj/item/gun/energy/laser/carbine) is included since its a child.
/obj/item/gun/energy/laser/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(4, STANDARD_CELL_CHARGE), \
		cooldown_time = 6 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 3 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

// Allstar sc2 energy carbine
/obj/item/gun/energy/e_gun/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(4, STANDARD_CELL_CHARGE), \
		cooldown_time = 6 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 3 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

// Hellfire laser gun
/obj/item/gun/energy/laser/hellgun/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(4, STANDARD_CELL_CHARGE), \
		cooldown_time = 6 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 3 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

// Ion carbine
/obj/item/gun/energy/ionrifle/carbine/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(4, STANDARD_CELL_CHARGE), \
		cooldown_time = 6 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 3 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

// X ray laser gun
/obj/item/gun/energy/xray/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(4, STANDARD_CELL_CHARGE), \
		cooldown_time = 6 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 3 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

// Tesla cannon
/obj/item/gun/energy/tesla_cannon/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(4, STANDARD_CELL_CHARGE), \
		cooldown_time = 6 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 3 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)
