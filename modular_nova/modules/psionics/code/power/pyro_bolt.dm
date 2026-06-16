/datum/psionic_power/pyro_bolt
	action_type = /datum/action/cooldown/psionic/pointed/projectile/pyro_bolt

/datum/psionic_rank_variant/pyro_bolt
	rank = PSIONIC_RANK_GAMMA
	variant_name = "barrage"
	description = "Three thermal beams fired in a loose spread."
	strain_gain = 14
	cooldown_time = 12 SECONDS
	cast_range = 9
	/// Projectile type launched by this form.
	var/obj/projectile/projectile_type = /obj/projectile/psionic/pyro_bolt
	/// Number of projectiles released by one activation.
	var/projectiles_per_fire = 3
	/// Degrees between projectiles in a multi-projectile spread.
	var/projectile_spread = 8
	/// Sound played once when this form fires.
	var/projectile_sound = 'sound/items/weapons/laser.ogg'

/datum/psionic_rank_variant/pyro_bolt/proc/get_projectile_type(datum/action/cooldown/psionic/pointed/projectile/pyro_bolt/action)
	if(!isnull(projectile_type))
		return projectile_type

	return action.projectile_type

/datum/psionic_rank_variant/pyro_bolt/proc/get_projectiles_per_fire(datum/action/cooldown/psionic/pointed/projectile/pyro_bolt/action)
	if(!isnull(projectiles_per_fire))
		return projectiles_per_fire

	return action.projectiles_per_fire

/datum/psionic_rank_variant/pyro_bolt/proc/get_projectile_spread(datum/action/cooldown/psionic/pointed/projectile/pyro_bolt/action)
	if(!isnull(projectile_spread))
		return projectile_spread

	return action.projectile_spread

/datum/psionic_rank_variant/pyro_bolt/proc/get_projectile_sound(datum/action/cooldown/psionic/pointed/projectile/pyro_bolt/action)
	if(!isnull(projectile_sound))
		return projectile_sound

	return action.projectile_sound

/datum/psionic_rank_variant/pyro_bolt/proc/show_activation_message(mob/living/user)
	user.visible_message(
		span_warning("[user]'s hand blooms with orange fire."),
		span_purple("Your hand blooms with orange fire."),
	)

/datum/psionic_rank_variant/pyro_bolt/epsilon
	rank = PSIONIC_RANK_EPSILON
	variant_name = "bolt"
	description = "One careful thermal bolt."
	strain_gain = 8
	cooldown_time = 20 SECONDS
	projectiles_per_fire = 1
	projectile_spread = 0

/datum/psionic_rank_variant/pyro_bolt/delta
	rank = PSIONIC_RANK_DELTA
	variant_name = "rapid bolt"
	description = "One thermal bolt with no psionic recharge pause."
	strain_gain = 5
	cooldown_time = 0
	projectiles_per_fire = 1
	projectile_spread = 0

/datum/psionic_rank_variant/pyro_bolt/beta
	rank = PSIONIC_RANK_BETA
	variant_name = "fireball"
	description = "An explosive knot of compressed psionic heat."
	strain_gain = 32
	cooldown_time = 30 SECONDS
	cast_range = 8
	active_msg = "A bright pressure gathers in your burning hand."
	deactive_msg = "You let the fireball gutter out."
	projectile_type = /obj/projectile/psionic/pyro_fireball
	projectiles_per_fire = 1
	projectile_spread = 0
	projectile_sound = 'sound/effects/magic/fireball.ogg'

/datum/psionic_rank_variant/pyro_bolt/beta/show_activation_message(mob/living/user)
	user.visible_message(
		span_warning("[user] hurls a dense knot of orange fire."),
		span_purple("You hurl a dense knot of orange fire."),
	)

/datum/action/cooldown/psionic/pointed/projectile/pyro_bolt
	name = "Pyro Bolt"
	desc = "Ignite your hand and shape psionic heat into bolts or fireballs."
	button_icon_state = "psi_pyro_bolt"
	active_msg = "Flame gathers over your palm."
	deactive_msg = "The flame drains back into your skin."
	cooldown_time = 12 SECONDS
	cast_range = 9
	click_cd_override = CLICK_CD_RANGE
	point_cost = 1
	strain_gain = 14
	psionic_flags = PSIONIC_THERMAL
	school = PSIONIC_SCHOOL_FLUX
	needs_hands = TRUE
	rank_variant_types = list(
		/datum/psionic_rank_variant/pyro_bolt/epsilon,
		/datum/psionic_rank_variant/pyro_bolt,
		/datum/psionic_rank_variant/pyro_bolt/delta,
		/datum/psionic_rank_variant/pyro_bolt/beta,
	)
	projectile_type = /obj/projectile/psionic/pyro_bolt
	projectile_hand_visual_type = /obj/item/psionic_pyro_hand
	projectiles_per_fire = 3
	projectile_spread = 8
	projectile_sound = 'sound/items/weapons/laser.ogg'

