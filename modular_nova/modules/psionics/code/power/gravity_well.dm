#define PSIONIC_GRAVITY_WELL_DURATION (15 SECONDS)
#define PSIONIC_GRAVITY_WELL_PULL_INTERVAL (1 SECONDS)

/datum/psionic_power/gravity_well
	required_powers = list(/datum/action/cooldown/psionic/pointed/kinetic_shove)
	required_school_points = 3
	action_type = /datum/action/cooldown/psionic/pointed/gravity_well

/datum/psionic_rank_variant/gravity_well
	rank = PSIONIC_RANK_GAMMA
	variant_name = "well"
	description = "A collapsing point that drags everything nearby toward it."
	strain_gain = 30
	cooldown_time = 40 SECONDS
	cast_range = 6
	block_charge_cost = 0
	/// Tiles this form pulls from.
	var/pull_range = 3
	/// Forced gravity inside the field. Above STANDARD_GRAVITY this slows; injury needs strictly
	/// more than GRAVITY_DAMAGE_THRESHOLD, since the damage scales on the excess over it.
	var/field_gravity = 2
	/// Knockdown applied to living mobs dragged onto the centre. 0 disables it.
	var/center_knockdown = 0

/datum/psionic_rank_variant/gravity_well/alpha
	rank = PSIONIC_RANK_ALPHA
	variant_name = "collapse"
	description = "A wider, heavier well that crushes what it drags in."
	strain_gain = 45
	cooldown_time = 60 SECONDS
	cast_range = 8
	pull_range = 5
	field_gravity = (GRAVITY_DAMAGE_THRESHOLD + 1)
	center_knockdown = 2 SECONDS

/datum/action/cooldown/psionic/pointed/gravity_well
	name = "Gravity Well"
	desc = "Collapse a point of space, dragging everything nearby toward it until it fades. Anchored footing, magnetic boots, and psionic dampening hold against it."
	button_icon_state = "psi_gravity_well"
	point_cost = 2
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	active_msg = "You gather a knot of collapsing weight..."
	deactive_msg = "You let the collapsing weight disperse."
	variant_type = /datum/psionic_rank_variant/gravity_well
	rank_variant_types = list(
		/datum/psionic_rank_variant/gravity_well,
		/datum/psionic_rank_variant/gravity_well/alpha,
	)

/datum/action/cooldown/psionic/pointed/gravity_well/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE

	var/turf/target_turf = get_turf(target)
	if(!target_turf || target_turf.is_blocked_turf(exclude_mobs = TRUE))
		owner.balloon_alert(owner, "no room!")
		return FALSE
	if(locate(/obj/effect/psionic_gravity_well) in target_turf)
		owner.balloon_alert(owner, "already collapsing!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/gravity_well/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/datum/psionic_rank_variant/gravity_well/form = get_form()
	var/turf/target_turf = get_turf(target)
	if(!istype(living_owner) || !form || !target_turf)
		return FALSE

	new /obj/effect/psionic_gravity_well(target_turf, living_owner, form, get_manifestation_color())
	living_owner.visible_message(
		span_warning("Space folds inward over [target_turf]."),
		span_purple("You collapse a point of space over [target_turf]."),
	)
	playsound(target_turf, 'sound/effects/magic/cosmic_energy.ogg', 55, TRUE)
	return TRUE

/obj/effect/psionic_gravity_well
	name = "gravity well"
	desc = "A knot of collapsed space dragging everything toward its centre."
	icon = 'modular_nova/modules/psionics/icons/gravity_well.dmi'
	icon_state = "gravity_well"
	SET_BASE_VISUAL_PIXEL(-32, -32)
	anchored = TRUE
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	move_resist = INFINITY
	light_system = OVERLAY_LIGHT
	light_range = 3
	light_power = 1.2
	light_color = PSIONIC_DEFAULT_COLOR
	light_on = TRUE
	/// Tiles this well pulls from.
	var/pull_range = 3
	/// Knockdown applied to living mobs dragged onto the centre. 0 disables it.
	var/center_knockdown = 0
	/// Psion who shaped this well. They are not pulled by it.
	var/datum/weakref/caster_ref
	/// Forced gravity field covering the pull radius.
	var/datum/proximity_monitor/advanced/gravity/gravity_field
	/// Repeating pull timer.
	var/pull_timer

/obj/effect/psionic_gravity_well/Initialize(mapload, mob/living/caster, datum/psionic_rank_variant/gravity_well/form, manifestation_color)
	. = ..()
	if(!form)
		return INITIALIZE_HINT_QDEL

	pull_range = form.pull_range
	center_knockdown = form.center_knockdown
	if(caster)
		caster_ref = WEAKREF(caster)
	if(manifestation_color)
		add_atom_colour(color_transition_filter(manifestation_color, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
		set_light_color(manifestation_color)
	gravity_field = new(src, pull_range, TRUE, form.field_gravity)
	pull_timer = addtimer(CALLBACK(src, PROC_REF(pull_tick)), PSIONIC_GRAVITY_WELL_PULL_INTERVAL, TIMER_STOPPABLE|TIMER_LOOP|TIMER_DELETE_ME)
	QDEL_IN(src, PSIONIC_GRAVITY_WELL_DURATION)

/obj/effect/psionic_gravity_well/Destroy()
	if(pull_timer)
		deltimer(pull_timer)
		pull_timer = null
	QDEL_NULL(gravity_field)
	caster_ref = null
	return ..()

/obj/effect/psionic_gravity_well/proc/pull_tick()
	var/turf/well_turf = get_turf(src)
	if(!well_turf)
		return

	for(var/atom/movable/dragged as anything in get_pullable_atoms(well_turf))
		if(get_turf(dragged) == well_turf)
			crush_at_centre(dragged)
			continue

		step_towards(dragged, well_turf)

/// Everything the well can currently act on. The caster is exempt, and anything holding its own
/// footing (magnetic boots, an anchored psion, a bolted machine) is skipped rather than dragged.
/obj/effect/psionic_gravity_well/proc/get_pullable_atoms(turf/well_turf)
	var/mob/living/caster = caster_ref?.resolve()
	var/list/pullable = list()
	for(var/atom/movable/candidate in range(pull_range, well_turf))
		if(candidate == src || candidate == caster)
			continue
		if(candidate.anchored || candidate.move_resist >= MOVE_FORCE_STRONG)
			continue
		if(isliving(candidate))
			var/mob/living/living_candidate = candidate
			if(living_candidate.mob_negates_gravity())
				continue
			if(living_candidate.has_free_psionic_block(PSIONIC_KINETIC))
				continue

			pullable += candidate
			continue
		if(isitem(candidate))
			pullable += candidate

	return pullable

/obj/effect/psionic_gravity_well/proc/crush_at_centre(atom/movable/dragged)
	if(center_knockdown <= 0 || !isliving(dragged))
		return

	var/mob/living/living_dragged = dragged
	if(living_dragged.body_position == LYING_DOWN)
		return

	living_dragged.Knockdown(center_knockdown)
	to_chat(living_dragged, span_userdanger("The collapse drags you off your feet!"))

#undef PSIONIC_GRAVITY_WELL_DURATION
#undef PSIONIC_GRAVITY_WELL_PULL_INTERVAL
