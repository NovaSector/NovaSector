// Planner
/datum/storyteller_planner
	/// current global goal identifier
	var/current_goal
	/// optional subgoals/branches
	var/list/subgoals

	var/datum/storyteller/owner

/datum/storyteller_planner/New(datum/storyteller/_owner)
	..()
	owner = _owner

/datum/storyteller_planner/proc/pick_new_global_goal(datum/storyteller/ctl)
	// Placeholder: choose goal based on mood and current station snapshot if any
	current_goal = "stabilize_economy"
	subgoals = list()

/datum/storyteller_planner/proc/update_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	// Placeholder: adjust subgoals depending on inputs and balance
	return
