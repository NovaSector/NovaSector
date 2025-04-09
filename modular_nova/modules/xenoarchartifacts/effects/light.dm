/datum/artifact_effect/light
	log_name = "Light"
	type_name = ARTIFACT_EFFECT_PARTICLE

/datum/artifact_effect/light/New()
	. = ..()
	release_method = ARTIFACT_EFFECT_TOUCH
	trigger = TRIGGER_TOUCH
	activation_touch_cost = 0

/datum/artifact_effect/light/toggle_artifact_effect(reveal_toggle)
	if(!activated)
		if(log_name == "Darkness")
			holder.set_light(range, -round(maximum_charges/5))
		else
			holder.set_light(range, round(maximum_charges/5))
	else
		holder.set_light(0,0)
	return ..()

/datum/artifact_effect/light/darkness
	log_name = "Darkness"
