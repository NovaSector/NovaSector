/datum/psionic_power/psionic_barrier
	action_type = /datum/action/cooldown/psionic/psionic_barrier

/proc/get_psionic_barrier_dir(direction)
	if(isnull(direction))
		return SOUTH
	if(ISDIAGONALDIR(direction))
		var/east_west_direction = EWCOMPONENT(direction)
		if(east_west_direction == EAST || east_west_direction == WEST)
			return east_west_direction
		var/north_south_direction = NSCOMPONENT(direction)
		if(north_south_direction == NORTH || north_south_direction == SOUTH)
			return north_south_direction
	if(direction == NORTH || direction == SOUTH || direction == EAST || direction == WEST)
		return direction

	return SOUTH

/datum/psionic_rank_variant/psionic_barrier
	rank = PSIONIC_RANK_GAMMA
	variant_name = "thin barrier"
	description = "A translucent directional barrier."
	cooldown_time = 0
	strain_gain = 0
	/// Minimum strain gained for each blocked attack.
	var/block_strain_gain = 10
	/// Fraction of incoming attack pressure converted to strain.
	var/block_strain_multiplier = 1
	/// Visual alpha used while this barrier form is maintained.
	var/barrier_alpha = 115

/datum/psionic_rank_variant/psionic_barrier/proc/get_block_strain_gain()
	return block_strain_gain

/datum/psionic_rank_variant/psionic_barrier/proc/get_block_strain_multiplier()
	return block_strain_multiplier

/datum/psionic_rank_variant/psionic_barrier/proc/get_barrier_alpha()
	return barrier_alpha

/datum/psionic_rank_variant/psionic_barrier/get_description(datum/action/cooldown/psionic/action)
	var/form_description = description || get_name(action)
	return "[form_description] ([get_block_strain_gain()] minimum strain, [round(get_block_strain_multiplier() * 100)]% impact strain per block)"

/datum/psionic_rank_variant/psionic_barrier/beta
	rank = PSIONIC_RANK_BETA
	variant_name = "reinforced barrier"
	description = "A brighter directional barrier that divides incoming impact."
	block_strain_gain = 6
	block_strain_multiplier = 0.5
	barrier_alpha = 210

/datum/action/cooldown/psionic/psionic_barrier
	name = "Psionic Barrier"
	desc = "Toggle a directional psionic barrier that catches incoming attacks, building strain with each block."
	button_icon_state = "psi_psionic_barrier"
	cooldown_time = 0
	point_cost = 1
	strain_gain = 0
	psionic_flags = PSIONIC_PROTECTIVE
	school = PSIONIC_SCHOOL_FLUX
	rank_variant_types = list(
		/datum/psionic_rank_variant/psionic_barrier,
		/datum/psionic_rank_variant/psionic_barrier/beta,
	)
	/// TRUE while the psion is maintaining the barrier.
	var/barrier_active = FALSE
	/// Visible projection tracking the psion.
	var/obj/effect/psionic_barrier/barrier_visual
	/// Degrees on either side of the facing direction covered by the barrier.
	var/block_angle = 60

/datum/action/cooldown/psionic/psionic_barrier/Remove(mob/living/remove_from)
	if(remove_from)
		clear_barrier(remove_from, TRUE)
	return ..()

/datum/action/cooldown/psionic/psionic_barrier/IsAvailable(feedback = FALSE)
	if(is_barrier_active())
		return TRUE

	return ..()

/datum/action/cooldown/psionic/psionic_barrier/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return is_barrier_active()

/datum/action/cooldown/psionic/psionic_barrier/Activate(atom/target)
	var/mob/living/living_owner = owner
	if(is_barrier_active())
		return clear_barrier(living_owner)

	return ..()

