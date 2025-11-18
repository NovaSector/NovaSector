/datum/status_effect/incapacitating/sleeping
	show_duration = TRUE
	///If set to TRUE, the affected mob can resist to wake up.
	var/voluntary = FALSE

/datum/status_effect/incapacitating/sleeping/on_apply()
	. = ..()
	///Pause expiry of the effect on mob logout
	RegisterSignal(owner, COMSIG_MOB_GHOSTIZED, PROC_REF(disable_expiry))
	RegisterSignal(owner, COMSIG_MOB_LOGOUT, PROC_REF(disable_expiry))
	///Unpause expiry of the effect on mob login
	RegisterSignal(owner, COMSIG_MOB_GIVE_DIRECT_CONTROL, PROC_REF(enable_expiry))
	RegisterSignal(owner, COMSIG_MOB_LOGIN, PROC_REF(enable_expiry))

/datum/status_effect/incapacitating/sleeping/on_remove()
	UnregisterSignal(owner, list(
		COMSIG_MOB_GIVE_DIRECT_CONTROL,
		COMSIG_MOB_GHOSTIZED,
		COMSIG_MOB_LOGOUT,
		COMSIG_MOB_LOGIN,
	))
	. = ..()

/datum/status_effect/incapacitating/sleeping/on_creation(mob/living/new_owner, set_duration, is_voluntary = FALSE)
	voluntary = is_voluntary
	// Sleep until the client logs-in again
	if(isnull(new_owner.client))
		pause_expiry = TRUE
	// Hide sleep duration if permanent
	if(set_duration == STATUS_EFFECT_PERMANENT)
		show_duration = FALSE
	return ..()

/atom/movable/screen/alert/status_effect/asleep
	desc = "You've fallen asleep. Wait a bit and you should wake up. Resist or click here to wake up from voluntary naps."

// Wakes mob from sleep if the sleep verb was used
/atom/movable/screen/alert/status_effect/asleep/Click()
	. = ..()
	if(!.)
		return
	var/mob/living/living_owner = owner
	if(!istype(living_owner) || !living_owner.can_resist())
		return
	var/datum/status_effect/incapacitating/sleeping/sleep_effect = attached_effect
	if(sleep_effect.voluntary)
		living_owner.SetSleeping(0)
