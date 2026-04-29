/**
 * Attached to the knotter (the one with the knot) when a knot "locks" during/after a climax.
 *
 * Simplified port of SPLURT's knotting state machine. Instead of SPLURT's bespoke
 * `COMSIG_MOVABLE_ATTEMPTED_MOVE` wall on /mob/living, we force an aggressive grab on
 * the partner
 *
 */
/datum/component/knotted
	dupe_mode = COMPONENT_DUPE_UNIQUE

	/// The partner tied to our parent.
	var/mob/living/partner
	/// Organ slot of the partner that the knot is in — for messaging on untie.
	var/partner_slot
	/// Time at which the knot auto-unties.
	var/untie_at
	/// Timer id for the auto-untie timer, so we can cancel it on early untie.
	var/untie_timer

/datum/component/knotted/Initialize(mob/living/partner, partner_slot, duration = KNOT_DEFAULT_DURATION)
	if(!isliving(parent) || !isliving(partner) || parent == partner)
		return COMPONENT_INCOMPATIBLE
	if(QDELETED(partner))
		return COMPONENT_INCOMPATIBLE

	src.partner = partner
	src.partner_slot = partner_slot
	src.untie_at = world.time + clamp(duration, KNOT_MIN_DURATION, KNOT_MAX_DURATION)

	var/mob/living/knotter = parent
	knotter.visible_message(
		span_purple("[knotter]'s knot swells inside [partner][partner_slot ? "'s [partner_slot]" : ""], locking them together!"),
		span_userlove("Your knot swells inside [partner][partner_slot ? "'s [partner_slot]" : ""], locking you together!"),
	)
	to_chat(partner, span_userlove("[knotter]'s knot swells, locking [knotter.p_them()] inside you."))

	// Aggressive grab does the movement lock: puller drags pulled, disarm/resist breaks it.
	// grab() only establishes a passive pull — upgrade explicitly via setGrabState.
	knotter.grab(partner)
	if(knotter.pulling == partner)
		knotter.setGrabState(GRAB_AGGRESSIVE)

	untie_timer = addtimer(CALLBACK(src, PROC_REF(untie), FALSE), untie_at - world.time, TIMER_STOPPABLE)

/datum/component/knotted/RegisterWithParent()
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(on_parent_gone))
	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(on_parent_gone))
	if(partner)
		RegisterSignal(partner, COMSIG_LIVING_DEATH, PROC_REF(on_partner_gone))
		RegisterSignal(partner, COMSIG_QDELETING, PROC_REF(on_partner_gone))

/datum/component/knotted/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	if(partner)
		UnregisterSignal(partner, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))

/datum/component/knotted/Destroy(force)
	if(untie_timer)
		deltimer(untie_timer)
		untie_timer = null
	untie(silent = QDELING(parent) || QDELETED(partner))
	partner = null
	return ..()

/// Force-untie now. `silent` skips the flavor message (used on death / qdel cleanup).
/datum/component/knotted/proc/untie(silent = FALSE)
	var/mob/living/knotter = parent
	if(!silent && knotter && !QDELETED(knotter) && partner && !QDELETED(partner))
		knotter.visible_message(
			span_purple("[knotter]'s knot slips free of [partner]."),
			span_purple("Your knot slips free of [partner]."),
		)
		to_chat(partner, span_purple("[knotter]'s knot slips free of you."))

	// Drop the aggressive grab on our partner if we're still the one holding it.
	if(knotter?.pulling == partner)
		knotter.stop_pulling()

	if(!QDELING(src))
		qdel(src)

/datum/component/knotted/proc/on_parent_gone(datum/source)
	SIGNAL_HANDLER
	qdel(src)

/datum/component/knotted/proc/on_partner_gone(datum/source)
	SIGNAL_HANDLER
	qdel(src)
