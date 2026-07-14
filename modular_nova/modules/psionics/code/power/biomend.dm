/datum/psionic_power/biomend
	required_school_points = 1
	action_type = /datum/action/cooldown/psionic/pointed/living_target/biomend

/datum/psionic_rank_variant/biomend
	rank = PSIONIC_RANK_EPSILON
	variant_name = "mend"
	description = "A maintained restorative pattern for organic wounds."
	cooldown_time = 8 SECONDS
	cast_range = 6
	strain_gain = 0
	active_strain_gain_per_second = 10
	block_charge_cost = 1
	block_message = "mending blocked!"

/datum/action/cooldown/psionic/pointed/living_target/biomend
	name = "Biomend"
	desc = "Channel a restorative psionic pattern into a living target, mending organic brute and burn trauma while your concentration holds."
	button_icon_state = "psi_biomend"
	point_cost = 1
	psionic_flags = PSIONIC_PROTECTIVE
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	requires_concentration = TRUE
	maintain_end_message = "The restorative pattern collapses."
	active_msg = "You gather a restorative pattern..."
	deactive_msg = "You let the restorative pattern dissolve."
	no_living_target_alert = "no patient!"
	dead_target_alert = "no life pattern!"
	rank_variant_types = list(
		/datum/psionic_rank_variant/biomend,
	)
	/// Brute damage mended each second while the channel is active.
	var/brute_healing_per_second = 3
	/// Burn damage mended each second while the channel is active.
	var/burn_healing_per_second = 3
	/// Current target of the maintained channel.
	var/mob/living/carbon/biomend_target
	/// Beam drawn from the psion to the patient.
	var/datum/beam/biomend_beam
	/// Unique filter name used for the patient's outline.
	var/biomend_filter_name
	/// TRUE while this action is intentionally tearing down its beam.
	var/clearing_biomend = FALSE

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

	biomend_target = carbon_target
	var/manifestation_color = get_manifestation_color()
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
	RegisterSignal(biomend_target, COMSIG_LIVING_DEATH, PROC_REF(on_target_death))
	RegisterSignal(biomend_target, COMSIG_QDELETING, PROC_REF(on_target_deleted))
	start_maintaining(living_owner)

	living_owner.visible_message(
		span_notice("A beam of light reaches from [living_owner] to [biomend_target]."),
		span_purple("You mend [biomend_target]'s wounds."),
	)
	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/has_healable_organic_damage(mob/living/carbon/carbon_target)
	if(!istype(carbon_target))
		return FALSE

	return carbon_target.get_brute_loss_for_type(BODYTYPE_ORGANIC) > 0 || carbon_target.get_fire_loss_for_type(BODYTYPE_ORGANIC) > 0

/datum/action/cooldown/psionic/pointed/living_target/biomend/maintain_tick(mob/living/living_owner, datum/component/psionic_profile/profile, seconds_per_tick)
	if(!istype(biomend_target) || QDELETED(biomend_target) || biomend_target.stat == DEAD)
		stop_maintaining(living_owner, silent = TRUE)
		return FALSE
	var/turf/owner_turf = get_turf(living_owner)
	var/turf/target_turf = get_turf(biomend_target)
	if(!owner_turf || !target_turf || get_dist(owner_turf, target_turf) > get_psionic_cast_range(profile))
		return FALSE
	if(!has_healable_organic_damage(biomend_target))
		stop_maintaining(living_owner, silent = TRUE)
		return FALSE

	var/healed_damage = biomend_target.heal_overall_damage(
		brute = brute_healing_per_second * seconds_per_tick,
		burn = burn_healing_per_second * seconds_per_tick,
		required_bodytype = BODYTYPE_ORGANIC,
	)
	if(healed_damage <= 0)
		stop_maintaining(living_owner, silent = TRUE)
		return FALSE

	return try_gain_active_strain(profile, seconds_per_tick)

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/on_target_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = owner
	stop_maintaining(living_owner, silent = TRUE)

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/on_target_deleted(datum/source)
	SIGNAL_HANDLER

	var/mob/living/living_owner = owner
	stop_maintaining(living_owner, silent = TRUE)

/datum/action/cooldown/psionic/pointed/living_target/biomend/proc/on_biomend_beam_deleted(datum/source)
	SIGNAL_HANDLER

	biomend_beam = null
	if(clearing_biomend || QDELETED(owner))
		return

	var/mob/living/living_owner = owner
	stop_maintaining(living_owner)

/datum/action/cooldown/psionic/pointed/living_target/biomend/on_maintain_stopped(mob/living/living_owner, silent = FALSE)
	clearing_biomend = TRUE
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
