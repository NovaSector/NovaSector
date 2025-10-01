// Balance subsystem for storyteller
// Analyzes antagonist quantity, effectiveness (e.g., health, activity from metrics), and ratio to station strength (e.g., crew resilience, resources).
// Inspired by RimWorld's threat adaptation: balances player/antag weights to prevent one-sided dominance, influencing goal selection (e.g., boost weak antags).
// Snapshot captures current state for planner use.

/datum/storyteller_balance
	var/datum/storyteller/owner

	/// Base weight per player (scales with crew health/resilience)
	var/player_weight = 1.0
	/// Base weight per antagonist (scales with antag effectiveness)
	var/antag_weight = 2.0
	/// Threshold for "weak antags" (e.g., if effectiveness < this, bias toward antag-boost goals)
	var/weak_antag_threshold = 0.5
	/// Station strength multiplier (e.g., high crew health/resources = higher value)
	var/station_strength_multiplier = 1.0

/datum/storyteller_balance/New(_owner)
	owner = _owner
	..()

// Create a snapshot of current balance state
// Analyzes inputs.vault for antag/crew metrics; placeholders for future expansions (e.g., antag kills, resource control).
/datum/storyteller_balance/proc/make_snapshot(datum/storyteller_inputs/inputs)
	var/datum/storyteller_balance_snapshot/snap = new()
	snap.total_player_weight = inputs.total_crew_count * player_weight * station_strength_multiplier  // Placeholder: Scale by crew health avg
	snap.total_antag_weight = inputs.total_antags_count * antag_weight  // Placeholder: Scale by antag effectiveness (e.g., avg antag health)

	// Analyze effectiveness (placeholder: based on antag health/wounding from vault)
	var/antag_effectiveness = 1.0
	if(inputs.total_antags_count > 0)
		var/avg_antag_health = inputs.vault[STORY_VAULT_ANTAG_HEALTH] / 3.0  // Normalize 0-3 to 0-1
		var/avg_antag_wounding = 3.0 - (inputs.vault[STORY_VAULT_ANTAG_WOUNDING] / 3.0)  // Invert: low wounds = high effectiveness
		antag_effectiveness = (avg_antag_health + avg_antag_wounding) / 2.0  // Average; future: add activity/deaths caused

	snap.antag_effectiveness = antag_effectiveness
	snap.station_strength = station_strength_multiplier * (inputs.vault[STORY_VAULT_CREW_HEALTH] / 3.0)  // Placeholder: Crew health as proxy for strength

	// Ratio: Antag power vs station (0-1; <0.5 = antags weak, >1.5 = antags dominant)
	snap.ratio = (snap.total_antag_weight * antag_effectiveness) / max(1, snap.total_player_weight * snap.station_strength)
	snap.overall_tension = clamp((snap.ratio - 1.0) * 50 + 50, 0, 100)  // 0-100 scale for planner

	return snap

// Snapshot datum
/datum/storyteller_balance_snapshot
	var/total_player_weight = 0
	var/total_antag_weight = 0
	var/ratio = 1.0
	/// Antag effectiveness (0-1; based on health, wounds, etc.)
	var/antag_effectiveness = 1.0
	/// Station strength proxy (0-1; crew resilience, resources)
	var/station_strength = 1.0
	/// Overall tension (0-100; derived from ratio for mood/planner use)
	var/overall_tension = 50
