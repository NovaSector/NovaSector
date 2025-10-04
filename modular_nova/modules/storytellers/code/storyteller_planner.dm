// Planner subsystem for storyteller
// Manages global goals, subgoals, and timeline-based execution.
// Central hub: update_plan() called every think tick to advance timeline, fire ready goals, and recalculate as needed.
// Inspired by RimWorld's adaptive cycles: Plans sequenced events with timing based on mood/pace, adaptation/grace periods,
// and balance; dynamically adjusts for station changes (e.g., recalculate on major metric shifts).


#define ENTRY_GOAL "goal"
#define ENTRY_FIRE_TIME "fire_time"
#define ENTRY_CATEGORY "category"
#define ENTRY_STATUS "status"


/datum/storyteller_planner
	// Our owner
	var/datum/storyteller/owner
	/// Current global goal instance
	var/datum/storyteller_goal/current_goal
	/// List of active subgoals (instances or IDs)
	var/list/subgoals = list()
	/// Timeline plan: Assoc list of world.time offsets -> list(goal_instance, category, status="pending|firing|completed")
	var/list/timeline = list()
	/// Last recalculation time; throttle to avoid spam
	var/last_recalc_time = 0
	/// Recalc frequency
	var/recalc_interval = STORY_RECALC_INTERVAL




/datum/storyteller_planner/New(datum/storyteller/_owner)
	..()
	owner = _owner



// Main update_plan: Central control for goal execution and timeline advancement.
// Called every think tick; checks timeline for fire-ready goals, executes them, updates progress,
// and triggers recalc if needed (e.g., major changes or interval hit).
// Returns list of fired goals for logging/feedback.
/datum/storyteller_planner/proc/update_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	SHOULD_NOT_OVERRIDE(TRUE)

	var/list/fired_goals = list()
	var/current_time = world.time

	for(var/offset in get_upcoming_goals(length(timeline)))
		if(current_time < offset)
			continue

		var/entry = timeline[offset]
		var/datum/storyteller_goal/goal = entry[1]
		var/status = entry[ENTRY_STATUS] || STORY_GOAL_PENDING
		if(status != STORY_GOAL_PENDING)
			continue

		// Check if goal can fire now (uses vault/inputs for context)
		if(!goal.can_fire_now(inputs.vault, inputs, ctl))
			timeline -= offset
			try_plan_goal(entry[ENTRY_GOAL], ctl.next_think_time) //We try to fire again on next think time
			continue

		entry[ENTRY_STATUS] = STORY_GOAL_FIRING
		if(goal.trigger_event(inputs.vault, inputs, ctl, round(ctl.threat_points * ctl.difficulty_multiplier * 100), inputs.station_value))
			fired_goals += goal
			entry[ENTRY_STATUS] = STORY_GOAL_COMPLETED
			ctl.recent_events |= goal.id
			// Update adaptation if damage event (placeholder: check tags)
			if(goal.tags & STORY_TAG_ESCALATION)
				ctl.adaptation_factor = min(1.0, ctl.adaptation_factor + 0.2)  // Increase adaptation post-threat
			ctl.time_since_last_event = current_time
			// Progress global if subgoal
			if(goal != current_goal)
				ctl.global_goal_progress += 0.2
			message_admins("[span_notice("Storyteller fired goal: ")] [goal.name || goal.id].")
		else
			entry[ENTRY_STATUS] = STORY_GOAL_FAILED
			message_admins("[span_warning("Storyteller goal failed to fire: ")] [goal.name || goal.id]")


	// Clean completed/failed from timeline
	for(var/offset in timeline.Copy())
		var/entry = timeline[offset]
		if(entry[ENTRY_STATUS] in list(STORY_GOAL_COMPLETED, STORY_GOAL_FAILED))
			timeline -= offset

	// TODO: add recalculating aftet changing populcation factor
	// Something like inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] != ctl.population_factor * 20
	if(!length(timeline) || current_time - last_recalc_time > recalc_interval)
		recalculate_plan(ctl, inputs, bal)
	last_recalc_time = current_time
	return fired_goals



