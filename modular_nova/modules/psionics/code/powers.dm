/datum/psionic_school
	/// Display name for this school.
	var/name = "Unaligned"
	/// Short description of the school's psionic expression.
	var/desc = "Psionic expression without a known anomaly signature."
	/// Primary anomaly type this school resonates with.
	var/obj/effect/anomaly/anomaly_path
	/// Primary anomaly core type this school resonates with.
	var/obj/item/assembly/signaler/anomaly/anomaly_core_path
	/// Additional anomaly variants that should be treated as the same school.
	var/list/related_anomaly_paths
	/// Additional anomaly core variants that should be treated as the same school.
	var/list/related_anomaly_core_paths

/datum/psionic_school/New()
	. = ..()
	if(!length(related_anomaly_paths) && anomaly_path)
		related_anomaly_paths = list(anomaly_path)
	if(!length(related_anomaly_core_paths) && anomaly_core_path)
		related_anomaly_core_paths = list(anomaly_core_path)

/datum/psionic_school/bioscrambler
	name = "Bioscrambler"
	desc = "Neural, somatic, and identity resonance."
	anomaly_path = /obj/effect/anomaly/bioscrambler
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/bioscrambler

/datum/psionic_school/gravity
	name = "Gravity"
	desc = "Mass, inertia, and kinetic pressure."
	anomaly_path = /obj/effect/anomaly/grav
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/grav
	related_anomaly_paths = list(/obj/effect/anomaly/grav, /obj/effect/anomaly/grav/high)

/datum/psionic_school/bluespace
	name = "Bluespace"
	desc = "Distance, folds, and spatial discontinuity."
	anomaly_path = /obj/effect/anomaly/bluespace
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/bluespace

/datum/psionic_school/flux
	name = "Flux"
	desc = "Interference, disruption, and reactive static."
	anomaly_path = /obj/effect/anomaly/flux
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/flux

/proc/get_psionic_school_catalog()
	var/static/list/catalog
	if(catalog)
		return catalog

	catalog = list()
	for(var/school_type in subtypesof(/datum/psionic_school))
		catalog[school_type] = new school_type

	return catalog

/proc/get_psionic_school(school_type)
	if(!ispath(school_type, /datum/psionic_school))
		return null

	return get_psionic_school_catalog()[school_type]

/proc/get_psionic_school_for_anomaly(anomaly_type)
	if(!ispath(anomaly_type, /obj/effect/anomaly))
		return null

	var/list/catalog = get_psionic_school_catalog()
	for(var/school_type in catalog)
		var/datum/psionic_school/school = catalog[school_type]
		for(var/related_anomaly_path in school.related_anomaly_paths)
			if(ispath(anomaly_type, related_anomaly_path))
				return school

	return null

/proc/get_psionic_school_for_anomaly_core(anomaly_core_type)
	if(!ispath(anomaly_core_type, /obj/item/assembly/signaler/anomaly))
		return null

	var/list/catalog = get_psionic_school_catalog()
	for(var/school_type in catalog)
		var/datum/psionic_school/school = catalog[school_type]
		for(var/related_anomaly_core_path in school.related_anomaly_core_paths)
			if(ispath(anomaly_core_type, related_anomaly_core_path))
				return school

	return null

/proc/get_psionic_school_for_anomaly_source(anomaly_source_type)
	var/datum/psionic_school/school = get_psionic_school_for_anomaly(anomaly_source_type)
	if(school)
		return school

	return get_psionic_school_for_anomaly_core(anomaly_source_type)

/datum/psionic_power
	/// Display name in the imprinting menu.
	var/name = "Psionic Power"
	/// Short description in the imprinting menu.
	var/desc = "A psionic discipline."
	/// Imprint point cost.
	var/cost = 1
	/// Anomaly resonance school this power belongs to.
	var/datum/psionic_school/school
	/// Action type granted when learned.
	var/datum/action/cooldown/psionic/action_type

/datum/psionic_power/proc/get_school()
	if(!school)
		return null

	return get_psionic_school(school)

/datum/psionic_power/proc/get_school_name()
	var/datum/psionic_school/resonance_school = get_school()
	if(!resonance_school)
		return "Unaligned"

	return resonance_school.name

/proc/get_psionic_power_catalog()
	var/static/list/catalog
	if(catalog)
		return catalog

	catalog = list()
	for(var/power_type in subtypesof(/datum/psionic_power))
		var/datum/psionic_power/power = new power_type
		if(!power.action_type)
			qdel(power)
			continue
		catalog += power

	return catalog

