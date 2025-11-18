// baseline
/datum/ai_controller/basic_controller/looter
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

// regular shots
/datum/ai_controller/basic_controller/looter/ranged
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper/looter,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper/looter
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/trooper/looter

/datum/ai_behavior/basic_ranged_attack/trooper/looter
	action_cooldown = 1 SECONDS
	required_distance = 5
	avoid_friendly_fire = TRUE

// shotgunner
/datum/ai_controller/basic_controller/trooper/ranged/shotgunner/looter
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper_shotgun/looter,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
	)

/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper_shotgun/looter
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/trooper_shotgun/looter

/datum/ai_behavior/basic_ranged_attack/trooper_shotgun/looter
	action_cooldown = 3 SECONDS
	required_distance = 4
	avoid_friendly_fire = TRUE
