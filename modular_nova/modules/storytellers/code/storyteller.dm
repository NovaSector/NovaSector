// Base storyteller actor

/datum/storyteller
	var/name = ""
	var/desc = ""
	/// Current mood profile
	var/datum/storyteller_mood/mood
	/// Planner selects global goal and branches
	var/datum/storyteller_planner/planner
	/// Analyzer computes station value and inputs
	var/datum/storyteller_analyzer/analyzer
	/// Balancer computes weights of players vs antagonists
	var/datum/storyteller_balance/balancer
	/// Next time to update analysis and planning
	var/next_think_time = 0
	/// Base think frequency; scaled by mood pace
	var/base_think_delay = 2 MINUTES

/datum/storyteller/New()
	..()
	mood = new /datum/storyteller_mood
	planner = new /datum/storyteller_planner(src)
	analyzer = new /datum/storyteller_analyzer
	balancer = new /datum/storyteller_balance

/datum/storyteller/proc/initialize_round()
	// Called at round start
	planner.pick_new_global_goal(src)
	schedule_next_think()

/datum/storyteller/proc/schedule_next_think()
	var/mult = max(0.1, mood?.get_event_frequency_multiplier() || 1.0)
	next_think_time = world.time + (base_think_delay / mult)

/datum/storyteller/proc/think()
	if(world.time < next_think_time)
		return
	var/datum/storyteller_inputs/inputs = analyzer.sample_station()
	var/datum/storyteller_balance_snapshot/bal = balancer.compute(inputs)
	planner.update_plan(src, inputs, bal)
	schedule_next_think()

/datum/storyteller/proc/on_goal_completed()
	planner.pick_new_global_goal(src)
	schedule_next_think()


// Inputs bundle passed between subsystems
/datum/storyteller_inputs
	var/station_value = 0
	var/num_players = 0
	var/num_antags = 0
	var/list/role_weights


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


// Balance
/datum/storyteller_balance
	/// Base weight per player
	var/player_weight = 1.0
	/// Base weight per antagonist
	var/antag_weight = 2.0

/datum/storyteller_balance/proc/compute(datum/storyteller_inputs/inputs)
	var/datum/storyteller_balance_snapshot/s = new
	var/roles_weight = 0
	for(var/role in inputs.role_weights)
		roles_weight += inputs.role_weights[role]
	s.total_player_weight = (inputs.num_players * player_weight) + roles_weight
	s.total_antag_weight = inputs.num_antags * antag_weight
	s.ratio = max(0.001, s.total_player_weight) / max(0.001, s.total_antag_weight)
	return s

/datum/storyteller_balance_snapshot
	var/total_player_weight = 0
	var/total_antag_weight = 0
	var/ratio = 1.0


// Utility
/proc/list_values(list/L)
	var/list/out = list()
	for(var/k in L)
		out += L[k]
	return out


// Analyzer
/datum/storyteller_analyzer
	var/list/role_multipliers = list(
		JOB_SECURITY_OFFICER = 1.3,
		JOB_HEAD_OF_SECURITY = 1.5,
		JOB_CAPTAIN = 1.6,
		JOB_HEAD_OF_PERSONNEL = 1.3,
	)

/datum/storyteller_analyzer/proc/storyteller_atom_value(atom/A)
	if(isnull(A) || QDELETED(A))
		return 0
	// Prefer per-atom personalized story value if provided
	var/personal = A.story_value()
	if(isnum(personal) && personal > 0)
		return personal
	// Prefer intrinsic item credit value when available
	if(istype(A, /obj/item))
		var/obj/item/I = A
		var/item_val = I.get_item_credit_value()
		if(item_val)
			return max(0, item_val)
	// Fall back to material worth for anything with custom materials
	return max(0, materials_value(A))

/datum/storyteller_analyzer/proc/sample_station()
	var/datum/storyteller_inputs/i = new
	i.station_value = compute_station_value()
	i.num_players = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)
	i.num_antags = length(GLOB.antagonists)
	i.role_weights = compute_role_weights()
	return i
