/datum/psionic_power/psychic_guard
	action_type = /datum/action/cooldown/psionic/psychic_guard

/datum/action/cooldown/psionic/psychic_guard
	name = "Psychic Guard"
	desc = "Briefly shield yourself from psionic effects."
	button_icon_state = "psi_psychic_guard"
	cooldown_time = 30 SECONDS
	point_cost = 1
	strain_gain = 15
	psionic_flags = PSIONIC_PROTECTIVE
	school = PSIONIC_SCHOOL_FLUX
	/// Guard duration.
	var/guard_duration = 10 SECONDS
	/// Charges granted to the guard.
	var/guard_charges = 2

/datum/action/cooldown/psionic/psychic_guard/psionic_activate(atom/target)
	var/datum/callback/block_callback = CALLBACK(src, PROC_REF(on_guard_block))
	var/datum/component/psionic_protection/shield = owner.AddComponent(/datum/component/psionic_protection, charges = guard_charges, on_block = block_callback)
	addtimer(CALLBACK(src, PROC_REF(clear_guard), WEAKREF(shield)), guard_duration)
	to_chat(owner, span_purple("You draw a quiet guard around your thoughts."))
	return TRUE

/datum/action/cooldown/psionic/psychic_guard/proc/on_guard_block(mob/living/source, atom/movable/blocker)
	to_chat(source, span_notice("Your psychic guard catches the psionic effect and collapses part of its pattern."))

/datum/action/cooldown/psionic/psychic_guard/proc/clear_guard(datum/weakref/shield_ref)
	var/datum/component/psionic_protection/shield = shield_ref?.resolve()
	if(shield)
		qdel(shield)
