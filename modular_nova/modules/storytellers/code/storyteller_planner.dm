// Planner subsystem for storyteller
// Manages global goals, subgoals, and timeline-based execution.
// Central hub: update_plan() called every think tick to advance timeline, fire ready goals, and recalculate as needed.
// Inspired by RimWorld's adaptive cycles: Plans sequenced events with timing based on mood/pace, adaptation/grace periods,
// and balance; dynamically adjusts for station changes (e.g., recalculate on major metric shifts).


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
	/// Recalc frequency (scaled by pace; default 5 mins)
	var/recalc_interval = 5 MINUTES




/datum/storyteller_planner/New(datum/storyteller/_owner)
	..()
	owner = _owner



// Main update_plan: Central control for goal execution and timeline advancement.
// Called every think tick; checks timeline for fire-ready goals, executes them, updates progress,
// and triggers recalc if needed (e.g., major changes or interval hit).
// Returns list of fired goals for logging/feedback.
/datum/storyteller_planner/proc/update_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/list/fired_goals = list()
	var/current_time = world.time


	var/list/pending_offsets = timeline.Copy()
	for(var/offset in pending_offsets)
		var/entry = timeline[offset]
		var/datum/storyteller_goal/goal = entry[1]
		var/status = entry[3] || STORY_GOAL_PENDING
		if(status != STORY_GOAL_PENDING || current_time < offset)
			continue

		// Check if goal can fire now (uses vault/inputs for context)
		if(!goal.can_fire_now(inputs.vault, inputs, ctl))
			continue

		entry[3] = STORY_GOAL_FIRING
		if(goal.trigger_event())
			fired_goals += goal
			entry[3] = STORY_GOAL_COMPLETED
			ctl.recent_events |= goal.id
			// Update adaptation if damage event (placeholder: check tags)
			if(goal.tags & STORY_TAG_ESCALATION)
				ctl.adaptation_factor = min(1.0, ctl.adaptation_factor + 0.2)  // Increase adaptation post-threat
			ctl.time_since_last_event = current_time
			// Progress global if subgoal
			if(goal != current_goal)
				ctl.global_goal_progress += 0.2
		else
			entry[3] = STORY_GOAL_FAILED

	// Clean completed/failed from timeline
	for(var/offset in timeline.Copy())
		var/entry = timeline[offset]
		if(entry[10] in list(STORY_GOAL_COMPLETED, STORY_GOAL_FAILED))
			timeline -= offset


	if(!length(timeline) || current_time - last_recalc_time > recalc_interval \
			|| inputs.vault[STORY_VAULT_CREW_ALIVE_COUNT] != ctl.population_factor * 20)
		recalculate_plan(ctl, inputs, bal)

	last_recalc_time = current_time
	return fired_goals



// Recalculate the entire plan: Rebuild timeline from current state.
// Clears old timeline, picks new global if needed, generates subgoals, and schedules.
// Throttled by recalc_interval to avoid spam.
/datum/storyteller_planner/proc/recalculate_plan(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, duration = 30 MINUTES)
	timeline.Cut()  // Clear old plan
	subgoals.Cut()


	if(!current_goal || !current_goal.is_available(inputs.vault, inputs, ctl))
		pick_new_global_goal(ctl, inputs, bal)

	if(!current_goal)
		return list()

	// Generate subgoals and build timeline
	var/derived_tags = derive_universal_tags(current_goal.category, ctl, inputs, bal)
	subgoals = generate_subgoals(current_goal, derived_tags)
	var/list/new_timeline = build_timeline(ctl, inputs, bal, derived_tags, duration)
	timeline += new_timeline

	log_storyteller("Storyteller recalculated plan: [length(timeline)] events scheduled.")
	return timeline



