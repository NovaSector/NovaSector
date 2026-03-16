// Roundstart Bloodsucker

/datum/dynamic_ruleset/roundstart/bloodsucker
	name = "Bloodsuckers"
	config_tag = "Roundstart Bloodsucker"
	pref_flag = ROLE_BLOODSUCKER
	preview_antag_datum = /datum/antagonist/bloodsucker
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES
	weight = 5
	max_antag_cap = list("denominator" = 24)
	/// List of species that cannot be bloodsuckers
	var/list/restricted_species = BLOODSUCKER_RESTRICTED_SPECIES

/datum/dynamic_ruleset/roundstart/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	return ..()

/datum/dynamic_ruleset/roundstart/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.AdjustUnspentRank(rand(2, 3))

// Latejoin Bloodsucker

/datum/dynamic_ruleset/latejoin/bloodsucker
	name = "Bloodsucker Breakout"
	config_tag = "Latejoin Bloodsucker"
	preview_antag_datum = /datum/antagonist/bloodsucker
	pref_flag = ROLE_BLOODSUCKERBREAKOUT
	jobban_flag = ROLE_BLOODSUCKER
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES
	weight = 5
	repeatable = FALSE
	/// List of species that cannot be bloodsuckers
	var/list/restricted_species = BLOODSUCKER_RESTRICTED_SPECIES

/datum/dynamic_ruleset/latejoin/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	if(!candidate.mind.valid_bloodsucker_candidate())
		return FALSE
	return ..()

/datum/dynamic_ruleset/latejoin/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.AdjustUnspentRank(rand(2, 3))

// Midround Bloodsucker

/datum/dynamic_ruleset/midround/from_living/bloodsucker
	name = "Vampiric Accident"
	config_tag = "Midround Bloodsucker"
	midround_type = HEAVY_MIDROUND
	preview_antag_datum = /datum/antagonist/bloodsucker
	pref_flag = ROLE_VAMPIRICACCIDENT
	jobban_flag = ROLE_BLOODSUCKER
	blacklisted_roles = BLOODSUCKER_BLACKLISTED_ROLES
	weight = 5
	repeatable = FALSE
	/// List of species that cannot be bloodsuckers
	var/list/restricted_species = BLOODSUCKER_RESTRICTED_SPECIES

/datum/dynamic_ruleset/midround/from_living/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	if(!is_station_level(candidate.z))
		return FALSE
	var/selected_species = candidate_client.prefs?.read_preference(/datum/preference/choiced/species)
	if(selected_species in restricted_species)
		return FALSE
	if(!candidate.mind.valid_bloodsucker_candidate())
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/suck_datum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	suck_datum.AdjustUnspentRank(rand(2, 3))
