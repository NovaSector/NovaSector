// Storyteller Goals
/datum/storyteller_goal
	/// Unique identifier for the goal
	var/id
	/// Display name
	var/name
	/// Description
	var/desc
	/// Category of the goal
	var/category
	/// Optional for filtering
	var/tags
	/// Optional parent goal id
	var/parent_id
	/// Linked child goal datums after resolution
	var/list/children

	var/list/path_ids

	/// Optional event path to trigger on achievement (e.g., /datum/event/meteor)
	var/event_path

	var/announce_color = COLOR_GRAY


/// Is goal available for selection under the given context?
/datum/storyteller_goal/proc/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return TRUE

/// Compute selection weight
/datum/storyteller_goal/proc/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return 1.0


/datum/storyteller_goal/proc/get_priority(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return 1


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
		E.__announce_for_storyteller()
		E.__start_for_storyteller()
	return TRUE


// Storyteller Goals
/datum/storyteller_goal/global_goal



// Global goals should be always completed, before
/datum/storyteller_goal/global_goal/complete(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	if(!get_progress(vault, inputs, storyteller) < 1)
		return FALSE
	return ..()



/datum/storyteller_goal/global_goal/proc/move_to_goal(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)



/datum/storyteller_goal/global_goal/execute_event
	name = "Execute the event"
