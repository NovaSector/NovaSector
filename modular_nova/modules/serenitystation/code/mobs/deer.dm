/mob/living/basic/deer/mining
	desc = "A common deer, used to living alongside monsters after generations on this planet."
	faction = list("mining")
	ai_controller = /datum/ai_controller/basic_controller/deer/mining

/datum/ai_controller/basic_controller/deer/mining/New()
	planning_subtrees -= list(
		/datum/ai_planning_subtree/play_with_friends,
		/datum/ai_planning_subtree/find_and_hunt_target/mark_territory,
		/datum/ai_planning_subtree/find_and_hunt_target/graze,
		/datum/ai_planning_subtree/find_and_hunt_target/drink_water,
	)
	return ..()
