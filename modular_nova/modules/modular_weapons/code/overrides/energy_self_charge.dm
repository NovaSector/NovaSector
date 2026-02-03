// This is where we put all the overrides for energy recharge. At the moment of this change, TG default charge_delay is 8. With this they recharge 10% per what charge_delay says

#define CHARGE_MESSAGE "Equipped with a trickle-charge microcell. Regains a couple of shots every quarter minute or so without external power. Don't expect it to keep up with heavy use."
#define SUPER_CHARGE_MESSAGE "Equipped with a fission-powered microcell. Regains a couple of shots every few seconds or so without external power. While not infinite, it can handle heavier usage than its peers without running dry."

// Disablers
/obj/item/gun/energy/disabler
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/disabler/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Eguns
/obj/item/gun/energy/e_gun
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/e_gun/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Tesla Cannon
/obj/item/gun/energy/tesla_cannon
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/tesla_cannon/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Photon
/obj/item/gun/energy/photon
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/photon/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Pulse
/obj/item/gun/energy/pulse
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/pulse/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Lasers
/obj/item/gun/energy/laser
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/laser/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Pure Tasers
/obj/item/gun/energy/taser
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/taser/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Ion Rifles
/obj/item/gun/energy/ionrifle
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/ionrifle/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Temperature Guns
/obj/item/gun/energy/temperature
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/temperature/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Special Cases
/obj/item/gun/energy/mindflayer
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/mindflayer/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

/obj/item/gun/energy/alien
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/alien/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

/obj/item/gun/energy/shrink_ray
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/shrink_ray/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

/obj/item/gun/energy/lasercannon
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/lasercannon/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

/obj/item/gun/energy/meteorgun
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/meteorgun/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Crank guns + thermal pistols + instakill rifles + emplacements that shouldn't get self-charge or delay changes
/obj/item/gun/energy/disabler/smoothbore
	selfcharge = FALSE

/obj/item/gun/energy/disabler/smoothbore/examine(mob/user)
	. = ..()
	. -= span_notice(CHARGE_MESSAGE)

/obj/item/gun/energy/laser/musket/
	selfcharge = FALSE

/obj/item/gun/energy/laser/musket/examine(mob/user)
	. = ..()
	. -= span_notice(CHARGE_MESSAGE)

/obj/item/gun/energy/laser/instakill
	selfcharge = FALSE

/obj/item/gun/energy/laser/instakill/examine(mob/user)
	. = ..()
	. -= span_notice(CHARGE_MESSAGE)

/obj/item/gun/energy/laser/thermal/
	selfcharge = FALSE

/obj/item/gun/energy/laser/thermal/examine(mob/user)
	. = ..()
	. -= span_notice(CHARGE_MESSAGE)

/obj/item/gun/energy/taser/crank
	selfcharge = FALSE

/obj/item/gun/energy/taser/crank/examine(mob/user)
	. = ..()
	. -= span_notice(CHARGE_MESSAGE)

//Removes standard charge message for the advanced energy gun and replaces it with the super charge message
/obj/item/gun/energy/e_gun/nuclear/examine(mob/user)
	. = ..()
	. -= span_notice(CHARGE_MESSAGE)
	. += span_notice(SUPER_CHARGE_MESSAGE)

// Ditto for event horizon, giving a slight delay boost for consistency
/obj/item/gun/energy/event_horizon
	charge_delay = 10

/obj/item/gun/energy/event_horizon/examine(mob/user)
	. = ..()
	. += span_notice(SUPER_CHARGE_MESSAGE)

// Triple ditto for flora guns, since it's primarily a tool
/obj/item/gun/energy/floragun
	charge_delay = 10

/obj/item/gun/energy/floragun/examine(mob/user)
	. = ..()
	. += span_notice(SUPER_CHARGE_MESSAGE)

#undef CHARGE_MESSAGE
#undef SUPER_CHARGE_MESSAGE
