/mob/living/basic/mothroach/pet
	name = "pet mothroach"
	desc = "A domestic mothroach that has learnt commands."

	ai_controller = /datum/ai_controller/basic_controller/mothroach/pet

/mob/living/basic/mothroach/pet/gib()
	// Peoples' bespoke pets probably shouldn't be gibbable.
	// This is both for RP reasons (don't force people to RP permanent pet death) and to prevent griefing.
	return

/datum/ai_controller/basic_controller/mothroach/pet
	blackboard = list(
		BB_VISION_RANGE = AI_DOG_VISION_RANGE,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/random_speech/mothroach,
	)

/// == DONATOR PET: Mr. Fluff, Central's Mothroach, ckey centralsmith ==
/mob/living/basic/mothroach/pet/mr_fluff
	name = "Mr. Fluff"
	desc = "Central's beloved pet mothroach, Mr. Fluff. He looks so happy to be here!"
	gender = MALE
	icon = 'modular_nova/master_files/icons/mob/donator_pets.dmi'
	icon_state = "mr_fluff"
	icon_living = "mr_fluff"
	icon_dead = "mr_fluff_dead"

/obj/item/mob_holder/pet/donator/centralsmith
	name = "Mr. Fluff"
	desc = "Central's beloved pet mothroach, Mr. Fluff. He looks so happy to be here!"
	icon = 'modular_nova/master_files/icons/mob/donator_pets.dmi'
	icon_state = "mr_fluff"

	starting_pet = /mob/living/basic/mothroach/pet/mr_fluff
