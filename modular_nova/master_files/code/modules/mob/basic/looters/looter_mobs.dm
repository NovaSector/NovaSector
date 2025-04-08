// Lootas
/mob/living/basic/looter
	name = "Looter"
	desc = "One of the many random looters or bandits of the frontiers. This one is carrying a pipe."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "scavpipe"
	icon_living = "scavpipe"
	gender = NEUTER
	maxHealth = 125
	health = 125
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "pipes"
	attack_verb_simple = "bludgeon"
	attack_sound = 'sound/items/weapons/smash.ogg'
	speed = 2.5
	gold_core_spawnable = NO_SPAWN
	faction = list(FACTION_HOSTILE)
	ai_controller = /datum/ai_controller/basic_controller/looter
	///does this type do range attacks?
	var/ranged_attacker = FALSE
	/// How often can we shoot?
	var/ranged_attack_cooldown = 3 SECONDS

/mob/living/basic/looter/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/decal/cleanable/blood/gibs,
		/obj/effect/spawner/random/maintenance/three,
		)
	AddElement(/datum/element/death_drops, death_loot)
	AddComponent(/datum/component/appearance_on_aggro, overlay_icon = icon, overlay_state = "[initial(icon_state)]_attack")
	if(!ranged_attacker)
		return
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/hivebot, cooldown_time = ranged_attack_cooldown)

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

/mob/living/basic/looter/big/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/decal/cleanable/blood/gibs,
		/obj/effect/spawner/random/maintenance/six,
		)
	AddElement(/datum/element/death_drops, death_loot)

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

/mob/living/basic/looter/crusher/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/decal/cleanable/blood/gibs,
		/obj/effect/spawner/random/maintenance/six,
		)
	AddElement(/datum/element/death_drops, death_loot)

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
	attack_sound = 'sound/items/weapons/gun/shotgun/shot.ogg'
	ai_controller = /datum/ai_controller/basic_controller/trooper/ranged/shotgunner/looter

/mob/living/basic/looter/ranged/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/decal/cleanable/blood/gibs,
		/obj/effect/spawner/random/maintenance/five,
		)
	AddElement(/datum/element/death_drops, death_loot)
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/shotgun/buckshot, cooldown_time = ranged_attack_cooldown)

/*
* Guys i swear it's just a makarov
*/

/mob/living/basic/looter/ranged/space
	name = "Looter Shipbreaker"
	desc = "A scavenger with an outdated spacesuit, likely out here to get salvage."
	icon_state = "scavsmg"
	icon_living = "scavsmg"
	attack_sound = 'sound/items/weapons/gun/pistol/shot.ogg'
	ai_controller = /datum/ai_controller/basic_controller/looter/ranged

/mob/living/basic/looter/ranged/space/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/c9mm, cooldown_time = ranged_attack_cooldown)

/*
* Igive me your fuckin wallet SKREK!
*/

/mob/living/basic/looter/ranged/space/laser
	name = "Looter Heavy"
	desc = "A shipbreaker scavenger, carrying a laser gun."
	icon_state = "scavlaser"
	icon_living = "scavlaser"
	attack_sound = 'sound/items/weapons/laser3.ogg'
	ai_controller = /datum/ai_controller/basic_controller/looter/ranged

/mob/living/basic/looter/ranged/space/laser/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	var/static/list/death_loot = list(
		/obj/effect/spawner/random/maintenance/six,
		)
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/energy/laser/hellfire, cooldown_time = ranged_attack_cooldown)