/proc/get_psionic_power_for_action(action_type)
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return null

	for(var/datum/psionic_power/power as anything in get_psionic_power_catalog())
		if(power.action_type == action_type)
			return power

	return null

/datum/psionic_power/telepathy
	name = "Telepathic Whisper"
	desc = "Send a private thought to a nearby living target."
	cost = 1
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	action_type = /datum/action/cooldown/psionic/pointed/telepathy

/datum/psionic_power/kinetic_shove
	name = "Kinetic Shove"
	desc = "Throw a nearby target away with focused force."
	cost = 1
	school = PSIONIC_SCHOOL_GRAVITY
	action_type = /datum/action/cooldown/psionic/pointed/kinetic_shove

/datum/psionic_power/spatial_slip
	name = "Spatial Slip"
	desc = "Blink a short distance through a bluespace fold."
	cost = 1
	school = PSIONIC_SCHOOL_BLUESPACE
	action_type = /datum/action/cooldown/psionic/spatial_slip

/datum/psionic_power/psychic_guard
	name = "Psychic Guard"
	desc = "Briefly shield yourself from intrusive and sensory psionics."
	cost = 1
	school = PSIONIC_SCHOOL_FLUX
	action_type = /datum/action/cooldown/psionic/psychic_guard

/datum/action/cooldown/psionic/pointed/telepathy
	name = "Telepathic Whisper"
	desc = "<b>Left click</b>: project a thought to a target. <b>Right click</b>: project to your last target."
	button_icon_state = "r_transmit"
	cooldown_time = 3 SECONDS
	cast_range = 7
	point_cost = 1
	strain_gain = 5
	psionic_flags = PSIONIC_INTRUSIVE
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	/// Last living target contacted by this action.
	var/datum/weakref/last_target_ref
	/// Message being projected for this activation.
	var/message

/datum/action/cooldown/psionic/pointed/telepathy/Trigger(mob/clicker, trigger_flags, atom/target)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		if(!IsAvailable(feedback = TRUE))
			return FALSE

		var/mob/living/last_target = last_target_ref?.resolve()
		if(!last_target)
			last_target_ref = null
			owner.balloon_alert(owner, "no last target!")
			return FALSE
		return PreActivate(last_target)

	return ..()