/datum/action/cooldown/psionic/psionic_barrier/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	if(!can_maintain_barrier(living_owner, profile))
		return FALSE

	var/datum/psionic_rank_variant/psionic_barrier/form = get_selected_variant_as_type(/datum/psionic_rank_variant/psionic_barrier)
	if(!form)
		return FALSE

	barrier_active = TRUE
	barrier_visual = new /obj/effect/psionic_barrier(get_turf(living_owner), living_owner)
	profile.apply_manifestation_color(barrier_visual)
	apply_barrier_form(form)
	RegisterSignal(living_owner, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(on_pre_bullet))
	RegisterSignal(living_owner, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(on_check_block))
	RegisterSignal(living_owner, COMSIG_ATOM_POST_DIR_CHANGE, PROC_REF(on_owner_dir_change))
	RegisterSignal(living_owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_owner_moved))
	RegisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_owner_life))
	RegisterSignal(living_owner, COMSIG_LIVING_DEATH, PROC_REF(on_owner_death))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

	living_owner.visible_message(
		span_notice("Static folds into a barrier before [living_owner]."),
		span_purple("You focus a psionic barrier before you."),
	)
	playsound(living_owner, 'sound/vehicles/mecha/mech_shield_raise.ogg', 35, TRUE)
	return TRUE

/datum/action/cooldown/psionic/psionic_barrier/proc/is_barrier_active()
	return barrier_active && istype(owner, /mob/living)


/datum/action/cooldown/psionic/psionic_barrier/proc/apply_barrier_form(datum/psionic_rank_variant/psionic_barrier/form)
	if(!form || !barrier_visual || QDELETED(barrier_visual))
		return

	barrier_visual.set_barrier_alpha(form.get_barrier_alpha())

/datum/action/cooldown/psionic/psionic_barrier/on_rank_variant_selected(mob/living/living_owner, datum/psionic_rank_variant/variant)
	. = ..()
	if(!is_barrier_active())
		return
	if(!istype(variant, /datum/psionic_rank_variant/psionic_barrier))
		return

	var/datum/psionic_rank_variant/psionic_barrier/barrier_form = variant
	apply_barrier_form(barrier_form)

/datum/action/cooldown/psionic/psionic_barrier/proc/can_maintain_barrier(mob/living/living_owner, datum/component/psionic_profile/profile)
	if(action_disabled || !istype(living_owner) || !profile)
		return FALSE
	if(living_owner.stat != CONSCIOUS)
		return FALSE
	if(HAS_TRAIT(living_owner, TRAIT_INCAPACITATED))
		return FALSE
	if(!isturf(living_owner.loc))
		return FALSE
	if(profile.is_burned_out())
		return FALSE

	return living_owner.can_cast_psionics(psionic_flags)

/datum/action/cooldown/psionic/psionic_barrier/proc/on_pre_bullet(mob/living/source, obj/projectile/hitting_projectile, def_zone, piercing_hit)
	SIGNAL_HANDLER

	var/mob/living/living_owner = owner
	if(!istype(living_owner) || source != living_owner)
		return NONE

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	if(!can_maintain_barrier(living_owner, profile))
		clear_barrier(living_owner, TRUE)
		return NONE
	var/datum/psionic_rank_variant/psionic_barrier/form = get_selected_variant_as_type(/datum/psionic_rank_variant/psionic_barrier)
	if(!form)
		clear_barrier(living_owner, TRUE)
		return NONE
	if(!barrier_covers_projectile(living_owner, hitting_projectile))
		return NONE
	if(!profile.try_gain_strain(get_projectile_strain(hitting_projectile, form), src))
		clear_barrier(living_owner, TRUE)
		return NONE

	if(barrier_visual && !QDELETED(barrier_visual))
		barrier_visual.sync_to_owner(living_owner)
		barrier_visual.show_impact()
	living_owner.visible_message(
		span_warning("[living_owner]'s psionic barrier scatters [hitting_projectile]."),
		span_notice("Your psionic barrier catches [hitting_projectile]."),
	)
	playsound(living_owner, 'sound/vehicles/mecha/mech_shield_deflect.ogg', 50, TRUE)
	return COMPONENT_BULLET_BLOCKED

