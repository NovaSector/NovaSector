// baseline vox raider AI
/datum/ai_controller/basic_controller/voxraider
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/vox/voxraider.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_REINFORCEMENTS_SAY = "SKREKS!"
	)

	ai_movement = /datum/ai_movement/basic_avoidance

// normal shots
/datum/ai_controller/basic_controller/voxraider/ranged
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/basic/vox/ranged.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_REINFORCEMENTS_SAY = "YAYA GETS THEM!!"
	)

	ai_movement = /datum/ai_movement/basic_avoidance