// Build timeline from global/subgoals: Schedules events with offsets based on mood, adaptation, threat.
/datum/storyteller_planner/proc/build_timeline(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, derived_tags, duration = 30 MINUTES)
	var/list/timeline_plan = list()
	var/current_time = world.time

	// Add global goal at now (if not already)
	if(current_goal && current_goal.can_fire_now(inputs.vault, inputs, ctl))
		timeline_plan[current_time] = list(current_goal, current_goal.category, STORY_GOAL_PENDING)

	// Schedule subgoals
	var/effective_pace = ctl.mood.get_event_frequency_multiplier() * (1.0 - ctl.adaptation_factor)
	var/event_interval = (ctl.min_event_interval + (ctl.max_event_interval - ctl.min_event_interval) / effective_pace) / ctl.population_factor
	var/num_events = min(length(subgoals), round(duration / event_interval))


	for(var/i in 1 to num_events)
		var/fire_offset = current_time + (event_interval * i)
		if(fire_offset - ctl.time_since_last_event < ctl.grace_period)
			continue  // Delay during grace

		var/subgoal = subgoals[i]
		var/datum/storyteller_goal/sg = istype(subgoal, /datum/storyteller_goal) ? subgoal : SSstorytellers.goals_by_id[subgoal]
		if(!sg)
			continue

		var/sub_category = select_goal_category(ctl, bal)
		if(sg.tags & STORY_TAG_ESCALATION && ctl.threat_points > ctl.max_threat_scale * 0.5)
			fire_offset -= (event_interval * 0.2)

		timeline_plan[fire_offset] = list(sg, sub_category, STORY_GOAL_PENDING)

	// Sort by time (ascending)
	return sortTim(timeline_plan, GLOBAL_PROC_REF(cmp_numeric_asc))



// Get upcoming events: Returns list of {goal, fire_time, category, status} for next N events (default 5).
// Used for preview/debugging in admin tools or logs.
/datum/storyteller_planner/proc/get_upcoming_events(limit = 5)
	var/list/upcoming = list()
	var/current_time = world.time
	var/count = 0
	for(var/offset in sortTim(timeline.Copy(), GLOBAL_PROC_REF(cmp_numeric_asc)))
		if(current_time >= offset || count >= limit)
			continue
		var/entry = timeline[offset]
		upcoming += list(list(
			"goal" = entry[1],
			"fire_time" = offset,
			"category" = entry[2],
			"status" = entry[3]
		))
		count++
	return upcoming




