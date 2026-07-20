/// Custom spider AI trees

/// web faster
/datum/bt_node/ai_behavior/spin_web
	time_between_perform = 5 SECONDS

///destroy surveillance objects to boost our stealth
/datum/target_source/oview_typed/spider_surveillance
	typecache = typecacheof(list(/obj/machinery/camera, /obj/machinery/light))

/datum/bt_node/ai_behavior/random_speech/insect
	speech_chance = 5
	sound = list('sound/mobs/non-humanoids/insect/chitter.ogg')
	emote_hear = list("chitters.") // Space spiders are taxonomically insects not arachnids, don't DM me

/datum/bt_node/ai_behavior/random_speech/insect/laugh
	speech_chance = 5
	sound = list('sound/mobs/non-humanoids/insect/chitter.ogg')
	emote_hear = list("laughs.")

/**
 * ### Webslinger Spider
 */

/datum/ai_controller/basic_controller/webslinger
	behavior_tree_json = "modular_nova/modules/spider/spider_abilities/webslinger.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_FLEE_DISTANCE = 5,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/**
 * ### Voltaic Spider
 */

/datum/ai_controller/basic_controller/voltaic
	behavior_tree_json = "modular_nova/modules/spider/spider_abilities/voltaic.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/**
 * ### Pit Spider
 */
/datum/ai_controller/basic_controller/pit
	behavior_tree_json = "modular_nova/modules/spider/spider_abilities/pit.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/**
 * ### Carrier Spider
 */
/datum/ai_controller/basic_controller/carrier
	behavior_tree_json = "modular_nova/modules/spider/spider_abilities/carrier.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/**
 * ### Ogre Spider
 */
/datum/ai_controller/basic_controller/ogre
	behavior_tree_json = "modular_nova/modules/spider/spider_abilities/ogre.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/**
 * ### Baron Spider
 */
/datum/ai_controller/basic_controller/baron
	behavior_tree_json = "modular_nova/modules/spider/spider_abilities/baron.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance

/**
 * ### Badnana Spider
 */

/datum/ai_controller/basic_controller/badnana
	behavior_tree_json = "modular_nova/modules/spider/spider_abilities/badnana.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
