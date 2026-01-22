// This is where we put all the overrides for energy recharge. At the moment of this change, TG default charge_delay is 8. With this they recharge 10% per what charge_delay says

#define CHARGE_MESSAGE "Equipped with a trickle-charge microcell. Regains a shot every couple of minutes without external power. Dont expect it to keep up with heavy use."

// disabler
/obj/item/gun/energy/disabler
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/disabler/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// hybrid taser
/obj/item/gun/energy/e_gun/advtaser
	selfcharge = TRUE
	charge_delay = 15

// disabler smg
/obj/item/gun/energy/disabler/smg
	selfcharge = TRUE
	charge_delay = 15

// miniature energy gun
// Allstar sc2 energy carbine
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

/obj/item/gun/energy/laser
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/laser/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

/obj/item/gun/energy/ionrifle
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/ionrifle/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

#undef CHARGE_MESSAGE
