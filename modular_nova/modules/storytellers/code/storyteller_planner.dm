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



// Main update_plan: Central control for goal execution and timeline advancement in event chain.
// Called every think tick; scans upcoming for fire-ready goals, executes (complete()), updates status,
// reschedules fails, cleans timeline. Returns list of fired goals for think() processing (adaptation/tags).
// No global/sub distinction — all goals uniform in chain; inspired by RimWorld's cycle firing with adaptive rescheduling.
/datum/storyteller_planner/proc/update_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	SHOULD_NOT_OVERRIDE(TRUE)

	var/list/fired_goals = list()
	var/current_time = world.time

	for(var/offset in get_upcoming_goals(10))
		var/list/entry = timeline[offset]
		var/datum/storyteller_goal/goal = entry[ENTRY_GOAL]

		if(current_time < offset)
			continue

		var/status = entry[ENTRY_STATUS] || STORY_GOAL_PENDING
		if(status != STORY_GOAL_PENDING)
			continue

		if(!goal.can_fire_now(inputs.vault, inputs, ctl))
			timeline -= offset
			try_plan_goal(goal, 5 MINUTES * (1 - goal.get_progress(inputs.vault, inputs, ctl)))  // Faster retry if high progress
			continue

		entry[ENTRY_STATUS] = STORY_GOAL_FIRING
		if(goal.complete(inputs.vault, inputs, ctl, round(ctl.threat_points * ctl.difficulty_multiplier * 100), inputs.station_value))
			fired_goals += goal
			entry[ENTRY_STATUS] = STORY_GOAL_COMPLETED
			message_admins("[span_notice("Storyteller fired goal: ")] [goal.name || goal.id].")
		else
			entry[ENTRY_STATUS] = STORY_GOAL_PENDING
			timeline -= offset
			var/replan_delay = 10 MINUTES * (1 - goal.get_progress(inputs.vault, inputs, ctl)) * ctl.mood.get_event_frequency_multiplier()
			try_plan_goal(goal, replan_delay)
			message_admins("[span_warning("Storyteller goal failed to fire: ")] [goal.name || goal.id] — rescheduling.")


	for(var/offset in timeline.Copy())
		var/list/entry = timeline[offset]
		if(entry[ENTRY_STATUS] in list(STORY_GOAL_COMPLETED, STORY_GOAL_FAILED))
			var/datum/storyteller_goal/clean_goal = entry[ENTRY_GOAL]
			timeline -= offset
			if(clean_goal)
				qdel(clean_goal)

	var/pending_count = 0
	for(var/offset in timeline)
		if(timeline[offset][ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++
	var/pop_changed = (inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] != round(ctl.population_factor * 20))  // TODO: refine threshold
	if(!length(timeline) || pending_count < 3 || current_time - last_recalc_time > recalc_interval || pop_changed)
		recalculate_plan(ctl, inputs, bal)
	last_recalc_time = current_time
	return fired_goals



// Recalculate the entire plan: Rebuild timeline from current state.
// Clears invalid/unavailable goals, ensures at least 3 pending events for continuous pacing.
// Dynamically generates chain of events (no global/sub distinction), throttled by recalc_interval.
// Triggers on major shifts (threat/adaptation) or emptiness; analyzes station for fresh tags.
// Ensures storyteller's event chain branches adaptively toward threat escalation.
/datum/storyteller_planner/proc/recalculate_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, duration = 30 MINUTES)
	var/pending_count = 0
	var/invalid_goals = 0
	for(var/offset in get_upcoming_goals(length(timeline)))
		var/list/entry = timeline[offset]
		var/datum/storyteller_goal/goal = entry[ENTRY_GOAL]
		if(!goal.is_available(inputs.vault, inputs, ctl) || !goal.can_fire_now(inputs.vault, inputs, ctl))
			invalid_goals++
			timeline -= offset
			qdel(goal)  // Cleanup instance
			continue
		if(entry[ENTRY_STATUS] == STORY_GOAL_PENDING)
			pending_count++

	var/needs_rebuild = (invalid_goals > 0 || pending_count < 3 || (world.time - last_recalc_time > recalc_interval))
	var/effective_threat = ctl.get_effective_threat()
	if(effective_threat > ctl.max_threat_scale * 0.7 || ctl.adaptation_factor > 0.5)
		needs_rebuild = TRUE

	if(!needs_rebuild)
		return timeline

	if(timeline && length(timeline) > 0)
		timeline = list()


	var/category = select_goal_category(ctl, bal)
	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)

	if(effective_threat > ctl.max_threat_scale * 0.7 && !(derived_tags & STORY_TAG_ESCALATION))
		derived_tags |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(derived_tags & STORY_TAG_DEESCALATION))
		derived_tags |= STORY_TAG_DEESCALATION

	var/target_count = max(3, STORY_BASE_SUBGOALS_COUNT)
	var/event_interval = ctl.get_event_interval()
	for(var/i = 1 to target_count)
		var/datum/storyteller_goal/new_goal = build_goal(ctl, inputs, bal, derived_tags, category)
		if(!new_goal)
			continue

		var/fire_offset = event_interval * i * ctl.mood.get_event_frequency_multiplier()
		if(ctl.can_trigger_event_at(world.time + fire_offset))
			if(try_plan_goal(new_goal, fire_offset))
				pending_count++
			else
				qdel(new_goal)

		ctl.threat_points += ctl.threat_growth_rate * ctl.mood.get_variance_multiplier()

	var/attempts = 0
	while(pending_count < 3)
		if(attempts > 3)
			break
		var/datum/storyteller_goal/fallback = build_goal(ctl, inputs, bal, 0, STORY_GOAL_RANDOM)
		if(fallback && try_plan_goal(fallback, event_interval * pending_count))
			pending_count++
		attempts++
	last_recalc_time = world.time
	log_storyteller_planner("Storyteller recalculated plan: [pending_count] pending events in chain, [invalid_goals] invalids cleared.")
	return timeline





