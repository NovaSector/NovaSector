//basic cult mobs
/datum/ai_controller/basic_controller/cult
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/cult/cult.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)
	ai_movement = /datum/ai_movement/basic_avoidance

//magic range cult mobs
/datum/ai_controller/basic_controller/cult/magic
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/cult/magic.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
