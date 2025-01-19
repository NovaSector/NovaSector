/datum/artifact_effect/temperature
	/// target_temp is initialized in New() with value between target_temp_low and target_temp_high
	var/target_temp
	/// the lowest temperature that this effect can cause
	var/target_temp_low
	/// the highest temperature that this effect can cause
	var/target_temp_high

/datum/artifact_effect/temperature/New()
	. = ..()
	target_temp = rand(target_temp_low, target_temp_high)
	release_method = pick(ARTIFACT_EFFECT_TOUCH, ARTIFACT_EFFECT_AURA)
	type_name = pick(ARTIFACT_EFFECT_ORGANIC, ARTIFACT_EFFECT_BLUESPACE, ARTIFACT_EFFECT_SYNTH)

/datum/artifact_effect/temperature/do_effect_touch(mob/user)
	. = ..()
	var/turf/holder_turf = get_turf(holder)
	if(isnull(holder_turf))
		return FALSE
	if(!.)
		return FALSE
	var/datum/gas_mixture/env = holder_turf.return_air()
	if(!env)
		return FALSE
	return env

/datum/artifact_effect/temperature/do_effect_aura(seconds_per_tick)
	. = ..()
	var/turf/holder_turf = get_turf(holder)
	if(isnull(holder_turf))
		return FALSE
	if(!.)
		return FALSE
	var/datum/gas_mixture/env = holder_turf.return_air()
	if(!env)
		return FALSE
	return env

/datum/artifact_effect/temperature/do_effect_destroy()
	var/turf/holder_turf = get_turf(holder)
	if(isnull(holder_turf))
		return FALSE
	var/datum/gas_mixture/env = holder_turf.return_air()
	if(!env)
		return FALSE
	return env

/datum/artifact_effect/temperature/cold
	log_name = "Cold"
	target_temp_low = TCMB
	target_temp_high = 180

/datum/artifact_effect/temperature/cold/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	var/datum/gas_mixture/env = .
	env.temperature = clamp(env.temperature - 100, target_temp_low, target_temp_high)
	holder.air_update_turf(FALSE, FALSE)
	to_chat(user, span_warning("A chill passes up your spine!"))

/datum/artifact_effect/temperature/cold/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/datum/gas_mixture/env = .
	if(env.temperature > target_temp)
		env.temperature -= 50 * seconds_per_tick
		holder.air_update_turf(FALSE, FALSE)

/datum/artifact_effect/temperature/cold/do_effect_destroy()
	. = ..()
	if(!.)
		return
	var/datum/gas_mixture/env = .
	env.temperature = target_temp_low
	holder.air_update_turf(FALSE, FALSE)

/datum/artifact_effect/temperature/heat
	log_name = "Heat"
	target_temp_low = 300
	target_temp_high = 1000

/datum/artifact_effect/temperature/heat/New()
	. = ..()
	target_temp_high = rand(1000, 20000)

/datum/artifact_effect/temperature/heat/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	var/datum/gas_mixture/env = .
	var/amount_to_change = (target_temp_high - env.temperature) / 4
	env.temperature = clamp(env.temperature + amount_to_change, target_temp_low, target_temp_high)
	holder.air_update_turf(FALSE, FALSE)
	to_chat(user, span_warning("You feel a wave of heat travel up your spine!"))

/datum/artifact_effect/temperature/heat/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/datum/gas_mixture/env = .
	var/amount_to_change = (target_temp_high - env.temperature) / 8
	if(env.temperature < target_temp)
		env.temperature += amount_to_change * seconds_per_tick
		holder.air_update_turf(FALSE, FALSE)

/datum/artifact_effect/temperature/heat/do_effect_destroy()
	. = ..()
	if(!.)
		return
	var/datum/gas_mixture/env = .
	env.temperature = target_temp_high
	holder.air_update_turf(FALSE, FALSE)
