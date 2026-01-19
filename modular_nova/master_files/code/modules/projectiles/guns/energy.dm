/obj/item/gun/energy/process(seconds_per_tick)
	. = ..()
	if(selfcharge && cell && cell.percent() < 100)
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/energy/select_fire(mob/living/user)
	. = ..()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

// alt method for selecting firemodes - not on attack_self_secondary because that conflicts with gun spinning, but maybe it should be.
/obj/item/gun/energy/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return .
	if(ammo_type.len > 1 && can_select)
		select_fire(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
