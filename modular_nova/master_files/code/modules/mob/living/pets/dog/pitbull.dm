/mob/living/basic/pet/dog/pitbull
	name = "\improper pitbull"
	desc = "There is no such thing as a bad dog, only bad owners. Though, it's best to keep it away from toddlers. Just in case..."
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_state = "pitbull"
	icon_dead = "pitbull_dead"
	icon_living = "pitbull"
	ai_controller = /datum/ai_controller/basic_controller/pitbull

/datum/ai_controller/basic_controller/pitbull
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/living/pets/dog/pitbull.bt.json"
	blackboard = list(
		BB_DOG_HARASS_HARM = TRUE,
		BB_VISION_RANGE = AI_DOG_VISION_RANGE,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		// Find smaller mobs
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/of_size/smaller,
		// With tongs in hand!
		BB_TARGET_HELD_ITEM = /obj/item/kitchen/tongs,
		BB_BABIES_PARTNER_TYPES = list(/mob/living/basic/pet/dog),
	)

/mob/living/basic/pet/dog/pitbull/Initialize(mapload)
	. = ..()
	if(prob(1))
		name = pick("Crayon", "Pimpy", "Staypuft", "Bape", "BLOODSKULL", "Baby G")
	RemoveElement(/datum/element/can_be_held) //He's too big.
	AddElement(/datum/element/tiny_mob_hunter, MOB_SIZE_SMALL) //He eats anything that he sees as a toddler.
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_CLAW)

/mob/living/basic/pet/dog/pitbull/hungry //Evil
	name = "hungry pitbull"
	desc = "A wild pitbull denied their daily baby ration."
	sharpness = SHARP_EDGED
	gold_core_spawnable = HOSTILE_SPAWN
	faction = list(FACTION_HOSTILE)
	ai_controller = /datum/ai_controller/basic_controller/guarddog
