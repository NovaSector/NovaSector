/datum/psionic_power/kinetic_shove
	action_type = /datum/action/cooldown/psionic/pointed/kinetic_shove

/datum/action/cooldown/psionic/pointed/kinetic_shove
	name = "Kinetic Shove"
	desc = "Throw a nearby target away with focused psionic force."
	button_icon_state = "psi_kinetic_shove"
	cooldown_time = 12 SECONDS
	cast_range = 5
	point_cost = 1
	strain_gain = 18
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY

/datum/action/cooldown/psionic/pointed/kinetic_shove/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!ismovable(target))
		owner.balloon_alert(owner, "not movable!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove/psionic_activate(atom/target)
	var/atom/movable/movable_target = target
	var/mob/living/living_target = movable_target
	if(istype(living_target) && living_target.can_block_psionics(PSIONIC_KINETIC, charge_cost = 1))
		owner.balloon_alert(owner, "force dampened!")
		to_chat(owner, span_warning("Your force breaks against [living_target]'s psionic dampening."))
		return FALSE

	var/throw_direction = get_dir(owner, get_step_away(movable_target, owner))
	if(!throw_direction)
		throw_direction = get_dir(owner, movable_target)

	var/turf/throw_target = get_ranged_target_turf(movable_target, throw_direction, 3)
	if(!throw_target)
		return FALSE

	owner.visible_message(
		span_warning("[movable_target] lurches away from [owner] under invisible force."),
		span_notice("You shove [movable_target] with focused force."),
		ignored_mobs = movable_target,
	)
	if(istype(living_target))
		to_chat(living_target, span_userdanger("Invisible force slams into you!"))
		living_target.apply_damage(20, STAMINA)
		living_target.Knockdown(1 SECONDS)

	movable_target.safe_throw_at(throw_target, range = 3, speed = 1, thrower = owner, gentle = TRUE)
	return TRUE
