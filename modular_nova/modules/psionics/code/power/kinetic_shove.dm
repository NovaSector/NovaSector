/datum/psionic_power/kinetic_shove
	action_type = /datum/action/cooldown/psionic/pointed/kinetic_shove

/datum/psionic_power/kinetic_pull
	action_type = /datum/action/cooldown/psionic/pointed/kinetic_pull

/datum/psionic_rank_variant/kinetic_shove
	rank = PSIONIC_RANK_GAMMA
	variant_name = "shove"
	description = "A focused shove that throws one target several tiles."
	strain_gain = 16
	cooldown_time = 12 SECONDS
	cast_range = 5
	/// Distance this form throws affected atoms.
	var/throw_distance = 3
	/// Stamina damage dealt to living targets.
	var/stamina_damage = 20
	/// Knockdown applied to living targets.
	var/knockdown_time = 1 SECONDS
	/// If TRUE, this form erupts from the caster instead of requiring a target.
	var/radial_shove = FALSE
	/// Radius affected by radial forms.
	var/radial_range = 0
	block_charge_cost = 1
	block_message = "force dampened!"
	/// If TRUE, this form launches a wide advancing wave in a targeted direction.
	var/directional_wave = FALSE
	/// Distance travelled by directional waves.
	var/wave_range = 0
	/// Width of directional waves, centered on their travelling line.
	var/wave_width = 1
	/// Delay between each travelled wave tile.
	var/wave_step_delay = 0.2 SECONDS
	/// Brute damage dealt by directional waves.
	var/wave_brute_damage = 0
	/// Damage dealt to windows and grilles by directional waves.
	var/structure_damage = 0
	/// Chance for a directional wave to break a normal wall it crosses.
	var/wall_break_chance = 0

/datum/psionic_rank_variant/kinetic_shove/epsilon
	rank = PSIONIC_RANK_EPSILON
	variant_name = "nudge"
	description = "A mild shove that bumps one target a short distance."
	strain_gain = 8
	cooldown_time = 8 SECONDS
	throw_distance = 2
	stamina_damage = 8
	knockdown_time = 0

/datum/psionic_rank_variant/kinetic_shove/beta
	rank = PSIONIC_RANK_BETA
	variant_name = "kinetic wave"
	description = "A radial wave that shoves nearby things away from you."
	strain_gain = 30
	cooldown_time = 25 SECONDS
	throw_distance = 4
	stamina_damage = 24
	knockdown_time = 1.5 SECONDS
	radial_shove = TRUE
	radial_range = 4
	block_charge_cost = 2

/datum/psionic_rank_variant/kinetic_shove/alpha
	rank = PSIONIC_RANK_ALPHA
	variant_name = "kinetic rupture"
	description = "A crushing wave that rolls forward, breaking bodies and structures in its path."
	strain_gain = 45
	cooldown_time = 45 SECONDS
	cast_range = 8
	throw_distance = 3
	stamina_damage = 0
	knockdown_time = 2 SECONDS
	block_charge_cost = 3
	directional_wave = TRUE
	wave_range = 8
	wave_width = 3
	wave_brute_damage = 35
	structure_damage = 75
	wall_break_chance = 25
	active_msg = "Space buckles around your hand. Pick a direction."
	deactive_msg = "The pressure in your hand collapses."

/datum/psionic_rank_variant/kinetic_pull
	rank = PSIONIC_RANK_EPSILON
	variant_name = "pull"
	description = "A light kinetic tug that pulls one loose item into your hand."
	strain_gain = 8
	cooldown_time = 8 SECONDS
	cast_range = 5
	/// Speed used when pulling the item toward the psion.
	var/pull_speed = 2

/datum/action/cooldown/psionic/pointed/kinetic_shove
	name = "Kinetic Shove"
	desc = "Throw a nearby target away with focused psionic force."
	button_icon_state = "psi_kinetic_shove"
	point_cost = 1
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	rank_variant_types = list(
		/datum/psionic_rank_variant/kinetic_shove/epsilon,
		/datum/psionic_rank_variant/kinetic_shove,
		/datum/psionic_rank_variant/kinetic_shove/beta,
		/datum/psionic_rank_variant/kinetic_shove/alpha,
	)

