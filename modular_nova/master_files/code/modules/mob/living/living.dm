/mob/living
	/// When was the last time this mob was alerted to a height difference in turfs that necessitates climbing out?
	COOLDOWN_DECLARE(last_height_alert)

/mob/living/set_pull_offsets(mob/living/pull_target, grab_state, animate)
	. = ..()
	SEND_SIGNAL(pull_target, COMSIG_LIVING_SET_PULL_OFFSET)

/mob/living/reset_pull_offsets(mob/living/pull_target, override, animate)
	. = ..()
	SEND_SIGNAL(pull_target, COMSIG_LIVING_RESET_PULL_OFFSETS)