// Recalculate the entire plan: Rebuild timeline from current state.
// Clears old timeline, picks new global if needed, generates subgoals, and schedules.
// Throttled by recalc_interval to avoid spam.
/datum/storyteller_planner/proc/recalculate_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, duration = 30 MINUTES)
	if(!timeline)
		return build_timeline(ctl, inputs, bal, duration = 30 MINUTES)

	if(!current_goal || !current_goal.is_available(inputs.vault, inputs, ctl))
		var/datum/storyteller_goal/new_goal = pick_new_global_goal(ctl, inputs, bal)
		try_plan_goal(new_goal, ctl.get_event_interval() * ctl.grace_period MINUTES)

	if(!current_goal)
		return list()

	var/new_sub_goals = 0
	for(var/offset in get_upcoming_goals(length(timeline)))
		var/list/entry = timeline[offset]
		if(entry[ENTRY_CATEGORY] & STORY_GOAL_GLOBAL)
			continue

		var/datum/storyteller_goal/goal = entry[ENTRY_GOAL]
		if(!goal.is_available(inputs.vault, inputs, ctl))
			new_sub_goals += 1
			timeline -= offset
			qdel(entry)


	if(new_sub_goals != 0)
		var/category = current_goal.category
		category = category & ~STORY_GOAL_GLOBAL

		var/new_tags = derive_universal_tags(category, ctl, inputs, bal)
		var/count = min(STORY_BASE_SUBGOALS_COUNT, new_sub_goals * ctl.mood.get_event_frequency_multiplier())
		var/list/subgoals = generate_subgoals(current_goal, new_tags, category, count)

		for(var/i = 1 to length(subgoals))
			var/fire_offset = ctl.get_event_interval() * i * ctl.mood.get_event_frequency_multiplier()
			if(!ctl.can_trigger_event_at(fire_offset))
				continue
			try_plan_goal(subgoals[i], fire_offset MINUTES)

	ctl.threat_points += ctl.threat_growth_rate * ctl.mood.get_variance_multiplier()
	log_storyteller_planner("Storyteller recalculated plan: [length(timeline)] events rescheduled.")
	return timeline





// Build timeline from global/subgoals: Schedules events with offsets based on mood, adaptation, threat.
/datum/storyteller_planner/proc/build_timeline(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, derived_tags, duration = 30 MINUTES)
	var/list/timeline_plan = list()
	var/event_interval = ctl.get_event_interval()

	// Add global goal at now (if not already)
	if(!current_goal)
		var/datum/storyteller_goal/new_goal = pick_new_global_goal(ctl, inputs, bal)
		try_plan_goal(new_goal, duration)

	var/category = current_goal.category
	category = category & ~STORY_GOAL_GLOBAL


	var/tags = derive_universal_tags(category, ctl, inputs, bal)
	// 3-4 goals at start
	var/num_subgoals = min(STORY_BASE_SUBGOALS_COUNT, round(duration / event_interval))
	var/list/subgoals = generate_subgoals(current_goal, tags, category, num_subgoals)

	for(var/i in 1 to num_subgoals)
		var/fire_offset = num_subgoals * i
		if(ctl.can_trigger_event_at(fire_offset))
			continue
		var/datum/storyteller_goal/sg = subgoals[i]
		if(!sg)
			continue
		if(sg.tags & STORY_TAG_ESCALATION)
			fire_offset -= (event_interval * 0.2)
		try_plan_goal(sg, fire_offset MINUTES)

	return sortTim(timeline_plan, GLOBAL_PROC_REF(cmp_numeric_asc))



/datum/storyteller_planner/proc/try_plan_goal(datum/storyteller_goal/goal, time)
	if(!goal)
		return FALSE

	var/list/timeline_plan = timeline
	var/target_time = world.time + time

	if(timeline_plan[target_time])
		return try_plan_goal(goal, time + 1 MINUTES)

	timeline_plan[target_time] = list(
		ENTRY_GOAL = goal,
		ENTRY_FIRE_TIME = target_time,
		ENTRY_CATEGORY = goal.category,
		ENTRY_STATUS = STORY_GOAL_PENDING
	)
	return TRUE


// Get upcoming events: Returns list of {goal, fire_time, category, status} for next N events (default 5).
// Used for preview/debugging in admin tools or logs.
/datum/storyteller_planner/proc/get_upcoming_goals(limit = 5)
	var/list/upcoming = list()
	var/current_time = world.time
	var/count = 0
	for(var/offset in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_numeric_asc)))
		if(current_time >= offset || count >= limit)
			continue
		var/entry = timeline[offset]
		upcoming += list(list(
			"goal" = entry[ENTRY_GOAL],
			"fire_time" = offset,
			"category" = entry[ENTRY_CATEGORY],
			"status" = entry[ENTRY_STATUS]
		))
		count++
	return upcoming


/datum/storyteller_planner/proc/get_closest_goal()
	for(var/offset in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_numeric_asc)))
		if(world.time >= offset)
			continue
		var/entry = timeline[offset]
		return entry[ENTRY_GOAL]


/datum/storyteller_planner/proc/get_goals_in_time(time = 1 MINUTES)
	var/list/upcoming = list()
	var/current_time = world.time
	for(var/i = current_time to current_time + time)
		if(timeline[i])
			upcoming += timeline[i]
	return upcoming


// Pick a new global goal at round start or on completion
// Integrates category selection, tag derivation, and weighting with adaptation/threat.
/datum/storyteller_planner/proc/pick_new_global_goal(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/base_category = select_goal_category(ctl, bal)
	var/category = base_category | STORY_GOAL_GLOBAL  // Ensure global flag

	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)
	var/effective_threat = ctl.threat_points * ctl.mood.get_threat_multiplier() * ctl.difficulty_multiplier

	// Bias tag filter by threat/adaptation
	var/tag_filter = derived_tags
	if(effective_threat > ctl.max_threat_scale * 0.7)
		tag_filter |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5)
		tag_filter |= STORY_TAG_DEESCALATION

	var/list/candidates = SSstorytellers.filter_goals(base_category, tag_filter, null, FALSE)
	if(!candidates.len)
		candidates = SSstorytellers.filter_goals(base_category)

	current_goal = select_weighted_goal(ctl, inputs, bal, candidates, ctl.population_factor)
	return current_goal


