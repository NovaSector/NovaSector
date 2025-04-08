// Vox Raiders

/mob/living/basic/vox
	name = "Vox Raider"
	desc = "Vox are typically one of two things. Shady traders or hostile raiders. This one seems to be pretty hostile."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "vox"
	icon_living = "vox"
	icon_dead = "voxdead"
	speed = 2.5
	gold_core_spawnable = NO_SPAWN
	maxHealth = 125
	health = 125
	melee_damage_lower = 10
	melee_damage_upper = 15
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/items/weapons/pierce_slow.ogg'
	faction = list(FACTION_HOSTILE)
	ai_controller = /datum/ai_controller/basic_controller/voxraider
	///does this type do range attacks?
	var/ranged_attacker = TRUE
	/// How often can we shoot?
	var/ranged_attack_cooldown = 3 SECONDS

/mob/living/basic/vox/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/spawner/random/maintenance/three,
		)
	AddElement(/datum/element/death_drops, death_loot)

/*
* Vox Slappies
*/

/mob/living/basic/vox/melee
	name = "Vox Shanker"
	desc = "A Vox pirate armed with a knife."
	icon_state = "voxmelee"
	icon_living = "voxmelee"
	icon_dead = "voxmeleedead"
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	ai_controller = /datum/ai_controller/basic_controller/voxraider

/mob/living/basic/vox/melee/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/spawner/random/medical/medkit,
		)
	AddElement(/datum/element/death_drops, death_loot)

/*
* Guns
*/

/mob/living/basic/vox/ranged
	name = "Vox Gunman"
	desc = "SKREEEEE!"
	icon_state = "voxbow"
	icon_living = "voxbow"
	icon_dead = "voxdead"
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_sound = 'sound/items/weapons/gun/pistol/shot.ogg'
	ai_controller = /datum/ai_controller/basic_controller/voxraider/ranged

/mob/living/basic/vox/ranged/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/spawner/random/engineering/material_rare = 2,
		)
	AddElement(/datum/element/death_drops, death_loot)
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/c9mm, cooldown_time = ranged_attack_cooldown)

/*
* LASERS
*/

/mob/living/basic/vox/ranged/laser
	name = "Vox Laser Gunman"
	desc = "Vox pirates often utilize a mix of energy and ballistic weapons in combat."
	icon_state = "voxlaser"
	icon_living = "voxlaser"
	icon_dead = "voxsuitdead"
	attack_sound = 'sound/items/weapons/laser3.ogg'
	ai_controller = /datum/ai_controller/basic_controller/voxraider/ranged

/mob/living/basic/vox/ranged/laser/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/spawner/random/engineering/material_rare = 2,
		)
	AddElement(/datum/element/death_drops, death_loot)
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/energy/laser/hellfire, cooldown_time = ranged_attack_cooldown)

/*
* Space guns
*/

/mob/living/basic/vox/ranged/space
	name = "Vox Space Raider"
	desc = "A Vox in a space suit, with a gun!"
	icon_state = "voxspace"
	icon_living = "voxspace"
	icon_dead = "voxspacedead"
	attack_sound = 'sound/items/weapons/gun/pistol/shot.ogg'
	ai_controller = /datum/ai_controller/basic_controller/voxraider/ranged

/mob/living/basic/vox/ranged/space/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	var/static/list/death_loot = list(
		/obj/effect/spawner/random/maintenance/five,
		)
	AddElement(/datum/element/death_drops, death_loot)
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/c9mm, cooldown_time = ranged_attack_cooldown)

/*
* Space LASERS
*/

/mob/living/basic/vox/ranged/space/laser
	name = "Vox Helmsman"
	desc = "Space-faring Vox raider, armed with a laser rifle and wearing a MODsuit."
	icon_state = "voxspacelaser"
	icon_living = "voxspacelaser"
	icon_dead = "voxspacedead"
	attack_sound = 'sound/items/weapons/laser3.ogg'
	ai_controller = /datum/ai_controller/basic_controller/voxraider/ranged

/mob/living/basic/vox/ranged/space/laser/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	var/static/list/death_loot = list(
		/obj/effect/spawner/random/engineering/material_rare = 4,
		)
	AddElement(/datum/element/death_drops, death_loot)
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/energy/laser/hellfire, cooldown_time = ranged_attack_cooldown)

