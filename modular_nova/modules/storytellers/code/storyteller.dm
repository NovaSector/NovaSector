// Base storyteller actor
/datum/storyteller
	var/name = "Base Storyteller"
	var/desc = "A generic storyteller managing station events and goals."

	var/base_cost_multiplier = 1.0
	/// Current mood profile, affecting event pacing and tone
	var/datum/storyteller_mood/mood
	/// Planner selects global goal and branches
	var/datum/storyteller_planner/planner
	/// Analyzer computes station value and inputs
	var/datum/storyteller_analyzer/analyzer
	/// Balancer computes weights of players vs antagonists
	var/datum/storyteller_balance/balancer

	var/datum/storyteller_inputs/inputs

	/// Next time to update analysis and planning (in world.time)
	var/next_think_time = 0
	/// Base think frequency; scaled by mood pace (in ticks)
	var/base_think_delay = 2 MINUTES
	var/datum/storyteller_goal/current_global_goal = null
	var/datum/storyteller_goal/subgoals = null
	var/global_goal_progress = 0
	var/global_goal_weight = 1.0
	var/min_event_interval = 30 SECONDS
	var/max_event_interval = 5 MINUTES
	var/list/recent_events = list()
	var/player_antag_balance = 50
	var/event_difficulty_modifier = 1.0
	var/max_antagonists = 0
	var/min_players_for_antags = 5

/datum/storyteller/New()
	..()
	mood = new /datum/storyteller_mood
	planner = new /datum/storyteller_planner(src)
	analyzer = new /datum/storyteller_analyzer(src)
	balancer = new /datum/storyteller_balance
	inputs = new /datum/storyteller_inputs

/datum/storyteller/proc/initialize_round()
	// Initialize inputs with starting station analysis
	analyzer.scan_station()
	inputs = analyzer.get_inputs()

	// Select initial global goal
	current_global_goal = SSstorytellers.select_weighted_goal(get_context())
	if(current_global_goal)
		log_storyteller("Initialized with global goal: [current_global_goal.id]")
		global_goal_weight = current_global_goal.get_weight(get_context())
		// Initialize subgoals if any
		var/list/children = current_global_goal.get_children()
		if(children.len)
			subgoals = SSstorytellers.select_weighted_goal_from_list(children, get_context())
			if(subgoals)
				log_storyteller("Selected initial subgoal: [subgoals.id]")

	// Schedule first think
	schedule_next_think()

/datum/storyteller/proc/schedule_next_think()
	// Apply mood-based pacing (assumes mood.pace is a multiplier, e.g., 0.5 for fast, 2.0 for slow)
	var/pace_multiplier = (mood ? mood.pace : 1.0)
	var/delay = base_think_delay * pace_multiplier
	next_think_time = world.time + delay

/datum/storyteller/proc/think()
	if(world.time < next_think_time)
		return

	// Update inputs with fresh analysis
	analyzer.scan_station()
	inputs = analyzer.get_inputs()
	var/list/context = get_context()

	// Check if current global goal is still valid
	if(current_global_goal && !current_global_goal.is_available(context))
		log_storyteller("Global goal [current_global_goal.id] no longer valid")
		current_global_goal = null
		subgoals = null
		global_goal_progress = 0

	// Select new global goal if none
	if(!current_global_goal)
		current_global_goal = SSstorytellers.select_weighted_goal(context)
		if(current_global_goal)
			log_storyteller("Selected new global goal: [current_global_goal.id]")
			global_goal_weight = current_global_goal.get_weight(context)
			var/list/children = current_global_goal.get_children()
			if(children.len)
				subgoals = SSstorytellers.select_weighted_goal_from_list(children, context)
				if(subgoals)
					log_storyteller("Selected subgoal: [subgoals.id]")

	// Update goal progress
	if(current_global_goal)
		global_goal_progress = update_goal_progress(context)
		if(global_goal_progress >= 1.0)
			on_goal_completed()

	// Check for subgoal progress
	if(subgoals)
		if(subgoals.is_available(context) && check_subgoal_progress(context) >= 1.0)
			log_storyteller("Subgoal [subgoals.id] achieved")
			subgoals.trigger_event()
			var/list/children = subgoals.get_children()
			subgoals = children.len ? SSstorytellers.select_weighted_goal_from_list(children, context) : null
			if(subgoals)
				log_storyteller("Selected next subgoal: [subgoals.id]")

	// Trigger events based on mood and balance
	if(can_trigger_event())
		trigger_random_event(context)

	// Schedule next think
	schedule_next_think()

