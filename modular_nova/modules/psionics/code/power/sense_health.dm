/datum/psionic_power/sense_health
	action_type = /datum/action/cooldown/psionic/pointed/sense_health

/datum/action/cooldown/psionic/pointed/sense_health
	name = "Sense Health"
	desc = "Read a nearby living target's condition as an advanced health analyzer."
	button_icon_state = "psi_sense_health"
	cooldown_time = 8 SECONDS
	cast_range = 8
	point_cost = 1
	strain_gain = 7
	psionic_flags = PSIONIC_SENSORY
	school = PSIONIC_SCHOOL_BIOSCRAMBLER

/datum/action/cooldown/psionic/pointed/sense_health/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(target))
		owner.balloon_alert(owner, "no vitals!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/sense_health/psionic_activate(atom/target)
	var/mob/living/living_target = target
	if(living_target.can_block_psionics(PSIONIC_SENSORY, charge_cost = 1))
		owner.balloon_alert(owner, "sense blurred!")
		to_chat(owner, span_warning("[living_target]'s condition blurs behind psionic dampening."))
		return FALSE

	to_chat(owner, span_purple("You unfold [living_target]'s condition into a diagnostic impression."))
	healthscan(owner, living_target, mode = SCANNER_VERBOSE, advanced = TRUE)
	return TRUE
