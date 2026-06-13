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

/// Living mob login modular extension
/mob/living/Login()
	. = ..()
	if(CONFIG_GET(flag/disable_antag_opt_in_preferences)) //lets not annoy our fellow players with useless info if we don't use this system at all
		return
	if (isnull(mind))
		return
	if (isnull(client?.prefs))
		return
	if (!mind.antag_opt_in_initialized)
		mind.update_antag_opt_in(client.prefs)
		mind.send_antag_optin_reminder()
		mind.antag_opt_in_initialized = TRUE
	if(ckey)
		if(is_banned_from(ckey, BAN_PACIFICATION))
			ADD_TRAIT(src, TRAIT_PACIFISM, ROUNDSTART_TRAIT)
	if(CONFIG_GET(flag/disable_conflict_opt_in_preferences)) //lets not annoy our fellow players with useless info if we don't use this system at all
		return
	if (isnull(mind))
		return
	if (isnull(client?.prefs))
		return
	if (!mind.conflict_opt_in_initialized)
		mind.update_conflict_opt_in(client.prefs)
		mind.conflict_opt_in_initialized = TRUE
	set_ssd_indicator(FALSE)
