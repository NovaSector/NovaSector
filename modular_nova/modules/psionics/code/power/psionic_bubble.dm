/datum/psionic_power/psionic_bubble
	required_school_points = 1
	required_powers = list(/datum/action/cooldown/psionic/pointed/sense_health)
	action_type = /datum/action/cooldown/psionic/pointed/living_target/psionic_bubble

/datum/psionic_rank_variant/psionic_bubble
	rank = PSIONIC_RANK_GAMMA
	variant_name = "environmental sheath"
	description = "A protective field against vacuum, cold, and suffocation."
	cooldown_time = 30 SECONDS
	cast_range = 5
	strain_gain = 12
	block_charge_cost = 0

/datum/action/cooldown/psionic/pointed/living_target/psionic_bubble
	name = "Psionic Bubble"
	desc = "Wrap a living target in a short-lived environmental sheath."
	button_icon_state = "psi_psionic_bubble"
	allow_self_target = TRUE
	point_cost = 1
	psionic_flags = PSIONIC_PROTECTIVE
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	rank_variant_types = list(/datum/psionic_rank_variant/psionic_bubble)
	active_msg = "You shape an environmental sheath..."
	deactive_msg = "You let the environmental sheath collapse."

/datum/action/cooldown/psionic/pointed/living_target/psionic_bubble/psionic_activate(atom/target)
	var/mob/living/living_target = target
	living_target.apply_status_effect(/datum/status_effect/psionic_bubble, 30 SECONDS)
	to_chat(owner, span_purple("You wrap [living_target] in a psionic bubble."))
	to_chat(living_target, span_notice("A psionic bubble closes around you."))
	return TRUE

/datum/status_effect/psionic_bubble
	id = "psionic_bubble"
	duration = 30 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/psionic_bubble
	var/mutable_appearance/bubble_overlay

/datum/status_effect/psionic_bubble/on_creation(mob/living/new_owner, set_duration)
	if(isnum(set_duration))
		duration = set_duration
	return ..()

/datum/status_effect/psionic_bubble/on_apply()
	. = ..()
	bubble_overlay = mutable_appearance('icons/effects/effects.dmi', "shield-greyscale")
	bubble_overlay.alpha = 180
	bubble_overlay.transform = matrix().Scale(1.35)
	owner.add_overlay(bubble_overlay)
	owner.add_traits(list(TRAIT_OXYIMMUNE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), PSIONIC_TRAIT_SOURCE)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/psionic_bubble)
	RegisterSignal(owner, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/status_effect/psionic_bubble/on_remove()
	UnregisterSignal(owner, COMSIG_ATOM_EXAMINE)
	owner.cut_overlay(bubble_overlay)
	owner.remove_traits(list(TRAIT_OXYIMMUNE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), PSIONIC_TRAIT_SOURCE)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/psionic_bubble)
	bubble_overlay = null
	return ..()

/datum/status_effect/psionic_bubble/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_purple("[owner.p_They(TRUE)] [owner.p_are()] surrounded by a faint psionic bubble.")

/atom/movable/screen/alert/status_effect/psionic_bubble
	name = "Psionic Bubble"
	desc = "A psionic field is helping you survive hostile atmospheres."
	icon_state = "slime_rainbowshield"

/datum/movespeed_modifier/psionic_bubble
	multiplicative_slowdown = 0.25