// Build initial timeline on round start: Generates chain of 3+ events as adaptive threat sequence.
// Analyzes station (bal/inputs) for category/tags, biases by threat/adaptation for escalation start.
// No current_goal dependency; schedules with dynamic offsets based on mood/pace.
// Ensures buffer for branching sub-threats, fallback to random for continuity.
/datum/storyteller_planner/proc/build_timeline(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, derived_tags)
	timeline = list()
	var/event_interval = ctl.get_event_interval()

	var/category = select_goal_category(ctl, bal)
	var/tags = derived_tags || derive_universal_tags(category, ctl, inputs, bal)


	var/effective_threat = ctl.get_effective_threat()
	if(effective_threat > ctl.max_threat_scale * 0.7 && !(derived_tags & STORY_TAG_ESCALATION))
		tags |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(derived_tags & STORY_TAG_DEESCALATION))
		tags |= STORY_TAG_DEESCALATION

	if(SSstorytellers.hard_debug)
		var/string_tags = ""
		for(var/tag_str in get_valid_bitflags("story_universal_tags"))
			if(tags & get_valid_bitflags("story_universal_tags")[tag_str])
				string_tags += "[tag_str], "
		message_admins("Storyteller [ctl.name] built initial timeline with category: [bitfield_to_list(category)], tags: [string_tags]")


	var/pending_count = 0
	var/target_count = max(3, STORY_BASE_SUBGOALS_COUNT)
	for(var/i = 1 to target_count)
		var/datum/storyteller_goal/new_goal = build_goal(ctl, inputs, bal, tags, category)
		if(!new_goal)
			continue

		var/fire_offset = event_interval * i * ctl.mood.get_event_frequency_multiplier()
		if(new_goal.tags & STORY_TAG_ESCALATION)
			fire_offset *= 0.8  // Accelerate 20% for high-threat branches
		else if(new_goal.tags & STORY_TAG_DEESCALATION)
			fire_offset *= 1.2  // Slow for adaptation phases

		if(!new_goal.is_available(inputs.vault, inputs, ctl) || !new_goal.can_fire_now(inputs.vault, inputs, ctl))
			qdel(new_goal)
			continue

		if(!ctl.can_trigger_event_at(world.time + fire_offset))
			fire_offset += ctl.grace_period
			if(!ctl.can_trigger_event_at(world.time + fire_offset))
				qdel(new_goal)
				continue

		if(try_plan_goal(new_goal, fire_offset))
			pending_count++
		else
			qdel(new_goal)

		ctl.threat_points += ctl.threat_growth_rate * ctl.mood.get_variance_multiplier()

	var/attempts = 0
	while(pending_count < 3)
		if(attempts > 3)
			break

		var/fallback_category = STORY_GOAL_RANDOM
		var/datum/storyteller_goal/fallback = build_goal(ctl, inputs, bal, 0, fallback_category)
		if(fallback && try_plan_goal(fallback, event_interval * pending_count))
			pending_count++
			ctl.threat_points += ctl.threat_growth_rate * 0.5
		attempts++

	timeline = sortTim(timeline, GLOBAL_PROC_REF(cmp_numeric_asc))
	last_recalc_time = world.time
	log_storyteller_planner("Storyteller built initial timeline: [pending_count] events chained, threat=[effective_threat].")
	return timeline



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


