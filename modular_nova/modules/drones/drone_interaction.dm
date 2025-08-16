/mob/living/basic/drone/attack_hand(mob/user, list/modifiers)
	if(isdrone(user))
		attack_drone(user)
		return
	return ..()

/mob/living/basic/drone/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(isobserver(user))
		examine(user) // Show examine info to ghosts
		return


/mob/living/basic/drone/attack_hand_secondary(mob/user, list/modifiers)
	if(user == src || isAdminGhostAI(user) || (mind && mind.key == user.key))
		return ..()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/mob/living/basic/drone/proc/on_mousedrop(atom/over, src_location, over_location, src_control, over_control, params)
	// Allow pickup by dragging to any mob that can hold us
	if(ismob(over) && over != src && over.CanReach(src) && over.MouseDrop(src))
		var/mob/over_mob = over
		if(can_be_held && over_mob.can_hold_items())
			return TRUE // Allow normal pickup handling

	// Allow self and admin interactions
	if(usr == src || isAdminGhostAI(usr) || (mind && mind.key == usr.key))
		return TRUE

	return FALSE // Block all other drag-and-drop interactions

// Prevents drone-to-drone container-like behavior
/mob/living/basic/drone/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(isdrone(mover))

		return FALSE