/datum/action/cooldown/psionic/psionic_barrier/proc/on_check_block(mob/living/source, atom/hit_by, damage, attack_text, attack_type, armour_penetration, damage_type)
	SIGNAL_HANDLER

	var/mob/living/living_owner = owner
	if(!istype(living_owner) || source != living_owner)
		return FAILED_BLOCK
	if(attack_type == PROJECTILE_ATTACK || damage <= 0)
		return FAILED_BLOCK

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	if(!can_maintain_barrier(living_owner, profile))
		clear_barrier(living_owner, TRUE)
		return FAILED_BLOCK
	var/datum/psionic_rank_variant/psionic_barrier/form = get_selected_variant_as_type(/datum/psionic_rank_variant/psionic_barrier)
	if(!form)
		clear_barrier(living_owner, TRUE)
		return FAILED_BLOCK
	if(!barrier_covers_atom(living_owner, hit_by))
		return FAILED_BLOCK
	if(!profile.try_gain_strain(get_attack_strain(damage, form), src))
		clear_barrier(living_owner, TRUE)
		return FAILED_BLOCK

	if(barrier_visual && !QDELETED(barrier_visual))
		barrier_visual.sync_to_owner(living_owner)
		barrier_visual.show_impact()
	living_owner.visible_message(
		span_warning("[living_owner]'s psionic barrier turns aside [attack_text]."),
		span_notice("Your psionic barrier catches [attack_text]."),
	)
	playsound(living_owner, 'sound/vehicles/mecha/mech_shield_deflect.ogg', 50, TRUE)
	return SUCCESSFUL_BLOCK

/datum/action/cooldown/psionic/psionic_barrier/proc/barrier_covers_projectile(mob/living/living_owner, obj/projectile/hitting_projectile)
	var/source_angle = get_projectile_source_angle(living_owner, hitting_projectile)
	return barrier_covers_source_angle(living_owner, source_angle)

/datum/action/cooldown/psionic/psionic_barrier/proc/barrier_covers_atom(mob/living/living_owner, atom/hit_by)
	var/source_angle = get_atom_source_angle(living_owner, hit_by)
	return barrier_covers_source_angle(living_owner, source_angle)

/datum/action/cooldown/psionic/psionic_barrier/proc/barrier_covers_source_angle(mob/living/living_owner, source_angle)
	if(isnull(source_angle))
		return FALSE

	var/facing_angle = dir2angle(get_psionic_barrier_dir(living_owner.dir))
	if(isnull(facing_angle))
		return FALSE

	return abs(closer_angle_difference(facing_angle, source_angle)) <= block_angle

/datum/action/cooldown/psionic/psionic_barrier/proc/get_projectile_source_angle(mob/living/living_owner, obj/projectile/hitting_projectile)
	var/turf/owner_turf = get_turf(living_owner)
	if(!owner_turf)
		return null

	var/turf/projectile_turf = get_turf(hitting_projectile)
	if(projectile_turf && projectile_turf != owner_turf)
		return get_angle(owner_turf, projectile_turf)
	if(hitting_projectile.starting && hitting_projectile.starting != owner_turf)
		return get_angle(owner_turf, hitting_projectile.starting)
	if(isnum(hitting_projectile.angle))
		return SIMPLIFY_DEGREES(hitting_projectile.angle + 180)

	return null

/datum/action/cooldown/psionic/psionic_barrier/proc/get_atom_source_angle(mob/living/living_owner, atom/hit_by)
	var/turf/owner_turf = get_turf(living_owner)
	if(!owner_turf)
		return null

	var/turf/source_turf = get_turf(hit_by)
	if(source_turf && source_turf != owner_turf)
		return get_angle(owner_turf, source_turf)

	var/mob/living/attacker
	if(isliving(hit_by))
		attacker = hit_by
	else
		attacker = GET_ASSAILANT(hit_by)
	source_turf = get_turf(attacker)
	if(source_turf && source_turf != owner_turf)
		return get_angle(owner_turf, source_turf)

	return null

/datum/action/cooldown/psionic/psionic_barrier/proc/get_projectile_strain(obj/projectile/hitting_projectile, datum/psionic_rank_variant/psionic_barrier/form)
	var/projectile_pressure = max(hitting_projectile.damage, 0) + max(hitting_projectile.stamina, 0)
	if(istype(hitting_projectile, /obj/projectile/bullet/pulse))
		var/obj/projectile/bullet/pulse/pulse_projectile = hitting_projectile
		projectile_pressure += max(pulse_projectile.secondary_damage, 0)

	return max(form.get_block_strain_gain(), round(projectile_pressure * form.get_block_strain_multiplier()))

