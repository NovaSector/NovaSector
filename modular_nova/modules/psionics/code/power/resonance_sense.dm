#define PSIONIC_RESONANCE_SENSE_RANGE 10
#define PSIONIC_RESONANCE_TRACE_RANGE 60
#define PSIONIC_RESONANCE_TRACE_ARROW "psionic_resonance_trace_arrow"
#define PSIONIC_RESONANCE_TRACE_ARROW_COLOR "#5bd6ff"

/datum/psionic_power/resonance_sense
	action_type = /datum/action/cooldown/psionic/resonance/sense

/datum/psionic_rank_variant/resonance_sense
	rank = PSIONIC_RANK_LAMBDA
	variant_name = "pulse"
	description = "A brief pulse for nearby active psionic signatures."
	strain_gain = 3
	cooldown_time = 15 SECONDS
	block_charge_cost = 0
	/// Maximum distance this form can sense.
	var/scan_range = PSIONIC_RESONANCE_SENSE_RANGE
	/// If TRUE, this form selects one signature and gives a directional trace.
	var/traces_signature = FALSE

/datum/psionic_rank_variant/resonance_sense/trace
	rank = PSIONIC_RANK_BETA
	variant_name = "trace"
	description = "A focused directional trace of one nearby psionic signature."
	strain_gain = 16
	cooldown_time = 45 SECONDS
	block_charge_cost = 0
	scan_range = PSIONIC_RESONANCE_TRACE_RANGE
	traces_signature = TRUE

/datum/action/cooldown/psionic/resonance
	psionic_flags = PSIONIC_SENSORY
	school = PSIONIC_SCHOOL_BIOSCRAMBLER

/datum/action/cooldown/psionic/resonance/proc/get_resonance_targets(mob/living/seeker, scan_range)
	var/list/resonance_targets = list()
	var/turf/seeker_turf = get_turf(seeker)
	if(!seeker_turf)
		return resonance_targets

	for(var/mob/living/possible_psion as anything in GLOB.alive_mob_list)
		if(!is_valid_resonance_target(seeker, possible_psion, scan_range))
			continue

		resonance_targets += possible_psion

	return resonance_targets

/datum/action/cooldown/psionic/resonance/proc/is_valid_resonance_target(mob/living/seeker, mob/living/possible_psion, scan_range)
	if(!istype(seeker) || !istype(possible_psion) || seeker == possible_psion)
		return FALSE
	if(possible_psion.stat == DEAD)
		return FALSE

	var/turf/seeker_turf = get_turf(seeker)
	var/turf/target_turf = get_turf(possible_psion)
	if(!seeker_turf || !target_turf || seeker_turf.z != target_turf.z)
		return FALSE
	if(get_dist(seeker_turf, target_turf) > scan_range)
		return FALSE

	var/datum/component/psionic_profile/profile = possible_psion.get_psionic_profile()
	if(!profile || profile.is_burned_out())
		return FALSE

	return possible_psion.can_cast_psionics(PSIONIC_SENSORY)

/datum/action/cooldown/psionic/resonance/proc/get_nearest_resonance_target(mob/living/seeker, list/resonance_targets)
	var/turf/seeker_turf = get_turf(seeker)
	if(!seeker_turf)
		return null

	var/mob/living/nearest_target
	var/nearest_distance = INFINITY
	for(var/mob/living/resonance_target as anything in resonance_targets)
		var/turf/target_turf = get_turf(resonance_target)
		if(!target_turf)
			continue

		var/target_distance = get_dist(seeker_turf, target_turf)
		if(target_distance >= nearest_distance)
			continue

		nearest_target = resonance_target
		nearest_distance = target_distance

	return nearest_target

/datum/action/cooldown/psionic/resonance/proc/get_resonance_targets_by_distance(mob/living/seeker, list/resonance_targets)
	var/list/remaining_targets = resonance_targets.Copy()
	var/list/sorted_targets = list()
	while(length(remaining_targets))
		var/mob/living/nearest_target = get_nearest_resonance_target(seeker, remaining_targets)
		if(!nearest_target)
			break

		sorted_targets += nearest_target
		remaining_targets -= nearest_target

	return sorted_targets

/datum/action/cooldown/psionic/resonance/proc/get_resonance_descriptor(mob/living/seeker, mob/living/resonance_target)
	var/turf/seeker_turf = get_turf(seeker)
	var/turf/target_turf = get_turf(resonance_target)
	if(!seeker_turf || !target_turf)
		return "somewhere unreachable"

	var/distance = get_dist(seeker_turf, target_turf)
	var/distance_text
	switch(distance)
		if(0 to 4)
			distance_text = "very near"
		if(5 to 10)
			distance_text = "near"
		if(11 to 25)
			distance_text = "distant"
		else
			distance_text = "far"

	var/direction = get_dir(seeker_turf, target_turf)
	if(!direction)
		return distance_text

	return "[distance_text], [dir2text(direction)]"

