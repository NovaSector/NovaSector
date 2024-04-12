/particles/mana_regain
	icon = 'icons/effects/particles/echo.dmi'
	icon_state = list("echo1" = 3, "echo2" = 1, "echo3" = 1)
	width = 40
	height = 80
	count = 1000
	spawning = 1
	lifespan = 1 SECONDS
	fade = 0.5 SECONDS
	friction = 0.25
	position = generator(GEN_SPHERE, 12, 12, NORMAL_RAND)
	drift = generator(GEN_VECTOR, list(-1, 1), list(1, 1), NORMAL_RAND)
	color = COLOR_BLUE_LIGHT

/atom/movable/screen/alert/status_effect/mana_regeneration
	name = "Regenerating Mana"
	desc = "Your body and mind are currently converting nutrition into mana to fuel your magical arts."
	icon_state = "cell_overcharge1"

/datum/status_effect/mana_regeneration
	id = "mana_regeneration"
	status_type = STATUS_EFFECT_REFRESH
	duration = 3 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/mana_regeneration

/datum/status_effect/mana_regeneration/update_particles()
	if(isnull(particle_effect))
		particle_effect = new(owner, /particles/mana_regain)

	particle_effect.alpha = 200
	var/original_duration = initial(duration)
	if(original_duration == -1)
		return
	animate(particle_effect, alpha = 50, time = original_duration)

/datum/status_effect/mana_regeneration/refresh(effect, ...)
	. = ..()
	update_particles()
