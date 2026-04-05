/obj/docking_port/mobile/emergency/proc/hide_roleplayers()
	for(var/mob/living/roleplayer as anything in GLOB.alive_player_list)
		RegisterSignal(roleplayer, COMSIG_MOB_BATONED, PROC_REF(punish_bad_batons))
		if(!roleplayer.client?.prefs?.read_preference(/datum/preference/toggle/eorgpreference))
			roleplayer.density = FALSE
			roleplayer.see_invisible++
			roleplayer.invisibility = roleplayer.see_invisible // There's a proc for this, but we are ultimate in our judgement
			roleplayer.add_traits(list(TRAIT_PACIFISM, TRAIT_UNHITTABLE_BY_PROJECTILES, TRAIT_BLOCKING_PROJECTILES), "EORG Preference Protection")
			// honesly signals is the best way i found, god bless there not being a simple "allow this mob to disarm" flags
			RegisterSignal(roleplayer, COMSIG_MOB_TRYING_TO_FIRE_GUN, PROC_REF(prevent_guns))
			RegisterSignal(roleplayer, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(prevent_shoves))
			RegisterSignal(roleplayer, COMSIG_LIVING_TRY_PULL, PROC_REF(prevent_grabs))

/obj/docking_port/mobile/emergency/proc/prevent_guns(mob/living/user)
	SIGNAL_HANDLER
	to_chat(user, span_warning("You wouldn't violate your oath of non-violence when the shuttle docks at centcom, would you?"))
	return COMPONENT_CANCEL_GUN_FIRE

/obj/docking_port/mobile/emergency/proc/prevent_shoves(mob/living/user, atom/attack_target, proximity, modifiers)
	SIGNAL_HANDLER
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		to_chat(user, span_warning("You wouldn't violate your oath of non-violence when the shuttle docks at centcom, would you?"))
		return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/docking_port/mobile/emergency/proc/prevent_grabs(mob/living/grabber, atom/grabbed_thingy)
	SIGNAL_HANDLER
	if(!isliving(grabbed_thingy))
		return

	if(!grabber.density && grabbed_thingy.density)
		to_chat(grabber, span_warning("You wouldn't violate your oath of non-violence when the shuttle docks at centcom, would you?"))
		return COMSIG_LIVING_CANCEL_PULL

/obj/docking_port/mobile/emergency/proc/punish_bad_batons(mob/living/baton_target, mob/living/baton_user)
	SIGNAL_HANDLER
	if(!baton_user.density)
		baton_user.dust() // You didn't want to engage in EORG, did you?
