#define PSIONIC_SUNDER_DURATION (30 SECONDS)

/datum/psionic_power/sunder
	required_school_points = 3
	required_powers = list(/datum/action/cooldown/psionic/pointed/warp)
	action_type = /datum/action/cooldown/psionic/pointed/living_target/sunder

/datum/psionic_rank_variant/sunder
	rank = PSIONIC_RANK_BETA
	variant_name = "sunder"
	description = "A close-range rupture that temporarily dampens a lower-ranked psion."
	strain_gain = 35
	cooldown_time = 60 SECONDS
	cast_range = 1
	block_charge_cost = 3
	block_message = "connection guarded!"
	/// Time spent focusing on the target before the rupture resolves.
	var/sunder_time = 5 SECONDS
	/// How long the target remains dampened.
	var/sunder_duration = PSIONIC_SUNDER_DURATION

/datum/action/cooldown/psionic/pointed/living_target/sunder
	name = "Psionic Sunder"
	desc = "Rupture a weaker psion's connection and temporarily suppress their abilities."
	button_icon_state = "psi_sunder"
	point_cost = 2
	psionic_flags = PSIONIC_INTRUSIVE|PSIONIC_SPATIAL
	school = PSIONIC_SCHOOL_BLUESPACE
	active_msg = "You search for a nearby psionic connection to sunder..."
	deactive_msg = "You let the rupture pattern fade."
	no_living_target_alert = "no living psion!"
	dead_target_alert = "mind silent!"
	rank_variant_types = list(/datum/psionic_rank_variant/sunder)


/datum/action/cooldown/psionic/pointed/living_target/sunder/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/living_owner = owner
	var/mob/living/living_target = target
	var/datum/psionic_rank_variant/sunder/form = get_selected_variant_as_type(/datum/psionic_rank_variant/sunder)
	return can_sunder_target(living_owner, living_target, form, TRUE)

/datum/action/cooldown/psionic/pointed/living_target/sunder/proc/can_sunder_target(mob/living/living_owner, mob/living/living_target, datum/psionic_rank_variant/sunder/form, feedback = FALSE)
	if(!istype(living_owner) || !istype(living_target) || !form)
		return FALSE

	var/datum/component/psionic_profile/source_profile = living_owner.get_psionic_profile()
	var/datum/component/psionic_profile/target_profile = living_target.get_psionic_profile()
	if(!source_profile)
		return FALSE
	if(!target_profile)
		if(feedback)
			living_owner.balloon_alert(living_owner, "no psionic signature!")
		return FALSE
	if(HAS_TRAIT(living_target, TRAIT_PSIONIC_DAMPENER))
		if(feedback)
			living_owner.balloon_alert(living_owner, "already dampened!")
		return FALSE
	if(get_psionic_rank_level(target_profile.psionic_rank) >= get_psionic_rank_level(source_profile.psionic_rank))
		if(feedback)
			living_owner.balloon_alert(living_owner, "connection too strong!")
		return FALSE

	var/turf/source_turf = get_turf(living_owner)
	var/turf/target_turf = get_turf(living_target)
	if(!source_turf || !target_turf || source_turf.z != target_turf.z || get_dist(source_turf, target_turf) > form.get_cast_range(src))
		if(feedback)
			living_owner.balloon_alert(living_owner, "too far away!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/sunder/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/mob/living/living_target = target
	var/datum/psionic_rank_variant/sunder/form = get_selected_variant_as_type(/datum/psionic_rank_variant/sunder)
	if(!can_sunder_target(living_owner, living_target, form, TRUE))
		return FALSE

	living_owner.visible_message(
		span_warning("[living_owner] presses a fraying psionic pattern toward [living_target]."),
		span_purple("You hook into [living_target]'s psionic connection and begin to tear."),
		ignored_mobs = living_target,
	)
	to_chat(living_target, span_userdanger("A cold pressure hooks into your psionic focus!"))
	if(!do_after(living_owner, form.sunder_time, target = living_target, timed_action_flags = IGNORE_HELD_ITEM))
		living_owner.balloon_alert(living_owner, "focus broken!")
		return FALSE
	if(!can_sunder_target(living_owner, living_target, form, TRUE))
		return FALSE

	living_target.apply_status_effect(/datum/status_effect/psionic_sundered, form.sunder_duration)
	var/turf/target_turf = get_turf(living_target)
	living_owner.visible_message(
		span_danger("[living_target]'s psionic focus collapses into static."),
		span_purple("You sunder [living_target]'s psionic connection."),
		ignored_mobs = living_target,
	)
	to_chat(living_target, span_userdanger("Your psionic focus collapses into static!"))
	new /obj/effect/temp_visual/psionic_sunder(target_turf, get_manifestation_color())
	playsound(target_turf, 'sound/effects/magic/magic_block_mind.ogg', 70, TRUE)
	return TRUE

/datum/status_effect/psionic_sundered
	id = "psionic_sundered"
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null
	remove_on_fullheal = TRUE

/datum/status_effect/psionic_sundered/on_creation(mob/living/new_owner, duration = PSIONIC_SUNDER_DURATION)
	src.duration = duration
	return ..()

/datum/status_effect/psionic_sundered/refresh(effect, duration = PSIONIC_SUNDER_DURATION)
	src.duration = max(src.duration, duration)
	update_shown_duration()

/datum/status_effect/psionic_sundered/on_apply()
	ADD_TRAIT(owner, TRAIT_PSIONIC_DAMPENER, TRAIT_STATUS_EFFECT(id))
	return TRUE

/datum/status_effect/psionic_sundered/on_remove()
	REMOVE_TRAIT(owner, TRAIT_PSIONIC_DAMPENER, TRAIT_STATUS_EFFECT(id))
	to_chat(owner, span_notice("Your psionic focus knits back together."))

/datum/status_effect/psionic_sundered/get_examine_text()
	return span_warning("[owner.p_Their()] psionic focus looks frayed.")

/obj/effect/temp_visual/psionic_sunder
	name = "psionic rupture"
	icon_state = "purplecrack"
	duration = 1.5 SECONDS
	alpha = 210
	randomdir = TRUE

/obj/effect/temp_visual/psionic_sunder/Initialize(mapload, manifestation_color)
	. = ..()
	if(!manifestation_color)
		manifestation_color = PSIONIC_DEFAULT_COLOR
	add_atom_colour(color_transition_filter(manifestation_color, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	set_light(1.5, 0.8, manifestation_color)
	add_filter("psionic_sunder_static", 1, list("type" = "ripple", "flags" = WAVE_BOUNDED, "radius" = 0, "size" = 2))
	var/filter = get_filter("psionic_sunder_static")
	animate(filter, radius = 18, size = 0.5, time = duration)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)

#undef PSIONIC_SUNDER_DURATION
