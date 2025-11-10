/// Custom spider AI trees

/**
 * ### Webslinger Spider
 */

/datum/ai_controller/basic_controller/webslinger
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_FLEE_DISTANCE = 5,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/targeted_mob_ability/arachnid_restrain,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/webslinger,
		/datum/ai_planning_subtree/flee_target/webslinger,
		/datum/ai_planning_subtree/find_and_hunt_target/destroy_surveillance/spider,
		/datum/ai_planning_subtree/random_speech/insect, // Space spiders are taxonomically insects not arachnids, don't DM me
		/datum/ai_planning_subtree/find_unwebbed_turf,
		/datum/ai_planning_subtree/spin_web,
	)

/// web faster
/datum/ai_behavior/spin_web
	action_cooldown = 5 SECONDS

///destroy surveillance objects to boost our stealth
/datum/ai_planning_subtree/find_and_hunt_target/destroy_surveillance/spider
	target_key = BB_SURVEILLANCE_TARGET
	finding_behavior = /datum/ai_behavior/find_hunt_target/find_active_surveillance/spider
	hunting_behavior = /datum/ai_behavior/hunt_target/interact_with_target
	hunt_targets = list(/obj/machinery/camera, /obj/machinery/light)
	hunt_range = 7

/datum/ai_behavior/find_hunt_target/find_active_surveillance/spider

/datum/ai_behavior/find_hunt_target/find_active_camera/valid_dinner(mob/living/source, obj/machinery/dinner, radius)
	if(dinner.machine_stat & BROKEN)
		return FALSE

	return can_see(source, dinner, radius)

///spray slippery acid as we flee!
/datum/ai_planning_subtree/flee_target/webslinger
	flee_behaviour = /datum/ai_behavior/run_away_from_target/webslinger

/datum/ai_planning_subtree/flee_target/webslinger/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(controller.blackboard[BB_BASIC_MOB_STOP_FLEEING])
		return
	var/datum/action/cooldown/slip_acid = controller.blackboard[BB_ARACHNID_SLIP]

	if(!QDELETED(slip_acid) && slip_acid.IsAvailable())
		controller.queue_behavior(/datum/ai_behavior/use_mob_ability, BB_ARACHNID_SLIP)

	return ..()

/datum/ai_behavior/run_away_from_target/webslinger
	clear_failed_targets = FALSE

///only engage in melee combat against cuffed targets, otherwise keep throwing restraints at them
/datum/ai_planning_subtree/basic_melee_attack_subtree/webslinger
	///minimum health our target must be before we can attack them
	var/minimum_health = 100

/datum/ai_planning_subtree/basic_melee_attack_subtree/webslinger/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!ishuman(target))
		return ..()

	var/mob/living/carbon/human_target = target
	if(!human_target.legcuffed && human_target.health > minimum_health)
		return

	return ..()

/datum/ai_planning_subtree/targeted_mob_ability/arachnid_restrain
	ability_key = BB_ARACHNID_RESTRAIN

/// only fire ability at humans if they are not cuffed
/datum/ai_planning_subtree/targeted_mob_ability/arachnid_restrain/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/target = controller.blackboard[target_key]
	if(!ishuman(target))
		return
	var/mob/living/carbon/human_target = target
	if(human_target.legcuffed)
		return
	return ..()

/**
 * ### Voltaic Spider
 */


/datum/ai_controller/basic_controller/voltaic
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/find_and_hunt_target/destroy_surveillance/spider,
		/datum/ai_planning_subtree/random_speech/insect,
		/datum/ai_planning_subtree/find_unwebbed_turf,
		/datum/ai_planning_subtree/spin_web,
	)

/**
 * ### Pit Spider
 */
/datum/ai_controller/basic_controller/pit
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/find_and_hunt_target/destroy_surveillance/spider,
		/datum/ai_planning_subtree/random_speech/insect,
		/datum/ai_planning_subtree/find_unwebbed_turf,
		/datum/ai_planning_subtree/spin_web,
	)

/**
 * ### Carrier Spider
 */
/datum/ai_controller/basic_controller/carrier
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/find_and_hunt_target/destroy_surveillance/spider,
		/datum/ai_planning_subtree/random_speech/insect,
		/datum/ai_planning_subtree/find_unwebbed_turf,
		/datum/ai_planning_subtree/spin_web,
	)

/**
 * ### Ogre Spider
 */
/datum/ai_controller/basic_controller/ogre
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/find_and_hunt_target/destroy_surveillance/spider,
		/datum/ai_planning_subtree/random_speech/insect,
		/datum/ai_planning_subtree/find_unwebbed_turf,
		/datum/ai_planning_subtree/spin_web,
	)

/**
 * ### Baron Spider
 */
/datum/ai_controller/basic_controller/baron
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/targeted_mob_ability/arachnid_restrain,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/find_and_hunt_target/destroy_surveillance/spider,
		/datum/ai_planning_subtree/random_speech/insect,
		/datum/ai_planning_subtree/find_unwebbed_turf,
		/datum/ai_planning_subtree/spin_web,
	)

/**
 * ### Badnana Spider
 */


/datum/ai_controller/basic_controller/badnana
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/,
		/datum/ai_planning_subtree/random_speech/insect/laugh,
		/datum/ai_planning_subtree/find_unwebbed_turf,
		/datum/ai_planning_subtree/spin_web,
	)

/datum/ai_planning_subtree/random_speech/insect/laugh
	speech_chance = 5
	sound = list('sound/mobs/non-humanoids/insect/chitter.ogg')
	emote_hear = list("laughs.")
