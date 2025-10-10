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
	var/datum/storyteller_balance_snapshot/snap = new

	// Normalize counts
	var/crew_count = max(0, inputs.player_count)
	var/antag_count = max(0, inputs.antag_count)

	// Crew health proxy (0 healthy -> 1 worst). Vault uses 0..3 where 3 is worst
	var/crew_health_level = inputs.vault[STORY_VAULT_CREW_HEALTH] || STORY_VAULT_HEALTH_HEALTHY
	var/crew_health_index = clamp(crew_health_level / 3.0, 0, 1)

	// New: Crew morale and readiness (invert for strength)
	var/crew_morale_level = inputs.vault[STORY_VAULT_CREW_MORALE] || STORY_VAULT_HIGH_MORALE
	var/crew_morale_index = clamp(1 - (crew_morale_level / 3.0), 0, 1)  // High morale -> high index
	var/crew_readiness_level = inputs.vault[STORY_VAULT_CREW_READINESS] || STORY_VAULT_UNPREPARED
	var/crew_readiness_index = clamp(crew_readiness_level / 3.0, 0, 1)  // Higher level -> higher index

	// Station resource proxy
	var/resource_minerals = inputs.vault[STORY_VAULT_RESOURCE_MINERALS] || 0
	var/resource_other = inputs.vault[STORY_VAULT_RESOURCE_OTHER] || 0
	var/total_resources = max(0, resource_minerals + resource_other)
	var/resource_strength = clamp(log(1 + total_resources) / 10, 0, 1)
	resource_strength *= (crew_morale_index * 0.5 + crew_readiness_index * 0.5)  // Morale/readiness affect resource efficiency

	// Crew resilience proxy from wounds/deaths/diseases (invert to strength)
	var/crew_wound_level = inputs.vault[STORY_VAULT_CREW_WOUNDING] || STORY_VAULT_NO_WOUNDS
	var/crew_dead_ratio_level = inputs.vault[STORY_VAULT_CREW_DEAD_RATIO] || STORY_VAULT_LOW_DEAD_RATIO
	var/crew_disease_level = inputs.vault[STORY_VAULT_CREW_DISEASES] || STORY_VAULT_NO_DISEASES
	var/crew_resilience = clamp(1 - ((crew_wound_level + crew_dead_ratio_level + crew_disease_level) / 9.0), 0, 1)

	// New: Infrastructure and env hazards (invert for strength)
	var/infra_damage_level = inputs.vault[STORY_VAULT_INFRA_DAMAGE] || STORY_VAULT_NO_DAMAGE
	var/env_hazards_level = inputs.vault[STORY_VAULT_ENV_HAZARDS] || STORY_VAULT_NO_HAZARDS
	var/infra_strength = clamp(1 - ((infra_damage_level + env_hazards_level) / 6.0), 0, 1)

	// New: Security proxy
	var/security_strength_level = inputs.vault[STORY_VAULT_SECURITY_STRENGTH] || STORY_VAULT_WEAK_SECURITY
	var/security_alert_level = inputs.vault[STORY_VAULT_SECURITY_ALERT] || STORY_VAULT_GREEN_ALERT
	var/security_index = clamp((security_strength_level / 3.0) * (1 - (security_alert_level / 3.0)), 0, 1)  // Strong/low alert -> high

	// Aggregate station strength (expanded weights)
	var/station_strength = clamp( \
		(1 - crew_health_index) * 0.3 + \
		crew_resilience * 0.2 + \
		resource_strength * 0.15 + \
		infra_strength * 0.15 + \
		security_index * 0.15 + \
		crew_readiness_index * 0.05, \
		0, 1)
	station_strength *= station_strength_multiplier

	// Antagonist effectiveness/activity from vault (0..3 -> normalize 0..1)
	var/antag_activity_level = inputs.vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || STORY_VAULT_NO_ACTIVITY
	var/antag_activity_index = clamp(antag_activity_level / 3.0, 0, 1)

	var/antag_influence_level = inputs.vault[STORY_VAULT_ANTAG_INFLUENCE] || STORY_VAULT_LOW_INFLUENCE
	var/antag_disruption_level = inputs.vault[STORY_VAULT_ANTAG_DISRUPTION] || STORY_VAULT_NO_DISRUPTION
	var/antag_kills_level = inputs.vault[STORY_VAULT_ANTAG_KILLS] || STORY_VAULT_NO_KILLS
	var/antag_objectives_level = inputs.vault[STORY_VAULT_ANTAG_OBJECTIVES_COMPLETED] || STORY_VAULT_NO_OBJECTIVES

	// New: Additional antag metrics
	var/antag_intensity_level = inputs.vault[STORY_VAULT_ANTAG_INTENSITY] || STORY_VAULT_LOW_INTENSITY
	var/antag_teamwork_level = inputs.vault[STORY_VAULT_ANTAG_TEAMWORK] || STORY_VAULT_NO_TEAMWORK
	var/antag_stealth_level = inputs.vault[STORY_VAULT_ANTAG_STEALTH] || STORY_VAULT_NO_STEALTH
	var/antag_escalation_level = inputs.vault[STORY_VAULT_THREAT_ESCALATION] || STORY_VAULT_SLOW_ESCALATION
	var/major_threat = inputs.vault[STORY_VAULT_MAJOR_THREAT] || "none"

	var/antag_effectiveness = clamp( \
		(antag_activity_index * 0.3) + \
		(antag_influence_level / 3.0) * 0.15 + \
		(antag_disruption_level / 3.0) * 0.1 + \
		(antag_kills_level / 3.0) * 0.1 + \
		(antag_objectives_level / 3.0) * 0.1 + \
		(antag_intensity_level / 3.0) * 0.15 +  \
		(antag_teamwork_level / 3.0) * 0.1 +   \
		(antag_stealth_level / 3.0) * 0.05 +  \
		(antag_escalation_level / 3.0) * 0.05, \
		0, 1
	)
	if(major_threat != "none")
		antag_effectiveness = min(1, antag_effectiveness + 0.2)  // Dominant threat bonus

	// Determine weak/inactive antags + new flags
	var/antag_inactive_ratio = inputs.vault[STORY_VAULT_ANTAG_INACTIVE_RATIO] || 0
	var/inactive = (antag_inactive_ratio >= 0.5) || (antag_activity_index < inactive_activity_threshold)
	var/weak = antag_effectiveness < weak_antag_threshold
	var/coordinated = antag_teamwork_level >= STORY_VAULT_MODERATE_TEAMWORK
	var/stealthy = antag_stealth_level >= STORY_VAULT_MODERATE_STEALTH
	var/station_vulnerable = (infra_damage_level >= STORY_VAULT_MAJOR_DAMAGE) || (env_hazards_level >= STORY_VAULT_MAJOR_HAZARDS) || (crew_readiness_level <= STORY_VAULT_BASIC_READY)

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
	snap.antag_coordinated = coordinated
	snap.antag_stealthy = stealthy
	snap.station_vulnerable = station_vulnerable

	snap.ratio = snap.total_antag_weight / max(1, snap.total_player_weight)
	if(stealthy)
		snap.ratio *= 1.2  // Hidden threats feel stronger
	if(coordinated)
		snap.ratio *= 1.1  // Teamwork multiplies impact
	if(station_vulnerable)
		snap.ratio *= 1.15  // Vulnerable station tips balance to antags

	snap.overall_tension = clamp((snap.ratio - 1.0) * 50 + 50 + (antag_escalation_level * 10), 0, 100)

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
	var/antag_coordinated
	var/antag_stealthy
	var/station_vulnerable
	/// Flags
	var/antag_inactive = FALSE
	var/antag_weak = FALSE
