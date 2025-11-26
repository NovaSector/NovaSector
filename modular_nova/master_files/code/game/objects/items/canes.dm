/// Gives this the same effect as a crutch
/obj/item/cane/movement_support_add(mob/living/user)
 	. = ..()
	RegisterSignal(user, COMSIG_LIVING_LIMBLESS_SLOWDOWN, PROC_REF(handle_cane_slowdown))
	user.update_usable_leg_status()
	return TRUE

/obj/item/cane/movement_support_del(mob/living/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_LIVING_LIMBLESS_SLOWDOWN), PROC_REF(handle_cane_slowdown))
	user.update_usable_leg_status()
	return TRUE

/obj/item/cane/proc/handle_cane_slowdown(mob/living/user, limbless_slowdown, list/slowdown_mods)
	SIGNAL_HANDLER
	var/leg_amount = user.usable_legs
	// Don't do anything if the number is equal (or higher) to the usual.
	if(leg_amount >= user.default_num_legs)
		return
	// If we have at least one leg and it's less than the default, reduce slowdown by 60%.
	if(leg_amount && (leg_amount < user.default_num_legs))
		slowdown_mods += 0.4
