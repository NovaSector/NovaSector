/datum/psionic_power/biomend
	required_school_points = 1
	action_type = /datum/action/cooldown/psionic/pointed/living_target/biomend

/datum/action/cooldown/psionic/pointed/living_target/biomend
	name = "Biomend"
	desc = "Channel a restorative psionic pattern into a living target, mending organic brute and burn trauma while your concentration holds."
	button_icon_state = "psi_biomend"
	cooldown_time = 8 SECONDS
	cast_range = 6
	point_cost = 1
	strain_gain = 0
	active_strain_gain_per_second = 10
	psionic_flags = PSIONIC_PROTECTIVE
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	requires_concentration = TRUE
	active_msg = "You gather a restorative pattern..."
	deactive_msg = "You let the restorative pattern dissolve."
	no_living_target_alert = "no patient!"
	dead_target_alert = "no life pattern!"
	/// Brute damage mended each second while the channel is active.
	var/brute_healing_per_second = 3
	/// Burn damage mended each second while the channel is active.
	var/burn_healing_per_second = 3
	/// Dampener charge cost for blocking the initial restorative pattern.
	var/dampener_charge_cost = 1
	/// TRUE while a target is being mended.
	var/biomending = FALSE
	/// Current target of the maintained channel.
	var/mob/living/carbon/biomend_target
	/// Beam drawn from the psion to the patient.
	var/datum/beam/biomend_beam
	/// Unique filter name used for the patient's outline.
	var/biomend_filter_name
	/// TRUE while this action is intentionally tearing down its beam.
	var/clearing_biomend = FALSE

/datum/action/cooldown/psionic/pointed/living_target/biomend/Remove(mob/living/remove_from)
	clear_biomend(remove_from, TRUE)
	return ..()

/datum/action/cooldown/psionic/pointed/living_target/biomend/IsAvailable(feedback = FALSE)
	if(is_biomending())
		return TRUE

	return ..()

/datum/action/cooldown/psionic/pointed/living_target/biomend/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return is_biomending()

/datum/action/cooldown/psionic/pointed/living_target/biomend/Trigger(mob/clicker, trigger_flags, atom/target)
	if(is_biomending())
		var/mob/living/living_owner = owner
		return clear_biomend(living_owner)

	return ..()

/datum/action/cooldown/psionic/pointed/living_target/biomend/Activate(atom/target)
	var/mob/living/living_owner = owner
	if(is_biomending())
		return clear_biomend(living_owner)

	return ..()

