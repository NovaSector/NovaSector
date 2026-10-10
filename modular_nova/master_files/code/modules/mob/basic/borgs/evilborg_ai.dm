// baseline
/datum/ai_controller/basic_controller/evilborgs
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/borgs/evilborgs.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_REINFORCEMENTS_SAY = "Engaging hostile protocols!",
	)

	ai_movement = /datum/ai_movement/basic_avoidance

// burst shots
/datum/ai_controller/basic_controller/evilborgs/burst
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/borgs/burst.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_REINFORCEMENTS_SAY = "Engaging hostile protocols!",
	)

	ai_movement = /datum/ai_movement/basic_avoidance

// normal shots
/datum/ai_controller/basic_controller/evilborgs/ranged
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/borgs/ranged.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_REINFORCEMENTS_SAY = "Engaging hostile protocols!",
	)

	ai_movement = /datum/ai_movement/basic_avoidance
