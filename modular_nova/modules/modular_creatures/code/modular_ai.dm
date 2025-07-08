//modular ai behaviors that aren't specific to any particular mob or type of mob

/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper/serious
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/trooper/serious

/datum/ai_behavior/basic_ranged_attack/trooper/serious
	required_distance = 32
	chase_range = 18

/datum/ai_planning_subtree/simple_find_target/huge_range

/datum/ai_planning_subtree/simple_find_target/huge_range/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	controller.queue_behavior(/datum/ai_behavior/find_potential_targets/huge_range, target_key, BB_TARGETING_STRATEGY, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)

/datum/ai_behavior/find_potential_targets/huge_range
	vision_range = 32 // what the fuck units are these in?
