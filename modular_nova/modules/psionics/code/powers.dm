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
	/// Stable TGUI key used for school-specific presentation.
	var/ui_key = "unaligned"
	/// Icon used for the imprinting branch display.
	var/ui_icon = "icons/effects/anomalies.dmi"
	/// Icon state used for the imprinting branch display.
	var/ui_icon_state = "vortex"
	/// Accent color used for the imprinting branch display.
	var/ui_color = "#8dd8ff"

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
	ui_key = "bioscrambler"
	ui_icon_state = "bioscrambler"
	ui_color = "#d86fff"

/datum/psionic_school/gravity
	name = "Gravity"
	desc = "Mass, inertia, and kinetic pressure."
	anomaly_path = /obj/effect/anomaly/grav
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/grav
	related_anomaly_paths = list(/obj/effect/anomaly/grav, /obj/effect/anomaly/grav/high)
	ui_key = "gravity"
	ui_icon = "icons/effects/effects.dmi"
	ui_icon_state = "shield2"
	ui_color = "#61d878"

/datum/psionic_school/bluespace
	name = "Bluespace"
	desc = "Distance, folds, and spatial discontinuity."
	anomaly_path = /obj/effect/anomaly/bluespace
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/bluespace
	ui_key = "bluespace"
	ui_icon = "icons/obj/weapons/guns/projectiles.dmi"
	ui_icon_state = "bluespace"
	ui_color = "#3fd6ff"

/datum/psionic_school/flux
	name = "Flux"
	desc = "Interference, disruption, and reactive static."
	anomaly_path = /obj/effect/anomaly/flux
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/flux
	ui_key = "flux"
	ui_icon_state = "flux"
	ui_color = "#ffe36b"

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
	/// Points that must already be spent in this power's school before it can be imprinted.
	var/required_school_points = 0
	/// Action type paths that must already be known before this power can be imprinted.
	var/list/required_powers
	/// Action type granted when learned.
	var/datum/action/cooldown/psionic/action_type

/datum/psionic_power/proc/get_name()
	if(!action_type)
		return "Psionic Power"

	return initial(action_type.name)

/datum/psionic_power/proc/get_desc()
	if(!action_type)
		return "A psionic discipline."

	return initial(action_type.desc)

/datum/psionic_power/proc/get_cost()
	if(!action_type)
		return 0

	return max(initial(action_type.point_cost), 0)

/datum/psionic_power/proc/get_school_type()
	if(!action_type)
		return null

	return initial(action_type.school)

/datum/psionic_power/proc/get_school()
	var/school_type = get_school_type()
	if(!school_type)
		return null

	return get_psionic_school(school_type)

/datum/psionic_power/proc/get_school_name()
	var/datum/psionic_school/resonance_school = get_school()
	if(!resonance_school)
		return "Unaligned"

	return resonance_school.name

/datum/psionic_power/proc/get_catalog_error()
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return "has no valid psionic action_type"
	if(get_cost() <= 0)
		return "has a non-positive action point_cost"
	if(!get_school_type())
		return "has no action school"
	if(!get_school())
		return "uses an unknown action school [get_school_type()]"
	if(length(required_powers))
		for(var/required_power_type in required_powers)
			if(!ispath(required_power_type, /datum/action/cooldown/psionic))
				return "has a non-psionic required power [required_power_type]"

	return null

/proc/get_psionic_power_catalog()
	var/static/list/catalog
	if(catalog)
		return catalog

	catalog = list()
	var/list/cataloged_actions = list()
	for(var/power_type in subtypesof(/datum/psionic_power))
		var/datum/psionic_power/power = new power_type
		var/catalog_error = power.get_catalog_error()
		if(catalog_error)
			stack_trace("[power.type] [catalog_error].")
			qdel(power)
			continue
		if(cataloged_actions[power.action_type])
			stack_trace("[power.type] duplicates psionic action [power.action_type].")
			qdel(power)
			continue
		cataloged_actions[power.action_type] = TRUE
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
	action_type = /datum/action/cooldown/psionic/pointed/telepathy

