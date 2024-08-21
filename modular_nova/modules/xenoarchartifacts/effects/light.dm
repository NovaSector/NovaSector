/datum/artifact_effect/light
	log_name = "Light"
	type_name = ARTIFACT_EFFECT_PARTICLE
	/// Later multiplied by 2. Basically the range of light
	var/radius
	/// The power of light. Bigger number == brighter/darker the light is.
	var/l_power

/datum/artifact_effect/light/New()
	..()
	release_method = ARTIFACT_EFFECT_TOUCH
	trigger = TRIGGER_TOUCH
	activation_touch_cost = 0
	radius = rand(2, 6) // Can be VERY big
	l_power = rand(1, 12)

/datum/artifact_effect/light/toggle_artifact_effect(reveal_toggle)
	if(!activated)
		holder.set_light(l_power, radius*2)
	else
		holder.set_light(0,0)
	return ..()

/datum/artifact_effect/light/darkness
	log_name = "Darkness"

/datum/artifact_effect/light/darkness/New()
	. = ..()
	l_power *= -1

/datum/artifact_effect/light/darkness/toggle_artifact_effect(reveal_toggle)
	if(!activated)
		holder.set_light(l_power, radius*2)
	else
		holder.set_light(0,0)
	return ..()
