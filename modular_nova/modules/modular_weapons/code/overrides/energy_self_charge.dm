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
