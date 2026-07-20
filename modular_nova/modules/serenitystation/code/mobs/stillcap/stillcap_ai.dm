/datum/ai_controller/basic_controller/stillcap
	behavior_tree_json = "modular_nova/modules/serenitystation/code/mobs/stillcap/stillcap.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/allow_items,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_BASIC_MOB_FLEE_DISTANCE = 25,
		BB_AGGRO_RANGE = 5,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_HIDING_HIDDEN = FALSE,
		BB_HIDING_AGGRO_RANGE = DEFAULT_HIDING_AGGRO_RANGE,
		BB_HIDING_COOLDOWN_MAXIMUM = 3 MINUTES,
		BB_HIDING_COOLDOWN_MINIMUM = 1 MINUTES,
		BB_HIDING_RANDOM_STOP_HIDING_CHANCE = 2,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
