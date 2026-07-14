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
	maintain_end_message = "Your psionic light fades."
	rank_variant_types = list(/datum/psionic_rank_variant/lumen)
	/// Visible psionic light orbiting the psion.
	var/obj/effect/psionic_lumen/light_visual

/datum/action/cooldown/psionic/lumen/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner) || !isturf(living_owner.loc))
		return FALSE

	light_visual = new /obj/effect/psionic_lumen(get_turf(living_owner))
	light_visual.set_light_color(get_manifestation_color())
	light_visual.add_atom_colour(color_transition_filter(get_manifestation_color(), SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	light_visual.orbit(living_owner, 18, rotation_speed = 45)
	start_maintaining(living_owner)

	living_owner.visible_message(
		span_notice("A small mote of light takes shape beside [living_owner]."),
		span_purple("You shape a small mote of psionic light."),
	)
	return TRUE

/datum/action/cooldown/psionic/lumen/on_maintain_stopped(mob/living/living_owner, silent = FALSE)
	QDEL_NULL(light_visual)

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
