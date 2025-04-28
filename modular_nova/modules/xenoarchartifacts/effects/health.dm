/datum/artifact_effect/heal
	log_name = "Heal"
	type_name = ARTIFACT_EFFECT_ORGANIC

/**
 * Heals target mob
 *
 * Arguments:
 * * receiver - mob to heal
 * * healing_power - how much to heal
 */
/datum/artifact_effect/heal/proc/heal_target(mob/living/receiver, healing_power)
	if(ishuman(receiver))
		var/mob/living/carbon/human/human_mob = receiver
		var/weakness = get_anomaly_protection(human_mob)
		human_mob.heal_overall_damage(healing_power * weakness, healing_power * weakness)
		return
	receiver.heal_overall_damage(healing_power, healing_power)

/datum/artifact_effect/heal/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	to_chat(user, span_notice("A soothing energy invigorate you."))
	heal_target(user, 25)

/datum/artifact_effect/heal/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		to_chat(receiver, span_notice("A wave of energy invigorates you."))
		heal_target(receiver, rand(1,3)/2 * seconds_per_tick)

/datum/artifact_effect/heal/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/used_power = .
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		to_chat(receiver, span_notice("A wave of energy invigorates you."))
		heal_target(receiver, 2.5 * used_power * seconds_per_tick)

/datum/artifact_effect/heal/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(7, curr_turf))
		to_chat(receiver, span_notice("A wave of energy healed your wounds."))
		heal_target(receiver, 50)

/datum/artifact_effect/roboheal
	log_name = "Robo-heal"

/datum/artifact_effect/roboheal/New()
	. = ..()
	type_name = pick(ARTIFACT_EFFECT_ELECTRO, ARTIFACT_EFFECT_PARTICLE)

/**
 * Heals silicons only
 *
 * Arguments:
 * * receiver - mob to heal
 * * healing_power - how much to heal
 */
/datum/artifact_effect/roboheal/proc/heal_target(mob/living/receiver, healing_power)
	receiver.heal_overall_damage(healing_power, healing_power)

/datum/artifact_effect/roboheal/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	if(!issilicon(user))
		return
	to_chat(user, span_notice("Your systems report damaged components mending by themselves!"))
	heal_target(user, 25)

/datum/artifact_effect/roboheal/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/silicon/receiver in range(range, curr_turf))
		to_chat(receiver, span_notice("SYSTEM ALERT: Beneficial energy field detected!"))
		heal_target(receiver, 0.5 * seconds_per_tick)

/datum/artifact_effect/roboheal/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/used_power = .
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/silicon/receiver in range(range, curr_turf))
		to_chat(receiver, span_notice("SYSTEM ALERT: Structural damage has been repaired by energy pulse!"))
		heal_target(receiver, 2.5 * used_power * seconds_per_tick)

/datum/artifact_effect/roboheal/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/silicon/receiver in range(7, curr_turf))
		to_chat(receiver, span_notice("SYSTEM ALERT: Structural damage has been repaired by energy pulse!"))
		heal_target(receiver, 50)

/datum/artifact_effect/hurt
	log_name = "Hurt"

/**
 * Deals damage to mobs via take_overall_damage
 *
 * Arguments:
 * * receiver - mob to damage
 * * damage_power - how much to damage
 */
/datum/artifact_effect/hurt/proc/deal_damage(mob/living/receiver, damage_power)
	if(ishuman(receiver))
		var/mob/living/carbon/human/human_receiver = receiver
		var/weakness = get_anomaly_protection(human_receiver)
		human_receiver.take_overall_damage(damage_power * weakness, damage_power * weakness)
		return
	receiver.take_overall_damage(damage_power, damage_power)

/datum/artifact_effect/hurt/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	to_chat(user, span_warning("A painful discharge of energy strikes you!"))
	deal_damage(user, 10)
	return TRUE

/datum/artifact_effect/hurt/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		to_chat(receiver, span_warning("You feel a painful force radiating from something nearby."))
		deal_damage(receiver, 0.5 * seconds_per_tick)

/datum/artifact_effect/hurt/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/used_power = .
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(range, curr_turf))
		to_chat(receiver, span_notice("A wave of energy invigorates you, tearing your flesh."))
		deal_damage(receiver, 2.5 * (used_power / 3) * seconds_per_tick)

/datum/artifact_effect/hurt/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/receiver in range(7, curr_turf))
		to_chat(receiver, span_warning("You feel tremendous pain"))
		deal_damage(receiver, 50)

/datum/artifact_effect/robohurt
	log_name = "Robo-hurt"

/datum/artifact_effect/robohurt/New()
	. = ..()
	type_name = pick(ARTIFACT_EFFECT_ELECTRO, ARTIFACT_EFFECT_PARTICLE)

/**
 * Deals damage to silicons only
 *
 * Arguments:
 * * receiver - mob to damage
 * * damage_power - how much to damage
 */
/datum/artifact_effect/robohurt/proc/deal_damage(mob/living/receiver, damage_power)
	receiver.take_overall_damage(damage_power, damage_power)

/datum/artifact_effect/robohurt/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	if(!issilicon(user))
		return
	to_chat(user, span_warning("Your systems report severe damage has been inflicted!"))
	deal_damage(user, 10)

/datum/artifact_effect/robohurt/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/silicon/receiver in range(range, curr_turf))
		to_chat(receiver, span_warning("SYSTEM ALERT: Harmful energy field detected!"))
		deal_damage(receiver, 0.5 * seconds_per_tick)

/datum/artifact_effect/robohurt/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/used_power = .
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/silicon/receiver in range(range, curr_turf))
		to_chat(receiver, span_warning("SYSTEM ALERT: Structural damage inflicted by energy pulse!"))
		deal_damage(receiver, 0.25 * used_power * seconds_per_tick)

/datum/artifact_effect/robohurt/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/silicon/receiver in range(7, curr_turf))
		to_chat(receiver, span_warning("SYSTEM ALERT: Critical structural damage inflicted by energy pulse!"))
		deal_damage(receiver, 50)
