/mob/living
	/// When was the last time this mob was alerted to a height difference in turfs that necessitates climbing out?
	COOLDOWN_DECLARE(last_height_alert)

/mob/living/set_pull_offsets(mob/living/pull_target, grab_state, animate)
	. = ..()
	SEND_SIGNAL(pull_target, COMSIG_LIVING_SET_PULL_OFFSET)

/mob/living/reset_pull_offsets(mob/living/pull_target, override, animate)
	. = ..()
	SEND_SIGNAL(pull_target, COMSIG_LIVING_RESET_PULL_OFFSETS)

/mob/living/experience_pressure_difference(pressure_difference, direction, pressure_resistance_prob_delta = 0)
	if(HAS_TRAIT(src, TRAIT_HEAVYSET))
		return

/// Toggle admin frozen
/mob/living/proc/toggle_admin_freeze(client/admin)
	admin_frozen = !admin_frozen

	if(admin_frozen)
		SetStun(INFINITY, ignore_canstun = TRUE)
	else
		SetStun(0, ignore_canstun = TRUE)

	if(client && admin)
		to_chat(src, span_userdanger("An admin has [!admin_frozen ? "un" : ""]frozen you."))
		log_admin("[key_name(admin)] toggled admin-freeze on [key_name(src)].")
		message_admins("[key_name_admin(admin)] toggled admin-freeze on [key_name_admin(src)].")

/// Toggle admin sleeping
/mob/living/proc/toggle_admin_sleep(client/admin)
	admin_sleeping = !admin_sleeping

	if(admin_sleeping)
		SetSleeping(INFINITY)
	else
		SetSleeping(0)

	if(client && admin)
		to_chat(src, span_userdanger("An admin has [!admin_sleeping ? "un": ""]slept you."))
		log_admin("[key_name(admin)] toggled admin-sleep on [key_name(src)].")
		message_admins("[key_name_admin(admin)] toggled admin-sleep on [key_name_admin(src)].")
