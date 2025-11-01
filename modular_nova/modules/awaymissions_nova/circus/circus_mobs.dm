//lobotomized mobs category
/mob/living/basic/trooper/nanotrasen/ranged/smg/display
	ai_controller = null

/mob/living/basic/trooper/nanotrasen/ranged/assault/dispaly
	ai_controller = null

/mob/living/basic/trooper/syndicate/melee/space/stormtrooper/display
	ai_controller = null

/mob/living/basic/trooper/syndicate/ranged/shotgun/space/stormtrooper/anthro/fox/display
	ai_controller = null

/mob/living/basic/trooper/cin_soldier/ranged/display
	ai_controller = null

//mech displays

/obj/structure/showcase/mecha/gygax
	name = "Gygax"
	desc = "A great replica of a gygax that is completely non functional."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "gygax"

/obj/structure/showcase/mecha/gygax/dark_gygax
	name = "Dark gygax"
	desc = "A great replica of a syndicate gygax that is completely non functional."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "darkgygax"

/obj/structure/showcase/mecha/durand
	name = "Durand"
	desc = "A great replica of a durand that is completely non functional."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "durand"

/obj/structure/showcase/mecha/mauler
	name = "Mauler"
	desc = "A great replica of a Mauler that is completely non functional."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "mauler"

//i gave up organizing

/mob/living/basic/trooper/syndicate/melee/ninja //Long before time had a name, Ninjago was created by the first Spinjitzu master by using the four weapons of Spinjitzu.
	name = "Space Ninja"
	desc = "A ninja- in space."
	melee_damage_lower = 40
	melee_damage_upper = 40
	corpse = /obj/effect/mob_spawn/corpse/human/nanotrasensoldier/ninja
	mob_spawner = /obj/effect/mob_spawn/corpse/human/nanotrasensoldier/ninja
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	r_hand = /obj/item/katana/ninja_blade
	projectile_deflect_chance = 50

/mob/living/basic/trooper/syndicate/melee/ninja/display

	ai_controller = null

/datum/outfit/nanotrasensoldiercorpse/ninja
	name = "Ninja corpse"
	uniform = /obj/item/clothing/under/syndicate/ninja
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	ears = /obj/item/radio/headset/syndicate/alt
	mask = /obj/item/clothing/mask/gas/ninja
	back = /obj/item/mod/control/pre_equipped/ninja
	id = /obj/item/card/id/advanced/black/syndicate_command

/obj/effect/mob_spawn/corpse/human/nanotrasensoldier/ninja
	name = "Ninja corpse"
	outfit = /datum/outfit/nanotrasensoldiercorpse/ninja

/mob/living/basic/revolutionary/deranged_assistant
	name = "Deranged Assistant"
	desc = "Your average grey shirt assistant"

/mob/living/basic/trooper/nanotrasen/ranged/the_victor
	name = "The Victor"
	desc = "They used their know-how of laser weaponry to become the ultimate victor of laser tag..."
	maxHealth = 1500
	health = 1500
	melee_damage_lower = 40
	melee_damage_upper = 40
	habitable_atmos = null
	unsuitable_cold_damage = 0
	casingtype = /obj/item/ammo_casing/energy/laser
	burst_shots = 5
	projectilesound = 'sound/items/weapons/laser.ogg'
	ranged_cooldown = 2 SECONDS
	faction = list(ROLE_DEATHSQUAD)
	loot = list(/obj/item/keycard/circus_minigun)
	corpse = /obj/effect/mob_spawn/corpse/human/Heavy_minigunner
	r_hand = /obj/item/gun/energy/pulse
	ai_controller = /datum/ai_controller/basic_controller/trooper/ranged

/obj/effect/mob_spawn/corpse/human/Heavy_minigunner
	name = "\improper Heavy Minigunner Corpse"
	outfit = /datum/outfit/Heavy_minigunner
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/Heavy_minigunner
	name = "\improper Heavy Minigunner Corpse"
	uniform = /obj/item/clothing/under/rank/centcom/military
	suit = /obj/item/clothing/suit/armor/heavy
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/cigarette/cigar/premium
	glasses = /obj/item/clothing/glasses/sunglasses/big
	head = /obj/item/clothing/head/helmet/space/beret
	back = /obj/item/minigunpack
	id = /obj/item/card/id/advanced/silver

/datum/ai_controller/basic_controller/cult/cult_circus
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_AGGRO_RANGE = 80
	)
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk

/datum/ai_controller/basic_controller/cult/magic/cult_circus
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path/trooper,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/trooper/cult,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_AGGRO_RANGE = 80
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk

//start of the Call of duty zombies attack wave mobs
/mob/living/basic/cult/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c100
	)

/mob/living/basic/cult/assassin/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c100
	)

/mob/living/basic/cult/engorge/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c1000
	)

/mob/living/basic/cult/engorge/devourdem/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c100
	)

/mob/living/basic/cult/ghost/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c100
	)

/mob/living/basic/cult/horror/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c100
	)

/mob/living/basic/cult/magic/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/magic/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c1000
	)

/mob/living/basic/cult/magic/elite/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/magic/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000
	)

/mob/living/basic/cult/magic/elite/fireball/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/magic/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000,
		/obj/item/stack/spacecash/c1000
	)

/mob/living/basic/cult/mannequin/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c100,
		/obj/item/stack/spacecash/c100
	)

/mob/living/basic/cult/spear/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c1000
	)

/mob/living/basic/cult/warrior/CodZ
	ai_controller = /datum/ai_controller/basic_controller/cult/cult_circus
	death_loot = list(
		/obj/item/stack/spacecash/c1000
	)

/mob/living/basic/cult/magic/elite/CodZ/Final_Boss
	name = "Cult Leader"
	desc = "The boss of the cult operating on this planet, killing him will be taking the head off the snake."
	maxHealth = 1500
	health = 1500
	melee_damage_lower = 40
	melee_damage_upper = 40
	death_loot = list(
		/obj/item/keycard/circus
	)

/mob/living/basic/cult/magic/elite/fireball/CodZ/Rare_shiny_final_boss
	name = "Shiny Cult Leader"
	desc = "Well isnt this your lucky day."
	maxHealth = 15000
	health = 15000
	melee_damage_lower = 40
	melee_damage_upper = 40
	death_loot = list(
		/obj/item/nullrod/vibro/talking/chainsword,
		/obj/item/mod/control/pre_equipped/responsory/inquisitory/commander,
		/obj/item/stack/spacecash/c10000,
		/obj/item/stack/spacecash/c10000,
		/obj/item/stack/spacecash/c10000,
		/obj/item/keycard/circus
	)
