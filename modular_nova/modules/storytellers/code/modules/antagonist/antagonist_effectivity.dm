/datum/antagonist/proc/get_effectivity()
	// Base effectiveness derived from tracker aggregation, normalized to 0..1
	var/datum/component/antag_metric_tracker/T = GetComponent(/datum/component/antag_metric_tracker)
	if(!T)
		return 0.5
	var/score = 0
	// Weights tuned for general case
	score += clamp(T.damage_dealt / 300, 0, 1) * 0.25
	score += clamp(T.activity_time / (world.time / 20), 0, 1) * 0.25
	score += clamp(T.kills / 3, 0, 1) * 0.15
	score += clamp(T.objectives_completed / 3, 0, 1) * 0.2
	score += clamp(T.disruption_score / 50, 0, 1) * 0.1
	score += clamp(T.influence_score / 50, 0, 1) * 0.05
	return clamp(score, 0, 1)

// Attach tracker when an antagonist is gained
/datum/antagonist/on_gain()
	. = ..()
	AddComponent(/datum/component/antag_metric_tracker)
	return .

// Detach tracker on removal
/datum/antagonist/on_removal()
	var/datum/component/antag_metric_tracker/T = GetComponent(/datum/component/antag_metric_tracker)
	if(T)
		qdel(T)
	return ..()


/datum/antagonist/traitor/get_effectivity()
	var/base = ..()
	var/total = base
	var/datum/uplink_handler/uplink = uplink_handler
	if(uplink)
		if(!uplink.has_progression)
			total *= 0.75
		else
/*
			// Reward spent TC and completed contracts
			var/tc_spent = uplink.tc_spent ? uplink.tc_spent : 0
			total = clamp(total + (tc_spent / 40) * 0.15, 0, 1)
*/
			return total
