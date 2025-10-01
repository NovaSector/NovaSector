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
	/// Storyteller short memory
	var/datum/storyteller_inputs/inputs
	/// Next time to update analysis and planning (in world.time)
	var/next_think_time = 0
	/// Base think frequency; scaled by mood pace (in ticks)
	var/base_think_delay = 2 MINUTES

	var/datum/storyteller_goal/current_global_goal = null
	var/list/subgoals = list()

	var/global_goal_progress = 0

	var/global_goal_weight = 1.0

	var/min_event_interval = 30 SECONDS

	var/max_event_interval = 20 MINUTES

	var/list/recent_events = list()

	var/player_antag_balance = 50

	// Balance and weights

	var/event_difficulty_modifier = 1.0

	var/max_antagonists = 0

	var/min_players_for_antags = 5

	// Adaptation and difficulty variables (inspired by RimWorld's threat adaptation and cycles)
	/// Current threat points; accumulate over time to scale event intensity
	var/threat_points = 0
	/// Rate at which threat points increase per think cycle
	var/threat_growth_rate = 1.0
	/// Adaptation factor; reduces threat intensity after recent damage/losses (0-1, where 0 = full adaptation/no threats)
	var/adaptation_factor = 0
	/// Rate at which adaptation decays over time (e.g., 0.1 per cycle, restoring normal threats)
	var/adaptation_decay_rate = 0.05
	/// Threshold for triggering adaptation (e.g., if recent_damage > this, increase adaptation_factor)
	var/recent_damage_threshold = 20
	/// Target tension level; storyteller aims to keep overall_tension around this (from balancer)
	var/target_tension = 50  // 0-100 scale, adjusted by mood/storyteller type
	/// Current grace period after major event
	var/grace_period = 5 MINUTES
	/// Time since last major event; used to enforce grace periods
	var/time_since_last_event = 0
	/// Overall difficulty multiplier; scales all weights/threats (e.g., 1.0 normal, 2.0 for hard modes)
	var/difficulty_multiplier = 1.0
	/// Population factor; scales threats/events by player count (like RimWorld's population curve)
	var/population_factor = 1.0  // E.g., increases with more players for bigger events
	/// Max threat scale; caps threat_points to prevent over-escalation
	var/max_threat_scale = 5.0
	/// Repetition penalty; reduces weight of recently used events/goals for variety
	var/repetition_penalty = 0.5  // Applied to recent_events matches



/datum/storyteller/New()
	..()
	mood = new /datum/storyteller_mood
	planner = new /datum/storyteller_planner(src)
	analyzer = new /datum/storyteller_analyzer(src)
	balancer = new /datum/storyteller_balance(src)
	inputs = new /datum/storyteller_inputs


/datum/storyteller/proc/initialize_round()
	// Initialize inputs with starting station analysis
	inputs = analyzer.get_inputs()
	inputs = analyzer.get_inputs()
	balancer.make_snapshot(inputs)


	current_global_goal = planner.select_weighted_goal()

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

	inputs = analyzer.get_inputs()


	// Check if current global goal is still valid
	if(current_global_goal && !current_global_goal.is_available(inputs.vault, inputs, src))
		log_storyteller("Global goal [current_global_goal.id] no longer valid")
		current_global_goal = null
		global_goal_progress = 0


	if(!current_global_goal)
		current_global_goal = planner.select_weighted_goal()


	// Update goal progress
	if(current_global_goal)
		global_goal_progress = update_goal_progress(inputs.vault, inputs, src)
		if(global_goal_progress >= 1.0)
			on_goal_completed()

	// Check for subgoal progress
	if(subgoals)
		for(var/datum/storyteller_goal/subgoal in subgoals)
			if(subgoal.is_available(inputs.vault, inputs, src) && \
				check_subgoal_progress(subgoal, inputs.vault, inputs, src) >= 1.0)
				log_storyteller("Subgoal [subgoal.id] achieved")
				subgoal.trigger_event()



	// Schedule next think
	schedule_next_think()



/datum/storyteller/proc/on_goal_completed()
	if(!current_global_goal)
		return
	log_storyteller("Global goal [current_global_goal.id] completed")
	current_global_goal.trigger_event()


/// Check progress toward global goal
/datum/storyteller/proc/update_goal_progress(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!current_global_goal)
		return 0
	var/weight = current_global_goal.get_weight(vault, inputs, storyteller)
	if(weight <= 0)
		return 0
	return min(global_goal_progress + (0.1 * global_goal_weight / weight), 1.0)


/datum/storyteller/proc/check_subgoal_progress(datum/storyteller_goal/goal, list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	if(!goal)
		return 0
	var/weight = goal.get_weight(vault, inputs, storyteller)
	if(weight <= 0)
		return 0
	return min(1.0, goal.get_weight(vault, inputs, storyteller) / global_goal_weight)


/datum/storyteller/proc/can_trigger_event()
	var/last_event_time = recent_events.len ? recent_events[recent_events.len] : 0
	var/time_since_last = world.time - last_event_time
	if(time_since_last < min_event_interval)
		return FALSE
	if(time_since_last > max_event_interval)
		return TRUE
	var/prob_modifier = (mood ? mood.get_threat_multiplier() : 1.0) * event_difficulty_modifier
	return prob(50 * prob_modifier)

/datum/storyteller/proc/trigger_random_event(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	SSevents.spawnEvent()
	recent_events += world.time
	log_storyteller("Triggered random event via SSevents")

/datum/storyteller/proc/get_active_player_count()
	return inputs.player_count

/datum/storyteller/proc/get_active_antagonist_count()
	return inputs.antag_count





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
