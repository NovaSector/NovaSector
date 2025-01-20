// Lets cyborgs drag pulled objects
/atom/proc/attack_robot(mob/user, modifiers)
	if (SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_ROBOT, user, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	if((isturf(src) || istype(src, /obj/structure/table) || istype(src, /obj/machinery/conveyor)) && get_dist(user, src) <= 1)
		user.Move_Pulled(src)
		return
	attack_ai(user)
	return
