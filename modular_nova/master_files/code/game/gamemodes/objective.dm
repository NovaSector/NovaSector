// For modularity, we hook into the update_explanation_text to be sure we have a target to register.
/datum/objective/assassinate/update_explanation_text()
	if(target)
		var/mob/living/target_mob = target.current // mind to mob
		RegisterSignal(target_mob, COMSIG_LIVING_DEATH, PROC_REF(register_target_death))
	return ..()

/datum/objective/assassinate/proc/register_target_death(mob/living/dead_guy, gibbed)
	SIGNAL_HANDLER
	completed = TRUE
	UnregisterSignal(dead_guy, COMSIG_LIVING_DEATH)
