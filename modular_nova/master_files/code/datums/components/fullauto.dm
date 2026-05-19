/// Because autofire weapons bypass do_fire() they will also bypass the safety check unless we do it here
/datum/component/automatic_fire/start_autofiring()
	if(autofire_stat == AUTOFIRE_STAT_FIRING)
		return
	// Pass the actual shooter (mob), not the gun, so signal handlers like the
	// gun-safety component can balloon_alert the user properly.
	if(SEND_SIGNAL(parent, COMSIG_GUN_TRY_FIRE, shooter) & COMPONENT_CANCEL_GUN_FIRE)
		stop_autofiring()
		return

	return ..()
