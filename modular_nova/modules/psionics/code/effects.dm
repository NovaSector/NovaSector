/// Shared base for short-lived psionic manifestations. Tints itself to the caster's
/// manifestation color, lights to match, and fades out over its own duration.
/obj/effect/temp_visual/psionic
	/// Light radius cast while visible. 0 casts no light.
	var/psionic_light_range = 0
	/// Light intensity cast while visible.
	var/psionic_light_power = 0.7

/obj/effect/temp_visual/psionic/Initialize(mapload, manifestation_color)
	. = ..()
	apply_psionic_manifestation(manifestation_color)

/obj/effect/temp_visual/psionic/proc/apply_psionic_manifestation(manifestation_color)
	if(!manifestation_color)
		manifestation_color = PSIONIC_DEFAULT_COLOR

	add_atom_colour(color_transition_filter(manifestation_color, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	if(psionic_light_range > 0)
		set_light(psionic_light_range, psionic_light_power, manifestation_color)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)

/// As above, for effects that need /dir_setting's directional New() signature.
/obj/effect/temp_visual/dir_setting/psionic
	var/psionic_light_range = 0
	var/psionic_light_power = 0.7

/obj/effect/temp_visual/dir_setting/psionic/Initialize(mapload, set_dir, manifestation_color)
	. = ..()
	if(!manifestation_color)
		manifestation_color = PSIONIC_DEFAULT_COLOR

	add_atom_colour(color_transition_filter(manifestation_color, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	if(psionic_light_range > 0)
		set_light(psionic_light_range, psionic_light_power, manifestation_color)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)
