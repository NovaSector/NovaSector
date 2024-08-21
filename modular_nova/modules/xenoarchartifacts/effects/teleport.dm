/datum/artifact_effect/teleport
	log_name = "Teleport"
	type_name = ARTIFACT_EFFECT_BLUESPACE

/datum/artifact_effect/teleport/DoEffectTouch(mob/user)
	. = ..()
	if(!.)
		return
	if(teleport_around(user, 10))
		to_chat(user, span_warning("You are suddenly zapped away elsewhere!)")

/datum/artifact_effect/teleport/DoEffectAura()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/living_mob in range(range, curr_turf))
		if(teleport_around(living_mob, 20))
			to_chat(living_mob, span_warning("You are displaced by a strange force!"))

/datum/artifact_effect/teleport/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/used_power = .
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/living_mob in range(range, curr_turf))
		if(teleport_around(living_mob, round(1 * used_power)))
			to_chat(living_mob, span_warning("You are displaced by a strange force!"))

/datum/artifact_effect/teleport/DoEffectDestroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/living_mob in range(7, curr_turf))
		if(teleport_around(M, 50))
			to_chat(living_mob, span_warning("You are displaced by a strange force!"))

/datum/artifact_effect/teleport/proc/teleport_around(mob/receiver, max_range)
	var/weakness = get_anomaly_protection(receiver)
	if(!weakness)
		return FALSE
	do_sparks(rand(3,6), 1, src.holder)
	var/turf/target_turf = pick(orange(get_turf(receiver), max_range * weakness))
	do_teleport(receiver, target_turf, 4)
	do_sparks(rand(3,6), 1,  get_turf(receiver))
	return TRUE
