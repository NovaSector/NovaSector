/datum/artifact_effect/blood_regen
	log_name = "Blood regeneration"
	type_name = ARTIFACT_EFFECT_ORGANIC

/**
 * Regenerates mob's blood
 *
 * Arguments:
 * * receiver - who shall receive blood
 * * volume - how much blood
 */
/datum/artifact_effect/blood_regen/proc/regen_target(mob/living/receiver, volume)
	if(ishuman(receiver))
		var/mob/living/carbon/human/human_receiver = receiver
		var/weakness = get_anomaly_protection(human_receiver)
		if(human_receiver.blood_volume < BLOOD_VOLUME_MAXIMUM && HAS_TRAIT(human_receiver, TRAIT_DRINKS_BLOOD)) // Hemophages can get filled up to 1000
			human_receiver.blood_volume += volume * weakness
		else if(human_receiver.blood_volume < BLOOD_VOLUME_NORMAL)
			human_receiver.blood_volume += volume * weakness

/datum/artifact_effect/blood_regen/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	if(issynthetic(user))
		return
	to_chat(user, span_notice("Your body feels full, somehow."))
	regen_target(user, 15)

/datum/artifact_effect/blood_regen/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		if(issynthetic(receiver))
			continue
		to_chat(receiver, span_notice("Your chest feels warm."))
		regen_target(receiver, 5 * seconds_per_tick)

/datum/artifact_effect/blood_regen/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		if(issynthetic(receiver))
			continue
		to_chat(receiver, span_notice("Your chest feels warm."))
		regen_target(receiver, 25 * seconds_per_tick)

/datum/artifact_effect/blood_regen/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(7, curr_turf))
		if(issynthetic(receiver))
			continue
		to_chat(receiver, span_notice("Your chest feels warm."))
		regen_target(receiver, 100)

/datum/artifact_effect/blood_drain
	log_name = "Blood drain"
	type_name = ARTIFACT_EFFECT_ORGANIC

/**
 * Drains mob's blood
 *
 * Arguments:
 * * receiver - whos blood shall be drained
 * * volume - how much blood
 */
/datum/artifact_effect/blood_drain/proc/suck(mob/living/receiver, volume)
	if(ishuman(receiver))
		var/mob/living/carbon/human/human_receiver = receiver
		var/weakness = get_anomaly_protection(human_receiver)
		if(human_receiver.blood_volume > BLOOD_VOLUME_SURVIVE)
			human_receiver.blood_volume -= volume * weakness

/datum/artifact_effect/blood_drain/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	if(issynthetic(user))
		return
	to_chat(user, span_warning("Blood starts pouring out of your pores!"))
	suck(user, 50)
	return TRUE

/datum/artifact_effect/blood_drain/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		if(issynthetic(receiver))
			continue
		to_chat(receiver, span_warning("Your nose bleeds."))
		suck(receiver, 5 * seconds_per_tick)

/datum/artifact_effect/blood_drain/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/human_receiver in range(range, curr_turf))
		if(issynthetic(human_receiver))
			continue
		var/weakness = get_anomaly_protection(human_receiver)
		if(weakness >= 0.7)
			var/constructed_flags = (MOB_VOMIT_BLOOD | MOB_VOMIT_HARM | MOB_VOMIT_MESSAGE | MOB_VOMIT_FORCE)
			human_receiver.vomit(vomit_flags = constructed_flags, vomit_type = /obj/effect/decal/cleanable/vomit/toxic, lost_nutrition = 30, distance = 2)
			human_receiver.blood_volume -= 15 * weakness * seconds_per_tick

/datum/artifact_effect/blood_drain/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(7, curr_turf))
		if(issynthetic(receiver))
			continue
		to_chat(receiver, span_warning("You feel empty."))
		suck(receiver, 75)
