/datum/dynamic_ruleset/midround/from_living/bloodwashed
	name = "Bloodwashed"
	config_tag = "Midround Bloodwashed"
	preview_antag_datum = /datum/antagonist/cult/bloodwashed
	midround_type = LIGHT_MIDROUND
	pref_flag = ROLE_BLOODWASHED_MIDROUND
	jobban_flag = ROLE_CULTIST
	ruleset_flags = RULESET_VARIATION
	weight = alist(
		DYNAMIC_TIER_LOW = 1,
		DYNAMIC_TIER_LOWMEDIUM = 2,
		DYNAMIC_TIER_MEDIUMHIGH = 2,
		DYNAMIC_TIER_HIGH = 1,
	)
	min_pop = 15
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
	)

/datum/dynamic_ruleset/midround/from_living/bloodwashed/get_always_blacklisted_roles()
	return ..() | JOB_CHAPLAIN

/datum/dynamic_ruleset/midround/from_living/bloodwashed/is_valid_candidate(mob/candidate, client/candidate_client)
	return ..() && is_convertable_to_cult(candidate)

/datum/dynamic_ruleset/midround/from_living/bloodwashed/assign_role(datum/mind/candidate)
	bloodwash_mind(candidate)
	notify_ghosts(
		"[candidate.current.real_name] has been bloodwashed by a lingering occult influence!",
		source = candidate.current,
		header = "Bloodwashed",
	)