/datum/psionic_power/kinetic_shove
	action_type = /datum/action/cooldown/psionic/pointed/kinetic_shove

/datum/psionic_power/levitate
	action_type = /datum/action/cooldown/psionic/levitate

/datum/psionic_power/spatial_slip
	action_type = /datum/action/cooldown/psionic/spatial_slip

/datum/psionic_power/psychic_guard
	action_type = /datum/action/cooldown/psionic/psychic_guard

/datum/psionic_power/psiblade
	action_type = /datum/action/cooldown/psionic/psiblade

/datum/psionic_power/sense_health
	action_type = /datum/action/cooldown/psionic/pointed/sense_health

/datum/psionic_power/pyro_bolt
	action_type = /datum/action/cooldown/psionic/pointed/projectile/pyro_bolt

/datum/psionic_power/pyro_assault
	required_school_points = 1
	required_powers = list(/datum/action/cooldown/psionic/pointed/projectile/pyro_bolt)
	action_type = /datum/action/cooldown/psionic/pointed/projectile/pyro_assault

/datum/action/cooldown/psionic/pointed/telepathy
	name = "Telepathic Whisper"
	desc = "Send a private thought to a nearby living target. Right-click repeats your last target."
	button_icon_state = "psi_whisper"
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

/datum/action/cooldown/psionic/pointed/sense_health
	name = "Sense Health"
	desc = "Read a nearby living target's condition as an advanced health analyzer."
	button_icon_state = "psi_sense_health"
	cooldown_time = 8 SECONDS
	cast_range = 8
	point_cost = 1
	strain_gain = 7
	psionic_flags = PSIONIC_SENSORY
	school = PSIONIC_SCHOOL_BIOSCRAMBLER

/datum/action/cooldown/psionic/pointed/sense_health/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(target))
		owner.balloon_alert(owner, "no vitals!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/sense_health/psionic_activate(atom/target)
	var/mob/living/living_target = target
	if(living_target.can_block_psionics(PSIONIC_SENSORY, charge_cost = 1))
		owner.balloon_alert(owner, "sense blurred!")
		to_chat(owner, span_warning("[living_target]'s condition blurs behind psionic dampening."))
		return FALSE

	to_chat(owner, span_purple("You unfold [living_target]'s condition into a diagnostic impression."))
	healthscan(owner, living_target, mode = SCANNER_VERBOSE, advanced = TRUE)
	return TRUE

/datum/action/cooldown/psionic/pointed/kinetic_shove
	name = "Kinetic Shove"
	desc = "Throw a nearby target away with focused psionic force."
	button_icon_state = "psi_kinetic_shove"
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

/datum/action/cooldown/psionic/levitate
	name = "Levitate"
	desc = "Toggle a careful psionic weightlessness, building strain while maintained."
	button_icon_state = "psi_levitate"
	cooldown_time = 0
	point_cost = 1
	strain_gain = 0
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	/// TRUE while the psion is actively maintaining levitation.
	var/levitating = FALSE
	/// Strain gained per second while levitation is maintained, before normal strain decay.
	var/levitation_strain_per_second = 3
	/// Fractional strain waiting to be applied.
	var/levitation_strain_buffer = 0

/datum/action/cooldown/psionic/levitate/Remove(mob/living/remove_from)
	if(remove_from)
		clear_levitation(remove_from, TRUE)
	return ..()

/datum/action/cooldown/psionic/levitate/IsAvailable(feedback = FALSE)
	if(is_levitating())
		return TRUE

	return ..()

/datum/action/cooldown/psionic/levitate/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return is_levitating()

/datum/action/cooldown/psionic/levitate/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/living_owner = owner
	if(!istype(living_owner) || !isturf(living_owner.loc))
		return FALSE
	if(living_owner.buckled)
		living_owner.balloon_alert(living_owner, "buckled!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/levitate/Activate(atom/target)
	var/mob/living/living_owner = owner
	if(is_levitating())
		return clear_levitation(living_owner)

	return ..()

/datum/action/cooldown/psionic/levitate/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	levitating = TRUE
	levitation_strain_buffer = 0
	living_owner.AddElement(/datum/element/forced_gravity, gravity = 0, can_override = TRUE)
	ADD_TRAIT(living_owner, TRAIT_SILENT_FOOTSTEPS, PSIONIC_LEVITATION_TRAIT_SOURCE)
	living_owner.set_resting(FALSE, TRUE)
	RegisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_levitation_life))
	RegisterSignal(living_owner, COMSIG_LIVING_DEATH, PROC_REF(on_levitation_death))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

	living_owner.visible_message(
		span_notice("[living_owner] rises a handspan above the floor as the air warps around [living_owner.p_them()]."),
		span_purple("You bias gravity around yourself and lift into careful weightlessness."),
	)
	return TRUE

