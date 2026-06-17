/datum/psionic_power/spatial_slip
	action_type = /datum/action/cooldown/psionic/spatial_slip

/datum/action/cooldown/psionic/spatial_slip
	name = "Spatial Slip"
	desc = "Blink a short distance through a bluespace fold."
	button_icon_state = "psi_spatial_slip"
	cooldown_time = 15 SECONDS
	point_cost = 1
	strain_gain = 20
	psionic_flags = PSIONIC_SPATIAL
	school = PSIONIC_SCHOOL_BLUESPACE
	/// Maximum inaccuracy range for the bluespace slip.
	var/slip_range = 4

/datum/action/cooldown/psionic/spatial_slip/psionic_activate(atom/target)
	var/turf/source_turf = get_turf(owner)
	if(!source_turf)
		return FALSE

	var/manifestation_color = get_manifestation_color()
	if(!do_teleport(owner, source_turf, slip_range, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE))
		owner.balloon_alert(owner, "fold fails!")
		return FALSE

	show_spatial_slip_effects(source_turf, get_turf(owner), manifestation_color)
	to_chat(owner, span_purple("You slip through a brief bluespace fold."))
	return TRUE

/datum/action/cooldown/psionic/spatial_slip/proc/show_spatial_slip_effects(turf/source_turf, turf/target_turf, manifestation_color)
	if(!source_turf || !target_turf)
		return

	playsound(source_turf, 'sound/machines/airlock/airlockopen.ogg', 60, TRUE)
	playsound(target_turf, 'sound/effects/magic/wand_teleport.ogg', 60, TRUE)

	var/obj/effect/temp_visual/psionic_spatial_slip/source_effect = new(source_turf, manifestation_color)
	if(source_turf == target_turf)
		return

	var/obj/effect/temp_visual/psionic_spatial_slip/target_effect = new(target_turf, manifestation_color)
	var/beam_center_x = ICON_SIZE_X / 2
	var/beam_center_y = ICON_SIZE_Y / 2
	source_effect.Beam(
		target_effect,
		icon_state = "greyscale_lightning",
		beam_color = manifestation_color,
		time = 0.5 SECONDS,
		maxdistance = get_dist(source_turf, target_turf) + 1,
		override_origin_pixel_x = beam_center_x - source_effect.pixel_w,
		override_origin_pixel_y = beam_center_y - source_effect.pixel_z,
		override_target_pixel_x = beam_center_x - target_effect.pixel_w,
		override_target_pixel_y = beam_center_y - target_effect.pixel_z,
	)

/obj/effect/temp_visual/psionic_spatial_slip
	name = "psionic fold"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "hierophant_telegraph_edge"
	SET_BASE_VISUAL_PIXEL(-32, -32)
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	duration = 0.9 SECONDS
	alpha = 190
	randomdir = FALSE

/obj/effect/temp_visual/psionic_spatial_slip/Initialize(mapload, manifestation_color)
	. = ..()
	if(!manifestation_color)
		manifestation_color = PSIONIC_DEFAULT_COLOR

	var/icon/tinted_icon = icon(icon, icon_state)
	tinted_icon.ColorTone(manifestation_color)
	tinted_icon.Insert(tinted_icon, icon_state = icon_state)
	icon = tinted_icon

	set_light(2, 0.7, manifestation_color)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)
