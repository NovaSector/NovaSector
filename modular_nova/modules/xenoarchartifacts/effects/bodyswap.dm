// Picks 2 random humans in range and swaps their mind, similarly to the mage spell
/datum/artifact_effect/bodyswap
	log_name = "bodyswap"
	type_name = ARTIFACT_EFFECT_PSIONIC
	// We store original minds and bodies to return them to their original ones on Destroy()
	/// Assoc list of (original mind, original body) pairs, to remember what they were before we swapped
	var/list/datum/weakref/original_minds = list()

/datum/artifact_effect/bodyswap/New()
	. = ..()
	release_method = ARTIFACT_EFFECT_PULSE
	range = rand(2,5)

/datum/artifact_effect/bodyswap/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	swap_bodies()

/datum/artifact_effect/bodyswap/do_effect_destroy()
	return_bodies()
	original_minds = null

/**
 * Returns minds to their original bodies(if possible)
 */
/datum/artifact_effect/bodyswap/proc/return_bodies()
	for(var/datum/weakref/original_mind_ref in original_minds)
		var/datum/mind/original_mind = original_mind_ref.resolve()
		// If original mind was destroyed, there's nothing we can do. Remove it from the list.
		if(QDELETED(original_mind))
			original_minds -= original_mind_ref
			continue
		var/datum/weakref/original_body_ref = original_minds[original_mind_ref]
		var/mob/living/carbon/original_body = original_body_ref.resolve()
		// If the original body was destroyed
		if(QDELETED(original_body))
			original_minds -= original_mind_ref
			if(original_mind.current)
				to_chat(original_mind.current, span_boldwarning(
					"You feel dizzy for a moment, feeling like your mind wants to be transported, but it has nowhere to go. \
					Suddenly you return to the foreign body. A tremendous fear crawls into your soul. Seems like you are \
					stuck like this..." \
				))

			continue

		// perform the swap
		var/to_swap_key = original_mind.key
		original_mind.transfer_to(original_body)

		// Just in case
		if(to_swap_key)
			original_body.PossessByPlayer(to_swap_key)

		original_minds -= original_mind_ref

/**
 * Selects 2 random carbons in artifact range and swaps their minds.
 * Gives mind to those, who dont have it(monkeys)
 *
 * Arguments:
 * * add_range - bonus range to the base artifact's
 */
/datum/artifact_effect/bodyswap/proc/swap_bodies(add_range = 0)
	var/turf/curr_turf = get_turf(holder)
	var/list/poor_humans = list()
	for(var/mob/living/carbon/carbon_mob in range(range + add_range, curr_turf))
		if(carbon_mob.stat != DEAD) // Its not cool to transfer to dead monkey next room
			poor_humans.Add(carbon_mob)

	if(length(poor_humans) < 2)
		return FALSE

	// Stolen from mage spell
	var/mob/living/carbon/caster = pick_n_take(poor_humans)
	var/mob/living/carbon/to_swap = pick_n_take(poor_humans)

	if(!caster || !to_swap)
		return FALSE

	var/weakness_caster = get_anomaly_protection(caster)
	var/weakness_to_swap = get_anomaly_protection(to_swap)
	// 0 = full protection on both
	// 2 = zero protection summary
	if(weakness_caster + weakness_to_swap <= 1) { // Either one is fully protected, or they have total protection <= 1
		to_chat(caster, span_warning("You feel like you've just dodged a bullet."))
		to_chat(to_swap, span_warning("You feel like you've just dodged a bullet."))
		return FALSE
	}

	// IT WAS TRUE ALL ALONG
	if(istype(caster.head, /obj/item/clothing/head/costume/foilhat))
		to_chat(caster, span_clockred("Your tinfoil hat vibrates, protecting your brain from some kind of invisible rays!"))
		return FALSE

	// THEY CONTROL US WITH INVISIBLE RAYS FROM SPACE SATELLITES
	if(istype(to_swap.head, /obj/item/clothing/head/costume/foilhat))
		to_chat(to_swap, span_clockred("Your tinfoil hat vibrates, protecting your brain from some kind of invisible rays!"))
		return FALSE

	// Gives the target a mind if they don't have one
	if(!to_swap.mind)
		to_swap.mind_initialize()
	if(!caster.mind)
		to_swap.mind_initialize()

	var/datum/mind/mind_to_swap = to_swap.mind
	if(to_swap.can_block_magic(MAGIC_RESISTANCE_MIND) \
		|| mind_to_swap.has_antag_datum(/datum/antagonist/wizard) \
		|| mind_to_swap.has_antag_datum(/datum/antagonist/cult) \
		|| mind_to_swap.has_antag_datum(/datum/antagonist/changeling) \
		|| mind_to_swap.has_antag_datum(/datum/antagonist/rev) \
		|| mind_to_swap.key?[1] == "@" \
	)
		holder.balloon_alert(to_swap, "fizzles out!")
		holder.balloon_alert(caster, "fizzles out!")
		return FALSE

	// MIND TRANSFER BEGIN

	var/datum/mind/caster_mind = caster.mind
	var/datum/mind/to_swap_mind = to_swap.mind

	if(!caster_mind || !to_swap_mind)
		return FALSE

	// Checking if minds/bodies are already in list and adding them there, if not.
	// Checking if minds/bodies are already in list and adding them there, if not.
	var/found_caster
	var/found_to_swap
	for(var/datum/weakref/mind_ref in original_minds)
		var/datum/mind/found_mind = mind_ref.resolve()
		if(found_mind == caster_mind)
			found_caster = TRUE
		if(found_mind == to_swap_mind)
			found_to_swap = TRUE
		var/datum/weakref/body_ref = original_minds[mind_ref]
		var/mob/living/carbon/found_body = body_ref.resolve()
		if(found_body == caster)
			found_caster = TRUE
		if(found_body == to_swap)
			found_to_swap = TRUE

	if(!found_caster)
		original_minds.Add(list(WEAKREF(caster_mind) = WEAKREF(caster)))

	if(!found_to_swap)
		original_minds.Add(list(WEAKREF(to_swap_mind) = WEAKREF(to_swap)))

	var/to_swap_key = to_swap.key

	caster_mind.transfer_to(to_swap)
	to_swap_mind.transfer_to(caster)

	// Just in case the swappee's key wasn't grabbed by transfer_to...
	if(to_swap_key)
		caster.PossessByPlayer(to_swap_key)

	// MIND TRANSFER END

	// No stun, no sleep. Instant change for them to figure out
	// Also completely silent for everyone not affected
	// Should create some interesting situations >:)

	// Only the caster and victim hear the sounds,
	// that way no one knows for sure if the swap happened
	SEND_SOUND(caster, sound('sound/effects/magic/mandswap.ogg'))
	SEND_SOUND(to_swap, sound('sound/effects/magic/mandswap.ogg'))

	return TRUE
