/*
* We're buffing the mobs HP and in a couple cases damage to account for Nova's increased health pool and mining gear
*/
/// General Fauna
// Worm(s) +50 hp over base
/mob/living/basic/mining/bileworm
	maxHealth = 150
	health = 150

/mob/living/basic/mining/bileworm/vileworm
	maxHealth = 200
	health = 200

// let's slash that grapple time and make goliaths blush if they hold you too long.
/datum/status_effect/incapacitating/stun/goliath_tentacled
	duration = 6 SECONDS

/// Megafauna
// Legion - mild HP buff and Damage
/mob/living/simple_animal/hostile/megafauna/legion
	name = "Ashen Legion"
	health = 1000
	maxHealth = 1000
	speed = 3
	melee_damage_lower = 30
	melee_damage_upper = 30
	icon = 'modular_nova/modules/lavaland_expac/icons/96x96megafauna.dmi'

/mob/living/simple_animal/hostile/megafauna/legion/medium
	icon = 'modular_nova/modules/lavaland_expac/icons/64x64megafauna.dmi'
	maxHealth = 550

// Ash Drake - 500 more HP and a smidge more CHOMP
/mob/living/simple_animal/hostile/megafauna/dragon
	health = 3000
	maxHealth = 3000
	melee_damage_lower = 45
	melee_damage_upper = 45

// I need a HEROOOOOOO - their damage is more with their specials which are fine as-is so just more hp
/mob/living/simple_animal/hostile/megafauna/hierophant
	health = 3000
	maxHealth = 3000
	speed = 7
	move_to_delay = 7

// Bubbles - their damage output is fine so just more hp
/mob/living/simple_animal/hostile/megafauna/bubblegum
	health = 3000
	maxHealth = 3000

// Blood Drunk Miner - What happens when you give the BDM cocaine?
/mob/living/simple_animal/hostile/megafauna/blood_drunk_miner
	health = 1300
	maxHealth = 1300
	speed = 2.5
	move_to_delay = 2.5

// The less cool BDM
/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner
	health = 1750
	maxHealth = 1750

// Wendigo - not to be confused by what mario says in mario64
/mob/living/simple_animal/hostile/megafauna/wendigo
	health = 3000
	maxHealth = 3000
	melee_damage_lower = 45
	melee_damage_upper = 45
	speed = 5
	move_to_delay = 5

// Colly - tricky one to change much like bubbles - so we'll start with just hp
/mob/living/simple_animal/hostile/megafauna/colossus
	health = 3000
	maxHealth = 3000
	speed = 8
	move_to_delay = 8

/// Elites - VERY tricky here and may just not be overriden at all - power comes down to how good the player controlling them is.
// Brood
/mob/living/simple_animal/hostile/asteroid/elite/broodmother
	health = 1250
	maxHealth = 1250
	melee_damage_lower = 33
	melee_damage_upper = 33
	armour_penetration = 25

// Herald - aka the coolest one
/mob/living/simple_animal/hostile/asteroid/elite/herald
	maxHealth = 1500
	health = 1500
	melee_damage_lower = 30
	melee_damage_upper = 30
	armour_penetration = 25

// Skelly - kinda the joke of the bunch
/mob/living/simple_animal/hostile/asteroid/elite/legionnaire
	maxHealth = 1500
	health = 1500
	armour_penetration = 25
