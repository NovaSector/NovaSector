// Voluntary sleeping / Timed sleeping
/datum/status_effect/incapacitating/sleeping
	show_duration = TRUE
	var/voluntary = FALSE

/datum/status_effect/incapacitating/sleeping/on_creation(mob/living/new_owner, set_duration, is_voluntary = FALSE)
	voluntary = is_voluntary
	// Hide sleep duration if permanent
	if(set_duration == -1)
		show_duration = FALSE
	return ..()
