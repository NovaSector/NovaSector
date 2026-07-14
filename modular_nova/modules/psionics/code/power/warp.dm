/datum/psionic_power/warp
	required_school_points = 1
	required_powers = list(/datum/action/cooldown/psionic/spatial_slip)
	action_type = /datum/action/cooldown/psionic/pointed/warp

/datum/psionic_rank_variant/warp
	rank = PSIONIC_RANK_GAMMA
	variant_name = "phase scar"
	description = "A short-lived bluespace pass through a wall."
	cooldown_time = 45 SECONDS
	cast_range = 2
	strain_gain = 28
	block_charge_cost = 0

/datum/action/cooldown/psionic/pointed/warp
	name = "Warp"
	desc = "Temporarily phase a nearby wall enough for passage."
	button_icon_state = "psi_warp"
	point_cost = 2
	psionic_flags = PSIONIC_SPATIAL
	school = PSIONIC_SCHOOL_BLUESPACE
	rank_variant_types = list(/datum/psionic_rank_variant/warp)
	active_msg = "You search for a wall to phase..."
	deactive_msg = "The phase pattern slips away."

/datum/action/cooldown/psionic/pointed/warp/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!istype(target, /turf/closed/wall))
		owner.balloon_alert(owner, "not a wall!")
		return FALSE
	var/turf/closed/wall/wall_target = target
	if(istype(wall_target, /turf/closed/wall/r_wall))
		owner.balloon_alert(owner, "too reinforced!")
		return FALSE
	if(wall_target.psionically_warped)
		owner.balloon_alert(owner, "already warped!")
		return FALSE
	return TRUE

/datum/action/cooldown/psionic/pointed/warp/psionic_activate(atom/target)
	var/turf/closed/wall/wall_target = target
	var/mob/living/living_owner = owner
	if(!wall_target.psionic_warp(PSIONIC_WARP_DURATION, get_manifestation_color()))
		living_owner.balloon_alert(living_owner, "warp failed!")
		return FALSE
	living_owner.visible_message(
		span_notice("Space buckles through [wall_target]."),
		span_purple("You fold a short-lived passage through [wall_target]."),
	)
	return TRUE
