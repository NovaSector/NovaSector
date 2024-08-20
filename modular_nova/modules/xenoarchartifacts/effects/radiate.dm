/datum/artifact_effect/radiate
	log_name = "Radiate"
	var/radiation_amount

/datum/artifact_effect/radiate/New()
	..()
	radiation_amount = rand(1, 10)
	type_name = pick(ARTIFACT_EFFECT_PARTICLE, ARTIFACT_EFFECT_ORGANIC)

/datum/artifact_effect/radiate/DoEffectTouch(mob/living/user)
	. = ..()
	var/turf/T = get_turf(holder)
	if (T == null)
		return FALSE
	if(!.)
		return
	if (!holder)
		return
	radiation_pulse(source = T, max_range = range + 5, threshold = 0.3, chance = 50)

/datum/artifact_effect/radiate/DoEffectAura()
	. = ..()
	var/turf/T = get_turf(holder)
	if (T == null)
		return FALSE
	if(!.)
		return
	if (!holder)
		return
	radiation_pulse(source = T, max_range = range, threshold = 0.3, chance = 10  * radiation_amount)

/datum/artifact_effect/radiate/DoEffectPulse()
	. = ..()
	var/turf/T = get_turf(holder)
	if (T == null)
		return FALSE
	if(!.)
		return
	var/used_power = .
	if (!holder)
		return
	radiation_pulse(source = T, max_range = range, threshold = 0.3, chance = used_power)

/datum/artifact_effect/radiate/DoEffectDestroy()
	var/turf/T = get_turf(holder)
	if (T == null)
		return FALSE
	radiation_pulse(source = T, max_range = range*2, threshold = 0.1, chance = 75) // Really powerful pulse
