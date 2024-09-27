/datum/artifact_effect/dnaswitch
	log_name = "Dna Switch"
	type_name = ARTIFACT_EFFECT_ORGANIC

/datum/artifact_effect/dnaswitch/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	if(!ishuman(user))
		return
	roll_and_change_genes(user, 50)

/datum/artifact_effect/dnaswitch/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/human/human_mob in range(range, curr_turf))
		roll_and_change_genes(human_mob, 25 * seconds_per_tick)

/datum/artifact_effect/dnaswitch/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/human/human_mob in range(range, curr_turf))
		roll_and_change_genes(human_mob, 10 * seconds_per_tick)

/datum/artifact_effect/dnaswitch/do_effect_destroy()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/human/human_mob in range(range+3, curr_turf))
		for(var/i in 1 to 4)
			roll_and_change_genes(human_mob, 100)

/**
 * Tries to activate receiver's genes or mutate their appearance DNA
 *
 * Arguments:
 * * receiver - who will we mutate
 * * chance - chance to mutate mob
 */
/datum/artifact_effect/dnaswitch/proc/roll_and_change_genes(mob/living/carbon/human/receiver, chance)
	var/weakness = get_anomaly_protection(receiver)
	if(!prob(weakness * 100))
		return
	if(prob(chance))
		if (prob(50))
			receiver.easy_random_mutate()
		else if (prob(25))
			receiver.random_mutate_unique_identity()
		else
			receiver.random_mutate_unique_features()
	to_chat(receiver, pick(
		span_notice("You feel a little different."),
		span_notice("You feel very strange."),
		span_notice("Your stomach churns."),
		span_notice("Your skin feels loose."),
		span_notice("You feel a stabbing pain in your head."),
		span_notice("You feel a tingling sensation in your chest."),
		span_notice("Your entire body vibrates."),
	))
