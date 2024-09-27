/datum/artifact_effect/drugs
	log_name = "Hallucinations"

/datum/artifact_effect/drugs/New()
	. = ..()
	type_name = pick(ARTIFACT_EFFECT_PSIONIC, ARTIFACT_EFFECT_ORGANIC)

/datum/artifact_effect/drugs/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	do_drugs(user, 60)
	to_chat(user, span_hypnophrase("I feel so chill."))

/datum/artifact_effect/drugs/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/living_mob in range(range, curr_turf))
		if(!SPT_PROB(10, seconds_per_tick))
			continue
		do_drugs(living_mob, 10 * seconds_per_tick)
		to_chat(living_mob, span_hypnophrase("I feel good, like really good."))

/datum/artifact_effect/drugs/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/living_mob in range(range, curr_turf))
		if(!SPT_PROB(25, seconds_per_tick))
			continue
		do_drugs(living_mob, 20 * seconds_per_tick)
		to_chat(living_mob, span_hypnophrase("Things here are nice. Maybe I should come here more often."))

/datum/artifact_effect/drugs/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/living_mob in range(range+3, curr_turf))
		do_drugs(living_mob, 120)
		to_chat(living_mob, span_hypnophrase("Duuuude, I feel so transcendent."))

/**
 * Applies drugginess to mob
 *
 * Arguments:
 * * receiver - who will we drug
 * * power - drug power
 */
/datum/artifact_effect/drugs/proc/do_drugs(mob/receiver, power)
	var/weakened = get_anomaly_protection(receiver)
	if(!weakened)
		return FALSE
	if(!ishuman(receiver))
		return FALSE
	var/mob/living/carbon/carbon_mob = receiver
	carbon_mob.set_drugginess(power SECONDS * weakened)
	return TRUE
