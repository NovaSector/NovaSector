// Add 'good kitty' and 'good cat' as valid input
/datum/pet_command/good_boy/cat
	speech_commands = list("good cat", "good kitty")

/mob/living/basic/pet/cat/pet
	name = "trained cat"
	desc = "KITTY UPPIES!!!"

	ai_controller = /datum/ai_controller/basic_controller/cat/pet

	// almost all the commands dogs have, save for fetch - they don't seem likely to give you what you want, but mauling someone that annoys them is another story
	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/good_boy/cat,
		/datum/pet_command/follow/dog,
		/datum/pet_command/point_targeting/attack/dog,
		/datum/pet_command/play_dead,
	)

/mob/living/basic/pet/cat/pet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/obeys_commands, pet_commands)

/mob/living/basic/pet/cat/pet/gib()
	// People's bespoke pets probably shouldn't be gibbable.
	// This is both for RP reasons (don't force people to RP permanent pet death) and to prevent griefing.
	return

/datum/ai_controller/basic_controller/cat/pet
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_HOSTILE_MEOWS = list("Mawwww", "Mrewwww", "mhhhhng..."),
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/cats,
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/reside_in_home,
		/datum/ai_planning_subtree/flee_target/from_flee_key/cat_struggle,
		/datum/ai_planning_subtree/find_and_hunt_target/find_cat_food,
		/datum/ai_planning_subtree/simple_find_target,
	)



/// kitten ver
/mob/living/basic/pet/cat/kitten/pet
	name = "trained kitten"
	desc = "KITTEN UPPIES!!!"

	ai_controller = /datum/ai_controller/basic_controller/cat/kitten/pet

	// very limited commandset, bc they're KITTENS.  you're lucky to have them working with you at all!
	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/good_boy/cat,
		/datum/pet_command/follow/dog,
		/datum/pet_command/play_dead,
	)

/mob/living/basic/pet/cat/kitten/pet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/obeys_commands, pet_commands)

/mob/living/basic/pet/cat/kitten/pet/gib()
	// People's bespoke pets probably shouldn't be gibbable.
	// This is both for RP reasons (don't force people to RP permanent pet death) and to prevent griefing.
	// (Also, what kind of psychopath would gib a kitten, anyway.  You monster.)
	return

/datum/ai_controller/basic_controller/cat/kitten/pet
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_HUNGRY_MEOW = list("mrrp...", "mraw..."),
		BB_MAX_DISTANCE_TO_FOOD = 2,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/cats,
		/datum/ai_planning_subtree/beg_human, //begging you for snacks is higher priority than following your commands
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/find_and_hunt_target/find_cat_food/kitten,
	)
