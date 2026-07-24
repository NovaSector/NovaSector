// baseline
/datum/ai_controller/basic_controller/looter
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/looters/looter.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

// regular shots
/datum/ai_controller/basic_controller/looter/ranged
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/looters/ranged.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

// shotgunner
/datum/ai_controller/basic_controller/trooper/ranged/shotgunner/looter
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/looters/shotgunner.bt.json"
