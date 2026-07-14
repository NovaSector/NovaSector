/datum/psionic_power/riftwalk
	required_school_points = 1
	required_powers = list(/datum/action/cooldown/psionic/spatial_slip)
	action_type = /datum/action/cooldown/psionic/pointed/riftwalk

/datum/psionic_rank_variant/riftwalk
	rank = PSIONIC_RANK_GAMMA
	variant_name = "riftwalk"
	description = "A long bluespace step that leaves a pair of linked rifts."
	strain_gain = 32
	cooldown_time = 35 SECONDS
	cast_range = 12
	block_charge_cost = 0

/datum/action/cooldown/psionic/pointed/riftwalk
	name = "Riftwalk"
	desc = "Travel through a long bluespace fold, leaving a brief linked passage behind."
	button_icon_state = "psi_riftwalk"
	point_cost = 2
	psionic_flags = PSIONIC_SPATIAL
	school = PSIONIC_SCHOOL_BLUESPACE
	rank_variant_types = list(/datum/psionic_rank_variant/riftwalk)
	active_msg = "You trace a distant bluespace fold..."
	deactive_msg = "The distant fold collapses."

/datum/action/cooldown/psionic/pointed/riftwalk/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE

	var/turf/target_turf = get_turf(target)
	if(!target_turf || target_turf == get_turf(owner))
		owner.balloon_alert(owner, "pick another location!")
		return FALSE
	if(target_turf.is_blocked_turf(exclude_mobs = TRUE))
		owner.balloon_alert(owner, "destination blocked!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/riftwalk/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/turf/source_turf = get_turf(living_owner)
	var/turf/target_turf = get_turf(target)
	if(!source_turf || !target_turf)
		return FALSE

	if(!do_teleport(living_owner, target_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE))
		living_owner.balloon_alert(living_owner, "rift fails!")
		return FALSE

	show_riftwalk_effects(source_turf, get_turf(living_owner), get_manifestation_color())
	living_owner.visible_message(
		span_notice("[living_owner] vanishes through a psionic rift."),
		span_purple("You step through a long bluespace rift."),
	)
	return TRUE

/datum/action/cooldown/psionic/pointed/riftwalk/proc/show_riftwalk_effects(turf/source_turf, turf/target_turf, manifestation_color)
	if(!source_turf || !target_turf)
		return

	playsound(source_turf, 'sound/effects/magic/wand_teleport.ogg', 60, TRUE)
	playsound(target_turf, 'sound/effects/magic/wand_teleport.ogg', 60, TRUE)

	var/obj/effect/temp_visual/lesser_carp_rift/entrance/psionic/source_rift = new(source_turf, manifestation_color)
	var/obj/effect/temp_visual/lesser_carp_rift/entrance/psionic/target_rift = new(target_turf, manifestation_color)
	source_rift.link_to(target_rift)
	target_rift.link_to(source_rift)
	source_rift.Beam(
		target_rift,
		icon_state = "greyscale_lightning",
		beam_color = manifestation_color,
		time = 1 SECONDS,
		maxdistance = get_dist(source_turf, target_turf) + 1,
	)

/obj/effect/temp_visual/lesser_carp_rift/proc/apply_psionic_appearance(manifestation_color)
	if(!manifestation_color)
		manifestation_color = PSIONIC_DEFAULT_COLOR

	add_atom_colour(color_transition_filter(manifestation_color, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	set_light_color(manifestation_color)

/obj/effect/temp_visual/lesser_carp_rift/entrance/psionic
	name = "psionic rift"
	desc = "A short-lived rift in bluespace. It leads to another rift."
	duration = 10 SECONDS
	light_system = OVERLAY_LIGHT
	light_range = 1.5
	light_power = 0.8
	light_color = PSIONIC_DEFAULT_COLOR
	light_on = TRUE
	/// The rift at the other endpoint.
	var/datum/weakref/linked_rift
	/// REF strings of atoms that have just arrived and must not immediately return.
	var/list/recent_traveler_refs = list()

/obj/effect/temp_visual/lesser_carp_rift/entrance/psionic/Initialize(mapload, manifestation_color)
	. = ..()
	apply_psionic_appearance(manifestation_color)

/obj/effect/temp_visual/lesser_carp_rift/entrance/psionic/proc/link_to(obj/effect/temp_visual/lesser_carp_rift/entrance/psionic/new_linked_rift)
	if(!new_linked_rift)
		return

	linked_rift = WEAKREF(new_linked_rift)

/obj/effect/temp_visual/lesser_carp_rift/entrance/psionic/on_entered(datum/source, atom/movable/entered_atom)
	SIGNAL_HANDLER

	var/traveler_ref = REF(entered_atom)
	if(recent_traveler_refs[traveler_ref])
		return
	if(!ismob(entered_atom) && !isobj(entered_atom))
		return
	if(entered_atom.anchored || !entered_atom.loc || isobserver(entered_atom))
		return

	var/obj/effect/temp_visual/lesser_carp_rift/entrance/psionic/destination_rift = linked_rift?.resolve()
	if(QDELETED(destination_rift))
		return

	var/turf/destination_turf = get_turf(destination_rift)
	if(!destination_turf)
		return

	destination_rift.recent_traveler_refs[traveler_ref] = TRUE
	if(!do_teleport(entered_atom, destination_turf, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE))
		destination_rift.recent_traveler_refs -= traveler_ref
		return

	if(isliving(entered_atom))
		var/mob/living/living_traveler = entered_atom
		living_traveler.changeNext_move(disorient_time)
		living_traveler.ai_controller?.CancelActions()

	addtimer(CALLBACK(destination_rift, PROC_REF(clear_recent_traveler), traveler_ref), 0.5 SECONDS)
	playsound(src, 'sound/effects/magic/wand_teleport.ogg', 50)
	playsound(destination_turf, 'sound/effects/magic/wand_teleport.ogg', 50)

/obj/effect/temp_visual/lesser_carp_rift/entrance/psionic/proc/clear_recent_traveler(traveler_ref)
	recent_traveler_refs -= traveler_ref
