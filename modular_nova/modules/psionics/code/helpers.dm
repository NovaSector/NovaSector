/// Whether the quirk-granted mental shield covers [psionic_flags]. The Psionic Dampener quirk
/// only shields the mind, so it applies to intrusive and sensory effects alone; every other
/// `TRAIT_PSIONIC_DAMPENER` source (cuffs, sundering) suppresses all psionics.
/mob/proc/quirk_dampener_covers(psionic_flags)
	if(!(psionic_flags & (PSIONIC_INTRUSIVE|PSIONIC_SENSORY)))
		return FALSE

	return HAS_TRAIT_FROM(src, TRAIT_PSIONIC_DAMPENER, QUIRK_TRAIT)

/// Trait-based psionic blocking that consumes nothing. Used ahead of charged protection in
/// `can_block_psionics()`, and directly by area effects that must not drain item charges.
/mob/proc/has_free_psionic_block(psionic_flags = PSIONIC_INTRUSIVE)
	if(psionic_flags == NONE)
		return FALSE

	if(HAS_TRAIT_NOT_FROM(src, TRAIT_PSIONIC_DAMPENER, QUIRK_TRAIT))
		return TRUE
	if(HAS_TRAIT(src, TRAIT_RESIST_PSYCHIC))
		return TRUE

	return quirk_dampener_covers(psionic_flags)

/// Checks whether this mob can currently project psionics.
/// `TRAIT_PSIONIC_DAMPENER` suppresses casting; `TRAIT_RESIST_PSYCHIC` does not, by design:
/// resistance is receive-only (see `can_block_psionics`), not a casting lockout.
/// The quirk-sourced dampener locks out only the mental categories it shields.
/mob/proc/can_cast_psionics(psionic_flags = PSIONIC_ALL)
	if(psionic_flags == NONE)
		return TRUE

	if(HAS_TRAIT_NOT_FROM(src, TRAIT_PSIONIC_DAMPENER, QUIRK_TRAIT))
		return FALSE
	if(quirk_dampener_covers(psionic_flags))
		return FALSE

	return !(SEND_SIGNAL(src, COMSIG_MOB_RESTRICT_PSIONICS, psionic_flags) & COMPONENT_PSIONIC_BLOCKED)

/// Checks whether this mob blocks an incoming psionic effect.
/// Both `TRAIT_PSIONIC_DAMPENER` and `TRAIT_RESIST_PSYCHIC` block incoming effects here,
/// but only `TRAIT_PSIONIC_DAMPENER` also blocks casting in `can_cast_psionics()`.
/// Free trait blocks are checked first so charged protection items are not consumed needlessly.
/mob/proc/can_block_psionics(psionic_flags = PSIONIC_INTRUSIVE, charge_cost = 1)
	if(psionic_flags == NONE)
		return FALSE

	if(has_free_psionic_block(psionic_flags))
		return TRUE

	var/list/psionic_sources = list()
	var/list/psionic_blockers = list()

	SEND_SIGNAL(src, COMSIG_MOB_RECEIVE_PSIONICS, psionic_flags, charge_cost, psionic_sources, psionic_blockers)
	var/datum/component/psionic_protection/blocker = pick_psionic_blocker(psionic_blockers)
	return !!blocker?.block_psionic_effect(src, charge_cost)

/// Picks one active psionic blocker to handle an incoming effect.
/// Infinite protection wins first, psionic ability protection wins next, and worn item protection is randomized last.
/mob/proc/pick_psionic_blocker(list/psionic_blockers)
	if(!length(psionic_blockers))
		return null

	var/list/infinite_blockers = list()
	var/list/ability_blockers = list()
	var/list/item_blockers = list()

	for(var/datum/component/psionic_protection/blocker as anything in psionic_blockers)
		if(blocker.charges == INFINITY)
			infinite_blockers += blocker
		else if(!blocker.parent_is_item)
			ability_blockers += blocker
		else
			item_blockers += blocker

	if(length(infinite_blockers))
		return pick(infinite_blockers)
	if(length(ability_blockers))
		return pick(ability_blockers)
	if(length(item_blockers))
		return pick(item_blockers)
	return null

