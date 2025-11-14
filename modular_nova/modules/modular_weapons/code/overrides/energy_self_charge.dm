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

/obj/item/gun/energy/e_gun/advtaser/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// disabler smg
/obj/item/gun/energy/disabler/smg
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/disabler/smg/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// miniature energy gun
// Allstar sc2 energy carbine - Special, is not a sidearm but too many weapons are child of fthis thing, and they change modes too, so using a crank is tricky.
/obj/item/gun/energy/e_gun
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/e_gun/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

// Tesla Cannon a tad crazy with crank, plus its supposed to be fed by the anomaly
/obj/item/gun/energy/tesla_cannon
	selfcharge = TRUE
	charge_delay = 15

/obj/item/gun/energy/tesla_cannon/examine(mob/user)
	. = ..()
	. += span_notice(CHARGE_MESSAGE)

#undef CHARGE_MESSAGE
