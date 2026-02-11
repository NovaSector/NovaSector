// This is where we put all the overrides for energy recharge. At the moment of this change, TG default charge_delay is 8. With this they recharge 10% per what charge_delay says

#define SLOW_CHARGE_MESSAGE "Equipped with a drip-charge microcell. Regains a couple of shots after a while without external power, maybe. Remember - switching to another gun is <b>definitely</b> faster than waiting for this to recharge."
#define CHARGE_MESSAGE "Equipped with a trickle-charge microcell. Regains a couple of shots every quarter minute or so without external power. Don't expect it to keep up with heavy use."
#define SUPER_CHARGE_MESSAGE "Equipped with a hyper-charge microcell. Regains a couple of shots next to every ten seconds without external power. While not infinite, it can handle heavier usage than its peers without running dry."
#define HYPER_CHARGE_MESSAGE "Equipped with a fission-powered microcell. Regains a couple of shots every few seconds without external power. If this thing runs out of juice, you have bigger problems than recharging your gun."

/// Proc that is used to determine the message shown on examine for energy guns, if any. Override as needed with the appropriate message defined above.
/obj/item/gun/energy/proc/get_charge_message()
	if(!selfcharge)
		return

	var/charge_message
	switch(charge_delay)
		if(1 to 7)
			charge_message = HYPER_CHARGE_MESSAGE
		if(8 to 14)
			charge_message = SUPER_CHARGE_MESSAGE
		if(15 to 21)
			charge_message = CHARGE_MESSAGE
		if(21 to INFINITY)
			charge_message = SLOW_CHARGE_MESSAGE

	return span_notice(charge_message)

// Allows for messages about the gun's self-charge cababilities to be added to the end of the examine text.
/obj/item/gun/energy/examine(mob/user)
	. = ..()
	var/charge_message = get_charge_message()
	if(charge_message)
		. += charge_message

// Disablers
/obj/item/gun/energy/disabler
	selfcharge = TRUE
	charge_delay = 15

// Eguns
/obj/item/gun/energy/e_gun
	selfcharge = TRUE
	charge_delay = 15

// Tesla Cannon
/obj/item/gun/energy/tesla_cannon
	selfcharge = TRUE
	charge_delay = 15

// Photon
/obj/item/gun/energy/photon
	selfcharge = TRUE
	charge_delay = 15

// Pulse
/obj/item/gun/energy/pulse
	selfcharge = TRUE
	charge_delay = 15

// Advanced Energy Gun
/obj/item/gun/energy/e_gun/nuclear
	charge_delay = 5 // compare/contrast tg's default delay of 8, tg's adv e-gun delay of 10, nova's egun self-charge delay of 15
	self_charge_amount = STANDARD_ENERGY_GUN_SELF_CHARGE_RATE * 3 // recharges 15% of the internal cell per tick.

// Tesla Cannon
/obj/item/gun/energy/tesla_cannon
	selfcharge = TRUE
	charge_delay = 15

// Lasers
/obj/item/gun/energy/laser
	selfcharge = TRUE
	charge_delay = 15

// Captain's Laser
/obj/item/gun/energy/laser/captain
	charge_delay = 8 // compare/contrast tg's default delay of 8, nova's laser self-charge delay of 15

// Pure Tasers
/obj/item/gun/energy/taser
	selfcharge = TRUE
	charge_delay = 15

// Ion Rifles
/obj/item/gun/energy/ionrifle
	selfcharge = TRUE
	charge_delay = 15

// Temperature Guns
/obj/item/gun/energy/temperature
	selfcharge = TRUE
	charge_delay = 15

// Special Cases
/obj/item/gun/energy/mindflayer
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/alien
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/shrink_ray
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/lasercannon
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/meteorgun
	selfcharge = TRUE
	charge_delay = 15

// Crank guns + thermal pistols + instakill rifles + emplacements that shouldn't get self-charge or delay changes
/obj/item/gun/energy/disabler/smoothbore
	selfcharge = FALSE

/obj/item/gun/energy/laser/musket
	selfcharge = FALSE

/obj/item/gun/energy/laser/instakill
	selfcharge = FALSE

/obj/item/gun/energy/laser/thermal
	selfcharge = FALSE

/obj/item/gun/energy/taser/crank
	selfcharge = FALSE

#undef SLOW_CHARGE_MESSAGE
#undef CHARGE_MESSAGE
#undef SUPER_CHARGE_MESSAGE
#undef HYPER_CHARGE_MESSAGE
