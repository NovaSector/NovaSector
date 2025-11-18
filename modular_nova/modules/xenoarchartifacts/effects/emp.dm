/datum/artifact_effect/emp
	log_name = "EMP"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/emp/New()
	. = ..()
	release_method = ARTIFACT_EFFECT_PULSE

/datum/artifact_effect/emp/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	empulse(get_turf(holder), range / 2, range)

/datum/artifact_effect/emp/do_effect_destroy()
	empulse(get_turf(holder), range * 2, range)
