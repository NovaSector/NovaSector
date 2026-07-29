/datum/psionic_power/exchange
	required_school_points = 1
	required_powers = list(/datum/action/cooldown/psionic/spatial_slip)
	action_type = /datum/action/cooldown/psionic/pointed/living_target/exchange

/datum/psionic_rank_variant/exchange
	rank = PSIONIC_RANK_GAMMA
	variant_name = "exchange"
	description = "Swap places with one visible living target through a bluespace fold."
	strain_gain = 25
	cooldown_time = 30 SECONDS
	cast_range = 6
	block_charge_cost = 2
	block_message = "fold resisted!"

/datum/action/cooldown/psionic/pointed/living_target/exchange
	name = "Exchange"
	desc = "Fold space between yourself and a nearby living target, swapping your positions."
	button_icon_state = "psi_exchange"
	point_cost = 2
	psionic_flags = PSIONIC_SPATIAL
	school = PSIONIC_SCHOOL_BLUESPACE
	active_msg = "You mirror your position against a target..."
	deactive_msg = "You let the mirrored fold collapse."
	rank_variant_types = list(/datum/psionic_rank_variant/exchange)

/datum/action/cooldown/psionic/pointed/living_target/exchange/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/living_target = target
	if(living_target.buckled)
		owner.balloon_alert(owner, "buckled down!")
		return FALSE
	if(living_target.anchored || living_target.move_resist >= MOVE_FORCE_STRONG)
		owner.balloon_alert(owner, "too heavy!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/exchange/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/mob/living/living_target = target
	var/turf/source_turf = get_turf(living_owner)
	var/turf/target_turf = get_turf(living_target)
	if(!istype(living_owner) || !istype(living_target) || !source_turf || !target_turf)
		return FALSE

	if(!do_teleport(living_owner, target_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE))
		living_owner.balloon_alert(living_owner, "fold fails!")
		return FALSE

	// The caster has already crossed, so a target-side failure leaves a one-way blink rather than a swap.
	do_teleport(living_target, source_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
	show_exchange_effects(source_turf, target_turf, get_manifestation_color())
	living_owner.changeNext_move(CLICK_CD_MELEE)
	living_target.changeNext_move(CLICK_CD_MELEE)
	living_owner.visible_message(
		span_warning("[living_owner] and [living_target] fold through space, trading places."),
		span_purple("You fold space and trade places with [living_target]."),
		ignored_mobs = living_target,
	)
	to_chat(living_target, span_userdanger("Space folds around you, wrenching you somewhere else!"))
	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/exchange/proc/show_exchange_effects(turf/source_turf, turf/target_turf, manifestation_color)
	playsound(source_turf, 'sound/effects/magic/wand_teleport.ogg', 60, TRUE)
	playsound(target_turf, 'sound/effects/magic/wand_teleport.ogg', 60, TRUE)
	var/obj/effect/temp_visual/psionic/spatial_slip/source_effect = new(source_turf, manifestation_color)
	var/obj/effect/temp_visual/psionic/spatial_slip/target_effect = new(target_turf, manifestation_color)
	source_effect.Beam(
		target_effect,
		icon_state = "greyscale_lightning",
		beam_color = manifestation_color,
		time = 0.5 SECONDS,
		maxdistance = get_dist(source_turf, target_turf) + 1,
	)
