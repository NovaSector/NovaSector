//// this folder holds nova's abductor mobs.  \\\\

/mob/living/basic/trooper/abductor/nova
	name = "Abductor"
	desc = "He'd like to '◻︎❒︎□︎♌︎♏︎' your '♒︎□︎■︎♎︎♋︎ ♍︎♓︎❖︎♓︎♍︎'."
	icon = 'modular_nova/modules/awaymissions_nova/icons/abductors.dmi'
	icon_state = "abductor_scientist"
	speed = 0.4 // move very aggressively
	melee_damage_lower = 15
	melee_damage_upper = 20
	ai_controller = /datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors
	attack_verb_continuous = "abducts"
	attack_verb_simple = "abduct"
	attack_sound = 'sound/items/weapons/blade1.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	faction = list(ROLE_SYNDICATE)
	loot = list(/obj/effect/mob_spawn/corpse/human/abductor/nova)
	corpse = null // basic abductor uses corpse as a field
	mob_spawner = /obj/effect/mob_spawn/corpse/human/abductor/nova

/mob/living/basic/trooper/abductor/nova/Initialize(mapload) // respond when shot
	. = ..()
	AddElement(/datum/element/relay_attackers)
	RegisterSignal(src, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(immediate_aggro))

/mob/living/basic/trooper/abductor/nova/proc/immediate_aggro(datum/source, mob/attacker, flags)
	SIGNAL_HANDLER
	if(isnull(ai_controller) || stat || !istype(attacker) || ai_controller.blackboard_key_exists(BB_BASIC_MOB_CURRENT_TARGET))
		return
	ai_controller?.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, attacker)

/mob/living/basic/trooper/abductor/nova/melee
	r_hand = /obj/item/melee/baton/abductor
	attack_verb_continuous = "batons"
	attack_verb_simple = "baton"
	attack_sound = 'sound/items/weapons/egloves.ogg'

/mob/living/basic/trooper/abductor/nova/melee/armored
	name = "Abductor Agent"
	desc = "Wielding the finest equipment from ✌︎︎♌︎︎♎︎︎◆︎︎♍︎︎⧫︎︎❄︎♏︎♍︎♒︎."
	maxHealth = 120
	health = 120
	loot = list(/obj/effect/mob_spawn/corpse/human/abductor/nova/combat)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/abductor/nova/combat

/mob/living/basic/trooper/abductor/nova/melee/heavy
	name = "Abductor Trooper"
	desc = "New objective from Abductor Command: 😐︎♓︎♍︎🙵 ⍓︎□︎◆︎❒︎ ♋︎⬧︎⬧︎📬︎"
	icon_state = "abductor_agent"
	maxHealth = 160
	health = 160
	speed = 0.6
	melee_damage_lower = 20
	melee_damage_upper = 35
	ai_controller = /datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors/serious
	loot = list(/obj/effect/mob_spawn/corpse/human/abductor/nova/heavy)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/abductor/nova/heavy

/mob/living/basic/trooper/abductor/nova/ranged
	r_hand = /obj/item/gun/energy/alien
	melee_damage_lower = 5
	melee_damage_upper = 10
	ai_controller = /datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors/ranged
	var/casingtype = /obj/item/ammo_casing/energy/laser/purplebeam // 'mid power laser' - chosen for being funky and purple
	var/projectilesound = 'modular_nova/modules/modular_weapons/sounds/laser_firing/laser.ogg'
	var/burst_shots = 1
	var/ranged_cooldown = 0.5 SECONDS

/mob/living/basic/trooper/abductor/nova/ranged/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = casingtype,\
		projectile_sound = projectilesound,\
		cooldown_time = ranged_cooldown,\
		burst_shots = burst_shots,\
	)

/mob/living/basic/trooper/abductor/nova/ranged/armored
	name = "Abductor Agent"
	desc = "Wielding the finest equipment from ✌︎︎♌︎︎♎︎︎◆︎︎♍︎︎⧫︎︎❄︎♏︎♍︎♒︎."
	maxHealth = 120
	health = 120
	projectilesound = 'modular_nova/modules/modular_weapons/sounds/laser_firing/laser.ogg'
	burst_shots = 2
	ranged_cooldown = 0.4 SECONDS
	loot = list(/obj/effect/mob_spawn/corpse/human/abductor/nova/combat)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/abductor/nova/combat

/mob/living/basic/trooper/abductor/nova/ranged/heavy
	name = "Abductor Trooper"
	desc = "New objective from Abductor Command: 😐︎♓︎♍︎🙵 ⍓︎□︎◆︎❒︎ ♋︎⬧︎⬧︎📬︎"
	icon_state = "abductor_agent_combat_gun"
	maxHealth = 160
	health = 160
	speed = 0.8
	burst_shots = 1
	ranged_cooldown = 0.4
	casingtype = /obj/item/ammo_casing/energy/laser/purplebeam/burst // fires a shotgun blast, not a single bolt
	projectilesound = 'modular_nova/modules/modular_weapons/sounds/laser_firing/incinerate.ogg'
	r_hand = /obj/item/gun/energy/shrink_ray
	ai_controller = /datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors/serious/ranged
	loot = list(/obj/effect/mob_spawn/corpse/human/abductor/nova/heavy)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/abductor/nova/heavy

/mob/living/basic/trooper/abductor/nova/ranged/heavy/boss
	name = "Dr. Tilkmax"
	desc = "Almost certainly not their actual name, but it's a lot more fun if you pretend it is."
	maxHealth = 135
	health = 135
	damage_coeff = list(BRUTE = 0.7, BURN = 1, TOX = 1.2, STAMINA = 0, OXY = 0) // how are you even dealing tox
	speed = 8 // prefers to stay where he is
	burst_shots = 3
	ranged_cooldown = 0.6
	casingtype = /obj/item/ammo_casing/energy/laser/plasma_glob/spam
	r_hand = /obj/item/gun/energy/laser/instakill // just for show
	ai_controller = /datum/ai_controller/basic_controller/trooper/calls_reinforcements/abductors/serious/ranged/boss
	loot = list(/obj/effect/mob_spawn/corpse/human/abductor/nova/boss)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/abductor/nova/boss

/mob/living/basic/trooper/abductor/nova/ranged/heavy/badass // sick as fuck trooper from when i overtuned it
	maxHealth = 300
	health = 300
	speed = 0.9
	burst_shots = 4
	ranged_cooldown = 0.3

// Corpseless variants that leave a 'teleport away' effect behind on death, for when you'd like to use abductors, but not dump alien combat armor on the crew

/mob/living/basic/trooper/abductor/nova/melee/nocorpse
	loot = list(/obj/effect/temp_visual/teleport_abductor/syndi_teleporter)

/mob/living/basic/trooper/abductor/nova/melee/armored/nocorpse
	loot = list(/obj/effect/temp_visual/teleport_abductor/syndi_teleporter)

/mob/living/basic/trooper/abductor/nova/melee/heavy/nocorpse
	loot = list(/obj/effect/temp_visual/teleport_abductor/syndi_teleporter)

/mob/living/basic/trooper/abductor/nova/ranged/nocorpse
	loot = list(/obj/effect/temp_visual/teleport_abductor/syndi_teleporter)

/mob/living/basic/trooper/abductor/nova/ranged/armored/nocorpse
	loot = list(/obj/effect/temp_visual/teleport_abductor/syndi_teleporter)

/mob/living/basic/trooper/abductor/nova/ranged/heavy/nocorpse
	loot = list(/obj/effect/temp_visual/teleport_abductor/syndi_teleporter) // the syndi version is used just because it's quite short

//
