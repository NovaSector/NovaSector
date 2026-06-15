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
	var/is_psionic_blocked = FALSE

	if(SEND_SIGNAL(src, COMSIG_MOB_RECEIVE_PSIONICS, psionic_flags, charge_cost, psionic_sources) & COMPONENT_PSIONIC_BLOCKED)
		is_psionic_blocked = TRUE
	if(HAS_TRAIT(src, TRAIT_PSIONIC_DAMPENER))
		is_psionic_blocked = TRUE
	if(HAS_TRAIT(src, TRAIT_RESIST_PSYCHIC))
		is_psionic_blocked = TRUE

	return is_psionic_blocked

/mob/living/proc/get_psionic_profile()
	return GetComponent(/datum/component/psionic_profile)

/mob/living/proc/awaken_psionics(points = PSIONIC_DEFAULT_POINTS, list/starting_powers, source = PSIONIC_TRAIT_SOURCE)
	var/datum/component/psionic_profile/profile = get_psionic_profile()
	if(!profile)
		profile = AddComponent(/datum/component/psionic_profile, points, starting_powers, source)
	else
		profile.add_source(source)
		profile.add_points(points)
		profile.learn_starting_powers(starting_powers)
	return profile

/mob/living/proc/revoke_psionics(source = PSIONIC_TRAIT_SOURCE)
	var/datum/component/psionic_profile/profile = get_psionic_profile()
	if(profile)
		profile.remove_source(source)

/mob/living/proc/forget_psionics()
	var/datum/component/psionic_profile/profile = get_psionic_profile()
	if(profile)
		qdel(profile)