/datum/action/cooldown/psionic/pointed/kinetic_pull
	name = "Kinetic Pull"
	desc = "Pull a loose item into your hand with focused psionic force."
	button_icon_state = "psi_kinetic_pull"
	point_cost = 1
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	needs_hands = TRUE
	rank_variant_types = list(
		/datum/psionic_rank_variant/kinetic_pull,
	)

/datum/action/cooldown/psionic/pointed/kinetic_shove/Trigger(mob/clicker, trigger_flags, atom/target)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		return ..()

	var/datum/psionic_rank_variant/kinetic_shove/form = get_kinetic_form()
	if(!form?.radial_shove)
		return ..()

	var/mob/user = clicker || owner
	var/datum/action/cooldown/already_set = user?.click_intercept
	if(already_set == src)
		unset_click_ability(user, refund_cooldown = FALSE)
	else if(istype(already_set))
		already_set.unset_click_ability(user, refund_cooldown = TRUE)

	var/was_click_to_activate = click_to_activate
	click_to_activate = FALSE
	. = ..()
	click_to_activate = was_click_to_activate

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/get_kinetic_form()
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return null

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	var/datum/psionic_rank_variant/selected_variant = get_selected_rank_variant(profile)
	if(istype(selected_variant, /datum/psionic_rank_variant/kinetic_shove))
		return selected_variant

	return null

/datum/action/cooldown/psionic/pointed/kinetic_shove/try_block_target(atom/target, datum/component/psionic_profile/profile)
	return FALSE

/datum/action/cooldown/psionic/pointed/kinetic_pull/proc/get_pull_form()
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return null

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	var/datum/psionic_rank_variant/selected_variant = get_selected_rank_variant(profile)
	if(istype(selected_variant, /datum/psionic_rank_variant/kinetic_pull))
		return selected_variant

	return null

