/*
* Wet Status Effects
* For regular slimes when they're soaked in water
*/

/atom/movable/screen/alert/status_effect/wet_slime
	name = "Wet" // haha wet
	desc = "You are covered in water and you're losing cohesion! Dry it off or coat yourself using Hydrophobia to repel!"
	use_user_hud_icon = TRUE
	overlay_state = "drunk2"

/datum/status_effect/wet_slime
	id = "wet_slime"
	tick_interval = 3 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/wet_slime
	remove_on_fullheal = TRUE

/datum/status_effect/wet_slime/tick(seconds_between_ticks)
	if(!HAS_TRAIT(owner, TRAIT_IS_WET))
		to_chat(owner, span_info("You're no longer covered in water, your form regenerating once more."))
		qdel(src)

	var/blood_units_to_lose = 0

	blood_units_to_lose += 3 * seconds_between_ticks
	if(SPT_PROB(25, seconds_between_ticks))
		owner.visible_message(
			span_danger("[owner]'s form begins to lose cohesion, seemingly diluting with the water!"),
			span_warning("The water starts to dilute your body, dry it off!"),
		)

	owner.blood_volume -= blood_units_to_lose

/datum/status_effect/wet_slime/get_examine_text()
	return span_warning("[owner.p_Their()] outer membrane is soaked, [owner.p_their()] form losing cohesion!")

/*
* Dry Status Effects
* For water-breathing slimes when they run out of water
*/

/atom/movable/screen/alert/status_effect/dry_slime
	name = "Dry"
	desc = "You are covered in water and you're losing cohesion! Dry yourself or turn on hydrophobia to repel!"
	use_user_hud_icon = TRUE
	overlay_state = "terrified"

/datum/status_effect/dry_slime
	id = "dry_slime"
	tick_interval = 3 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/dry_slime
	remove_on_fullheal = TRUE

/datum/status_effect/dry_slime/tick(seconds_between_ticks)
	if(HAS_TRAIT(owner, TRAIT_IS_WET))
		to_chat(owner, span_info("You're now immersed in water, your form regenerating once more."))
		qdel(src)

	var/blood_units_to_lose = 0

	blood_units_to_lose += 3 * seconds_between_ticks
	if(SPT_PROB(25, seconds_between_ticks))
		owner.visible_message(
			span_danger("[owner]'s form begins to lose cohesion, seemingly drying out!"),
			span_warning("Your body loses cohesion as it dries, only immersion can restore it!"),
		)

	owner.blood_volume -= blood_units_to_lose

/datum/status_effect/dry_slime/get_examine_text()
	return span_warning("[owner.p_Their()] outer membrane appears to be dry, [owner.p_their()] form losing cohesion!")
