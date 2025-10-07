//Here's where is magic begin
#define CONTEXT_TAGS "tags"
#define CONTEXT_CATEGORY "category"
#define CONTEXT_BIAS "bias"
#define STORY_REPETITION_DECAY_TIME (20 MINUTES)

/datum/storyteller_think
	var/list/think_stages = list(
		/datum/think_stage/apply_category_bias,
		/datum/think_stage/base_health_tags,
		/datum/think_stage/base_antag_tags,
		/datum/think_stage/base_resource_tags,
		/datum/think_stage/mid_aggregation,
		/datum/think_stage/high_implications,
		/datum/think_stage/additional_influences,
		/datum/think_stage/volatility_random,
	)


/datum/storyteller_think/New()
	. = ..()
	for(var/i = 1 to length(think_stages))
		var/stage = think_stages[i]
		think_stages[i] = new stage



// Derive universal tags, incorporating balancer snapshot for antag/station dynamics
// Builds hierarchy: Base from metrics (influenced by category for bias), mid from aggregation, high from balance implications.
// Category biases derivation: e.g., GOAL_BAD favors ESCALATION/AFFECTS_CREW_HEALTH harm; GOAL_GOOD favors DEESCALATION/recovery.
/datum/storyteller_think/proc/tokenize( \
	category, \
	datum/storyteller/ctl, \
	datum/storyteller_inputs/inputs, \
	datum/storyteller_balance_snapshot/bal, \
	datum/storyteller_mood/mood)

	SHOULD_NOT_OVERRIDE(TRUE)
	if(!category)
		category = determine_category(ctl, bal)


	var/list/context = list(
		CONTEXT_TAGS = 0,
		CONTEXT_CATEGORY = 0,
		CONTEXT_BIAS = 1.0,
	)
	for(var/datum/think_stage/stage as anything in think_stages)
		stage.execute(ctl, inputs, bal, mood, context)
	return context[CONTEXT_TAGS]


// Method to select goal category (GOOD/BAD) based on storyteller state
// Uses mood (aggression/pace), balance tension, adaptation_factor, and threat_points.
// E.g., high tension/adaptation -> BAD (escalation); low threat/relaxed mood -> GOOD (recovery).
// Called in planner before filtering goals, to bias directionality (STORY_GOAL_GOOD/GOAL_BAD).
/datum/storyteller_think/proc/determine_category(datum/storyteller/ctl, datum/storyteller_balance_snapshot/bal)
	var/category = STORY_GOAL_UNCATEGORIZED  // Default neutral

	// Mood influence: High aggression favors BAD; low pace favors GOOD
	var/mood_bias = ctl.mood.get_threat_multiplier() - ctl.mood.get_variance_multiplier()
	if(mood_bias > 1.2)  // Aggressive/volatile -> Negative
		category = STORY_GOAL_BAD
	else if(mood_bias < 0.8)  // Calm/slow -> Positive
		category = STORY_GOAL_GOOD



	// Balance/tension override: High tension -> Deescalate with GOOD; low -> Escalate with BAD
	if(bal.overall_tension > ctl.target_tension + 10 * ctl.mood.get_threat_multiplier())
		category = STORY_GOAL_GOOD  // Recovery to balance
	else if(bal.overall_tension < ctl.target_tension - 10 * ctl.mood.get_threat_multiplier())
		category = STORY_GOAL_BAD  // Challenge to build tension


	// Adaptation/threat check: Post-damage adaptation -> GOOD (grace); high threat -> BAD
	if(ctl.adaptation_factor > 0.3)
		category = STORY_GOAL_GOOD
	else if(ctl.threat_points > ctl.max_threat_scale * 0.6)
		category = STORY_GOAL_BAD


	// Final volatility random: If high volatility, 30% chance to flip for chaos
	// Hello mr. random!
	if(ctl.mood.get_variance_multiplier() > 1.5)
		if(prob(round(30 * ctl.mood.get_threat_multiplier())))
			category = (category == STORY_GOAL_GOOD) ? STORY_GOAL_BAD : STORY_GOAL_GOOD
		else if(prob(50))
			category = STORY_GOAL_RANDOM

	return category