/datum/action/cooldown/psionic/psionic_barrier/proc/get_attack_strain(damage, datum/psionic_rank_variant/psionic_barrier/form)
	var/attack_pressure = max(damage, 0)
	return max(form.get_block_strain_gain(), round(attack_pressure * form.get_block_strain_multiplier()))

/datum/action/cooldown/psionic/psionic_barrier/proc/on_owner_dir_change(datum/source, olddir, newdir)
	SIGNAL_HANDLER

	var/mob/living/living_owner = owner
	if(barrier_visual && !QDELETED(barrier_visual))
		barrier_visual.sync_to_owner(living_owner, get_psionic_barrier_dir(newdir))

/datum/action/cooldown/psionic/psionic_barrier/proc/on_owner_moved(datum/source)
	SIGNAL_HANDLER

	var/mob/living/living_owner = owner
	if(barrier_visual && !QDELETED(barrier_visual))
		barrier_visual.sync_to_owner(living_owner)

/datum/action/cooldown/psionic/psionic_barrier/proc/on_owner_life(datum/source, seconds_per_tick)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	if(!istype(living_owner))
		return

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	if(!can_maintain_barrier(living_owner, profile))
		clear_barrier(living_owner, TRUE)
		return
	if(!get_selected_variant_as_type(/datum/psionic_rank_variant/psionic_barrier))
		clear_barrier(living_owner, TRUE)

/datum/action/cooldown/psionic/psionic_barrier/proc/on_owner_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	clear_barrier(living_owner, TRUE)

/datum/action/cooldown/psionic/psionic_barrier/proc/clear_barrier(mob/living/living_owner, silent = FALSE)
	if(!barrier_active)
		return FALSE

	barrier_active = FALSE
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(
			COMSIG_ATOM_PRE_BULLET_ACT,
			COMSIG_LIVING_CHECK_BLOCK,
			COMSIG_ATOM_POST_DIR_CHANGE,
			COMSIG_MOVABLE_MOVED,
			COMSIG_LIVING_LIFE,
			COMSIG_LIVING_DEATH,
		))
		if(!silent)
			to_chat(living_owner, span_notice("The psionic barrier dissolves."))
			playsound(living_owner, 'sound/vehicles/mecha/mech_shield_drop.ogg', 35, TRUE)
	clear_barrier_visual(silent)
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	return TRUE

/datum/action/cooldown/psionic/psionic_barrier/proc/clear_barrier_visual(silent = FALSE)
	if(!barrier_visual || QDELETED(barrier_visual))
		barrier_visual = null
		return
	if(silent)
		QDEL_NULL(barrier_visual)
		return

	barrier_visual.drop()
	QDEL_IN(barrier_visual, 1 SECONDS)
	barrier_visual = null

/obj/effect/psionic_barrier
	name = "psionic barrier"
	desc = "A directional fold of defensive psionic static."
	icon = 'modular_nova/modules/psionics/icons/psionic_barrier.dmi'
	icon_state = "shield"
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 0.7
	light_color = PSIONIC_DEFAULT_COLOR
	light_on = TRUE
	/// Mob currently maintaining this projection.
	var/mob/living/psion

/obj/effect/psionic_barrier/Initialize(mapload, mob/living/new_psion)
	. = ..()
	psion = new_psion
	sync_to_owner(psion)
	flick("shield_raise", src)

/obj/effect/psionic_barrier/Destroy()
	psion = null
	return ..()

/obj/effect/psionic_barrier/proc/sync_to_owner(mob/living/living_owner, override_dir)
	if(!istype(living_owner))
		return FALSE

	var/turf/owner_turf = get_turf(living_owner)
	if(!owner_turf)
		return FALSE

	forceMove(owner_turf)
	var/barrier_dir = get_psionic_barrier_dir(isnull(override_dir) ? living_owner.dir : override_dir)
	setDir(barrier_dir)
	pixel_w = 0
	if(barrier_dir & EAST)
		pixel_w = 6
	else if(barrier_dir & WEST)
		pixel_w = -6
	return TRUE

/obj/effect/psionic_barrier/proc/show_impact()
	flick("shield_impact", src)

/obj/effect/psionic_barrier/proc/set_barrier_alpha(new_alpha)
	alpha = new_alpha

/obj/effect/psionic_barrier/proc/drop()
	flick("shield_drop", src)
	icon_state = "shield_null"