/datum/storyteller/proc/on_goal_completed()
	if(!current_global_goal)
		return
	log_storyteller("Global goal [current_global_goal.id] completed")
	current_global_goal.trigger_event()
	var/list/children = current_global_goal.get_children()
	if(children.len)
		// Try to select a new global goal from children
		current_global_goal = SSstorytellers.select_weighted_goal_from_list(children, get_context())
		if(current_global_goal)
			log_storyteller("Promoted child to global goal: [current_global_goal.id]")
			global_goal_weight = current_global_goal.get_weight(get_context())
			global_goal_progress = 0
			subgoals = null
			var/list/new_children = current_global_goal.get_children()
			if(new_children.len)
				subgoals = SSstorytellers.select_weighted_goal_from_list(new_children, get_context())
				if(subgoals)
					log_storyteller("Selected subgoal: [subgoals.id]")
	else
		current_global_goal = null
		global_goal_progress = 0
		subgoals = null

/// Helper to build context for goal evaluation
/datum/storyteller/proc/get_context()
	return list(
		"inputs" = inputs,
		"owner" = src,
		"vault" = inputs.vault
	)

/// Check progress toward global goal (placeholder; customize per goal)
/datum/storyteller/proc/update_goal_progress(list/context)
	if(!current_global_goal)
		return 0
	// Example: progress based on requirement expression; could be customized via JSON
	var/weight = current_global_goal.get_weight(context)
	if(weight <= 0)
		return 0
	return min(global_goal_progress + (0.1 * global_goal_weight / weight), 1.0)

/datum/storyteller/proc/check_subgoal_progress(list/context)
	if(!subgoals)
		return 0
	// Similar to global goal; assumes subgoal completion tied to requirement
	var/weight = subgoals.get_weight(context)
	if(weight <= 0)
		return 0
	return min(1.0, subgoals.get_weight(context) / global_goal_weight)

/datum/storyteller/proc/can_trigger_event()
	var/last_event_time = recent_events.len ? recent_events[recent_events.len] : 0
	var/time_since_last = world.time - last_event_time
	if(time_since_last < min_event_interval)
		return FALSE
	if(time_since_last > max_event_interval)
		return TRUE
	// Mood and balance influence probability
	var/prob_modifier = (mood ? mood.get_threat_multiplier() : 1.0) * event_difficulty_modifier
	return prob(50 * prob_modifier)

/datum/storyteller/proc/trigger_random_event(list/context)
	// Use events subsystem to spawn a random event now
	SSevents.spawnEvent()
	recent_events += world.time
	log_storyteller("Triggered random event via SSevents")

/datum/storyteller/proc/get_active_player_count()
	var/count = 0
	for(var/mob/M in GLOB.player_list)
		if(M.stat != DEAD && !isobserver(M))
			count++
	return count

/datum/storyteller/proc/get_active_antagonist_count()
	var/count = 0
	for(var/datum/mind/M in SSticker.minds)
		if(M.has_antag_datum())
			count++
	return count





// Inputs datum to hold sampled data from the station
// This structure packages analysis results from the analyzer for use in planner (global goal and subgoals branching)
// and balancer (player vs. antagonist weights). It supports decision-making for event planning, goal progress,
// and mood-influenced adjustments. Expanded to include more metrics for comprehensive station analysis.
/datum/storyteller_inputs
	/// Total computed value of the station (atoms + infrastructure, used for goal weighting)
	var/station_value = 0
	/// Total weight of non-antagonist crew members (influences balancer for event difficulty)
	var/crew_weight = 0
	/// Total weight of antagonist players
	var/antag_weight = 0
	/// Number of active players (living, non-observer)
	var/player_count = 0
	/// Number of active antagonists
	var/antag_count = 0
	/// Antagonist-to-crew ratio (float, e.g., 0.2 for 20% antags)
	var/antag_crew_ratio = 0
	/// Bitflags for station states/tendencies (e.g., STATION_HIGH_THREAT | STATION_LOW_RESOURCES)
	/// Set by analyzer based on thresholds
	var/station_states
	/// Detailed station state datum, count of floor, walls and e.t.c default updates one time per 10 minutes
	var/datum/station_state/station_state

	/// Vault: Associative list for unique/custom values (keyed by defines like STORY_VALUE_POWER)
	/// Stores dynamic metrics not fitting standard vars, e.g., department-specific values or event-specific data.
	/// check _storyteller.dm defines for examples
	var/list/vault = list()
