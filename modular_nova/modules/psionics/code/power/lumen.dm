/datum/psionic_power/lumen
	action_type = /datum/action/cooldown/psionic/lumen

/datum/psionic_rank_variant/lumen
	rank = PSIONIC_RANK_EPSILON
	variant_name = "lumen"
	description = "A small psionic light that orbits you."
	strain_gain = 2
	cooldown_time = 0
	block_charge_cost = 0

/datum/action/cooldown/psionic/lumen
	name = "Lumen"
	desc = "Toggle a small psionic light that follows beside you."
	button_icon_state = "psi_lumen"
	point_cost = 1
	psionic_flags = PSIONIC_SENSORY
	school = PSIONIC_SCHOOL_FLUX
	rank_variant_types = list(/datum/psionic_rank_variant/lumen)
	/// TRUE while the psion is maintaining their light.
	var/light_active = FALSE
	/// Visible psionic light orbiting the psion.
	var/obj/effect/psionic_lumen/light_visual

/datum/action/cooldown/psionic/lumen/Remove(mob/living/remove_from)
	if(remove_from)
		clear_light(remove_from, TRUE)
	return ..()

/datum/action/cooldown/psionic/lumen/IsAvailable(feedback = FALSE)
	if(is_light_active())
		return TRUE

	return ..()

/datum/action/cooldown/psionic/lumen/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return is_light_active()

/datum/action/cooldown/psionic/lumen/Activate(atom/target)
	var/mob/living/living_owner = owner
	if(is_light_active())
		return clear_light(living_owner)

	return ..()

/datum/action/cooldown/psionic/lumen/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner) || !isturf(living_owner.loc))
		return FALSE

	light_active = TRUE
	light_visual = new /obj/effect/psionic_lumen(get_turf(living_owner))
	light_visual.set_light_color(get_manifestation_color())
	light_visual.add_atom_colour(color_transition_filter(get_manifestation_color(), SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	light_visual.orbit(living_owner, 18, rotation_speed = 45)
	RegisterSignal(living_owner, COMSIG_LIVING_DEATH, PROC_REF(on_owner_death))
	RegisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_owner_life))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

	living_owner.visible_message(
		span_notice("A small mote of light takes shape beside [living_owner]."),
		span_purple("You shape a small mote of psionic light."),
	)
	return TRUE

/datum/action/cooldown/psionic/lumen/proc/is_light_active()
	return light_active && istype(owner, /mob/living)

/datum/action/cooldown/psionic/lumen/proc/on_owner_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	clear_light(living_owner, TRUE)

/datum/action/cooldown/psionic/lumen/proc/on_owner_life(datum/source, seconds_per_tick)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	if(!istype(living_owner) || living_owner.stat != CONSCIOUS || !living_owner.can_cast_psionics(psionic_flags))
		clear_light(living_owner, TRUE)

/datum/action/cooldown/psionic/lumen/proc/clear_light(mob/living/living_owner, silent = FALSE)
	if(!light_active)
		return FALSE

	light_active = FALSE
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_DEATH, COMSIG_LIVING_LIFE))
		if(!silent)
			to_chat(living_owner, span_notice("Your psionic light fades."))
	QDEL_NULL(light_visual)
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	return TRUE

/obj/effect/psionic_lumen
	name = "psionic light"
	desc = "A mote of softly glowing psionic energy."
	icon = 'modular_nova/modules/psionics/icons/psionic_lumen.dmi'
	icon_state = "lumen"
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	light_system = OVERLAY_LIGHT
	light_range = 5
	light_power = 1.5
	light_color = PSIONIC_DEFAULT_COLOR
	light_on = TRUE
