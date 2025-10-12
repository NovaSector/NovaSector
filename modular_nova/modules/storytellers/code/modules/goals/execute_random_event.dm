/datum/storyteller_goal/execute_random_event
	id = "execute_random_event"
	name = "Execute Random Event"
	desc = "Triggers a random event from the SSevents event pool."
	children = list()
	category = STORY_GOAL_RANDOM
	tags = STORY_TAG_CHAOTIC
	event_path = null // This will be set dynamically

	var/list/possible_events = list()


/datum/storyteller_goal/execute_random_event/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(storyteller.mood.volatility >= 1.3) //Best for chaotic storytellers
		return TRUE
	else
		return FALSE


/datum/storyteller_goal/execute_random_event/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return rand(STORY_GOAL_BASE_WEIGHT, STORY_GOAL_BASE_WEIGHT * 2) * storyteller.mood.volatility


/datum/storyteller_goal/execute_random_event/complete(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	if(!possible_events.len)
		possible_events = list()
		for(var/datum/round_event/event in subtypesof(/datum/round_event))
			if(event::allow_random && event != /datum/round_event)
				possible_events += event

	if(!possible_events.len)
		message_admins("No valid random events found for storyteller to execute.")
		return
	var/datum/round_event/event_to_execute = pick(possible_events)
	var/datum/round_event/evt = new event_to_execute(TRUE, new /datum/round_event_control/storyteller_control)
	evt.setup() // Executing event normally(without storyteller)