// Basic select_weighted_goal with integration to goal procs
// Computes final weight using G.get_weight (which can access vault/inputs for custom logic),
// then applies storyteller vars (difficulty, adaptation, repetition) for adaptation.
// Enhanced repetition: Gradient penalty based on recency (time since last similar) and frequency (count in history),
// scaled by adaptation (stronger post-recovery) and population (tolerable in big crews).
// Inspired by RimWorld's event weighting: base chance + modifiers from colony state (here(Nova), station metrics + history avoidance).
/datum/storyteller_think/proc/select_weighted_goal(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, list/candidates, population_scale = 1.0)
	if(!candidates.len)
		return null

	var/list/weighted = list()
	for(var/datum/storyteller_goal/G in candidates)
		if(!G.is_available(inputs.vault, inputs, ctl) && !SSstorytellers.hard_debug)
			continue

		var/base_weight = G.get_weight(inputs.vault, inputs, ctl)
		var/priority_boost = G.get_priority(inputs.vault, inputs, ctl) * 0.5  // Scale to avoid dominance
		var/diff_adjust = ctl.difficulty_multiplier * population_scale

		// Enhanced repetition penalty: Recency (time-based decay) + frequency (count in history)
		var/rep_penalty = 0
		var/list/recent_history = ctl.recent_events  // Assoc [unique_id = details], unique_id = G.id + "_time"
		var/id_prefix = G.id + "_"
		var/last_fire_time = 0
		var/repeat_count = 0

		for(var/hist_id in recent_history)
			if(starts_with_any(hist_id, id_prefix))  // Match prefix for this goal's ID
				repeat_count++
				var/list/details = recent_history[hist_id]
				var/fire_time = text2num(splittext(details["fired_at"], " ")[1]) * 1 MINUTES  // Parse "X min" back to world.time approx
				if(fire_time > last_fire_time)
					last_fire_time = fire_time

		if(repeat_count > 0)
			// Recency decay: Full penalty if recent, 0 if old (DECAY_TIME ~20-30 min)
			var/age = world.time - last_fire_time
			var/recency_factor = clamp(1 - (age / STORY_REPETITION_DECAY_TIME), 0, 1)
			// Frequency multiplier: Linear ramp for spam (e.g., 1x=base, 2x=1.5x, 3x=2x)
			var/freq_mult = 1 + (repeat_count - 1) * 0.5
			rep_penalty = ctl.repetition_penalty * recency_factor * freq_mult

		// Adaptation scaling: Stronger penalty when crew adapted (avoid boring repeats post-recovery)
		rep_penalty *= (1 + ctl.adaptation_factor * 0.5)
		// Population tolerance: Weaker in big crews (more players = less notice repeats)
		rep_penalty /= max(1.0, ctl.population_factor)

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

	// Use pick_weight helper for selection
	return pick_weight(weighted)


/datum/think_stage
	var/description = "Base think stage"

/datum/think_stage/proc/execute(datum/storyteller/ctl, \
	datum/storyteller_inputs/inputs, \
	datum/storyteller_balance_snapshot/bal, \
	datum/storyteller_mood/mood, \
	list/context)
	return

/datum/think_stage/apply_category_bias
	description = "Applies category bias and initial tags"

/datum/think_stage/apply_category_bias/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category = context[CONTEXT_CATEGORY]
	context[CONTEXT_BIAS] = 1.0
	if(category & STORY_GOAL_BAD)
		context[CONTEXT_BIAS] = 1.5
		context[CONTEXT_TAGS] |= STORY_TAG_ESCALATION
	else if(category & STORY_GOAL_GOOD)
		context[CONTEXT_BIAS] = 1.5
		context[CONTEXT_TAGS] |= STORY_TAG_DEESCALATION
	else if(category & STORY_GOAL_RANDOM)
		context[CONTEXT_BIAS] = 1.2
	else if(category & STORY_GOAL_NEUTRAL)
		context[CONTEXT_TAGS] = 0.8

	if(category & STORY_GOAL_GLOBAL)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_WHOLE_STATION


/datum/think_stage/base_health_tags
	description = "Adds base tags from crew health metrics"

