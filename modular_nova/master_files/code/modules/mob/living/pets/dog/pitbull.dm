/mob/living/basic/pet/dog/pitbull
	name = "\improper pitbull"
	desc = "There is no such thing as a bad dog, only bad owners. Though, it's best to keep it away from toddlers. Just in case..."
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_state = "pitbull"
	icon_dead = "pitbull_dead"
	icon_living = "pitbull"
	ai_controller = /datum/ai_controller/basic_controller/pitbull

/datum/ai_controller/basic_controller/pitbull
	blackboard = list(
		BB_ALWAYS_IGNORE_FACTION = TRUE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/of_size/smaller,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/dumb
	idle_behavior = /datum/idle_behavior/idle_dog
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate/to_flee,
		/datum/ai_planning_subtree/flee_target/from_flee_key,
		/datum/ai_planning_subtree/dog_harassment,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/dog,
	)

/mob/living/basic/pet/dog/pitbull/Initialize(mapload)
	. = ..()
	if(prob(1))
		name = pick("Crayon", "Pimpy", "Staypuft", "Bape", "BLOODSKULL", "Baby G")
	RemoveElement(/datum/element/can_be_held) //He's too big.
	AddElement(/datum/element/tiny_mob_hunter, MOB_SIZE_SMALL) //He eats anything that he sees as a toddler.
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_CLAW)

/mob/living/basic/pet/dog/pitbull/hungry //Evil but not the gorilla pitbull.
	name = "hungry pitbull"
	desc = "A wild pitbull denied their daily baby ration."
	health = 60
	maxHealth = 60
	obj_damage = 20
	melee_damage_lower = 10
	melee_damage_upper = 15
	wound_bonus = -25
	exposed_wound_bonus = 45
	sharpness = SHARP_EDGED
	gold_core_spawnable = HOSTILE_SPAWN
	faction = list(FACTION_HOSTILE)
	ai_controller = /datum/ai_controller/basic_controller/guarddog