/datum/action/cooldown/psionic/pointed/living_target/biomend/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!iscarbon(target))
		owner.balloon_alert(owner, "no organic anatomy!")
		return FALSE

	var/mob/living/carbon/carbon_target = target
	if(!has_healable_organic_damage(carbon_target))
		owner.balloon_alert(owner, "nothing to mend!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/biomend/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/mob/living/carbon/carbon_target = target
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!istype(carbon_target))
		return FALSE
	if(carbon_target.can_block_psionics(psionic_flags, charge_cost = dampener_charge_cost))
		living_owner.balloon_alert(living_owner, "mending blocked!")
		to_chat(living_owner, span_warning("[carbon_target]'s body rejects your restorative pattern."))
		return FALSE

	biomending = TRUE
	biomend_target = carbon_target
	var/manifestation_color = get_biomend_color(profile)
	biomend_filter_name = "psionic_biomend_[REF(src)]"
	biomend_target.add_filter(biomend_filter_name, 2, outline_filter(size = 1, color = manifestation_color))
	biomend_beam = living_owner.Beam(
		biomend_target,
		icon_state = "medbeam",
		maxdistance = get_psionic_cast_range(profile) + 1,
		beam_type = /obj/effect/ebeam/medical,
		beam_color = manifestation_color,
	)
	RegisterSignal(biomend_beam, COMSIG_QDELETING, PROC_REF(on_biomend_beam_deleted))
	RegisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_owner_life))
	RegisterSignal(living_owner, COMSIG_LIVING_DEATH, PROC_REF(on_owner_death))
	RegisterSignal(biomend_target, COMSIG_LIVING_DEATH, PROC_REF(on_target_death))
	RegisterSignal(biomend_target, COMSIG_QDELETING, PROC_REF(on_target_deleted))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

	living_owner.visible_message(
		span_notice("A thread of restorative light reaches from [living_owner] to [biomend_target]."),
		span_purple("You bind [biomend_target]'s wounds into a restorative pattern."),
	)
	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/is_biomending()
	return biomending && istype(owner, /mob/living)

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/has_healable_organic_damage(mob/living/carbon/carbon_target)
	if(!istype(carbon_target))
		return FALSE

	return carbon_target.get_brute_loss_for_type(BODYTYPE_ORGANIC) > 0 || carbon_target.get_fire_loss_for_type(BODYTYPE_ORGANIC) > 0

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/get_biomend_color(datum/component/psionic_profile/profile)
	return profile?.psionic_color || PSIONIC_DEFAULT_COLOR

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/on_owner_life(datum/source, seconds_per_tick)
	SIGNAL_HANDLER

	if(!biomending)
		return

	var/mob/living/living_owner = source
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!istype(biomend_target) || QDELETED(biomend_target) || biomend_target.stat == DEAD)
		clear_biomend(living_owner, TRUE)
		return
	var/turf/owner_turf = get_turf(living_owner)
	var/turf/target_turf = get_turf(biomend_target)
	if(!owner_turf || !target_turf || get_dist(owner_turf, target_turf) > get_psionic_cast_range(profile))
		clear_biomend(living_owner)
		return
	if(!has_healable_organic_damage(biomend_target))
		clear_biomend(living_owner, TRUE)
		return

	var/healed_damage = biomend_target.heal_overall_damage(
		brute = brute_healing_per_second * seconds_per_tick,
		burn = burn_healing_per_second * seconds_per_tick,
		required_bodytype = BODYTYPE_ORGANIC,
	)
	if(healed_damage <= 0)
		clear_biomend(living_owner, TRUE)
		return

	if(!try_gain_active_strain(profile, seconds_per_tick))
		clear_biomend(living_owner)

/datum/action/cooldown/psionic/pointed/living_target/biomend/on_concentration_broken(mob/living/living_owner)
	clear_biomend(living_owner)
	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/on_owner_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	clear_biomend(living_owner, TRUE)

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/on_target_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = owner
	clear_biomend(living_owner, TRUE)

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/on_target_deleted(datum/source)
	SIGNAL_HANDLER

	var/mob/living/living_owner = owner
	clear_biomend(living_owner, TRUE)

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/on_biomend_beam_deleted(datum/source)
	SIGNAL_HANDLER

	biomend_beam = null
	if(clearing_biomend || QDELETED(owner))
		return

	var/mob/living/living_owner = owner
	clear_biomend(living_owner)

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/clear_biomend(mob/living/living_owner, silent = FALSE)
	if(!biomending)
		return FALSE

	biomending = FALSE
	clearing_biomend = TRUE
	stop_concentration(living_owner)
	if(istype(living_owner))
		UnregisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_owner_life))
		UnregisterSignal(living_owner, COMSIG_LIVING_DEATH, PROC_REF(on_owner_death))
		if(!silent)
			to_chat(living_owner, span_notice("The restorative pattern collapses."))
	if(istype(biomend_target))
		UnregisterSignal(biomend_target, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
		if(biomend_filter_name && !QDELETED(biomend_target))
			biomend_target.remove_filter(biomend_filter_name)
	if(biomend_beam)
		UnregisterSignal(biomend_beam, COMSIG_QDELETING)
		QDEL_NULL(biomend_beam)

	biomend_target = null
	biomend_filter_name = null
	clearing_biomend = FALSE
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	return TRUE
