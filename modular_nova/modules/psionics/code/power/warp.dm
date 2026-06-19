#define PSIONIC_WARP_DURATION (8 SECONDS)

/datum/psionic_power/warp
	required_school_points = 1
	required_powers = list(/datum/action/cooldown/psionic/spatial_slip)
	action_type = /datum/action/cooldown/psionic/pointed/warp

/datum/psionic_rank_variant/warp
	rank = PSIONIC_RANK_GAMMA
	variant_name = "phase scar"
	description = "A short-lived bluespace pass through a wall."
	block_charge_cost = 0

/datum/action/cooldown/psionic/pointed/warp
	name = "Warp"
	desc = "Temporarily phase a nearby wall enough for passage."
	button_icon_state = "psi_warp"
	cooldown_time = 45 SECONDS
	cast_range = 2
	point_cost = 2
	strain_gain = 28
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

/turf/closed/wall
	var/psionically_warped = FALSE
	var/psionic_warp_timer
	var/psionic_warp_old_density
	var/psionic_warp_old_alpha
	var/psionic_warp_old_color

/turf/closed/wall/proc/psionic_warp(duration = PSIONIC_WARP_DURATION, warp_color = PSIONIC_DEFAULT_COLOR)
	if(psionically_warped)
		return FALSE
	psionically_warped = TRUE
	psionic_warp_old_density = density
	psionic_warp_old_alpha = alpha
	psionic_warp_old_color = color
	psionic_warp_timer = addtimer(CALLBACK(src, PROC_REF(clear_psionic_warp)), duration, TIMER_STOPPABLE)
	density = FALSE
	alpha = 90
	color = warp_color || PSIONIC_DEFAULT_COLOR
	add_filter("psionic_warp", 1, wave_filter(x = 3, y = 3, size = 1, offset = rand()))
	RegisterSignal(src, COMSIG_ATOM_EXAMINE, PROC_REF(on_psionic_warp_examine))
	return TRUE

/turf/closed/wall/proc/clear_psionic_warp()
	if(!psionically_warped)
		return
	psionically_warped = FALSE
	if(psionic_warp_timer)
		deltimer(psionic_warp_timer)
	psionic_warp_timer = null
	density = psionic_warp_old_density
	alpha = psionic_warp_old_alpha
	color = psionic_warp_old_color
	psionic_warp_old_density = null
	psionic_warp_old_alpha = null
	psionic_warp_old_color = null
	remove_filter("psionic_warp")
	UnregisterSignal(src, COMSIG_ATOM_EXAMINE)

/turf/closed/wall/proc/on_psionic_warp_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_purple("A wavering psionic fold has made it briefly passable.")

#undef PSIONIC_WARP_DURATION
