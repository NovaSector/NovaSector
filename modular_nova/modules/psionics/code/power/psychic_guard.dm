/datum/psionic_power/psychic_guard
	action_type = /datum/action/cooldown/psionic/psychic_guard

/datum/psionic_rank_variant/psychic_guard
	rank = PSIONIC_RANK_EPSILON
	variant_name = "psychic guard"
	description = "A brief self-shield against incoming psionic effects."
	block_charge_cost = 0

/datum/action/cooldown/psionic/psychic_guard
	name = "Psychic Guard"
	desc = "Briefly shield yourself from psionic effects."
	button_icon_state = "psi_psychic_guard"
	cooldown_time = 30 SECONDS
	point_cost = 1
	strain_gain = 15
	psionic_flags = PSIONIC_PROTECTIVE
	school = PSIONIC_SCHOOL_FLUX
	rank_variant_types = list(/datum/psionic_rank_variant/psychic_guard)
	/// Guard duration.
	var/guard_duration = 10 SECONDS
	/// Charges granted to the guard.
	var/guard_charges = 2
	/// Timer ID for the active guard cleanup, cleared on early teardown.
	var/active_guard_timer
	/// Active protection component granted by this guard.
	var/datum/weakref/active_guard_ref

/datum/action/cooldown/psionic/psychic_guard/psionic_activate(atom/target)
	clear_active_guard()
	var/datum/callback/block_callback = CALLBACK(src, PROC_REF(on_guard_block))
	var/datum/component/psionic_protection/shield = owner.AddComponent(/datum/component/psionic_protection, charges = guard_charges, on_block = block_callback)
	active_guard_ref = WEAKREF(shield)
	active_guard_timer = addtimer(CALLBACK(src, PROC_REF(clear_guard), active_guard_ref), guard_duration, TIMER_STOPPABLE|TIMER_DELETE_ME)
	to_chat(owner, span_purple("You draw a quiet guard around your thoughts."))
	return TRUE

/datum/action/cooldown/psionic/psychic_guard/Remove(mob/living/remove_from)
	clear_active_guard()
	return ..()

/datum/action/cooldown/psionic/psychic_guard/Destroy()
	clear_active_guard()
	return ..()

/datum/action/cooldown/psionic/psychic_guard/proc/on_guard_block(mob/living/source, atom/movable/blocker)
	to_chat(source, span_notice("Your psychic guard catches the psionic effect and collapses part of its pattern."))

/datum/action/cooldown/psionic/psychic_guard/proc/clear_guard(datum/weakref/shield_ref)
	active_guard_timer = null
	if(active_guard_ref == shield_ref)
		active_guard_ref = null
	var/datum/component/psionic_protection/shield = shield_ref?.resolve()
	if(shield)
		qdel(shield)

/// Clears the active guard timer and shield if one is present, used during teardown.
/datum/action/cooldown/psionic/psychic_guard/proc/clear_active_guard()
	if(active_guard_timer)
		deltimer(active_guard_timer)
		active_guard_timer = null
	var/datum/component/psionic_protection/shield = active_guard_ref?.resolve()
	active_guard_ref = null
	if(shield)
		qdel(shield)
