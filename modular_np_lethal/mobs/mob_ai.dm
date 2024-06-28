#define GAKSTER_CANSEE_RANGE 9

/datum/targeting_strategy/basic/gakster
	ignore_sight = FALSE

/datum/idle_behavior/idle_random_walk/gakster
	walk_chance = 75

// gakster mob custom retaliate component behavior
/mob/living/basic/trooper/gakster/proc/gakster_retaliate(mob/living/attacker)
	if (!istype(attacker))
		return

	// add them to the retaliate list then move to their location if we don't have a target
	// we've tried to make them move, so maybe it's just better to check if we can't see them, then maybe we should just flee from them instead?
	ai_controller.insert_blackboard_key_lazylist(BB_BASIC_MOB_RETALIATE_LIST, attacker)
	if (!ai_controller.blackboard_key_exists(BB_BASIC_MOB_CURRENT_TARGET))
		ai_controller.reset_ai_status()
		if (!can_see(src, attacker, GAKSTER_CANSEE_RANGE)) //oh fuck we can't see them and they shot us
			ai_controller.set_blackboard_key(BB_BASIC_MOB_FLEE_TARGET, attacker)
			ai_controller.set_blackboard_key(BB_BASIC_MOB_STOP_FLEEING, FALSE)
			ai_controller.CancelActions()
		else // YOU BASTARD!!!
			ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, attacker)
			ai_controller.set_blackboard_key(BB_BASIC_MOB_STOP_FLEEING, TRUE)
			ai_controller.CancelActions()

/// basic gakster mob ai controllers
/datum/ai_controller/basic_controller/trooper/gakster
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/gakster,
		BB_AGGRO_RANGE = 12,
		BB_VISION_RANGE = 12,
		BB_EMOTE_KEY = "swear",
		BB_CURRENT_HUNTING_TARGET = null,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_BASIC_MOB_FLEE_DISTANCE = 14,
		BB_REINFORCEMENTS_EMOTE = "reaches up to their comtac and utters a code phrase.",
	)

	ai_movement = /datum/ai_movement/jps // souped up pathfinding
	idle_behavior = /datum/idle_behavior/idle_random_walk/gakster
	interesting_dist = 20
	can_idle = FALSE

	planning_subtrees = list(
		/datum/ai_planning_subtree/flee_target/from_flee_key,
		/datum/ai_planning_subtree/target_retaliate/gakster/to_flee,
		/datum/ai_planning_subtree/target_retaliate/gakster,
		/datum/ai_planning_subtree/find_and_hunt_target/gakster,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/run_emote,
	)

// ranged gakster unit controllers
/datum/ai_controller/basic_controller/trooper/gakster/ranged
	planning_subtrees = list(
		/datum/ai_planning_subtree/flee_target/from_flee_key,
		/datum/ai_planning_subtree/target_retaliate/gakster/to_flee,
		/datum/ai_planning_subtree/target_retaliate/gakster,
		/datum/ai_planning_subtree/find_and_hunt_target/gakster,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/gakster,
		/datum/ai_planning_subtree/run_emote,
	)

// suicide bomber gakster unit controllers
/datum/ai_controller/basic_controller/trooper/gakster/suicide
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree
	)

/datum/ai_planning_subtree/basic_ranged_attack_subtree/gakster
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/gakster

/datum/ai_behavior/basic_ranged_attack/gakster
	action_cooldown = 1 SECONDS
	required_distance = 4
	avoid_friendly_fire = TRUE

/datum/ai_behavior/basic_ranged_attack/gakster/setup(datum/ai_controller/controller, target_key, targeting_strategy_key, hiding_location_key)
	. = ..()
	var/mob/living/basic/trooper/gakster/ranged/gak = controller.pawn
	if (gak)
		action_cooldown = gak.ranged_cooldown
		required_distance = gak.effective_range

/datum/ai_planning_subtree/ranged_skirmish/gakster
	min_range = 2

/datum/ai_planning_subtree/maintain_distance/gakster_ranged
	minimum_distance = 2
	maximum_distance = 4
	view_distance = GAKSTER_CANSEE_RANGE

/datum/ai_planning_subtree/maintain_distance/gakster_ranged/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/trooper/gakster/gak = controller.pawn
	if (gak)
		maximum_distance = gak.effective_range

/datum/ai_behavior/hunt_target/gakster
	behavior_flags = NONE
	always_reset_target = TRUE

/datum/ai_behavior/hunt_target/gakster/target_caught(mob/living/hunter, atom/hunted)
	return

/datum/ai_behavior/hunt_target/gakster/suicide

/datum/ai_behavior/hunt_target/gakster/suicide/target_caught(mob/living/hunter, atom/hunted)
	var/mob/living/basic/trooper/gakster/suicide/la_bomba = hunter
	if (la_bomba)
		la_bomba.combat_mode = TRUE
		la_bomba.melee_attack(hunted, null, TRUE)

/datum/ai_planning_subtree/find_and_hunt_target/gakster
	finish_planning = FALSE
	hunt_targets = list(/mob/living/carbon/human)
	finding_behavior = /datum/ai_behavior/find_hunt_target/gakster_through_walls
	hunting_behavior = /datum/ai_behavior/hunt_target/gakster
	hunt_range = GAKSTER_CANSEE_RANGE

/datum/ai_planning_subtree/find_and_hunt_target/gakster/suicide
	hunting_behavior = /datum/ai_behavior/hunt_target/gakster/suicide

/datum/ai_behavior/find_hunt_target/gakster_through_walls

/datum/ai_behavior/find_hunt_target/gakster_through_walls/valid_dinner(mob/living/source, atom/dinner, radius, datum/ai_controller/controller, seconds_per_tick)
	// totally ignores walls. TERROR INCARNATE. you WILL JUMP SCARE PEOPLE.
	if (isliving(dinner))
		var/mob/living/living_target = dinner
		if (living_target.stat == DEAD)
			return FALSE

	return get_dist(source, dinner) <= radius

/datum/ai_planning_subtree/target_retaliate/gakster
	check_faction = TRUE
	target_key = BB_CURRENT_HUNTING_TARGET

/datum/ai_planning_subtree/target_retaliate/gakster/to_flee
	target_key = BB_BASIC_MOB_FLEE_TARGET

// hey idea for z-level movement
// if attacked on stairs, track to the stairs then check the stairs turf for the direction to move up, then move in that direction and immediately retarget
// then retarget
// if attacked not near stairs, check the adjacent turfs for open space
// - then check to see if there's any stars below the open space
// - if there is, path to the space we were attacked from, then move down and immediately retarget

#undef GAKSTER_CANSEE_RANGE
