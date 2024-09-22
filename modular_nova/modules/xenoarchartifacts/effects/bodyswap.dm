// Picks 2 random humans in range and swaps their mind, similarly to the mage spell
/datum/artifact_effect/bodyswap
	log_name = "bodyswap"
	type_name = ARTIFACT_EFFECT_PSIONIC
	// We store original minds and bodies to return them to their original ones on Destroy()
	// var/list/switched_bodies = list(
	// 	"original_body" = list(),
	// 	"original_mind" = list(),
	// )
	var/list/datum/mind/original_mind = list()
	var/list/mob/living/carbon/original_body = list()

/datum/artifact_effect/bodyswap/New()
	. = ..()
	release_method = ARTIFACT_EFFECT_PULSE
	range = rand(2,5)

/datum/artifact_effect/bodyswap/do_effect_pulse()
	. = ..()
	if(!.)
		return
	SwapBodies(0)

/datum/artifact_effect/bodyswap/do_effect_destroy()
	ReturnBodies()
	original_mind = null
	original_body = null

/**
 * Returns minds to their original bodies(if possible)
 */
/datum/artifact_effect/bodyswap/proc/ReturnBodies()
	var/i
	for(i = 1, i <= length(original_mind), i++)
		if(!QDELETED(original_mind[i]) && !QDELETED(original_body[i]))
			var/datum/mind/mind_to_return = original_mind[i]
			var/mob/living/carbon/original_b = original_body[i]
			var/to_swap_key = mind_to_return.key
			mind_to_return.transfer_to(original_b)

			// Just in case
			if(to_swap_key)
				original_b.key = to_swap_key
		else if(!QDELETED(original_mind[i]) && QDELETED(original_body[i])) // If original body was destroyed
			var/datum/mind/mind_not_to_return = original_mind[i]
			if(mind_not_to_return.current)
				to_chat(mind_not_to_return.current, span_boldwarning("You feel dizzy for a moment, feeling like your mind is being transported, but \
																	  suddenly you return to the foreign body. A tremendous fear crawls into your soul. \
																	  Seems like you are stuck like this."))


/**
 * Selects 2 random carbons in artifact range and swaps their minds.
 * Gives mind to those, who dont have it(monkeys)
 *
 * Arguments:
 * * add_range - bonus range to the base artifact's
 */
/datum/artifact_effect/bodyswap/proc/SwapBodies(add_range)
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
	// It (probably) shouldnt break everything on Destroy(), since we store only a single pair of
	// (original_body) - (original_mind) in two lists.
	// And since we add both mind and body at the same time, their indexes should be the same in lists
	if(!(caster_mind in original_mind) && !(caster in original_body))
		original_mind.Add(caster_mind)
		original_body.Add(caster)

	if(!(to_swap in original_body) && !(to_swap_mind in original_mind))
		original_mind.Add(to_swap_mind)
		original_body.Add(to_swap)

	var/to_swap_key = to_swap.key

	caster_mind.transfer_to(to_swap)
	to_swap_mind.transfer_to(caster)

	// Just in case the swappee's key wasn't grabbed by transfer_to...
	if(to_swap_key)
		caster.key = to_swap_key

	// MIND TRANSFER END

	// No stun, no sleep. Instant change for them to figure out
	// Also completely silent for everyone not affected
	// Should create some interesting situations >:)

	// Only the caster and victim hear the sounds,
	// that way no one knows for sure if the swap happened
	SEND_SOUND(caster, sound('sound/magic/mandswap.ogg'))
	SEND_SOUND(to_swap, sound('sound/magic/mandswap.ogg'))

	return TRUE