/datum/action/cooldown/psionic/levitate/proc/is_levitating()
	return levitating && istype(owner, /mob/living)

/datum/action/cooldown/psionic/levitate/proc/can_maintain_levitation(mob/living/living_owner, datum/component/psionic_profile/profile)
	if(action_disabled || !istype(living_owner) || !profile)
		return FALSE
	if(living_owner.stat != CONSCIOUS)
		return FALSE
	if(HAS_TRAIT(living_owner, TRAIT_INCAPACITATED) || living_owner.buckled)
		return FALSE
	if(!isturf(living_owner.loc))
		return FALSE
	if(profile.is_burned_out())
		return FALSE

	return living_owner.can_cast_psionics(psionic_flags)

/datum/action/cooldown/psionic/levitate/proc/on_levitation_life(datum/source, seconds_per_tick)
	SIGNAL_HANDLER

	if(!levitating)
		return

	var/mob/living/living_owner = source
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!can_maintain_levitation(living_owner, profile))
		clear_levitation(living_owner)
		return

	levitation_strain_buffer += levitation_strain_per_second * seconds_per_tick
	var/strain_to_gain = FLOOR(levitation_strain_buffer, 1)
	if(strain_to_gain <= 0)
		return

	levitation_strain_buffer -= strain_to_gain
	if(!profile.try_gain_strain(strain_to_gain, src))
		clear_levitation(living_owner)

/datum/action/cooldown/psionic/levitate/proc/on_levitation_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	clear_levitation(living_owner, TRUE)

/datum/action/cooldown/psionic/levitate/proc/clear_levitation(mob/living/living_owner, silent = FALSE)
	if(!levitating)
		return FALSE

	levitating = FALSE
	levitation_strain_buffer = 0
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))
		REMOVE_TRAIT(living_owner, TRAIT_SILENT_FOOTSTEPS, PSIONIC_LEVITATION_TRAIT_SOURCE)
		living_owner.RemoveElement(/datum/element/forced_gravity, gravity = 0, can_override = TRUE)
		if(!silent)
			to_chat(living_owner, span_notice("The levitation pattern releases."))
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	return TRUE

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
	button_icon_state = "psi_psychic_guard"
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
	var/datum/component/anti_psionic/shield = owner.AddComponent(
		/datum/component/anti_psionic, \
		psionic_flags = PSIONIC_INTRUSIVE|PSIONIC_SENSORY, \
		charges = guard_charges, \
		block_psionic = block_callback \
	)
	addtimer(CALLBACK(src, PROC_REF(clear_guard), WEAKREF(shield)), guard_duration)
	to_chat(owner, span_purple("You draw a quiet guard around your thoughts."))
	return TRUE

/datum/action/cooldown/psionic/psychic_guard/proc/on_guard_block(mob/living/source, atom/movable/blocker)
	to_chat(source, span_notice("Your psychic guard catches the intrusion and collapses part of its pattern."))

/datum/action/cooldown/psionic/psychic_guard/proc/clear_guard(datum/weakref/shield_ref)
	var/datum/component/anti_psionic/shield = shield_ref?.resolve()
	if(shield)
		qdel(shield)

