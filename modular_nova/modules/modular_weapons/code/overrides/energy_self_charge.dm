// This is where we put all the overrides for energy recharge. At the moment of this change, TG default charge_delay is 8. With this they recharge 10% per what charge_delay says

// disabler
/obj/item/gun/energy/disabler
	selfcharge = TRUE
	charge_delay = 15

// hybrid taser
/obj/item/gun/energy/e_gun/advtaser
	selfcharge = TRUE
	charge_delay = 15

// disabler smg
/obj/item/gun/energy/disabler/smg
	selfcharge = TRUE
	charge_delay = 15

// miniature energy gun
/obj/item/gun/energy/e_gun/mini
	selfcharge = TRUE
	charge_delay = 15

// Allstar sc2 energy carbine - Special, is not a sidearm but too many weapons are child of fthis thing, and they change modes too, so using a crank is tricky.
/obj/item/gun/energy/e_gun
	selfcharge = TRUE
	charge_delay = 15

// Tesla Cannon a tad crazy with crank, plus its supposed to be fed by the anomaly
/obj/item/gun/energy/tesla_cannon
	selfcharge = TRUE
	charge_delay = 15
