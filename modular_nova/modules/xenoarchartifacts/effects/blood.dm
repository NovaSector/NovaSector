/datum/artifact_effect/blood_regen
	log_name = "Blood regeneration"
	type_name = ARTIFACT_EFFECT_ORGANIC

/datum/artifact_effect/blood_regen/proc/regen_target(mob/living/receiver, volume)
	if(ishuman(receiver))
		var/mob/living/carbon/human/H = receiver
		if(H.blood_volume < BLOOD_VOLUME_MAXIMUM && HAS_TRAIT(H, TRAIT_DRINKS_BLOOD)) // Hemophages can get filled up to 1000
			var/weakness = get_anomaly_protection(H)
			H.blood_volume += volume * weakness
		else if(H.blood_volume < BLOOD_VOLUME_NORMAL)
			var/weakness = get_anomaly_protection(H)
			H.blood_volume += volume * weakness

/datum/artifact_effect/blood_regen/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	to_chat(user, span_notice("Your body feels full, somehow."))
	regen_target(user, 15)

/datum/artifact_effect/blood_regen/do_effect_aura()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		to_chat(receiver, span_notice("Your chest feels warm."))
		regen_target(receiver, 10)

/datum/artifact_effect/blood_regen/do_effect_pulse()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		to_chat(receiver, span_notice("Your chest feels warm."))
		regen_target(receiver, 50)

/datum/artifact_effect/blood_regen/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(7, curr_turf))
		to_chat(receiver, span_notice("Your chest feels warm."))
		regen_target(receiver, 100)

/datum/artifact_effect/blood_drain
	log_name = "Blood drain"

/datum/artifact_effect/blood_drain/proc/suck(mob/living/receiver, volume)
	if(ishuman(receiver))
		var/mob/living/carbon/human/H = receiver
		if(H.blood_volume > BLOOD_VOLUME_SURVIVE)
			var/weakness = get_anomaly_protection(H)
			H.blood_volume -= volume * weakness

/datum/artifact_effect/blood_drain/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	to_chat(user, span_warning("Blood starts pouring out of your pores!"))
	suck(user, 50)
	return TRUE

/datum/artifact_effect/blood_drain/do_effect_aura()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		to_chat(receiver, span_warning("Your nose bleeds."))
		suck(receiver, 10)

/datum/artifact_effect/blood_drain/do_effect_pulse()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/H in range(range, curr_turf))
		var/weakness = get_anomaly_protection(H)
		if(weakness >= 0.7)
			var/constructed_flags = (MOB_VOMIT_BLOOD | MOB_VOMIT_HARM | MOB_VOMIT_MESSAGE | MOB_VOMIT_FORCE)
			H.vomit(vomit_flags = constructed_flags, vomit_type = /obj/effect/decal/cleanable/vomit/toxic, lost_nutrition = 30, distance = 2)
			H.blood_volume -= 30 * weakness

/datum/artifact_effect/blood_drain/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(7, curr_turf))
		to_chat(receiver, span_warning("You feel empty."))
		suck(receiver, 75)
