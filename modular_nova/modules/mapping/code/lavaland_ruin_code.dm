//MOBS

// hivelords that stand guard where they spawn
/mob/living/basic/mining/hivelord/no_wander
	ai_controller = /datum/ai_controller/basic_controller/hivelord/no_wander

//MOB AI

// same as a regular hivelord minus the idle walking
/datum/ai_controller/basic_controller/hivelord/no_wander
	idle_behavior = null
