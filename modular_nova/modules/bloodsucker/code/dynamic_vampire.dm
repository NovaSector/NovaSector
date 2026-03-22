/datum/dynamic_ruleset/roundstart/vampire
	name = "Vampires"
	config_tag = "Roundstart Vampire"
	preview_antag_datum = /datum/antagonist/vampire
	pref_flag = ROLE_VAMPIRE
	// higher for testing purposes, since it's surprisingly uncommon for us to reach the min pop anyways
	weight = alist(
		DYNAMIC_TIER_LOW = /* 8 */ 10,
		DYNAMIC_TIER_LOWMEDIUM = /* 8 */ 10,
		DYNAMIC_TIER_MEDIUMHIGH = /* 8 */ 10,
		DYNAMIC_TIER_HIGH = /* 10 */ 12,
	)
	min_pop = 15
	min_antag_cap = 2
	max_antag_cap = 2
	blacklisted_roles = list(
		JOB_CURATOR,
	)

/datum/dynamic_ruleset/roundstart/vampire/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/vampire)

/datum/dynamic_ruleset/midround/from_living/vampire
	name = "Midround Vampire"
	config_tag = "Midround Vampire"
	preview_antag_datum = /datum/antagonist/vampire
	midround_type = LIGHT_MIDROUND
	pref_flag = ROLE_VAMPIRIC_ACCIDENT
	jobban_flag = ROLE_VAMPIRE
	ruleset_flags = RULESET_VARIATION
	min_antag_cap = 1
	// higher for testing purposes, since it's surprisingly uncommon for us to reach the min pop anyways
	weight = alist(
		DYNAMIC_TIER_LOW = /* 8 */ 10,
		DYNAMIC_TIER_LOWMEDIUM = /* 8 */ 10,
		DYNAMIC_TIER_MEDIUMHIGH = /* 8 */ 10,
		DYNAMIC_TIER_HIGH = /* 10 */ 12,
	)
	min_pop = 15
	blacklisted_roles = list(
		JOB_CURATOR,
	)

/datum/dynamic_ruleset/midround/from_living/vampire/assign_role(datum/mind/candidate)
	var/wait_time = 0
	if(SSsol.sunlight_active)
		wait_time = (SSsol.time_til_cycle + 5) SECONDS // 5 seconds after sol ends
	else if(SSsol.time_til_cycle < 75)
		wait_time = (SSsol.time_til_cycle + TIME_VAMPIRE_DAY + 5) SECONDS
	if(wait_time)
		addtimer(CALLBACK(candidate, TYPE_PROC_REF(/datum/mind, add_antag_datum), /datum/antagonist/vampire), wait_time)
	else
		candidate.add_antag_datum(/datum/antagonist/vampire)

/datum/dynamic_ruleset/midround/from_living/vampire/collect_candidates()
	var/list/candidates = ..()
	return poll_candidates_for_one(trim_candidates(candidates))

/datum/dynamic_ruleset/midround/from_living/vampire/mass
	name = "Mass Vampires"
	config_tag = "Mass Vampires"
	min_antag_cap = 1
	max_antag_cap = list("denominator" = 25, offset = 1) // note: the amount of existing vampires is taken off of existing pop
	midround_type = HEAVY_MIDROUND

/**
 * Polls a group of candidates to see if they want to be a vampire.
 *
 * @param candidates a list containing a candidate mobs
 */
/datum/dynamic_ruleset/midround/from_living/vampire/proc/poll_candidates_for_one(list/candidates)
	var/max_candidates = get_antag_cap(length(GLOB.alive_player_list) - length(GLOB.all_vampires), max_antag_cap || min_antag_cap)
	message_admins("[name]: Attempting to poll [length(candidates)] people individually, trying to select [max_candidates]")
	log_dynamic("[name]: Attempting to poll [length(candidates)] people individually, trying to select [max_candidates]")
	var/list/yes_candidates = list()
	var/sanity = 5
	while((length(yes_candidates) < max_candidates) && length(candidates) && sanity > 0)
		sanity--
		var/mob/living/candidate = pick_n_take(candidates)
		if(QDELETED(candidate) || candidate.stat == DEAD || !candidate.client)
			continue
		log_dynamic("[name]: Polling candidate [key_name(candidate)]")
		if(poll_for_vampire(candidate, yes_candidates))
			log_dynamic("[name]: Candidate [key_name(candidate)] has accepted being a Vampire")
		else
			log_dynamic("[name]: Candidate [key_name(candidate)] has declined to be a Vampire")

	log_dynamic("[name]: [length(yes_candidates)] candidates accepted")
	return yes_candidates

/datum/dynamic_ruleset/midround/from_living/vampire/proc/poll_for_vampire(mob/living/candidate, list/yes_candidates)
	var/list/response = SSpolling.poll_candidates(
		question = "Do you want to be a Vampire?",
		group = list(candidate),
		poll_time = 15 SECONDS,
		flash_window = TRUE,
		start_signed_up = FALSE,
		announce_chosen = FALSE,
		role_name_text = "Vampiric Accident",
		alert_pic = image('modular_nova/modules/bloodsucker/icons/actions_vampire.dmi', "clanselect"),
		custom_response_messages = list(
			POLL_RESPONSE_SIGNUP = "You have signed up to be a vampire!",
			POLL_RESPONSE_ALREADY_SIGNED = "You are already signed up to be a vampire.",
			POLL_RESPONSE_NOT_SIGNED = "You aren't signed up to be a vampire.",
			POLL_RESPONSE_TOO_LATE_TO_UNREGISTER = "It's too late to decide against being a vampire.",
			POLL_RESPONSE_UNREGISTERED = "You decide against being a vampire.",
		),
		chat_text_border_icon = image('modular_nova/modules/bloodsucker/icons/actions_vampire.dmi', "clanselect"),
	)
	if(response)
		yes_candidates += response
		return TRUE
	else
		return FALSE

/datum/dynamic_ruleset/latejoin/vampire
	name = "Latejoin Vampire"
	config_tag = "Latejoin Vampire"
	preview_antag_datum = /datum/antagonist/vampire
	pref_flag = ROLE_VAMPIRE_BREAKOUT
	jobban_flag = ROLE_VAMPIRE
	// higher for testing purposes, since it's surprisingly uncommon for us to reach the min pop anyways
	weight = alist(
		DYNAMIC_TIER_LOW = /* 8 */ 10,
		DYNAMIC_TIER_LOWMEDIUM = /* 8 */ 10,
		DYNAMIC_TIER_MEDIUMHIGH = /* 8 */ 10,
		DYNAMIC_TIER_HIGH = /* 10 */ 12,
	)
	min_pop = 15
	blacklisted_roles = list(
		JOB_CURATOR,
	)

/datum/dynamic_ruleset/latejoin/vampire/assign_role(datum/mind/candidate)
	var/wait_time = 0
	if(SSsol.sunlight_active)
		wait_time = (SSsol.time_til_cycle + 5) SECONDS // 5 seconds after sol ends
	else if(SSsol.time_til_cycle < 75)
		wait_time = (SSsol.time_til_cycle + TIME_VAMPIRE_DAY + 5) SECONDS
	if(wait_time)
		addtimer(CALLBACK(candidate, TYPE_PROC_REF(/datum/mind, add_antag_datum), /datum/antagonist/vampire), wait_time)
	else
		candidate.add_antag_datum(/datum/antagonist/vampire)
