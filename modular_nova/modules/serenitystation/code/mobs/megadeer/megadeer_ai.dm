/datum/ai_controller/basic_controller/megadeer
	behavior_tree_json = "modular_nova/modules/serenitystation/code/mobs/megadeer/megadeer.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/allow_items,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_BASIC_MOB_FLEE_DISTANCE = 25,
		BB_VISION_RANGE = 9,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
