//This is where we add the crank elements to energy weapons, using a mix of both the musket and hot/cold revolvers as base. You see me using LASER_SHOTS because its a defined function to calculate a fraction of the power cell, in this case, I use it to calculate a 25% recharge. Ideally, this system would cancel on shoot, or even have a stamina cost, it will have to wait for a phase two.

#define CRANK_MESSAGE "Outfitted with a manual dyno-crank assembly. Burns an action to top up the cell on the fly, slower than a proper charger, but keeps you shooting when it counts."

// Allstar sc1 laser carbine, the allstar sc1 laser auto carbine (/obj/item/gun/energy/laser/carbine) and Hellfire laser gun (/obj/item/gun/energy/laser/hellgun) are included since they are its child.
/obj/item/gun/energy/laser/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(4, STANDARD_CELL_CHARGE), \
		cooldown_time = 8 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 4 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

/obj/item/gun/energy/laser/examine(mob/user)
	. = ..()
	. += span_notice(CRANK_MESSAGE)

// Ion carbine
/obj/item/gun/energy/ionrifle/carbine/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(4, STANDARD_CELL_CHARGE), \
		cooldown_time = 8 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 4 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

/obj/item/gun/energy/ionrifle/carbine/examine(mob/user)
	. = ..()
	. += span_notice(CRANK_MESSAGE)

// X ray laser gun
/obj/item/gun/energy/xray/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(4, STANDARD_CELL_CHARGE), \
		cooldown_time = 8 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 4 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

/obj/item/gun/energy/xray/examine(mob/user)
	. = ..()
	. += span_notice(CRANK_MESSAGE)

#undef CRANK_MESSAGE
