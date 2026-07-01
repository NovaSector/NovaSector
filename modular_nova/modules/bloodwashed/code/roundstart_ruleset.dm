/datum/dynamic_ruleset/roundstart/bloodwashed
	name = "Bloodwashed"
	config_tag = "Roundstart Bloodwashed"
	preview_antag_datum = /datum/antagonist/cult/bloodwashed
	pref_flag = ROLE_BLOODWASHED
	jobban_flag = ROLE_CULTIST
	ruleset_flags = RULESET_VARIATION
	weight = alist(
		DYNAMIC_TIER_LOW = 1,
		DYNAMIC_TIER_LOWMEDIUM = 2,
		DYNAMIC_TIER_MEDIUMHIGH = 2,
		DYNAMIC_TIER_HIGH = 1,
	)
	min_pop = 15
	max_antag_cap = list("denominator" = 30)
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
	)

/datum/dynamic_ruleset/roundstart/bloodwashed/get_always_blacklisted_roles()
	return ..() | JOB_CHAPLAIN

/datum/dynamic_ruleset/roundstart/bloodwashed/is_valid_candidate(mob/candidate, client/candidate_client)
	return ..() && is_convertable_to_cult(candidate)

/datum/dynamic_ruleset/roundstart/bloodwashed/assign_role(datum/mind/candidate)
	bloodwash_mind(candidate)