/datum/psionic_rank_variant/psiblade
	rank = PSIONIC_RANK_GAMMA
	variant_name = "machete"
	strain_gain = 10
	cooldown_time = 8 SECONDS
	/// Psiblade item spawned for this form.
	var/obj/item/psionic_blade/blade_type = /obj/item/psionic_blade/machete

/datum/psionic_rank_variant/psiblade/epsilon
	rank = PSIONIC_RANK_EPSILON
	variant_name = "knife"
	blade_type = /obj/item/psionic_blade/knife
	strain_gain = 5
	cooldown_time = 4 SECONDS

/datum/psionic_rank_variant/psiblade/delta
	rank = PSIONIC_RANK_DELTA
	variant_name = "sabre"
	blade_type = /obj/item/psionic_blade/sabre
	strain_gain = 14
	cooldown_time = 10 SECONDS

/datum/psionic_rank_variant/psiblade/beta
	rank = PSIONIC_RANK_BETA
	variant_name = "energy blade"
	blade_type = /obj/item/psionic_blade/energy
	strain_gain = 18
	cooldown_time = 12 SECONDS

/datum/psionic_rank_variant/psiblade/alpha
	rank = PSIONIC_RANK_ALPHA
	variant_name = "twinblade"
	blade_type = /obj/item/psionic_blade/twinblade
	strain_gain = 24
	cooldown_time = 16 SECONDS

/datum/action/cooldown/psionic/psiblade
	name = "Psiblade"
	desc = "Shape hardlight into a melee weapon. Higher ranks form stronger blades."
	button_icon_state = "psi_psiblade"
	cooldown_time = 12 SECONDS
	point_cost = 1
	strain_gain = 18
	psionic_flags = PSIONIC_KINETIC|PSIONIC_THERMAL
	school = PSIONIC_SCHOOL_FLUX
	rank_variant_types = list(
		/datum/psionic_rank_variant/psiblade/epsilon,
		/datum/psionic_rank_variant/psiblade,
		/datum/psionic_rank_variant/psiblade/delta,
		/datum/psionic_rank_variant/psiblade/beta,
		/datum/psionic_rank_variant/psiblade/alpha,
	)
	/// Currently manifested psiblade.
	var/obj/item/psionic_blade/psiblade
	/// TRUE while the action is intentionally deleting its blade.
	var/removing_psiblade = FALSE

/datum/action/cooldown/psionic/psiblade/Remove(mob/living/remove_from)
	clear_psiblade(remove_from, TRUE)
	return ..()

/datum/action/cooldown/psionic/psiblade/IsAvailable(feedback = FALSE)
	if(has_active_psiblade())
		return TRUE

	return ..()

/datum/action/cooldown/psionic/psiblade/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return has_active_psiblade()

/datum/action/cooldown/psionic/psiblade/Activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE
	if(has_active_psiblade())
		return clear_psiblade(living_owner)

	return ..()

/datum/action/cooldown/psionic/psiblade/before_psionic(atom/target)
	var/mob/living/living_owner = owner
	if(!length(living_owner.get_empty_held_indexes()))
		living_owner.balloon_alert(living_owner, "free a hand!")
		to_chat(living_owner, span_warning("You need a free hand to shape [src]."))
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/psiblade/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!profile)
		return FALSE

	var/datum/psionic_rank_variant/selected_variant = get_selected_rank_variant(profile)
	var/datum/psionic_rank_variant/psiblade/form
	if(istype(selected_variant, /datum/psionic_rank_variant/psiblade))
		form = selected_variant
	if(!form?.blade_type)
		return FALSE

	var/obj/item/psionic_blade/new_psiblade = new form.blade_type(living_owner)
	if(!living_owner.put_in_hands(new_psiblade, del_on_fail = TRUE))
		living_owner.balloon_alert(living_owner, "free a hand!")
		to_chat(living_owner, span_warning("You need a free hand to shape [src]."))
		return FALSE

	psiblade = new_psiblade
	RegisterSignal(psiblade, COMSIG_QDELETING, PROC_REF(on_psiblade_deleted))
	RegisterSignal(psiblade, COMSIG_ITEM_DROPPED, PROC_REF(on_psiblade_dropped))
	RegisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_owner_life))
	RegisterSignal(living_owner, COMSIG_LIVING_DEATH, PROC_REF(on_owner_death))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

	living_owner.visible_message(
		span_warning("[living_owner] shapes hardlight into [psiblade]."),
		span_purple("You draw hardlight into [psiblade]."),
	)
	playsound(living_owner, 'sound/items/weapons/saberon.ogg', 35, TRUE)
	return TRUE

