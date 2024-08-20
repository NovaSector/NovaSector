/datum/artifact_effect/drugs
	log_name = "Hallucinations"

/datum/artifact_effect/drugs/New()
	..()
	type_name = pick(ARTIFACT_EFFECT_PSIONIC, ARTIFACT_EFFECT_ORGANIC)

/datum/artifact_effect/drugs/DoEffectTouch(mob/user)
	. = ..()
	if(!.)
		return
	do_drugs(user, 60)
	to_chat(user, "<span class='hypnophrase'>I feel so chill.</span>")

/datum/artifact_effect/drugs/DoEffectAura()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/L in range(range, curr_turf))
		if(!prob(20))
			continue
		do_drugs(L, 20)
		to_chat(L, "<span class='hypnophrase'>I feel good, like really good.</span>")

/datum/artifact_effect/drugs/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/L in range(range, curr_turf))
		if(!prob(50))
			continue
		do_drugs(L, 40)
		to_chat(L, "<span class='hypnophrase'>Things here are nice. Maybe I should come here more often.</span>")

/datum/artifact_effect/drugs/DoEffectDestroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/L in range(range+3, curr_turf))
		do_drugs(L, 120)
		to_chat(L, "<span class='hypnophrase'>Duuuude, I feel so transcendent</span>")

/datum/artifact_effect/drugs/proc/do_drugs(mob/receiver, power)
	var/weakened = get_anomaly_protection(receiver)
	if(!weakened)
		return FALSE
	if(!ishuman(receiver))
		return FALSE
	var/mob/living/carbon/C = receiver
	C.set_drugginess(power SECONDS * weakened)
	return TRUE
