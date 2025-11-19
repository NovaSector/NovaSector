// For modularity, we hook into the update_explanation_text to be sure we have a target to register.
/datum/objective/assassinate/update_explanation_text()
	RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(register_target_death))
	return ..()

/datum/objective/assassinate/proc/register_target_death(mob/living/dead_guy, gibbed)
	SIGNAL_HANDLER
	completed = TRUE
	UnregisterSignal(dead_guy, COMSIG_LIVING_DEATH)

// Annihilates completion tracking elegantly
/datum/objective/get_roundend_success_suffix()
	if(no_failure)
		return "" // Just print the objective with no success/fail evaluation, as it has no mechanical backing
	return "" //And eliminate any success/fail tracking
