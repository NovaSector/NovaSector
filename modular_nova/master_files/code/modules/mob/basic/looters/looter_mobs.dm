// Lootas
/mob/living/basic/looter
	name = "Looter"
	desc = "One of the many random looters or bandits of the frontiers. This one is carrying a pipe."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "scavpipe"
	icon_living = "scavpipe"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	gender = NEUTER
	basic_mob_flags = DEL_ON_DEATH
	maxHealth = 125
	health = 125
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "pipes"
	attack_verb_simple = "bludgeon"
	attack_sound = 'sound/items/weapons/smash.ogg'
	unsuitable_atmos_damage = 7.5
	unsuitable_cold_damage = 7.5
	unsuitable_heat_damage = 7.5
	speed = 2.5
	gold_core_spawnable = NO_SPAWN
	faction = list(FACTION_HOSTILE)
	ai_controller = /datum/ai_controller/basic_controller/looter
	/// Does this type do range attacks?
	var/ranged_attacker = FALSE
	/// How often can we shoot?
	var/ranged_cooldown = 2 SECONDS
	/// Projectile sound
	var/projectilesound = 'sound/items/weapons/gun/pistol/shot.ogg'
	/// What gun shoot
	var/casingtype = /obj/item/ammo_casing/c9mm
	/// Lootbox
	var/list/death_loot
	/// why he dead?
	var/corpse = /obj/effect/gibspawner/human
	death_loot = list(
		/obj/effect/decal/cleanable/blood/gibs,
		/obj/effect/spawner/random/maintenance/three,
	)

/mob/living/basic/looter/Initialize(mapload)
	. = ..()
	if(LAZYLEN(death_loot) || corpse)
		LAZYOR(death_loot, corpse)
		death_loot = string_list(death_loot)
		AddElement(/datum/element/death_drops, death_loot)
	AddComponent(/datum/component/appearance_on_aggro, overlay_icon = icon, overlay_state = "[initial(icon_state)]_attack")

/*
* I am Heavy weapons guy, and this is my saw arm
*/

/mob/living/basic/looter/big
	name = "Big Looter"
	desc = "One of the many random looters of the frontiers. This guy is big, fat, and angry."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "fatscav"
	icon_living = "fatscav"
	maxHealth = 140
	health = 140
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "punches"
	attack_verb_simple = "slam"
	ai_controller = /datum/ai_controller/basic_controller/looter
	death_loot = list(
		/obj/effect/decal/cleanable/blood/gibs,
		/obj/effect/spawner/random/maintenance/six,
	)

/*
* lil fatter
*/

/mob/living/basic/looter/crusher
	name = "Looter Heavy"
	desc = "One of the many random looters or bandits of the frontiers. This one is carrying a PKC."
	icon_state = "scavcrush"
	icon_living = "scavcrush"
	maxHealth = 110
	health = 110
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	ai_controller = /datum/ai_controller/basic_controller/looter
	death_loot = list(
		/obj/effect/decal/cleanable/blood/gibs,
		/obj/effect/spawner/random/maintenance/six,
	)

/*
* Shotty
*/

/mob/living/basic/looter/ranged
	name = "Looter Gunman"
	desc = "He's got a shotgun, holy shit!!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "scavshotgun"
	icon_living = "scavshotgun"
	maxHealth = 110
	health = 110
	projectilesound = 'sound/items/weapons/gun/shotgun/shot.ogg'
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	ai_controller = /datum/ai_controller/basic_controller/trooper/ranged/shotgunner/looter
	ranged_attacker = TRUE
	death_loot = list(
		/obj/effect/decal/cleanable/blood/gibs,
		/obj/effect/spawner/random/maintenance/five,
	)

/mob/living/basic/looter/ranged/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = casingtype,\
		projectile_sound = projectilesound,\
		cooldown_time = ranged_cooldown,\
	)

/*
* Guys i swear it's just a makarov
*/

/mob/living/basic/looter/ranged/space
	name = "Looter Shipbreaker"
	desc = "A scavenger with an outdated spacesuit, likely out here to get salvage."
	icon_state = "scavsmg"
	icon_living = "scavsmg"
	projectilesound = 'sound/items/weapons/gun/pistol/shot.ogg'
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	ai_controller = /datum/ai_controller/basic_controller/looter/ranged
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0

/mob/living/basic/looter/ranged/space/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)

/*
* Give me your fuckin wallet SKREK!
*/

/mob/living/basic/looter/ranged/space/laser
	name = "Looter Heavy"
	desc = "A shipbreaker scavenger, carrying a laser gun."
	icon_state = "scavlaser"
	icon_living = "scavlaser"
	ai_controller = /datum/ai_controller/basic_controller/looter/ranged
	projectilesound = 'sound/items/weapons/lasercannonfire.ogg'
	casingtype = /obj/item/ammo_casing/energy/laser/hellfire
	death_loot = list(
		/obj/effect/spawner/random/maintenance/six,
	)


