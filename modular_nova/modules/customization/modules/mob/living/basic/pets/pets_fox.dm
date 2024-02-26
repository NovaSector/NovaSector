// Add 'good fox' as valid input
/datum/pet_command/good_boy/fox
	speech_commands = list("good fox")

/mob/living/basic/pet/fox/pet
	name = "pet fox"
	desc = "A domesticated fox that has learnt commands."

	ai_controller = /datum/ai_controller/basic_controller/fox/pet

	// same command set as dogs
	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/good_boy/fox,
		/datum/pet_command/follow/dog,
		/datum/pet_command/point_targeting/attack/dog,
		/datum/pet_command/point_targeting/fetch,
		/datum/pet_command/play_dead,
	)

/mob/living/basic/pet/fox/pet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/obeys_commands, pet_commands)

/mob/living/basic/pet/fox/pet/gib()
	// People's bespoke pets probably shouldn't be gibbable.
	// This is both for RP reasons (don't force people to RP permanent pet death) and to prevent griefing.
	return

// An AI controller for more docile foxes able to handle commands.
/datum/ai_controller/basic_controller/fox/pet
	blackboard = list(
		BB_DOG_HARASS_HARM = TRUE,
		BB_VISION_RANGE = AI_DOG_VISION_RANGE,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/fox,
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/dog_harassment,
	)
