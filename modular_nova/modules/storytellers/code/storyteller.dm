// Base storyteller actor
/datum/storyteller
	var/name = ""
	var/desc = ""

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
	var/list/subgoals = list()
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
	analyzer = new /datum/storyteller_analyzer
	balancer = new /datum/storyteller_balance

/datum/storyteller/proc/initialize_round()

/datum/storyteller/proc/schedule_next_think()


/datum/storyteller/proc/think()

/datum/storyteller/proc/on_goal_completed()





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