/datum/action/cooldown/psionic/pointed/kinetic_shove/is_valid_target(atom/target)
	var/datum/psionic_rank_variant/kinetic_shove/form = get_kinetic_form()
	if(form?.radial_shove)
		return TRUE
	if(form?.directional_wave)
		return ..()

	. = ..()
	if(!.)
		return FALSE
	if(!ismovable(target))
		owner.balloon_alert(owner, "not movable!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_pull/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/obj/item/item_target = target
	if(!istype(item_target))
		living_owner.balloon_alert(living_owner, "not an item!")
		return FALSE
	if(!isturf(item_target.loc))
		living_owner.balloon_alert(living_owner, "not loose!")
		return FALSE
	if(item_target.anchored || item_target.move_resist >= MOVE_FORCE_STRONG)
		living_owner.balloon_alert(living_owner, "too heavy!")
		return FALSE
	if(HAS_TRAIT(item_target, TRAIT_UNCATCHABLE) || !living_owner.can_hold_items(item_target))
		living_owner.balloon_alert(living_owner, "can't catch it!")
		return FALSE
	if(!length(living_owner.get_empty_held_indexes()))
		living_owner.balloon_alert(living_owner, "free a hand!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/datum/psionic_rank_variant/kinetic_shove/form = get_kinetic_form()
	if(!form)
		return FALSE

	if(form.radial_shove)
		return radial_shove(living_owner, form)
	if(form.directional_wave)
		return start_kinetic_wave(living_owner, target, form)

	if(check_shove_block(target, form))
		return TRUE
	return shove_target(target, form)

/datum/action/cooldown/psionic/pointed/kinetic_pull/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/obj/item/pulled_item = target
	if(!istype(pulled_item))
		return FALSE

	var/datum/psionic_rank_variant/kinetic_pull/form = get_pull_form()
	if(!form)
		return FALSE

	if(get_turf(pulled_item) == get_turf(living_owner))
		if(!living_owner.put_in_hands(pulled_item, ignore_animation = FALSE))
			return FALSE
		living_owner.visible_message(
			span_notice("[pulled_item] rises into [living_owner]'s hand under invisible force."),
			span_notice("You pull [pulled_item] into your hand."),
			ignored_mobs = pulled_item,
		)
		playsound(get_turf(living_owner), 'sound/effects/gravhit.ogg', 35, TRUE)
		return TRUE

	RegisterSignal(pulled_item, COMSIG_MOVABLE_PRE_IMPACT, PROC_REF(catch_pulled_item))
	var/datum/callback/throw_callback = CALLBACK(src, PROC_REF(clear_pull_signal), pulled_item)
	var/throw_range = max(get_dist(pulled_item, living_owner), 1)
	if(!pulled_item.safe_throw_at(
		living_owner,
		throw_range,
		form.pull_speed,
		living_owner,
		spin = FALSE,
		callback = throw_callback,
		gentle = TRUE,
	))
		clear_pull_signal(pulled_item)
		return FALSE

	living_owner.visible_message(
		span_notice("[pulled_item] snaps toward [living_owner] under invisible force."),
		span_notice("You pull [pulled_item] toward your hand."),
		ignored_mobs = pulled_item,
	)
	playsound(get_turf(pulled_item), 'sound/effects/gravhit.ogg', 45, TRUE)
	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_pull/proc/catch_pulled_item(obj/item/pulled_item, atom/hit_atom, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER

	var/mob/living/living_owner = throwingdatum?.initial_target?.resolve()
	if(!istype(living_owner))
		living_owner = owner
	if(!istype(living_owner) || hit_atom != living_owner)
		return NONE
	if(!living_owner.try_catch_item(pulled_item, skip_throw_mode_check = TRUE, try_offhand = TRUE))
		return NONE

	return COMPONENT_MOVABLE_IMPACT_NEVERMIND

/datum/action/cooldown/psionic/pointed/kinetic_pull/proc/clear_pull_signal(obj/item/pulled_item)
	if(!QDELETED(pulled_item))
		UnregisterSignal(pulled_item, COMSIG_MOVABLE_PRE_IMPACT)

/// Checks whether [target] blocks this kinetic form, emitting standard feedback if it does.
/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/check_shove_block(atom/target, datum/psionic_rank_variant/kinetic_shove/form, announce = TRUE)
	var/mob/living/living_target = target
	if(!istype(living_target))
		return FALSE
	if(!living_target.try_block_psionics(owner, PSIONIC_KINETIC, charge_cost = form.block_charge_cost, alert = form.block_message))
		return FALSE

	if(announce)
		to_chat(owner, span_warning("Your force breaks against [living_target]'s psionic dampening."))
	to_chat(living_target, span_warning("Invisible force breaks against your psionic dampening."))
	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/shove_target(atom/target, datum/psionic_rank_variant/kinetic_shove/form, announce = TRUE)
	var/atom/movable/movable_target = target
	if(!istype(movable_target))
		return FALSE

	var/mob/living/living_target = movable_target
	var/throw_direction = get_dir(owner, get_step_away(movable_target, owner))
	if(!throw_direction)
		throw_direction = get_dir(owner, movable_target)
	if(!throw_direction)
		throw_direction = pick(GLOB.cardinals)

	var/turf/throw_target = get_ranged_target_turf(movable_target, throw_direction, form.throw_distance)
	if(!throw_target)
		return FALSE

	if(announce)
		owner.visible_message(
			span_warning("[movable_target] lurches away from [owner] under invisible force."),
			span_notice("You shove [movable_target] with focused force."),
			ignored_mobs = movable_target,
		)
	if(istype(living_target))
		to_chat(living_target, span_userdanger("Invisible force slams into you!"))
		if(form.stamina_damage > 0)
			living_target.apply_damage(form.stamina_damage, STAMINA)
		if(form.knockdown_time > 0)
			living_target.Knockdown(form.knockdown_time)

	movable_target.safe_throw_at(throw_target, range = form.throw_distance, speed = 1, thrower = owner, gentle = TRUE)
	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/start_kinetic_wave(mob/living/living_owner, atom/target, datum/psionic_rank_variant/kinetic_shove/form)
	var/turf/source_turf = get_turf(living_owner)
	var/turf/target_turf = get_turf(target)
	if(!source_turf || !target_turf)
		return FALSE

	var/wave_direction = get_cardinal_dir(source_turf, target_turf)
	if(!(wave_direction in GLOB.cardinals))
		wave_direction = living_owner.dir
	if(!(wave_direction in GLOB.cardinals))
		wave_direction = SOUTH

	living_owner.setDir(wave_direction)
	living_owner.visible_message(
		span_danger("The air in front of [living_owner] folds into a crushing wave!"),
		span_notice("You release a crushing wave of focused force."),
	)
	playsound(living_owner, 'sound/effects/magic/forcewall.ogg', 70, TRUE)

	var/manifestation_color = get_manifestation_color()
	var/list/hit_atoms = list()
	var/datum/weakref/owner_ref = WEAKREF(living_owner)
	for(var/step_number in 1 to form.wave_range)
		var/datum/callback/wave_step = new /datum/callback(
			src,
			PROC_REF(resolve_kinetic_wave_step),
			owner_ref,
			wave_direction,
			step_number,
			form,
			manifestation_color,
			hit_atoms,
		)
		addtimer(wave_step, (step_number - 1) * form.wave_step_delay, TIMER_DELETE_ME)

	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/resolve_kinetic_wave_step(datum/weakref/owner_ref, wave_direction, step_number, datum/psionic_rank_variant/kinetic_shove/form, manifestation_color, list/hit_atoms)
	var/mob/living/living_owner = owner_ref?.resolve()
	if(!istype(living_owner))
		return

	var/list/wave_turfs = get_kinetic_wave_turfs(living_owner, wave_direction, step_number, form)
	if(!length(wave_turfs))
		return

	show_kinetic_wave_effects(wave_turfs, wave_direction, manifestation_color)
	playsound(wave_turfs[1], 'sound/effects/gravhit.ogg', 45, TRUE)

	for(var/turf/wave_turf as anything in wave_turfs)
		for(var/mob/living/living_target in wave_turf)
			if(living_target == living_owner)
				continue
			if(hit_atoms[living_target])
				continue

			hit_atoms[living_target] = TRUE
			hit_kinetic_wave_target(living_target, living_owner, wave_direction, form)
		damage_kinetic_wave_structures(wave_turf, living_owner, form)

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/get_kinetic_wave_turfs(mob/living/living_owner, wave_direction, step_number, datum/psionic_rank_variant/kinetic_shove/form)
	var/turf/center_turf = get_ranged_target_turf(living_owner, wave_direction, step_number)
	if(!center_turf)
		return list()

	var/list/wave_turfs = list(center_turf)
	var/side_reach = max(0, round((form.wave_width - 1) / 2))
	if(side_reach <= 0)
		return wave_turfs

	var/left_direction = turn(wave_direction, 90)
	var/right_direction = turn(wave_direction, -90)
	var/turf/left_turf = center_turf
	var/turf/right_turf = center_turf
	for(var/offset in 1 to side_reach)
		left_turf = get_step(left_turf, left_direction)
		right_turf = get_step(right_turf, right_direction)
		if(left_turf)
			wave_turfs |= left_turf
		if(right_turf)
			wave_turfs |= right_turf

	return wave_turfs

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/show_kinetic_wave_effects(list/wave_turfs, wave_direction, manifestation_color)
	for(var/turf/wave_turf as anything in wave_turfs)
		new /obj/effect/temp_visual/psionic_kinetic_fracture(wave_turf, manifestation_color)
		new /obj/effect/temp_visual/dir_setting/psionic_kinetic_distortion(wave_turf, wave_direction, manifestation_color)
		wave_turf.Shake(pixelshiftx = 1, pixelshifty = 1, duration = 0.4 SECONDS)

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/damage_kinetic_wave_structures(turf/wave_turf, mob/living/living_owner, datum/psionic_rank_variant/kinetic_shove/form)
	for(var/obj/structure/window/window in wave_turf)
		window.take_damage(
			damage_amount = form.structure_damage,
			damage_type = BRUTE,
			damage_flag = MELEE,
			attack_dir = get_dir(living_owner, window),
			armour_penetration = 30,
		)
	for(var/obj/structure/grille/grille in wave_turf)
		grille.take_damage(
			damage_amount = form.structure_damage,
			damage_type = BRUTE,
			damage_flag = MELEE,
			attack_dir = get_dir(living_owner, grille),
		)

	if(isindestructiblewall(wave_turf))
		return
	if(ismineralturf(wave_turf))
		var/turf/closed/mineral/mineral_turf = wave_turf
		mineral_turf.drill_aoe(living_owner)
		return
	if(!iswallturf(wave_turf))
		return

	var/turf/closed/wall/wall_turf = wave_turf
	wall_turf.add_dent(WALL_DENT_HIT)
	if(istype(wall_turf, /turf/closed/wall/r_wall))
		return
	if(form.wall_break_chance <= 0 || !prob(form.wall_break_chance))
		return

	wall_turf.dismantle_wall(devastated = FALSE, explode = TRUE)

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/hit_kinetic_wave_target(mob/living/living_target, mob/living/living_owner, wave_direction, datum/psionic_rank_variant/kinetic_shove/form)
	if(living_target.try_block_psionics(living_owner, PSIONIC_KINETIC, charge_cost = form.block_charge_cost, alert = form.block_message))
		to_chat(living_target, span_warning("Crushing force breaks against your psionic dampening."))
		return FALSE

	to_chat(living_target, span_userdanger("A crushing wave of invisible force slams into you!"))
	if(form.wave_brute_damage > 0)
		living_target.apply_damage(form.wave_brute_damage, BRUTE)
	if(form.knockdown_time > 0)
		living_target.Knockdown(form.knockdown_time)
	living_target.Shake(pixelshiftx = 2, pixelshifty = 2, duration = 0.5 SECONDS)

	var/turf/throw_target = get_ranged_target_turf(living_target, wave_direction, form.throw_distance)
	if(!throw_target)
		return TRUE

	living_target.safe_throw_at(
		throw_target,
		range = form.throw_distance,
		speed = 1,
		thrower = living_owner,
		spin = FALSE,
		force = MOVE_FORCE_STRONG,
		gentle = TRUE,
	)
	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/radial_shove(mob/living/living_owner, datum/psionic_rank_variant/kinetic_shove/form)
	living_owner.visible_message(
		span_warning("A wave of invisible force erupts from [living_owner]."),
		span_notice("You release a radial wave of focused force."),
	)
	show_radial_kinetic_effects(living_owner, get_manifestation_color())

	var/affected_anything = FALSE
	for(var/atom/movable/movable_target in view(form.radial_range, living_owner))
		if(movable_target == living_owner)
			continue
		if(movable_target.anchored)
			continue
		if(!isturf(movable_target.loc))
			continue
		if(check_shove_block(movable_target, form, announce = FALSE))
			continue

		if(shove_target(movable_target, form, announce = FALSE))
			affected_anything = TRUE

	if(!affected_anything)
		living_owner.balloon_alert(living_owner, "nothing moves")

	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove/proc/show_radial_kinetic_effects(mob/living/living_owner, manifestation_color)
	var/turf/center_turf = get_turf(living_owner)
	if(!center_turf)
		return

	var/center_direction = living_owner.dir
	if(!(center_direction in GLOB.cardinals))
		center_direction = SOUTH

	new /obj/effect/temp_visual/dir_setting/psionic_kinetic_distortion(center_turf, center_direction, manifestation_color)
	for(var/spark_direction in GLOB.cardinals)
		var/turf/spark_turf = get_step(center_turf, spark_direction)
		if(!spark_turf)
			continue

		new /obj/effect/temp_visual/dir_setting/psionic_kinetic_distortion(spark_turf, spark_direction, manifestation_color)

	living_owner.Shake(pixelshiftx = 1, pixelshifty = 1, duration = 0.4 SECONDS)

/obj/effect/temp_visual/psionic_kinetic_fracture
	name = "psionic fracture"
	icon_state = "purplecrack"
	duration = 1.5 SECONDS
	alpha = 180
	randomdir = TRUE

/obj/effect/temp_visual/psionic_kinetic_fracture/Initialize(mapload, manifestation_color)
	. = ..()
	if(!manifestation_color)
		manifestation_color = PSIONIC_DEFAULT_COLOR
	add_atom_colour(color_transition_filter(manifestation_color, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	set_light(1.4, 0.7, manifestation_color)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)

/obj/effect/temp_visual/dir_setting/psionic_kinetic_distortion
	name = "psionic distortion"
	icon_state = "shieldsparkles"
	duration = 0.6 SECONDS
	alpha = 140
	randomdir = FALSE

/obj/effect/temp_visual/dir_setting/psionic_kinetic_distortion/Initialize(mapload, set_dir, manifestation_color)
	. = ..()
	if(!manifestation_color)
		manifestation_color = PSIONIC_DEFAULT_COLOR
	add_atom_colour(color_transition_filter(manifestation_color, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	add_filter("psionic_kinetic_ripple", 1, list("type" = "ripple", "flags" = WAVE_BOUNDED, "radius" = 0, "size" = 2))
	var/filter = get_filter("psionic_kinetic_ripple")
	animate(filter, radius = 16, size = 1, time = duration)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)
