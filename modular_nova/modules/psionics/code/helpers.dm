/datum/mind
	/// Mutation-sourced psionic rank rolled for this mind. Reused to prevent mutadone rerolls.
	var/psionic_mutation_rank

/// Checks whether this mob can currently project psionics.
/mob/proc/can_cast_psionics(psionic_flags = PSIONIC_ALL)
	if(psionic_flags == NONE)
		return TRUE

	if(HAS_TRAIT(src, TRAIT_PSIONIC_DAMPENER))
		return FALSE

	return !(SEND_SIGNAL(src, COMSIG_MOB_RESTRICT_PSIONICS, psionic_flags) & COMPONENT_PSIONIC_BLOCKED)

/// Checks whether this mob blocks an incoming psionic effect.
/mob/proc/can_block_psionics(psionic_flags = PSIONIC_INTRUSIVE, charge_cost = 1)
	if(psionic_flags == NONE)
		return FALSE

	var/list/psionic_sources = list()

	if(SEND_SIGNAL(src, COMSIG_MOB_RECEIVE_PSIONICS, psionic_flags, charge_cost, psionic_sources) & COMPONENT_PSIONIC_BLOCKED)
		return TRUE
	if(HAS_TRAIT(src, TRAIT_PSIONIC_DAMPENER))
		return TRUE

	return HAS_TRAIT(src, TRAIT_RESIST_PSYCHIC)

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
