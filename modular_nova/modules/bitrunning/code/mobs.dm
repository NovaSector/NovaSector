/mob/living/basic/construct/juggernaut/angelic/bitrunning
	maxHealth = 300
	health = 300
	obj_damage = 40
	move_force = MOVE_FORCE_VERY_STRONG
	faction = list(FACTION_NEUTRAL)
	construct_spells = list(
		/datum/action/cooldown/spell/basic_projectile/juggernaut/bitrunning,
		/datum/action/cooldown/spell/forcewall/cult/bitrunning,
		/datum/action/cooldown/spell/conjure/cult_wall,
	)
	smashes_walls = FALSE //Added via Initialize() instead

/mob/living/basic/construct/juggernaut/angelic/bitrunning/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_tearer, allow_reinforced = TRUE)

/datum/action/cooldown/spell/basic_projectile/juggernaut/bitrunning
	cooldown_time = 15 SECONDS

/datum/action/cooldown/spell/forcewall/cult/bitrunning
	cooldown_time = 10 SECONDS

/mob/living/basic/tree/palm
	name = "palm tree"
	desc = "A tree straight from the tropics."
	icon = 'icons/obj/fluff/beach2.dmi'
	icon_state = "palm1"
	icon_state = "palm1"
	icon_living = "palm1"
	icon_dead = "palm1"
	icon_gib = "palm1"
	health_doll_icon = "palm1"
	faction = list(FACTION_NEUTRAL)
	maxHealth = 100
	health = 100
	paralyze_prob = 0
	paralyze_value = 0
	anger_boost = 0

/mob/living/simple_animal/hostile/mimic/crate/minor_illusion
	faction = list(FACTION_NEUTRAL)
	speed = 1
	maxHealth = 100
	health = 100

/mob/living/simple_animal/hostile/mimic/watermelon
	name = "watermelon"
	desc = "It's full of watery goodness. <br>\
	This one has been trained to become a competition-grade racer."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "watermelon"
	icon_state = "watermelon"
	icon_living = "watermelon"
	icon_dead = "watermelon"
	icon_gib = "watermelon"
	health_doll_icon = "watermelon"
	faction = list(FACTION_NEUTRAL)
	attack_verb_simple = "collide with"
	attack_verb_continuous = "collides with"
	melee_damage_lower = 5
	melee_damage_upper = 9
	obj_damage = 5
	speed = 0
	maxHealth = 50
	health = 50
	loot = list(
		/obj/item/food/watermelonslice,
		/obj/effect/gibspawner/generic,
	)
