/datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = SOFT_CRIT,
		BB_REINFORCEMENTS_EMOTE = "raises up its hand, motioning wildly towards itself!",
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
	)


/datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors/serious
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = SOFT_CRIT,
		BB_REINFORCEMENTS_EMOTE = "thumps its chest with a resounding +clang,+ raising its weapon!",
	)

/datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors/ranged
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper/serious,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
	)

/datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors/serious/ranged
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper/serious,
		/datum/ai_planning_subtree/travel_to_point/and_clear_target/reinforce,
	)

/datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors/serious/ranged/boss
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = SOFT_CRIT,
		BB_REINFORCEMENTS_EMOTE = "points imperiously.",
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper/serious,
	)

/obj/projectile/beam/laser/purple
	name = "hybrid abdubtech laser"
	icon_state = "laser_musket"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	damage = 10
	stamina = 10
	armour_penetration = 10
	weak_against_armour = FALSE

/obj/item/ammo_casing/energy/laser/plasma_glob/spam // boss weapon
	icon = null // hide your casings slut this is an energy weapon!!! they get cleaned up anyway it doesnt matter
	icon_state = null
	pellets = 2
	variance = 30 // dear god

/obj/item/ammo_casing/energy/laser/purplebeam // single purple beams
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/laser_firing/laser.ogg'
	icon = null
	icon_state = null
	projectile_type = /obj/projectile/beam/laser/purple
	pellets = 1
	variance = 10

/obj/item/ammo_casing/energy/laser/purplebeam/burst
	pellets = 3
	variance = 10