/datum/action/cooldown/psionic/pointed/projectile/pyro_bolt/proc/get_pyro_form()
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return null

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	var/datum/psionic_rank_variant/selected_variant = get_selected_rank_variant(profile)
	if(istype(selected_variant, /datum/psionic_rank_variant/pyro_bolt))
		return selected_variant

	return null

/datum/action/cooldown/psionic/pointed/projectile/pyro_bolt/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/datum/psionic_rank_variant/pyro_bolt/form = get_pyro_form()
	if(!form)
		return FALSE

	var/obj/projectile/original_projectile_type = projectile_type
	var/original_projectiles_per_fire = projectiles_per_fire
	var/original_projectile_spread = projectile_spread
	var/original_projectile_sound = projectile_sound

	form.show_activation_message(living_owner)
	projectile_type = form.get_projectile_type(src)
	projectiles_per_fire = form.get_projectiles_per_fire(src)
	projectile_spread = form.get_projectile_spread(src)
	projectile_sound = form.get_projectile_sound(src)
	. = ..()
	projectile_type = original_projectile_type
	projectiles_per_fire = original_projectiles_per_fire
	projectile_spread = original_projectile_spread
	projectile_sound = original_projectile_sound

/obj/item/psionic_pyro_hand
	name = "\improper psionic flame"
	desc = "A flame-shaped pressure shimmering around the hand."
	icon = 'icons/obj/weapons/hand.dmi'
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	icon_state = "greyscale"
	inhand_icon_state = "greyscale"
	color = COLOR_ORANGE
	item_flags = ABSTRACT | HAND_ITEM | DROPDEL | NOBLUDGEON
	w_class = WEIGHT_CLASS_HUGE
	force = 0
	throwforce = 0
	throw_range = 0
	throw_speed = 0

/obj/item/psionic_pyro_hand/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, PSIONIC_TRAIT_SOURCE)

/obj/projectile/psionic
	name = "psionic bolt"
	icon_state = "energy"
	damage_type = BURN
	armor_flag = ENERGY
	/// Psionic category checked by anti-psionic counters when this projectile hits.
	var/psionic_flags = PSIONIC_THERMAL
	/// Anti-psionic charge cost to block this projectile.
	var/psionic_charge_cost = 1

/obj/projectile/psionic/prehit_pierce(atom/target)
	. = ..()
	if(!isliving(target))
		return .

	var/mob/living/living_target = target
	if(living_target.can_block_psionics(psionic_flags, psionic_charge_cost))
		visible_message(span_warning("[src] unravels against [living_target]'s psionic dampening."))
		return PROJECTILE_DELETE_WITHOUT_HITTING

/obj/projectile/psionic/pyro_bolt
	name = "pyro bolt"
	icon_state = "firebeam"
	damage = 10
	damage_type = BURN
	armor_flag = LASER
	range = 9
	color = COLOR_ORANGE
	hitsound = 'sound/items/weapons/sear.ogg'
	hitsound_wall = 'sound/items/weapons/effects/searwall.ogg'
	impact_effect_type = /obj/effect/temp_visual/impact_effect/yellow_laser
	tracer_type = /obj/effect/projectile/tracer/laser/emitter/blast
	muzzle_type = /obj/effect/projectile/muzzle/laser/emitter/blast
	impact_type = /obj/effect/projectile/impact/laser/emitter/blast
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_power = 1.4
	light_color = LIGHT_COLOR_ORANGE
	/// Temperature used when igniting targets and exposed objects.
	var/temperature = 350

/obj/projectile/psionic/pyro_bolt/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(!.)
		return

	if(isobj(target))
		var/obj/object_target = target
		if(object_target.resistance_flags & ON_FIRE)
			return

		object_target.fire_act(temperature)
		return

	if(isliving(target))
		var/mob/living/living_target = target
		living_target.adjust_fire_stacks(2)
		living_target.ignite_mob()

/obj/projectile/psionic/pyro_bolt/on_range()
	var/turf/location = get_turf(src)
	if(location)
		new /obj/effect/hotspot(location)
		location.hotspot_expose(700, 50, 1)
	return ..()

/obj/projectile/psionic/pyro_fireball
	name = "psionic fireball"
	icon_state = "fireball"
	damage = 10
	damage_type = BURN
	range = 8
	color = COLOR_ORANGE
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1.8
	light_color = LIGHT_COLOR_ORANGE
	psionic_charge_cost = 2
	/// Heavy explosion range of the fireball.
	var/exp_heavy = 0
	/// Light explosion range of the fireball.
	var/exp_light = 2
	/// Fire radius of the fireball.
	var/exp_fire = 2
	/// Flash radius of the fireball.
	var/exp_flash = 3

/obj/projectile/psionic/pyro_fireball/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.take_overall_damage(burn = 10)

	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		return

	explosion(
		target_turf,
		devastation_range = -1,
		heavy_impact_range = exp_heavy,
		light_impact_range = exp_light,
		flame_range = exp_fire,
		flash_range = exp_flash,
		adminlog = FALSE,
		explosion_cause = src,
	)