/datum/think_stage/base_health_tags/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category_bias = context[CONTEXT_BIAS]
	var/crew_health = inputs.vault[STORY_VAULT_CREW_HEALTH] || STORY_VAULT_HEALTH_HEALTHY
	if(crew_health >= STORY_VAULT_HEALTH_DAMAGED)
		if(prob(70 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_CREW_HEALTH

	var/crew_wounding = inputs.vault[STORY_VAULT_CREW_WOUNDING] || STORY_VAULT_NO_WOUNDS
	if(crew_wounding >= STORY_VAULT_SOME_WOUNDED)
		if(prob(60 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_CREW_HEALTH

	var/crew_diseases = inputs.vault[STORY_VAULT_CREW_DISEASES] || STORY_VAULT_NO_DISEASES
	if(crew_diseases >= STORY_VAULT_MINOR_DISEASES)
		if(prob(65 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_CREW_HEALTH | STORY_TAG_AFFECTS_ENVIRONMENT

	var/crew_dead_ratio = inputs.vault[STORY_VAULT_CREW_DEAD_RATIO] || STORY_VAULT_LOW_DEAD_RATIO
	if(crew_dead_ratio >= STORY_VAULT_MODERATE_DEAD_RATIO)
		if(prob(75 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_MORALE


/datum/think_stage/base_antag_tags
	description = "Adds base tags from antagonist metrics"

/datum/think_stage/base_antag_tags/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category = context[CONTEXT_CATEGORY]
	var/category_bias = context[CONTEXT_BIAS]
	var/antag_presence = inputs.vault[STORY_VAULT_ANTAGONIST_PRESENCE] || STORY_VAULT_NO_ANTAGONISTS
	if(antag_presence >= STORY_VAULT_FEW_ANTAGONISTS)
		if(prob(50 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_ANTAGONIST
	if(antag_presence >= STORY_VAULT_MANY_ANTAGONISTS)
		context[CONTEXT_TAGS] |= (category & STORY_GOAL_BAD ? STORY_TAG_ESCALATION : STORY_TAG_DEESCALATION)

	var/antag_activity = inputs.vault[STORY_VAULT_ANTAGONIST_ACTIVITY] || STORY_VAULT_NO_ACTIVITY
	if(antag_activity >= STORY_VAULT_MODERATE_ACTIVITY)
		if(prob(70 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_SECURITY | STORY_TAG_ESCALATION

	var/antag_kills = inputs.vault[STORY_VAULT_ANTAG_KILLS] || STORY_VAULT_NO_KILLS
	if(antag_kills >= STORY_VAULT_MODERATE_KILLS)
		if(prob(80 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_MORALE | STORY_TAG_ESCALATION

	var/antag_objectives = inputs.vault[STORY_VAULT_ANTAG_OBJECTIVES_COMPLETED] || STORY_VAULT_NO_OBJECTIVES
	if(antag_objectives >= STORY_VAULT_MODERATE_OBJECTIVES)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_ANTAGONIST

	var/antag_influence = inputs.vault[STORY_VAULT_ANTAG_INFLUENCE] || STORY_VAULT_LOW_INFLUENCE
	if(antag_influence >= STORY_VAULT_HIGH_INFLUENCE)
		if(prob(60 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_WHOLE_STATION | STORY_TAG_AFFECTS_POLITICS

	var/antag_disruption = inputs.vault[STORY_VAULT_ANTAG_DISRUPTION] || STORY_VAULT_NO_DISRUPTION
	if(antag_disruption >= STORY_VAULT_MAJOR_DISRUPTION)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_ESCALATION


/datum/think_stage/base_resource_tags
	description = "Adds base tags from resources and additional metrics"

/datum/think_stage/base_resource_tags/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category = context[CONTEXT_CATEGORY]
	var/category_bias = context[CONTEXT_BIAS]
	var/research_progress = inputs.vault[STORY_VAULT_RESEARCH_PROGRESS] || STORY_VAULT_LOW_RESEARCH
	var/resource_minerals = inputs.vault[STORY_VAULT_RESOURCE_MINERALS] || 0
	if(resource_minerals >= 2)
		if(prob(60 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_RESOURCES | STORY_TAG_AFFECTS_ECONOMY

	if(inputs.vault[STORY_VAULT_POWER_STATUS] >= STORY_VAULT_LOW_POWER)
		if(prob(70 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_AFFECTS_TECHNOLOGY

	if(inputs.vault[STORY_VAULT_ATMOS_STATUS] >= STORY_VAULT_MINOR_BREACHES)
		if(prob(65 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_ENVIRONMENT | STORY_TAG_AFFECTS_CREW_HEALTH

	if(research_progress >= STORY_VAULT_HIGH_RESEARCH)
		if(prob(55 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_RESEARCH | (category & STORY_GOAL_BAD ? STORY_TAG_ESCALATION : STORY_TAG_DEESCALATION)

	if(inputs.vault[STORY_VAULT_MORALE_LEVEL] >= STORY_VAULT_LOW_MORALE)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_MORALE

	if(inputs.vault[STORY_VAULT_SECURITY_STATUS] >= STORY_VAULT_RED_ALERT)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_SECURITY | STORY_TAG_ESCALATION

/datum/think_stage/mid_aggregation
	description = "Aggregates mid-level crises and antag dynamics"

/datum/think_stage/mid_aggregation/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category = context[CONTEXT_CATEGORY]
	var/category_bias = context[CONTEXT_BIAS]
	var/tags = context[CONTEXT_TAGS]
	var/health_crisis = (tags & STORY_TAG_AFFECTS_CREW_HEALTH)
	var/morale_crisis = (tags & STORY_TAG_AFFECTS_MORALE)
	if(health_crisis || morale_crisis)
		if(category & STORY_GOAL_BAD || bal.overall_tension > ctl.target_tension)
			context[CONTEXT_TAGS] |= STORY_TAG_ESCALATION
		else
			context[CONTEXT_TAGS] |= STORY_TAG_DEESCALATION

	if(bal.antag_effectiveness < ctl.balancer.weak_antag_threshold && bal.ratio < 0.8)
		if(prob(80 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_ANTAGONIST

	if(bal.station_strength < 0.5)
		if(prob(70 * category_bias))
			context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_RESOURCES | STORY_TAG_AFFECTS_INFRASTRUCTURE

/datum/think_stage/high_implications
	description = "Applies high-level narrative adjustments"

/datum/think_stage/high_implications/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category = context[CONTEXT_CATEGORY]
	var/tags = context[CONTEXT_TAGS]
	var/health_crisis = (tags & STORY_TAG_AFFECTS_CREW_HEALTH)
	var/morale_crisis = (tags & STORY_TAG_AFFECTS_MORALE)
	if(health_crisis)
		if(category & STORY_GOAL_GOOD || bal.overall_tension > ctl.target_tension)
			context[CONTEXT_TAGS] |= STORY_TAG_DEESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH
		else
			context[CONTEXT_TAGS] |= STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_HEALTH
	if(morale_crisis)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_MORALE | (category & STORY_GOAL_BAD ? STORY_TAG_ESCALATION : STORY_TAG_DEESCALATION)
	if(bal.ratio < 0.8)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_ANTAGONIST | STORY_TAG_DEESCALATION
	if(bal.overall_tension > ctl.target_tension)
		context[CONTEXT_TAGS] |= STORY_TAG_DEESCALATION
	else if(bal.overall_tension < ctl.target_tension * 0.7)
		context[CONTEXT_TAGS] |= STORY_TAG_ESCALATION

/datum/think_stage/additional_influences
	description = "Adds additional category-specific influences"

/datum/think_stage/additional_influences/execute(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	var/category = context[CONTEXT_CATEGORY]
	var/research_progress = inputs.vault[STORY_VAULT_RESEARCH_PROGRESS] || STORY_VAULT_LOW_RESEARCH
	if(category & STORY_GOAL_GLOBAL)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_WHOLE_STATION
	if(STORY_VAULT_LOW_RESOURCE in inputs.vault)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_ECONOMY | STORY_TAG_AFFECTS_RESOURCES
	if(category & STORY_GOAL_BAD && research_progress >= STORY_VAULT_MODERATE_RESEARCH)
		context[CONTEXT_TAGS] |= STORY_TAG_AFFECTS_RESEARCH | STORY_TAG_AFFECTS_SECURITY

/datum/think_stage/volatility_random
	description = "Adds random tags based on mood volatility"

/datum/think_stage/volatility_random/process(datum/storyteller/ctl, datum/storyteller_inputs/inputs, datum/storyteller_balance_snapshot/bal, datum/storyteller_mood/mood, list/context)
	if(mood.volatility > 1.1)
		for(var/i in 1 to rand(1, 3))
			var/random_tag = get_random_bitflag("story_universal_tags")
			if(random_tag)
				context[CONTEXT_TAGS] |= random_tag
		if(mood.volatility > 1.5 && prob(50))
			context[CONTEXT_TAGS] |= STORY_TAG_CHAOTIC