/datum/action/cooldown/psionic/resonance/proc/show_resonance_arrow(mob/living/seeker, mob/living/resonance_target)
	var/turf/target_turf = get_turf(resonance_target)
	if(!target_turf || !seeker.hud_used)
		return

	var/atom/movable/screen/navigate_arrow/arrow = seeker.hud_used.add_screen_object(
		/atom/movable/screen/navigate_arrow,
		PSIONIC_RESONANCE_TRACE_ARROW,
		HUD_GROUP_INFO,
		update_screen = TRUE,
	)
	arrow.start_effect(target_turf, PSIONIC_RESONANCE_TRACE_ARROW_COLOR)

/datum/action/cooldown/psionic/resonance/sense
	name = "Resonance Sense"
	desc = "Pulse your senses for nearby active psionic signatures."
	button_icon_state = "psi_resonance_sense"
	cooldown_time = 15 SECONDS
	point_cost = 0
	strain_gain = 3
	rank_variant_types = list(
		/datum/psionic_rank_variant/resonance_sense,
		/datum/psionic_rank_variant/resonance_sense/trace,
	)
	/// Target selected during before_psionic() for the trace form.
	var/datum/weakref/trace_target_ref


/datum/action/cooldown/psionic/resonance/sense/before_psionic(atom/target)
	trace_target_ref = null
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/datum/psionic_rank_variant/resonance_sense/form = get_selected_variant_as_type(/datum/psionic_rank_variant/resonance_sense)
	if(!form)
		return FALSE
	if(!form.traces_signature)
		return TRUE

	var/list/resonance_targets = get_resonance_targets_by_distance(
		living_owner,
		get_resonance_targets(living_owner, form.scan_range),
	)
	if(!length(resonance_targets))
		living_owner.balloon_alert(living_owner, "no signatures!")
		to_chat(living_owner, span_notice("No active psionic signatures answer your trace."))
		return FALSE

	var/list/signature_options = list()
	var/list/signature_targets_by_option = list()
	var/signature_index = 1
	for(var/mob/living/resonance_target as anything in resonance_targets)
		var/signature_option = "Signature [signature_index]: [get_resonance_descriptor(living_owner, resonance_target)]"
		signature_options += signature_option
		signature_targets_by_option[signature_option] = resonance_target
		signature_index++

	var/chosen_signature = tgui_input_list(living_owner, "Choose a psionic signature to trace.", name, signature_options)
	if(QDELETED(src) || QDELETED(living_owner) || !chosen_signature)
		return FALSE

	var/mob/living/chosen_target = signature_targets_by_option[chosen_signature]
	if(!is_valid_resonance_target(living_owner, chosen_target, form.scan_range))
		living_owner.balloon_alert(living_owner, "signal lost!")
		return FALSE

	trace_target_ref = WEAKREF(chosen_target)
	return TRUE

/datum/action/cooldown/psionic/resonance/sense/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/datum/psionic_rank_variant/resonance_sense/form = get_selected_variant_as_type(/datum/psionic_rank_variant/resonance_sense)
	if(!form)
		return FALSE
	if(form.traces_signature)
		return trace_resonance(living_owner, form)

	return pulse_resonance(living_owner, form)

/datum/action/cooldown/psionic/resonance/sense/proc/pulse_resonance(mob/living/living_owner, datum/psionic_rank_variant/resonance_sense/form)
	var/list/resonance_targets = get_resonance_targets(living_owner, form.scan_range)
	living_owner.playsound_local(get_turf(living_owner), 'sound/machines/sonar-ping.ogg', 25, TRUE)
	if(!length(resonance_targets))
		to_chat(living_owner, span_notice("You send out a quiet psionic pulse, but no nearby signatures answer."))
		return TRUE

	var/mob/living/nearest_target = get_nearest_resonance_target(living_owner, resonance_targets)
	var/signature_word = length(resonance_targets) == 1 ? "signature" : "signatures"
	to_chat(
		living_owner,
		span_purple("You sense [length(resonance_targets)] nearby psionic [signature_word]. The nearest is [get_resonance_descriptor(living_owner, nearest_target)]."),
	)
	return TRUE

/datum/action/cooldown/psionic/resonance/sense/proc/trace_resonance(mob/living/living_owner, datum/psionic_rank_variant/resonance_sense/form)
	var/mob/living/traced_target = trace_target_ref?.resolve()
	trace_target_ref = null
	if(!is_valid_resonance_target(living_owner, traced_target, form.scan_range))
		return FALSE

	living_owner.playsound_local(get_turf(living_owner), 'sound/machines/radar-ping.ogg', 35, TRUE)
	show_resonance_arrow(living_owner, traced_target)
	to_chat(
		living_owner,
		span_purple("You catch the psionic resonance [get_resonance_descriptor(living_owner, traced_target)]."),
	)
	return TRUE

#undef PSIONIC_RESONANCE_SENSE_RANGE
#undef PSIONIC_RESONANCE_TRACE_RANGE
#undef PSIONIC_RESONANCE_TRACE_ARROW
#undef PSIONIC_RESONANCE_TRACE_ARROW_COLOR
