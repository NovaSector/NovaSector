// Balance subsystem for storyteller
// Analyzes antagonist quantity, effectiveness (e.g., health, activity from metrics), and ratio to station strength (e.g., crew resilience, resources).
// Inspired by RimWorld's threat adaptation: balances player/antag weights to prevent one-sided dominance, influencing goal selection (e.g., boost weak antags).
// Snapshot captures current state for planner use.

/datum/storyteller_balance
	var/datum/storyteller/owner

	/// Base weight per player (scales with crew health/resilience)
	var/player_weight = STORY_BALANCER_PLAYER_WEIGHT
	/// Base weight per antagonist (scales with antag effectiveness)
	var/antag_weight = STORY_BALANCER_ANTAG_WEIGHT
	/// Threshold for "weak antags" effectiveness (0-1)
	var/weak_antag_threshold = STORY_BALANCER_WEAK_ANTAG_THRESHOLD
	/// Threshold for "inactive antags" activity level (0-3 scaled -> 0-1 after normalize)
	var/inactive_activity_threshold = STORY_BALANCER_INACTIVE_ACTIVITY_THRESHOLD
	/// Station strength multiplier (e.g., high crew health/resources = higher value)
	var/station_strength_multiplier = STORY_STATION_STRENGTH_MULTIPLIER

/datum/storyteller_balance/New(_owner)
	owner = _owner
	..()

// Create a snapshot of current balance state based on storyteller inputs and vault
/datum/storyteller_balance/proc/make_snapshot(datum/storyteller_inputs/inputs)
	var/datum/storyteller_balance_snapshot/snap = new()

	// Normalize counts
	var/crew_count = max(0, inputs.player_count)
	var/antag_count = max(0, inputs.antag_count)

	// Crew health proxy (0 healthy -> 1 worst). Vault uses 0..3 where 3 is worst
	var/crew_health_level = inputs.vault[STORY_VAULT_CREW_HEALTH]
	var/crew_health_index = clamp(crew_health_level / 3.0, 0, 1)

	// Station resource proxy
	var/resource_minerals = inputs.vault[STORY_VAULT_RESOURCE_MINERALS]
	var/resource_other = inputs.vault[STORY_VAULT_RESOURCE_OTHER]
	var/resource_strength = 0
	if(resource_minerals || resource_other)
		// Simple sigmoid-like scaling to 0..1
		var/total_resources = max(0, (resource_minerals || 0) + (resource_other || 0))
		resource_strength = clamp((log(1 + total_resources) / 10), 0, 1)

	// Crew resilience proxy from wounds/deaths (invert to strength)
	var/crew_wound_level = inputs.vault[STORY_VAULT_CREW_WOUNDING]
	var/crew_dead_ratio_level = inputs.vault[STORY_VAULT_CREW_DEAD_RATIO]
	var/crew_resilience = clamp(1 - ((crew_wound_level || 0) + (crew_dead_ratio_level || 0)) / 6, 0, 1)

	// Aggregate station strength
	var/station_strength = clamp((1 - crew_health_index) * 0.5 + crew_resilience * 0.3 + resource_strength * 0.2, 0, 1)
	station_strength *= station_strength_multiplier

	// Antagonist effectiveness/activity from vault (0..3 -> normalize 0..1)
	var/antag_activity_level = inputs.vault[STORY_VAULT_ANTAGONIST_ACTIVITY]
	var/antag_activity_index = clamp((antag_activity_level || 0) / 3.0, 0, 1)

	var/antag_influence_level = inputs.vault[STORY_VAULT_ANTAG_INFLUENCE]
	var/antag_disruption_level = inputs.vault[STORY_VAULT_ANTAG_DISRUPTION]
	var/antag_kills_level = inputs.vault[STORY_VAULT_ANTAG_KILLS]
	var/antag_objectives_level = inputs.vault[STORY_VAULT_ANTAG_OBJECTIVES_COMPLETED]

	var/antag_effectiveness = clamp(((antag_activity_index * 0.4) \
		+ ((antag_influence_level || 0) / 3.0) * 0.2 \
		+ ((antag_disruption_level || 0) / 3.0) * 0.15 \
		+ ((antag_kills_level || 0) / 3.0) * 0.15 \
		+ ((antag_objectives_level || 0) / 3.0) * 0.1), 0, 1)

	// Determine weak/inactive antags
	var/antag_inactive_ratio = inputs.vault[STORY_VAULT_ANTAG_INACTIVE_RATIO]
	var/inactive = (antag_inactive_ratio && antag_inactive_ratio >= 0.5) || (antag_activity_index < inactive_activity_threshold)
	var/weak = antag_effectiveness < weak_antag_threshold

	// Totals to weights
	snap.total_player_weight = crew_count * player_weight * max(0.25, station_strength)
	snap.total_antag_weight = antag_count * antag_weight * max(0.25, antag_effectiveness)

	snap.antag_effectiveness = antag_effectiveness
	snap.station_strength = station_strength
	snap.resource_strength = resource_strength
	snap.crew_health_index = crew_health_index
	snap.antag_activity_index = antag_activity_index
	snap.antag_inactive = inactive
	snap.antag_weak = weak

	// Ratio and overall tension
	snap.ratio = (snap.total_antag_weight) / max(1, snap.total_player_weight)
	snap.overall_tension = clamp((snap.ratio - 1.0) * 50 + 50, 0, 100)

	return snap

// Snapshot datum
/datum/storyteller_balance_snapshot
	var/total_player_weight = 0
	var/total_antag_weight = 0
	var/ratio = 1.0
	/// Antag effectiveness (0-1; based on health, wounds, activity, influence, etc.)
	var/antag_effectiveness = 1.0
	/// Station strength proxy (0-1; crew resilience, resources)
	var/station_strength = 1.0
	/// Overall tension (0-100; derived from ratio for mood/planner use)
	var/overall_tension = 50
	/// Resource strength (0-1)
	var/resource_strength = 0
	/// Crew health index (0-1, 1 is worst)
	var/crew_health_index = 0
	/// Antag activity index (0-1)
	var/antag_activity_index = 0
	/// Flags
	var/antag_inactive = FALSE
	var/antag_weak = FALSE
