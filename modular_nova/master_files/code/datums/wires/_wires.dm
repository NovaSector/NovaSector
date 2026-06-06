// Shows all wires when owned
/datum/wires/can_reveal_wires(mob/user)
	if(HAS_TRAIT(user, TRAIT_SHOW_ALL_WIRES))
		return TRUE
	return ..()
