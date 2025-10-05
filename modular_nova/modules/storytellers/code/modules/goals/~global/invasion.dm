// This goal prepares the station for an external threat by building tension through sub-goals (e.g., security alerts, minor incursions).
// Once achieved or timed out, it triggers a major invasion event from selected antagonist sources (e.g., nukeops, pirates).

/datum/storyteller_goal/global_goal/invasion_defense
	id = "invasion_defense"
	name = "Invasion"
	category = STORY_GOAL_GLOBAL | STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_WHOLE_STATION | STORY_TAG_AFFECTS_SECURITY | STORY_TAG_AFFECTS_INFRASTRUCTURE
	path_ids = list("security_alert", "minor_incursion", "arm_crew")
	event_path = /datum/round_event/major_invasion
	var/list/invasion_sources = list(
		/datum/antagonist/pirate,
		/datum/antagonist/blob,
		/datum/antagonist/space_dragon,
	)


/datum/storyteller_goal/global_goal/invasion_defense/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return vault[STORY_VAULT_CREW_ALIVE_COUNT] >= 25 && inputs.crew_weight >= 400

/datum/storyteller_goal/global_goal/invasion_defense/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return (storyteller.threat_points / 10) * storyteller.round_progression * storyteller.difficulty_multiplier

/datum/storyteller_goal/global_goal/invasion_defense/get_priority(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return 9

/datum/storyteller_goal/global_goal/invasion_defense/can_fire_now(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)


/datum/storyteller_goal/global_goal/invasion_defense/complete(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	storyteller.threat_points += min(threat_points * 0.3, 1000)
	if(!event_path)
		return
	var/datum/round_event/E = new event_path(TRUE, new /datum/round_event_control/storyteller_control)
	E.__setup_for_storyteller(threat_points, invasion_sources)
	E.__announce_for_storyteller()
	E.__start_for_storyteller()



/datum/storyteller_goal/global_goal/invasion_defense/heavy
	id = "invasion_defense_heavy"
	name = "Heavy invasion"
	invasion_sources = list(
		/datum/antagonist/nukeop,
		/datum/antagonist/xeno,
	)

/datum/storyteller_goal/global_goal/invasion_defense/heavy/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return vault[STORY_VAULT_CREW_ALIVE_COUNT] >= 40 && inputs.crew_weight >= 600

/datum/storyteller_goal/global_goal/invasion_defense/heavy/get_priority(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return 11


/datum/round_event/major_invasion