/datum/action/cooldown/psionic/psiblade/proc/has_active_psiblade()
	return psiblade && !QDELETED(psiblade)

/datum/action/cooldown/psionic/psiblade/proc/can_maintain_psiblade(mob/living/living_owner, datum/component/psionic_profile/profile)
	if(action_disabled || !istype(living_owner) || !profile)
		return FALSE
	if(living_owner.stat != CONSCIOUS)
		return FALSE
	if(HAS_TRAIT(living_owner, TRAIT_INCAPACITATED))
		return FALSE
	if(profile.is_burned_out())
		return FALSE

	return living_owner.can_cast_psionics(psionic_flags)

/datum/action/cooldown/psionic/psiblade/proc/on_owner_life(datum/source, seconds_per_tick)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!can_maintain_psiblade(living_owner, profile))
		clear_psiblade(living_owner)

/datum/action/cooldown/psionic/psiblade/proc/on_owner_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	clear_psiblade(living_owner, TRUE)

/datum/action/cooldown/psionic/psiblade/proc/clear_psiblade(mob/living/living_owner, silent = FALSE)
	if(!has_active_psiblade())
		psiblade = null
		return FALSE

	if(!istype(living_owner))
		living_owner = owner
	removing_psiblade = TRUE
	UnregisterSignal(psiblade, list(COMSIG_QDELETING, COMSIG_ITEM_DROPPED))
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))
		living_owner.temporarilyRemoveItemFromInventory(psiblade, force = TRUE)
		if(!silent)
			to_chat(living_owner, span_notice("The psiblade disperses."))
			playsound(living_owner, 'sound/items/weapons/saberoff.ogg', 35, TRUE)
	QDEL_NULL(psiblade)
	removing_psiblade = FALSE
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	return TRUE

/datum/action/cooldown/psionic/psiblade/proc/on_psiblade_deleted(datum/source)
	SIGNAL_HANDLER

	psiblade = null
	if(removing_psiblade || QDELETED(owner))
		return
	var/mob/living/living_owner = owner
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

/datum/action/cooldown/psionic/psiblade/proc/on_psiblade_dropped(datum/source, mob/living/dropper)
	SIGNAL_HANDLER

	psiblade = null
	if(removing_psiblade || QDELETED(owner))
		return
	var/mob/living/living_owner = owner
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

/datum/action/cooldown/psionic/pointed/projectile/pyro_bolt
	name = "Pyro Bolt"
	desc = "Ignite your hand and lance a short barrage of orange thermal beams."
	button_icon_state = "psi_pyro_bolt"
	active_msg = "Flame gathers over your palm."
	deactive_msg = "The flame drains back into your skin."
	cooldown_time = 12 SECONDS
	cast_range = 9
	point_cost = 1
	strain_gain = 14
	psionic_flags = PSIONIC_THERMAL
	school = PSIONIC_SCHOOL_FLUX
	projectile_type = /obj/projectile/psionic/pyro_bolt
	projectile_hand_visual_type = /obj/item/psionic_pyro_hand
	projectiles_per_fire = 3
	projectile_spread = 8
	projectile_sound = 'sound/items/weapons/laser.ogg'

/datum/action/cooldown/psionic/pointed/projectile/pyro_bolt/psionic_activate(atom/target)
	owner.visible_message(
		span_warning("[owner]'s hand blooms with orange fire."),
		span_purple("Your hand blooms with orange fire."),
	)
	return ..()

