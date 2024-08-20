// Оружие массового опорожнения
// Dont mind me

/datum/artifact_effect/disgust
	log_name = "Disgust"

/datum/artifact_effect/disgust/New()
	..()
	type_name = pick(ARTIFACT_EFFECT_PSIONIC, ARTIFACT_EFFECT_ORGANIC)

/datum/artifact_effect/disgust/DoEffectTouch(mob/user)
	. = ..()
	if(!.)
		return
	apply_disgust(user, 200) // Insta-shit

/datum/artifact_effect/disgust/DoEffectAura()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/L in range(range, curr_turf))
		if(prob(50))
			apply_disgust(L, 5)

/datum/artifact_effect/disgust/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/used_power = .
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/L in range(range, curr_turf))
		apply_disgust(L, used_power)


/datum/artifact_effect/disgust/DoEffectDestroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/L in range(7, curr_turf))
		var/weakness = get_anomaly_protection(L)
		if(!weakness)
			continue
		L.SetSleeping(weakness * (10 SECONDS)) //0 resistance gives you 10 seconds of sleep

/datum/artifact_effect/disgust/proc/apply_disgust(mob/receiver, power)
	if(ishuman(receiver) && !issilicon(receiver))
		var/mob/living/carbon/human/H = receiver
		var/weakness = get_anomaly_protection(H)
		if(!weakness)
			return
		to_chat(H, pick("<span class='notice'>You feel like your guts are rearranging themself right now.</span>","<span class='notice'>You dont feel so good.</span>","<span class='notice'>Your stomach aches.</span>"))
		H.adjust_disgust(power)