/datum/action/cooldown/psionic/pointed/telepathy/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(target))
		to_chat(owner, span_warning("There are no thoughts there to reach."))
		owner.balloon_alert(owner, "no thoughts!")
		return FALSE

	var/mob/living/living_target = target
	if(living_target.stat == DEAD)
		owner.balloon_alert(owner, "no living mind!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/telepathy/before_psionic(atom/target)
	message = tgui_input_text(owner, "What do you wish to whisper to [target]?", "[src]", max_length = MAX_MESSAGE_LEN, multiline = TRUE)
	if(QDELETED(src) || QDELETED(owner) || QDELETED(target) || !message)
		return FALSE

	message = autopunct_bare(capitalize(message))
	if(!length(message))
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/telepathy/psionic_activate(atom/target)
	var/mob/living/living_target = target
	return send_thought(owner, living_target, message)

/datum/action/cooldown/psionic/pointed/telepathy/proc/send_thought(mob/living/caster, mob/living/target, thought)
	if(target.can_block_psionics(PSIONIC_INTRUSIVE, charge_cost = 1))
		caster.balloon_alert(caster, "thought blocked!")
		to_chat(caster, span_warning("Your thought meets a hard, silent wall."))
		return FALSE

	log_directed_talk(caster, target, thought, LOG_SAY, tag = "psionic whisper")
	last_target_ref = WEAKREF(target)

	to_chat(caster, span_boldnotice("You impress a thought on [target]: \"[span_purple(thought)]\""))
	to_chat(target, span_boldnotice("A thought presses into your mind: \"[span_purple(thought)]\""))

	if(caster.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
		caster.create_chat_message(caster, caster.get_selected_language(), thought, list("italics"))
	if(target.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
		target.create_chat_message(target, target.get_selected_language(), thought, list("italics"))

	for(var/mob/dead/ghost as anything in GLOB.dead_mob_list)
		if(!isobserver(ghost))
			continue

		var/from_link = FOLLOW_LINK(ghost, caster)
		var/to_link = FOLLOW_LINK(ghost, target)
		to_chat(ghost, "[from_link] [span_purple("<b>\[Psionics\]</b> [caster] impresses, \"[thought]\" on [target]")] [to_link]")

	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove
	name = "Kinetic Shove"
	desc = "Throw a nearby target away with focused psionic force."
	button_icon_state = "repulse"
	cooldown_time = 12 SECONDS
	cast_range = 5
	point_cost = 1
	strain_gain = 18
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY

/datum/action/cooldown/psionic/pointed/kinetic_shove/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!ismovable(target))
		owner.balloon_alert(owner, "not movable!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove/psionic_activate(atom/target)
	var/atom/movable/movable_target = target
	var/mob/living/living_target = movable_target
	if(istype(living_target) && living_target.can_block_psionics(PSIONIC_KINETIC, charge_cost = 1))
		owner.balloon_alert(owner, "force dampened!")
		to_chat(owner, span_warning("Your force breaks against [living_target]'s psionic dampening."))
		return FALSE

	var/throw_direction = get_dir(owner, get_step_away(movable_target, owner))
	if(!throw_direction)
		throw_direction = get_dir(owner, movable_target)

	var/turf/throw_target = get_ranged_target_turf(movable_target, throw_direction, 3)
	if(!throw_target)
		return FALSE

	owner.visible_message(
		span_warning("[movable_target] lurches away from [owner] under invisible force."),
		span_notice("You shove [movable_target] with focused force."),
		ignored_mobs = movable_target,
	)
	if(istype(living_target))
		to_chat(living_target, span_userdanger("Invisible force slams into you!"))
		living_target.apply_damage(20, STAMINA)
		living_target.Knockdown(1 SECONDS)

	movable_target.safe_throw_at(throw_target, range = 3, speed = 1, thrower = owner, gentle = TRUE)
	return TRUE

/datum/action/cooldown/psionic/spatial_slip
	name = "Spatial Slip"
	desc = "Blink a short distance through a bluespace fold."
	button_icon_state = "spell_default"
	cooldown_time = 15 SECONDS
	point_cost = 1
	strain_gain = 20
	psionic_flags = PSIONIC_SPATIAL
	school = PSIONIC_SCHOOL_BLUESPACE
	/// Maximum inaccuracy range for the bluespace slip.
	var/slip_range = 4

/datum/action/cooldown/psionic/spatial_slip/psionic_activate(atom/target)
	var/turf/current_turf = get_turf(owner)
	if(!current_turf)
		return FALSE

	if(!do_teleport(owner, current_turf, slip_range, channel = TELEPORT_CHANNEL_BLUESPACE))
		owner.balloon_alert(owner, "fold fails!")
		return FALSE

	to_chat(owner, span_purple("You slip through a brief bluespace fold."))
	return TRUE

/datum/action/cooldown/psionic/psychic_guard
	name = "Psychic Guard"
	desc = "Briefly shield yourself from intrusive and sensory psionics."
	button_icon_state = "shield"
	cooldown_time = 30 SECONDS
	point_cost = 1
	strain_gain = 15
	psionic_flags = PSIONIC_PROTECTIVE
	school = PSIONIC_SCHOOL_FLUX
	/// Guard duration.
	var/guard_duration = 10 SECONDS
	/// Charges granted to the guard.
	var/guard_charges = 2

/datum/action/cooldown/psionic/psychic_guard/psionic_activate(atom/target)
	var/datum/callback/block_callback = CALLBACK(src, PROC_REF(on_guard_block))
	var/datum/component/anti_psionic/shield = owner.AddComponent(/datum/component/anti_psionic, PSIONIC_INTRUSIVE|PSIONIC_SENSORY, guard_charges, ALL, block_callback)
	addtimer(CALLBACK(src, PROC_REF(clear_guard), WEAKREF(shield)), guard_duration)
	to_chat(owner, span_purple("You draw a quiet guard around your thoughts."))
	return TRUE

/datum/action/cooldown/psionic/psychic_guard/proc/on_guard_block(mob/living/source, atom/movable/blocker)
	to_chat(source, span_notice("Your psychic guard catches the intrusion and collapses part of its pattern."))

/datum/action/cooldown/psionic/psychic_guard/proc/clear_guard(datum/weakref/shield_ref)
	var/datum/component/anti_psionic/shield = shield_ref?.resolve()
	if(shield)
		qdel(shield)
