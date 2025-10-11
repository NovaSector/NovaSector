// Storyteller Goals
/datum/storyteller_goal
	// Unique identifier for the goal
	var/id
	// Display name
	var/name
	// Description
	var/desc
	// Category of the goal
	var/category
	// Optional for filtering
	var/tags
	// Optional parent goal id
	var/parent_id
	// Linked child goal datums after resolution
	var/list/children
	// List of child goal ids to link after selection
	var/list/path_ids
	// Optional event path to trigger on achievement (e.g., /datum/event/meteor)
	var/event_path
	// Color for announcer messages
	var/announce_color = COLOR_GRAY
	// Minimum threat level required to select this goal
	var/requierd_threat_level = STORY_GOAL_NO_THREAT
	// Minimum population of alive and non-afk crew required to select this goal
	var/requierd_population = 0
	// Minimum round progress (from 0..1) required to select this goal
	var/required_round_progress = STORY_ROUND_PROGRESSION_START


/// Is goal available for selection under the given context?
/datum/storyteller_goal/proc/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	. = TRUE
	if(requierd_threat_level < storyteller.get_effective_threat())
		. = FALSE
	if(requierd_population < vault[STORY_VAULT_CREW_ALIVE_COUNT])
		. = FALSE
	if(required_round_progress < storyteller.round_progression)
		. = FALSE
	return .

/// Compute selection weight
/datum/storyteller_goal/proc/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return STORY_GOAL_BASE_WEIGHT


/datum/storyteller_goal/proc/get_priority(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return STORY_GOAL_BASE_PRIORITY


/datum/storyteller_goal/proc/get_progress(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return 1


/datum/storyteller_goal/proc/can_fire_now(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return TRUE

/// Return linked children
/datum/storyteller_goal/proc/get_children()
	return children

/// Link this goal's children by id using a registry
/datum/storyteller_goal/proc/link_children(list/goals_by_id)
	children = list()
	if(!path_ids || !length(path_ids))
		return children

	for(var/i in 1 to path_ids.len)
		var/child_id = path_ids[i]
		var/datum/storyteller_goal/G = goals_by_id[child_id]
		if(G)
			children += G
	return children

/// Complete goal and triggers associative events if any
/datum/storyteller_goal/proc/complete(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	if(event_path)
		var/datum/round_event/E = new event_path(TRUE, new /datum/round_event_control/storyteller_control)
		E.__setup_for_storyteller(threat_points)
	return TRUE


/datum/storyteller_goal/global_goal/execute_event
	name = "Execute the event"