/datum/action/cooldown/psionic/pointed/projectile/pyro_assault
	name = "Pyro Assault"
	desc = "Compress psionic heat into an explosive fireball."
	button_icon_state = "psi_pyro_assault"
	active_msg = "A bright pressure gathers in your burning hand."
	deactive_msg = "You let the fireball gutter out."
	cooldown_time = 30 SECONDS
	cast_range = 8
	point_cost = 2
	strain_gain = 32
	psionic_flags = PSIONIC_THERMAL
	school = PSIONIC_SCHOOL_FLUX
	projectile_type = /obj/projectile/psionic/pyro_fireball
	projectile_hand_visual_type = /obj/item/psionic_pyro_hand
	projectile_sound = 'sound/effects/magic/fireball.ogg'

/datum/action/cooldown/psionic/pointed/projectile/pyro_assault/psionic_activate(atom/target)
	owner.visible_message(
		span_warning("[owner] hurls a dense knot of orange fire."),
		span_purple("You hurl a dense knot of orange fire."),
	)
	return ..()

/obj/item/psionic_pyro_hand
	name = "\improper psionic flame"
	desc = "A flame-shaped pressure shimmering around the hand."
	icon = 'icons/obj/weapons/hand.dmi'
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	icon_state = "greyscale"
	inhand_icon_state = "greyscale"
	color = COLOR_ORANGE
	item_flags = ABSTRACT | HAND_ITEM | DROPDEL | NOBLUDGEON
	w_class = WEIGHT_CLASS_HUGE
	force = 0
	throwforce = 0
	throw_range = 0
	throw_speed = 0

/obj/item/psionic_pyro_hand/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, PSIONIC_TRAIT_SOURCE)

/obj/item/psionic_blade
	name = "psionic machete"
	desc = "A shimmering blade of psionically-shaped hardlight."
	icon = 'modular_nova/modules/psionics/icons/psiblades.dmi'
	icon_state = "psiblade_gamma"
	inhand_icon_state = "psiblade_gamma"
	icon_angle = -45
	lefthand_file = 'modular_nova/modules/psionics/icons/psiblades_lefthand.dmi'
	righthand_file = 'modular_nova/modules/psionics/icons/psiblades_righthand.dmi'
	item_flags = ABSTRACT | DROPDEL | NO_BLOOD_ON_ITEM
	resistance_flags = INDESTRUCTIBLE | ACID_PROOF | FIRE_PROOF | LAVA_PROOF | UNACIDABLE
	force = 20
	throwforce = 0
	throw_speed = 0
	throw_range = 0
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/blade1.ogg'
	block_sound = 'sound/items/weapons/block_blade.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LIGHT_CYAN
	light_on = TRUE
	wound_bonus = 10
	exposed_wound_bonus = 20
	var/psionic_rank = PSIONIC_RANK_GAMMA
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/psionic_blade/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, PSIONIC_TRAIT_SOURCE)
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)

/obj/item/psionic_blade/knife
	name = "psionic knife"
	desc = "A compact hardlight knife shaped by minor psionic focus."
	icon_state = "psiblade_epsilon"
	inhand_icon_state = "psiblade_epsilon"
	force = 10
	w_class = WEIGHT_CLASS_SMALL
	armour_penetration = 0
	block_chance = 0
	wound_bonus = 5
	exposed_wound_bonus = 15
	light_range = 1
	psionic_rank = PSIONIC_RANK_EPSILON

/obj/item/psionic_blade/machete
	desc = "A chopping hardlight blade shaped by operant-rank psionics."

/obj/item/psionic_blade/sabre
	name = "psionic sabre"
	desc = "A focused hardlight sabre shaped by master-rank psionics."
	icon_state = "psiblade_delta"
	inhand_icon_state = "psiblade_delta"
	force = 25
	w_class = WEIGHT_CLASS_NORMAL
	armour_penetration = 20
	block_chance = 30
	psionic_rank = PSIONIC_RANK_DELTA

/obj/item/psionic_blade/energy
	name = "psionic energy blade"
	desc = "A lethal hardlight blade burning with grandmaster psionic focus."
	icon_state = "psiblade_beta"
	inhand_icon_state = "psiblade_beta"
	force = 30
	armour_penetration = 35
	block_chance = 50
	wound_bonus = 0
	light_range = 3
	psionic_rank = PSIONIC_RANK_BETA

