//basic cult mobs
/datum/ai_controller/basic_controller/cult
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_behavior/attack_obstructions/trooper,
	)

	movement_delay = 0.8 SECONDS

//magic range cult mobs
/datum/ai_controller/basic_controller/cult/magic
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper/cult,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
	)

	movement_delay = 0.8 SECONDS

/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper/cult
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/trooper/cult

/datum/ai_behavior/basic_ranged_attack/trooper/cult
	action_cooldown = 1 SECONDS
	avoid_friendly_fire = TRUE
