/datum/artifact_effect/stun
	log_name = "Stun"

/datum/artifact_effect/stun/New()
	. = ..()
	type_name = pick(ARTIFACT_EFFECT_PSIONIC, ARTIFACT_EFFECT_ORGANIC)

/datum/artifact_effect/stun/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	if(apply_stun(user, 200)) // Instant stun
		to_chat(user, span_warning("A powerful force overwhelms your consciousness."))

/datum/artifact_effect/stun/do_effect_aura()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/living_mob in range(range, curr_turf))
		if(!prob(20))
			continue
		if(apply_stun(living_mob, 25))
			to_chat(living_mob, span_warning("Your body goes numb for a moment."))

/datum/artifact_effect/stun/do_effect_pulse()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	var/used_power = .
	for(var/mob/living/living_mob in range(range, curr_turf))
		if(!prob(50))
			continue
		if(apply_stun(living_mob, 10 * used_power))
			to_chat(living_mob, span_warning("A wave of energy overwhelms your senses!"))

/datum/artifact_effect/stun/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/living_mob in range(range+3, curr_turf))
		if(apply_stun(living_mob, 200))
			to_chat(living_mob, span_warning("A <b>massive</b> wave of energy overwhelms your senses!"))

/datum/artifact_effect/stun/proc/apply_stun(mob/receiver, power)
	var/weakened = get_anomaly_protection(receiver)
	if(!weakened)
		return FALSE
	if(!ishuman(receiver))
		return FALSE
	var/mob/living/carbon/carbon_mob = receiver
	carbon_mob.adjust_confusion_up_to(15 SECONDS, 30 SECONDS)
	carbon_mob.adjustStaminaLoss(power * weakened, updating_stamina = TRUE, forced = TRUE)
	return TRUE
