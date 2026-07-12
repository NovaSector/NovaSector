#define KNOT_DEFAULT_DURATION (30 SECONDS)
#define KNOT_MIN_DURATION (10 SECONDS)
#define KNOT_MAX_DURATION (2 MINUTES)

/**
 * Attached to the knotter when a knot locks during/after climax.
 *
 * The aggressive grab is presentation/compatibility only. The component itself
 * keeps the partner tied to the knotter so stamina knockdown does not break the tie.
 */
/datum/component/knotted
	dupe_mode = COMPONENT_DUPE_UNIQUE

	/// The partner tied to our parent.
	var/mob/living/partner
	/// Organ slot of the partner that the knot is in, used for messaging.
	var/partner_slot
	/// Time at which the knot auto-unties.
	var/untie_at
	/// Timer id for the auto-untie timer, so it can be cancelled on early cleanup.
	var/untie_timer
	/// TRUE while the component is dragging the partner after the knotter moves.
	var/dragging_partner = FALSE
	/// If we've been untied already
	var/untied

/datum/component/knotted/Initialize(mob/living/partner, partner_slot, duration = KNOT_DEFAULT_DURATION)
	if(!isliving(parent) || !isliving(partner) || parent == partner)
		return COMPONENT_INCOMPATIBLE
	if(QDELETED(partner))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/knotter = parent
	if(!knotter.Adjacent(partner))
		return COMPONENT_INCOMPATIBLE
	if(HAS_TRAIT(knotter, TRAIT_KNOTTED) || HAS_TRAIT(partner, TRAIT_KNOTTED))
		return COMPONENT_INCOMPATIBLE

	src.partner = partner
	src.partner_slot = partner_slot
	src.untie_at = world.time + clamp(duration, KNOT_MIN_DURATION, KNOT_MAX_DURATION)

	ADD_TRAIT(knotter, TRAIT_KNOTTED, REF(src))
	ADD_TRAIT(partner, TRAIT_KNOTTED, REF(src))

	knotter.visible_message(
		span_purple("[knotter]'s knot swells inside [partner][partner_slot ? "'s [partner_slot]" : ""], locking them together!"),
		span_userlove("Your knot swells inside [partner][partner_slot ? "'s [partner_slot]" : ""], locking you together!"),
	)
	to_chat(partner, span_userlove("[knotter]'s knot swells, locking [knotter.p_them()] inside you."))

	knotter.grab(partner)
	if(knotter.pulling == partner)
		knotter.setGrabState(GRAB_AGGRESSIVE)

	untie_timer = addtimer(CALLBACK(src, PROC_REF(untie), FALSE), untie_at - world.time, TIMER_STOPPABLE)

/datum/component/knotted/RegisterWithParent()
	RegisterSignals(parent, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_participant_gone))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	RegisterSignal(parent, COMSIG_LIVING_RESIST, PROC_REF(on_resist))
	if(partner)
		RegisterSignals(partner, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_participant_gone))
		RegisterSignal(partner, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_pre_move))
		RegisterSignal(partner, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
		RegisterSignal(partner, COMSIG_LIVING_RESIST, PROC_REF(on_resist))

/datum/component/knotted/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING, COMSIG_MOVABLE_MOVED, COMSIG_LIVING_RESIST))
	if(partner)
		UnregisterSignal(partner, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED, COMSIG_LIVING_RESIST))

/datum/component/knotted/Destroy(force)
	if(untie_timer)
		deltimer(untie_timer)
		untie_timer = null

	var/mob/living/knotter = parent
	if(knotter && !QDELETED(knotter))
		REMOVE_TRAIT(knotter, TRAIT_KNOTTED, REF(src))
	if(partner && !QDELETED(partner))
		REMOVE_TRAIT(partner, TRAIT_KNOTTED, REF(src))

	untie(silent = untied)
	partner = null
	return ..()

/// Force-untie now. `silent` skips flavor messages used for death/qdel cleanup.
/datum/component/knotted/proc/untie(silent = FALSE)
	untied = TRUE
	var/mob/living/knotter = parent
	if(!silent && knotter && !QDELETED(knotter) && partner && !QDELETED(partner))
		knotter.visible_message(
			span_purple("[knotter]'s knot slips free of [partner]."),
			span_purple("Your knot slips free of [partner]."),
		)
		to_chat(partner, span_purple("[knotter]'s knot slips free of you."))

	if(knotter?.pulling == partner)
		knotter.stop_pulling()

	if(!QDELING(src))
		qdel(src)

/// Called on COMSIG_LIVING_DEATH and COMSIG_QDELETING
/datum/component/knotted/proc/on_participant_gone(datum/source, gibbed)
	SIGNAL_HANDLER
	qdel(src)

/datum/component/knotted/proc/on_pre_move(atom/movable/source, atom/new_location)
	SIGNAL_HANDLER

	if(dragging_partner)
		return
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/component/knotted/proc/on_moved(atom/movable/source, atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	SIGNAL_HANDLER

	var/mob/living/knotter = parent
	if(!knotter || QDELETED(knotter) || !partner || QDELETED(partner))
		qdel(src)
		return
	if(source == knotter && should_drag_partner(knotter, old_loc))
		drag_partner_to(old_loc)
		if(QDELETED(src))
			return
	if(!knotter.Adjacent(partner))
		qdel(src)

/datum/component/knotted/proc/should_drag_partner(mob/living/knotter, atom/old_loc)
	if(partner.loc == old_loc)
		return FALSE
	if(get_dist(knotter, partner) > 1)
		return TRUE
	return ISDIAGONALDIR(get_dir(partner, knotter))

/datum/component/knotted/proc/drag_partner_to(atom/old_loc)
	var/turf/target_turf = get_turf(old_loc)
	if(!target_turf)
		qdel(src)
		return

	dragging_partner = TRUE
	var/drag_dir = get_dir(partner, target_turf)
	var/move_success = partner.Move(target_turf, drag_dir)
	dragging_partner = FALSE
	if(!move_success)
		qdel(src)

/datum/component/knotted/proc/on_resist(mob/living/source)
	SIGNAL_HANDLER

	source.balloon_alert(source, "pulled free")
	qdel(src)

#undef KNOT_DEFAULT_DURATION
#undef KNOT_MIN_DURATION
#undef KNOT_MAX_DURATION
