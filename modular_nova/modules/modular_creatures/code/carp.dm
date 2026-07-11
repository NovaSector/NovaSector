/mob/living/basic/carp
	health = 50
	maxHealth = 50
	melee_damage_lower = 15
	melee_damage_upper = 23

/mob/living/basic/carp/mega
	health = 50
	maxHealth = 50

/*
	Space dragon related
*/

/mob/living/basic/carp/advanced
	health = 65
	maxHealth = 65

/mob/living/basic/space_dragon
	health = 600
	maxHealth = 600

/datum/action/cooldown/mob_cooldown/wing_buffet
	exhaustion_multiplier = 2

/datum/movespeed_modifier/dragon_depression
	multiplicative_slowdown = 2

/obj/structure/carp_rift
	max_integrity = 500

/datum/dynamic_ruleset/midround/from_ghosts/space_dragon/announce_space_dragon()
	return