// Generate subgoals as branches toward global goal, using children or filtered new ones.
// Scales count by mood pace; biases by tags for fit.
/datum/storyteller_planner/proc/generate_subgoals(datum/storyteller_goal/global_goal, derived_tags, initial_category, count = 1)
	var/list/generated = list()

	var/category = initial_category
	if(!initial_category)
		category = global_goal.category
		category = category & ~STORY_GOAL_GLOBAL

	if(!category)
		stack_trace("Storyteller tries selected goal without category or global goal has no category")
		category = STORY_GOAL_RANDOM

	var/list/candidates = SSstorytellers.filter_goals(category, derived_tags & ~(STORY_TAG_AFFECTS_WHOLE_STATION), null, FALSE)
	var/num_subs = round(STORY_BASE_SUBGOALS_COUNT * owner.mood.get_event_frequency_multiplier())
	for(var/i in 1 to min(num_subs, candidates.len))
		var/sub = select_weighted_goal(owner, owner.inputs, owner.balancer.make_snapshot(), candidates)
		if(sub)
			generated += sub
	return generated



// Basic select_weighted_goal with integration to goal procs
// Computes final weight using G.get_weight (which can access vault/inputs for custom logic),
// then applies storyteller vars (difficulty, adaptation, repetition) for adaptation.
// Inspired by RimWorld's event weighting: base chance + modifiers from colony state (here, station metrics).
/datum/storyteller_planner/proc/select_weighted_goal(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, list/candidates, population_scale = 1.0)
	if(!candidates.len)
		return null

	var/list/weighted = list()
	for(var/datum/storyteller_goal/G in candidates)
		var/base_weight = G.get_weight(inputs.vault, inputs, ctl)
		var/priority_boost = G.get_priority(inputs.vault, inputs, ctl) * 0.5  // Scale to avoid dominance
		var/diff_adjust = ctl.difficulty_multiplier * population_scale

		// Repetition penalty if goal similar to prevents spam
		var/rep_penalty = 0
		if(G.id in ctl.recent_events)
			rep_penalty = ctl.repetition_penalty

		// Threat/adaptation influence: Boost aggressive/escalation if threat high, reduce if adapted (post-damage grace)
		var/threat_bonus = ctl.threat_points * ctl.mood.get_threat_multiplier() * STORY_PICK_THREAT_BONUS_SCALE  // Small scaling for gradual escalation
		var/adapt_reduce = 1.0 - ctl.adaptation_factor

		// Balance tension: If tension high, boost deescalation goals; low -> escalation
		var/balance_bonus = 0
		if(bal.overall_tension > ctl.target_tension && (G.tags & STORY_TAG_DEESCALATION))
			balance_bonus += STORY_BALANCE_BONUS
		else if(bal.overall_tension < ctl.target_tension && (G.tags & STORY_TAG_ESCALATION))
			balance_bonus += STORY_BALANCE_BONUS

		// Final weight: Combine all, ensure minimum to avoid zero-weight goals
		var/final_weight = max(0.1, (base_weight + priority_boost + threat_bonus + balance_bonus - rep_penalty) * diff_adjust * adapt_reduce)
		weighted[G] = final_weight

	// Use pick_weighted helper for selection
	return pick_weight(weighted)




// Derive universal tags, incorporating balancer snapshot for antag/station dynamics
// Builds hierarchy: Base from metrics (influenced by category for bias), mid from aggregation, high from balance implications.
// Category biases derivation: e.g., GOAL_BAD favors ESCALATION/AFFECTS_CREW_HEALTH harm; GOAL_GOOD favors DEESCALATION/recovery.
/datum/storyteller_planner/proc/derive_universal_tags(category, datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	return ctl.mind.tokenize(category, ctl, inputs, bal, ctl.mood)



// Method to select goal category (GOOD/BAD) based on storyteller state
// Uses mood (aggression/pace), balance tension, adaptation_factor, and threat_points.
// E.g., high tension/adaptation -> BAD (escalation); low threat/relaxed mood -> GOOD (recovery).
// Called in planner before filtering goals, to bias directionality (STORY_GOAL_GOOD/GOAL_BAD).
/datum/storyteller_planner/proc/select_goal_category(datum/storyteller/ctl, datum/storyteller_balance_snapshot/bal)
	return ctl.mind.determine_category(ctl, bal)

#undef ENTRY_GOAL
#undef ENTRY_FIRE_TIME
#undef ENTRY_CATEGORY
#undef ENTRY_STATUS