// Pick a new global goal at round start or on completion
// Integrates category selection, tag derivation, and weighting with adaptation/threat.
/datum/storyteller_planner/proc/pick_new_global_goal(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/base_category = select_goal_category(ctl, bal)
	var/category = base_category | STORY_GOAL_GLOBAL  // Ensure global flag

	var/derived_tags = derive_universal_tags(category, ctl, inputs, bal)
	var/effective_threat = ctl.threat_points * ctl.mood.get_threat_multiplier() * ctl.difficulty_multiplier
	var/adaptation_adjust = 1.0 - ctl.adaptation_factor

	// Bias tag filter by threat/adaptation
	var/tag_filter = derived_tags
	if(effective_threat > ctl.max_threat_scale * 0.7)
		tag_filter |= STORY_TAG_ESCALATION
	else if(ctl.adaptation_factor > 0.5)
		tag_filter |= STORY_TAG_DEESCALATION

	var/list/candidates = SSstorytellers.filter_goals(category, tag_filter, null, FALSE)
	if(!candidates.len)
		candidates = SSstorytellers.filter_goals(STORY_GOAL_RANDOM)

	current_goal = select_weighted_goal(ctl, inputs, bal, candidates, ctl.population_factor)

	if(world.time - ctl.time_since_last_event < ctl.grace_period)
		return current_goal  // Delay subgoals

	var/new_tags = derive_universal_tags(current_goal.category, ctl, inputs, bal)  // Refresh for subgoals
	subgoals = generate_subgoals(current_goal, new_tags)


	ctl.threat_points += ctl.threat_growth_rate * ctl.mood.get_variance_multiplier()
	ctl.adaptation_factor = max(0, ctl.adaptation_factor - ctl.adaptation_decay_rate)
	log_storyteller("Storyteller picked global goal [current_goal?.name || "None"]. Threat: [ctl.threat_points], Adaptation: [ctl.adaptation_factor]")
	return current_goal



// Generate subgoals as branches toward global goal, using children or filtered new ones.
// Scales count by mood pace; biases by tags for fit.
/datum/storyteller_planner/proc/generate_subgoals(datum/storyteller_goal/global_goal, derived_tags)
	var/list/generated = list()

	var/list/children_goals = global_goal.get_children()
	if(children_goals.len)
		generated += children_goals
	else
		var/list/candidates = SSstorytellers.filter_goals(null, derived_tags & ~(STORY_TAG_AFFECTS_WHOLE_STATION), null, FALSE)
		var/num_subs = round(3 * owner.mood.get_event_frequency_multiplier())
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
		var/threat_bonus = ctl.threat_points * ctl.mood.get_threat_multiplier() * 0.01  // Small scaling for gradual escalation
		var/adapt_reduce = 1.0 - ctl.adaptation_factor

		// Balance tension: If tension high, boost deescalation goals; low -> escalation
		var/balance_bonus = 0
		if(bal.overall_tension > ctl.target_tension && (G.tags & STORY_TAG_DEESCALATION))
			balance_bonus += 1.5
		else if(bal.overall_tension < ctl.target_tension && (G.tags & STORY_TAG_ESCALATION))
			balance_bonus += 1.5

		// Final weight: Combine all, ensure minimum to avoid zero-weight goals
		var/final_weight = max(0.1, (base_weight + priority_boost + threat_bonus + balance_bonus - rep_penalty) * diff_adjust * adapt_reduce)
		weighted[G] = final_weight

	// Use pick_weighted helper for selection
	return pick_weight(weighted)



// Derive universal tags, incorporating balancer snapshot for antag/station dynamics
// Builds hierarchy: Base from metrics (influenced by category for bias), mid from aggregation, high from balance implications.
// Category biases derivation: e.g., GOAL_BAD favors ESCALATION/AFFECTS_CREW_HEALTH harm; GOAL_GOOD favors DEESCALATION/recovery.
/datum/storyteller_planner/proc/derive_universal_tags(category, datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal)
	var/tags = 0
	if(!category)
		category = STORY_GOAL_UNCATEGORIZED

	// Category bias: Influence base tag selection (e.g., BAD -> escalation/harm tags)
	var/category_bias = 1.0
	switch(category)
		if(STORY_GOAL_BAD)
			category_bias = 1.5
			tags |= STORY_TAG_ESCALATION
		if(STORY_GOAL_GOOD)
			category_bias = 1.5
			tags |= STORY_TAG_DEESCALATION
		if(STORY_GOAL_RANDOM)
			category_bias = 1.2
		if(STORY_GOAL_NEUTRAL)
			category_bias = 0.8

	if(category & STORY_GOAL_GLOBAL)
	tags |= STORY_TAG_AFFECTS_WHOLE_STATION

	// Step 1: Base Level - Direct from inputs.vault metrics, scaled by category bias
	var/crew_health = inputs.vault[STORY_VAULT_CREW_HEALTH]
	if(crew_health >= STORY_VAULT_HEALTH_DAMAGED)
		if(prob(70 * category_bias))
			tags |= STORY_TAG_AFFECTS_CREW_HEALTH

	var/crew_wounding = inputs.vault[STORY_VAULT_CREW_WOUNDING]
	if(crew_wounding >= STORY_VAULT_SOME_WOUNDED)
		if(prob(60 * category_bias))
			tags |= STORY_TAG_AFFECTS_CREW_HEALTH

	var/crew_diseases = inputs.vault[STORY_VAULT_CREW_DISEASES]
	if(crew_diseases >= STORY_VAULT_MINOR_DISEASES)
		if(prob(65 * category_bias))
			tags |= STORY_TAG_AFFECTS_CREW_HEALTH

	var/crew_dead_ratio = inputs.vault[STORY_VAULT_CREW_DEAD_RATIO]
	if(crew_dead_ratio >= STORY_VAULT_MODERATE_DEAD_RATIO)
		if(prob(75 * category_bias))
			tags |= STORY_TAG_AFFECTS_MORALE

	// Step 2: Mid Level - Aggregate for crises, incorporating bal for antag influence
	// Aggregation: If multiple base health/morale tags, add escalation/deescalation
	var/health_crisis = (tags & STORY_TAG_AFFECTS_CREW_HEALTH)
	var/morale_crisis = (tags & STORY_TAG_AFFECTS_MORALE)
	if(health_crisis || morale_crisis)
		if(category == STORY_GOAL_BAD || bal.overall_tension > ctl.target_tension)
			tags |= STORY_TAG_ESCALATION  // Aggregate to escalation in bad/high-tension states
		else
			tags |= STORY_TAG_DEESCALATION  // Otherwise, deescalate/recover

	// Deeper: Use bal snapshot for antag-station dynamics
	if(bal.antag_effectiveness < owner.balancer.weak_antag_threshold && bal.ratio < 0.8)
		if(prob(80 * category_bias))
			tags |= STORY_TAG_AFFECTS_ANTAGONIST
	if(bal.station_strength < 0.5)  // Low station strength
		if(prob(70 * category_bias))
			tags |= STORY_TAG_AFFECTS_RESOURCES | STORY_TAG_AFFECTS_INFRASTRUCTURE



	// Step 3: High Level - Narrative implications, biased by balance tension and category
	if(health_crisis)
		if(category == STORY_GOAL_GOOD || bal.overall_tension > ctl.target_tension)
			tags |= STORY_TAG_DEESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH
		else
			tags |= STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH
	if(morale_crisis)
		tags |= STORY_TAG_AFFECTS_MORALE | (category == STORY_GOAL_BAD ? STORY_TAG_ESCALATION : STORY_TAG_DEESCALATION)
	if(bal.ratio < 0.8)  // Weak antags
		tags |= STORY_TAG_AFFECTS_ANTAGONIST | STORY_TAG_DEESCALATION  // Boost to balance
	if(bal.overall_tension > owner.target_tension)
		tags |= STORY_TAG_DEESCALATION
	else if(bal.overall_tension < owner.target_tension * 0.7)
		tags |= STORY_TAG_ESCALATION


	// Additional influences based on category and potential vault entries (placeholders)
	if(category == STORY_GOAL_GLOBAL)
		tags |= STORY_TAG_AFFECTS_WHOLE_STATION
	if(inputs.vault["low_resources"])
		tags |= STORY_TAG_AFFECTS_ECONOMY | STORY_TAG_AFFECTS_RESOURCES
	if(category == STORY_GOAL_BAD && inputs.vault["research_progress"])
		tags |= STORY_TAG_AFFECTS_RESEARCH | STORY_TAG_AFFECTS_SECURITY



	// Volatility random: If high volatility
	// Randy Random likes it
	if(ctl.mood.volatility > 1.0)
		for(var/i = 0 to rand(1, 3))
			var/random_tag = get_random_bitflag("story_universal_tags")
			if(random_tag)
				tags |= random_tag

	return tags



// Method to select goal category (GOOD/BAD) based on storyteller state
// Uses mood (aggression/pace), balance tension, adaptation_factor, and threat_points.
// E.g., high tension/adaptation -> BAD (escalation); low threat/relaxed mood -> GOOD (recovery).
// Called in planner before filtering goals, to bias directionality (STORY_GOAL_GOOD/GOAL_BAD).
/datum/storyteller_planner/proc/select_goal_category(datum/storyteller/ctl, datum/storyteller_balance_snapshot/bal)
	var/category = STORY_GOAL_UNCATEGORIZED  // Default neutral

	// Mood influence: High aggression favors BAD; low pace favors GOOD
	var/mood_bias = ctl.mood.get_threat_multiplier() - ctl.mood.get_variance_multiplier()
	if(mood_bias > 1.2)  // Aggressive/volatile -> Negative
		category = STORY_GOAL_BAD
	else if(mood_bias < 0.8)  // Calm/slow -> Positive
		category = STORY_GOAL_GOOD



	// Balance/tension override: High tension -> Deescalate with GOOD; low -> Escalate with BAD
	if(bal.overall_tension > ctl.target_tension + 20)
		category = STORY_GOAL_GOOD  // Recovery to balance
	else if(bal.overall_tension < ctl.target_tension - 20)
		category = STORY_GOAL_BAD  // Challenge to build tension


	// Adaptation/threat check: Post-damage adaptation -> GOOD (grace); high threat -> BAD
	if(ctl.adaptation_factor > 0.3)
		category = STORY_GOAL_GOOD
	else if(ctl.threat_points > ctl.max_threat_scale * 0.6)
		category = STORY_GOAL_BAD


	// Final volatility random: If high volatility, 30% chance to flip for chaos
	// Hello mr. random!
	if(ctl.mood.get_variance_multiplier() > 1.5 && prob(30))
		category = (category == STORY_GOAL_GOOD) ? STORY_GOAL_BAD : STORY_GOAL_GOOD


	log_storyteller("Storyteller selected category [category] based on tension [bal.overall_tension], adaptation [ctl.adaptation_factor]")
	return category
