/datum/storyteller_goal/global_goal/catastrophic_failure
	id = "goal_global_catastrophic_failure"
	name = "Catastrophic station failure"
	category = STORY_GOAL_BAD | STORY_GOAL_BAD
	tags = STORY_TAG_AFFECTS_WHOLE_STATION | STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_ENVIRONMENT | STORY_TAG_AFFECTS_INFRASTRUCTURE

/datum/storyteller_goal/global_goal/catastrophic_failure/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return storyteller.round_progression >= 0.8 && vault[STORY_VAULT_CREW_ALIVE_COUNT] > 30 && vault[STORY_VAULT_ATMOS_STATUS] <= STORY_VAULT_MINOR_BREACHES

/datum/storyteller_goal/global_goal/catastrophic_failure/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return min(10, 1 * storyteller.difficulty_multiplier * storyteller.mood.get_threat_multiplier())

/datum/storyteller_goal/global_goal/can_fire_now(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return is_available(vault, inputs, storyteller)

/datum/storyteller_goal/global_goal/catastrophic_failure/get_progress(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)



/datum/storyteller_goal/global_goal/catastrophic_failure/move_to_goal(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	storyteller.threat_points += storyteller.threat_growth_rate * 2



	storyteller.adaptation_factor = max(0, storyteller.adaptation_factor - storyteller.adaptation_decay_rate * 0.5)
	if(inputs.antag_crew_ratio < 0.3)
		var/datum/storyteller_goal/antag_empower = SSstorytellers.goals_by_id["empower_antagonist"]
		if(antag_empower && antag_empower.is_available(vault, inputs, storyteller))
			antag_empower.complete(vault, inputs, storyteller, storyteller.threat_points * 0.2, inputs.station_value)


/datum/storyteller_goal/global_goal/catastrophic_failure/complete(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	return ..(vault, inputs, storyteller, threat_points, station_value)