/datum/storyteller_planner/proc/build_goal(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/category = select_goal_category(ctl, bal)
	var/effective_threat = ctl.get_effective_pace()
	var/tag_filter = derive_universal_tags(category, ctl, inputs, bal)
	if(effective_threat > ctl.max_threat_scale * 0.7 && !(tag_filter & STORY_TAG_ESCALATION))
		tag_filter |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5 && !(tag_filter & STORY_TAG_DEESCALATION))
		tag_filter |= STORY_TAG_DEESCALATION
	var/list/candidates = SSstorytellers.filter_goals(category, tag_filter, null, FALSE)
	if(!candidates.len)
		candidates = SSstorytellers.filter_goals(STORY_GOAL_RANDOM)
	var/datum/storyteller_goal/goal = ctl.mind.select_weighted_goal(ctl, inputs, bal, candidates, ctl.population_factor)
	return goal


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

	current_goal = ctl.mind.select_weighted_goal(ctl, inputs, bal, candidates, ctl.population_factor)
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
		var/sub = owner.mind.select_weighted_goal(owner, owner.inputs, owner.balancer.make_snapshot(), candidates)
		if(sub)
			generated += sub
	return generated


/datum/storyteller_planner/proc/derive_universal_tags(category, datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/tags = ctl.mind.tokenize(category, ctl, inputs, bal, ctl.mood)
	if(SSstorytellers.hard_debug)
		var/string_tags = ""
		for(var/tag_str in get_valid_bitflags("story_universal_tags"))
			if(tags & get_valid_bitflags("story_universal_tags")[tag_str])
				string_tags += tag_str + ", "
		message_admins("Storyteller [ctl.name] tokenize station snapshot with next tags: [string_tags]")
	return tags


/datum/storyteller_planner/proc/select_goal_category(datum/storyteller/ctl, datum/storyteller_balance_snapshot/bal)
	var/category = ctl.mind.determine_category(ctl, bal)

	if(SSstorytellers.hard_debug)
		var/string_tags = ""
		for(var/tag_str in get_valid_bitflags("story_goal_category"))
			if(category & get_valid_bitflags("story_goal_category")[tag_str])
				string_tags += tag_str + ", "
		message_admins("Storyteller [ctl.name] determinete goal category: [string_tags]")
	return category

#undef ENTRY_GOAL
#undef ENTRY_FIRE_TIME
#undef ENTRY_CATEGORY
#undef ENTRY_STATUS
