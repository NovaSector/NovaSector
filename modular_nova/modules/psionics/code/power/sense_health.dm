/datum/psionic_power/sense_health
	action_type = /datum/action/cooldown/psionic/pointed/sense_health

/datum/psionic_rank_variant/sense_health
	rank = PSIONIC_RANK_EPSILON
	variant_name = "diagnosis"
	description = "A focused read of one living target's condition."
	cooldown_time = 8 SECONDS
	cast_range = 8
	strain_gain = 7
	block_charge_cost = 1
	block_message = "sense blurred!"

/datum/action/cooldown/psionic/pointed/sense_health
	name = "Sense Health"
	desc = "Read a nearby living target's condition as an advanced health analyzer."
	button_icon_state = "psi_sense_health"
	point_cost = 1
	psionic_flags = PSIONIC_SENSORY
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	rank_variant_types = list(
		/datum/psionic_rank_variant/sense_health,
	)

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
	to_chat(owner, span_purple("You unfold [living_target]'s condition into a diagnostic impression."))
	healthscan(owner, living_target, mode = SCANNER_VERBOSE, advanced = TRUE)
	return TRUE
