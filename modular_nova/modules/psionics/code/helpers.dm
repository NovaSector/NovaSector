/datum/mind
	/// Mutation-sourced psionic rank rolled for this mind. Reused to prevent mutadone rerolls.
	var/psionic_mutation_rank

/// Checks whether this mob can currently project psionics.
/// `TRAIT_PSIONIC_DAMPENER` suppresses casting; `TRAIT_RESIST_PSYCHIC` does not, by design —
/// resistance is receive-only (see `can_block_psionics`), not a casting lockout.
/mob/proc/can_cast_psionics(psionic_flags = PSIONIC_ALL)
	if(psionic_flags == NONE)
		return TRUE

	if(HAS_TRAIT(src, TRAIT_PSIONIC_DAMPENER))
		return FALSE

	return !(SEND_SIGNAL(src, COMSIG_MOB_RESTRICT_PSIONICS, psionic_flags) & COMPONENT_PSIONIC_BLOCKED)

/// Checks whether this mob blocks an incoming psionic effect.
/// Both `TRAIT_PSIONIC_DAMPENER` and `TRAIT_RESIST_PSYCHIC` block incoming effects here,
/// but only `TRAIT_PSIONIC_DAMPENER` also blocks casting in `can_cast_psionics()`.
/mob/proc/can_block_psionics(psionic_flags = PSIONIC_INTRUSIVE, charge_cost = 1)
	if(psionic_flags == NONE)
		return FALSE

	var/list/psionic_sources = list()
	var/list/psionic_blockers = list()

	SEND_SIGNAL(src, COMSIG_MOB_RECEIVE_PSIONICS, psionic_flags, charge_cost, psionic_sources, psionic_blockers)
	var/datum/component/psionic_protection/blocker = pick_psionic_blocker(psionic_blockers)
	if(blocker?.block_psionic_effect(src, charge_cost))
		return TRUE
	if(HAS_TRAIT(src, TRAIT_PSIONIC_DAMPENER))
		return TRUE

	return HAS_TRAIT(src, TRAIT_RESIST_PSYCHIC)

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

	profile.set_rank(
		rank = mutation_rank,
		latent_rank = mutation_rank,
		limited = FALSE,
		new_max_strain = GLOB.psionic_rank_max_strain[mutation_rank],
		new_strain_decay = GLOB.psionic_rank_strain_decay[mutation_rank],
	)
	to_chat(src, span_purple("Your latent psionic rating resolves as [mutation_rank]."))
	return profile

/mob/living/proc/revoke_psionics(source = PSIONIC_TRAIT_SOURCE)
	var/datum/component/psionic_profile/profile = get_psionic_profile()
	if(profile)
		profile.remove_source(source)

/mob/living/proc/forget_psionics()
	var/datum/component/psionic_profile/profile = get_psionic_profile()
	if(profile)
		qdel(profile)