/// Checks whether this mob blocks an incoming psionic effect and emits standard feedback to [caster] if it does.
/// Returns TRUE if blocked. Use this in powers instead of calling `can_block_psionics` directly
/// to ensure consistent caster-side feedback without per-power ad-hoc messages.
/mob/proc/try_block_psionics(mob/caster, psionic_flags = PSIONIC_INTRUSIVE, charge_cost = 1, alert = "blocked!")
	if(can_block_psionics(psionic_flags, charge_cost))
		if(istype(caster))
			caster.balloon_alert(caster, alert)
		return TRUE
	return FALSE

/// Returns living mobs near [seeker] carrying an active, non-suppressed psionic profile.
/// Shared by Resonance Sense and the handheld psionic resonance scanner.
/proc/get_resonance_targets(mob/living/seeker, scan_range)
	var/list/resonance_targets = list()
	var/turf/seeker_turf = get_turf(seeker)
	if(!seeker_turf)
		return resonance_targets

	for(var/mob/living/possible_psion as anything in GLOB.alive_mob_list)
		if(!is_valid_resonance_target(seeker, possible_psion, scan_range))
			continue

		resonance_targets += possible_psion

	return resonance_targets

/proc/is_valid_resonance_target(mob/living/seeker, mob/living/possible_psion, scan_range)
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

/proc/get_nearest_resonance_target(mob/living/seeker, list/resonance_targets)
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

/proc/get_resonance_targets_by_distance(mob/living/seeker, list/resonance_targets)
	var/list/remaining_targets = resonance_targets.Copy()
	var/list/sorted_targets = list()
	while(length(remaining_targets))
		var/mob/living/nearest_target = get_nearest_resonance_target(seeker, remaining_targets)
		if(!nearest_target)
			break

		sorted_targets += nearest_target
		remaining_targets -= nearest_target

	return sorted_targets

/proc/get_resonance_descriptor(mob/living/seeker, mob/living/resonance_target)
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

/mob/living/proc/get_psionic_profile()
	return GetComponent(/datum/component/psionic_profile)

/mob/living/proc/awaken_psionics(points = PSIONIC_DEFAULT_POINTS, list/starting_powers, source = PSIONIC_TRAIT_SOURCE)
	var/mutation_rank
	if(source == PSIONIC_SOURCE_MUTATION)
		var/datum/mind/psion_mind = mind
		mutation_rank = psion_mind?.psionic_mutation_rank
		if(isnull(GLOB.psionic_mutation_rank_weights[mutation_rank]))
			mutation_rank = pick_weight(GLOB.psionic_mutation_rank_weights)
			if(psion_mind)
				psion_mind.psionic_mutation_rank = mutation_rank
		points = get_psionic_rank_points(mutation_rank)

	var/datum/component/psionic_profile/profile = get_psionic_profile()
	if(!profile)
		profile = AddComponent(/datum/component/psionic_profile, points, starting_powers, source)
	else if(profile.add_source(source, points))
		profile.learn_starting_powers(starting_powers)
	if(!profile || !mutation_rank || profile.has_source(PSIONIC_SOURCE_QUIRK))
		return profile

	profile.apply_rank(mutation_rank)
	if(iscarbon(src))
		var/mob/living/carbon/carbon_psion = src
		var/obj/item/organ/cyberimp/brain/psionic_limiter/limiter = carbon_psion.get_organ_slot(ORGAN_SLOT_PSIONIC_IMPLANT)
		limiter?.try_apply_limit(profile)
	to_chat(src, span_purple("Your latent psionic rating resolves as [mutation_rank]."))
	return profile

/mob/living/proc/revoke_psionics(source = PSIONIC_TRAIT_SOURCE)
	var/datum/component/psionic_profile/profile = get_psionic_profile()
	if(profile)
		profile.remove_source(source)
