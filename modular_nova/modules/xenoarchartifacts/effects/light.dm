/datum/artifact_effect/light
	log_name = "Light"
	type_name = ARTIFACT_EFFECT_PARTICLE
	var/radius
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
		holder.light_power = l_power
		holder.light_range = radius*2
		holder.update_light()
	else
		holder.light_power = 0
		holder.light_range = 0
		holder.update_light()
	return ..()

/datum/artifact_effect/light/darkness
	log_name = "Darkness"

/datum/artifact_effect/light/darkness/New()
	..()
	l_power *= -1

/datum/artifact_effect/light/darkness/toggle_artifact_effect(reveal_toggle)
	if(!activated)
		holder.light_power = l_power
		holder.light_range = radius*2
		holder.update_light()
	else
		holder.light_power = 0
		holder.light_range = 0
		holder.update_light()
	return ..()