/obj/item/psionic_blade/twinblade
	name = "psionic twinblade"
	desc = "A double-ended hardlight blade burning with paramount psionic focus."
	icon_state = "psiblade_alpha"
	inhand_icon_state = "psiblade_alpha"
	force = 40
	armour_penetration = 35
	block_chance = 75
	wound_bonus = -10
	light_range = 6
	psionic_rank = PSIONIC_RANK_ALPHA

/obj/item/psionic_blade/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE
	if(attack_type == LEAP_ATTACK)
		final_block_chance -= 25

	return ..()

/obj/item/psionic_blade/IsReflect()
	if(psionic_rank != PSIONIC_RANK_ALPHA)
		return FALSE

	return prob(block_chance)

/obj/projectile/psionic
	name = "psionic bolt"
	icon_state = "energy"
	damage_type = BURN
	armor_flag = ENERGY
	/// Psionic category checked by anti-psionic counters when this projectile hits.
	var/psionic_flags = PSIONIC_THERMAL
	/// Anti-psionic charge cost to block this projectile.
	var/psionic_charge_cost = 1

/obj/projectile/psionic/prehit_pierce(atom/target)
	. = ..()
	if(!isliving(target))
		return .

	var/mob/living/living_target = target
	if(living_target.can_block_psionics(psionic_flags, psionic_charge_cost))
		visible_message(span_warning("[src] unravels against [living_target]'s psionic dampening."))
		return PROJECTILE_DELETE_WITHOUT_HITTING

/obj/projectile/psionic/pyro_bolt
	name = "pyro bolt"
	icon_state = "firebeam"
	damage = 10
	damage_type = BURN
	armor_flag = LASER
	range = 9
	color = COLOR_ORANGE
	hitsound = 'sound/items/weapons/sear.ogg'
	hitsound_wall = 'sound/items/weapons/effects/searwall.ogg'
	impact_effect_type = /obj/effect/temp_visual/impact_effect/yellow_laser
	tracer_type = /obj/effect/projectile/tracer/laser/emitter/blast
	muzzle_type = /obj/effect/projectile/muzzle/laser/emitter/blast
	impact_type = /obj/effect/projectile/impact/laser/emitter/blast
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_power = 1.4
	light_color = LIGHT_COLOR_ORANGE
	/// Temperature used when igniting targets and exposed objects.
	var/temperature = 350

/obj/projectile/psionic/pyro_bolt/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(!.)
		return

	if(isobj(target))
		var/obj/object_target = target
		if(object_target.resistance_flags & ON_FIRE)
			return

		object_target.fire_act(temperature)
		return

	if(isliving(target))
		var/mob/living/living_target = target
		living_target.adjust_fire_stacks(2)
		living_target.ignite_mob()

/obj/projectile/psionic/pyro_bolt/on_range()
	var/turf/location = get_turf(src)
	if(location)
		new /obj/effect/hotspot(location)
		location.hotspot_expose(700, 50, 1)
	return ..()

/obj/projectile/psionic/pyro_fireball
	name = "psionic fireball"
	icon_state = "fireball"
	damage = 10
	damage_type = BURN
	range = 8
	color = COLOR_ORANGE
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1.8
	light_color = LIGHT_COLOR_ORANGE
	psionic_charge_cost = 2
	/// Heavy explosion range of the fireball.
	var/exp_heavy = 0
	/// Light explosion range of the fireball.
	var/exp_light = 2
	/// Fire radius of the fireball.
	var/exp_fire = 2
	/// Flash radius of the fireball.
	var/exp_flash = 3

/obj/projectile/psionic/pyro_fireball/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.take_overall_damage(burn = 10)

	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		return

	explosion(
		target_turf,
		devastation_range = -1,
		heavy_impact_range = exp_heavy,
		light_impact_range = exp_light,
		flame_range = exp_fire,
		flash_range = exp_flash,
		adminlog = FALSE,
		explosion_cause = src,
	)
