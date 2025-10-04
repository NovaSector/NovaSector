/datum/storyteller_metric/antagonist_activity
	name = "Antagonist Activity Aggregation"

/datum/storyteller_metric/antagonist_activity/can_perform_now(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	return inputs.antag_count > 0

/datum/storyteller_metric/antagonist_activity/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	..()
	var/total_damage = 0
	var/total_activity = 0
	var/total_kills = 0
	var/total_objectives = 0
	var/total_disruption = 0
	var/total_influence = 0
	var/alive_antags = 0
	var/inactive_count = 0

	for(var/datum/mind/antag_mind as anything in GLOB.antagonists)
		if(!antag_mind.current || antag_mind.current.stat == DEAD)
			continue
		var/mob/living/L = antag_mind.current
		var/datum/component/antag_metric_tracker/tracker = L.GetComponent(/datum/component/antag_metric_tracker)
		if(!tracker)
			continue  // Skip if no tracker (latejoin fix: add on spawn)

		total_damage += tracker.damage_dealt
		total_activity += tracker.activity_time
		total_kills += tracker.kills
		total_objectives += tracker.objectives_completed
		total_disruption += tracker.disruption_score
		total_influence += tracker.influence_score
		alive_antags++

		// Inactivity heuristic: very low relative activity
		var/act_index = clamp(tracker.activity_time / max(1, world.time / STORY_ACTIVITY_TIME_SCALE), 0, 1)
		if(act_index < STORY_INACTIVITY_ACT_INDEX_THRESHOLD && tracker.kills <= 0 && tracker.objectives_completed <= 0)
			inactive_count++

	if(alive_antags > 0)
		var/avg_damage = total_damage / alive_antags
		var/avg_activity = total_activity / max(1, world.time / STORY_ACTIVITY_TIME_SCALE)
		var/activity_score = (avg_damage / STORY_DAMAGE_SCALE) + (avg_activity * STORY_ACTIVITY_TIME_SCALE) + total_kills + (total_objectives * 2) + total_disruption / STORY_DISRUPTION_SCALE + total_influence / STORY_INFLUENCE_SCALE
		var/activity_level = clamp(activity_score / max(inputs.player_count * STORY_ACTIVITY_CREW_SCALE, 1), 0, 3)  // Scale to crew

		inputs.vault[STORY_VAULT_ANTAGONIST_ACTIVITY] = activity_level
		inputs.vault[STORY_VAULT_ANTAG_KILLS] = clamp(total_kills / max(inputs.player_count * 0.05, 1), 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_OBJECTIVES_COMPLETED] = clamp(total_objectives / min(alive_antags, STORY_OBJECTIVES_CAP), 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_DISRUPTION] = clamp(total_disruption / max(1, alive_antags), 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_INFLUENCE] = clamp(total_influence / max(1, alive_antags), 0, 3)
		var/dead_count = inputs.antag_count - alive_antags
		inputs.vault[STORY_VAULT_ANTAG_DEAD_RATIO] = clamp((dead_count / max(1, inputs.antag_count)) * 3, 0, 3)
		inputs.vault[STORY_VAULT_ANTAGONIST_PRESENCE] = clamp(alive_antags >= 4 ? 3 : (alive_antags >= 2 ? 2 : 1), 0, 3)
		inputs.vault[STORY_VAULT_ANTAG_INACTIVE_RATIO] = (inactive_count / alive_antags)
		log_storyteller_metrics("Antagonist metrics updated: alive=[alive_antags], inactive_ratio=[inputs.vault[STORY_VAULT_ANTAG_INACTIVE_RATIO]]")

	return
