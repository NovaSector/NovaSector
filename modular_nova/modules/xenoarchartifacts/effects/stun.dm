/datum/artifact_effect/stun
	log_name = "Stun"

/datum/artifact_effect/stun/New()
	..()
	type_name = pick(ARTIFACT_EFFECT_PSIONIC, ARTIFACT_EFFECT_ORGANIC)

/datum/artifact_effect/stun/DoEffectTouch(mob/user)
	. = ..()
	if(!.)
		return
	if(apply_stun(user, 200)) // Instant stun
		to_chat(user, "<span class='warning'>A powerful force overwhelms your consciousness.</span>")

/datum/artifact_effect/stun/DoEffectAura()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/L in range(range, curr_turf))
		if(!prob(20))
			continue
		if(apply_stun(L, 25))
			to_chat(L, "<span class='warning'>Your body goes numb for a moment.</span>")

/datum/artifact_effect/stun/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	var/used_power = .
	for(var/mob/living/L in range(range, curr_turf))
		if(!prob(50))
			continue
		if(apply_stun(L, 10 * used_power))
			to_chat(L, "<span class='warning'>A wave of energy overwhelms your senses!</span>")

/datum/artifact_effect/stun/DoEffectDestroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/L in range(range+3, curr_turf))
		if(apply_stun(L, 200))
			to_chat(L, "<span class='warning'>A <b>massive</b> wave of energy overwhelms your senses!</span>")

/datum/artifact_effect/stun/proc/apply_stun(mob/receiver, power)
	var/weakened = get_anomaly_protection(receiver)
	if(!weakened)
		return FALSE
	if(!ishuman(receiver))
		return FALSE
	var/mob/living/carbon/C = receiver
	C.adjust_confusion_up_to(15 SECONDS, 30 SECONDS)
	C.adjustStaminaLoss(power * weakened, updating_stamina = TRUE, forced = TRUE)
	C.updatehealth()
	return TRUE
