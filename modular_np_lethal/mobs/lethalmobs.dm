/mob/living/basic/trooper/gakster
	name = "Gakster"
	desc = "This assclown looks like they barely know what they're doing."
	maxHealth = 150
	health = 150
	faction = list(ROLE_SYNDICATE)
	loot = list(/obj/effect/mob_spawn/corpse/human/gakstermob)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/gakstermob

/mob/living/basic/trooper/gakster/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/regenerator, regeneration_delay = 30 SECONDS, brute_per_second = 8, outline_colour = COLOR_SOFT_RED)

/mob/living/basic/trooper/gakster/melee
	desc = "A gakster with a combat knife and very little to lose."
	loot = list(/obj/effect/mob_spawn/corpse/human/gakstermob, /obj/item/knife/combat)
	melee_damage_lower = 20
	melee_damage_upper = 25
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	r_hand = /obj/item/knife/combat

/mob/living/basic/trooper/gakster/ranged
	desc = "A gakster armed with a Seiba .27-54 submachinegun. They look pretty angry."
	loot = list(/obj/effect/mob_spawn/corpse/human/gakstermob, /obj/item/gun/ballistic/automatic/seiba_smg, /obj/item/ammo_box/magazine/miecz)
	ai_controller = /datum/ai_controller/basic_controller/trooper/ranged
	r_hand = /obj/item/gun/ballistic/automatic/seiba_smg
	var/casingtype = /obj/item/ammo_casing/c27_54cesarzowa
	var/projectilesound = 'modular_np_lethal/lethalguns/sound/seiba/seiba.wav'
	var/burst_shots = 3
	var/ranged_cooldown = 0.4 SECONDS

/mob/living/basic/trooper/gakster/ranged/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = casingtype,\
		projectile_sound = projectilesound,\
		cooldown_time = ranged_cooldown,\
		burst_shots = burst_shots,\
	)
	if (ranged_cooldown <= 1 SECONDS)
		AddComponent(/datum/component/ranged_mob_full_auto)

/mob/living/basic/trooper/gakster/filtre
	name = "Blue Company Filtre"
	desc = "This well-armored assclown looks like they barely know what they're doing."
	maxHealth = 300
	health = 300
	faction = list(ROLE_DEATHSQUAD)
	loot = list(/obj/effect/mob_spawn/corpse/human/filtremob)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/filtremob

/mob/living/basic/trooper/gakster/melee/filtre
	name = "Blue Company Filtre"
	desc = "A filtre with a combat knife and nerves of steel."
	faction = list(ROLE_DEATHSQUAD)
	loot = list(/obj/effect/mob_spawn/corpse/human/filtremob, /obj/item/knife/combat)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/filtremob

/mob/living/basic/trooper/gakster/ranged/filtre
	name = "Blue Company Filtre"
	desc = "A filtre wielding a Yari 12mm suppressed rifle. They seem decently upset!"
	faction = list(ROLE_DEATHSQUAD)
	loot = list(/obj/effect/mob_spawn/corpse/human/filtremob, /obj/item/gun/ballistic/automatic/suppressed_rifle, /obj/item/ammo_box/magazine/c12chinmoku/standard)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/filtremob
	r_hand = /obj/item/gun/ballistic/automatic/suppressed_rifle
	casingtype = /obj/item/ammo_casing/c12chinmoku
	projectilesound = 'modular_np_lethal/lethalguns/sound/yari/yari.wav'
	burst_shots = 1
	ranged_cooldown = 0.5 SECONDS

/// BOSS MOBS

// 178 Razor : Drops Kiboko, handful of incendiary .980 rounds, and type three armor

/mob/living/basic/trooper/gakster/ranged/razor
	name = "178 Razor"
	desc = "A well-respected gakster whose primary claim to fame is their overwhelming love for pyrotechnics and incendiary weaponry."
	maxHealth = 450
	health = 450
	loot = list(/obj/effect/mob_spawn/corpse/human/razor, /obj/item/gun/ballistic/automatic/sol_grenade_launcher/evil, /obj/item/ammo_box/magazine/ammo_stack/c980/prefilled/fire)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/razor
	r_hand = /obj/item/gun/ballistic/automatic/sol_grenade_launcher/evil
	casingtype = /obj/item/ammo_casing/c980grenade/shrapnel/phosphor
	projectilesound = 'modular_nova/modules/modular_weapons/sounds/grenade_launcher.ogg'
	burst_shots = 1
	ranged_cooldown = 2.5 SECONDS

// 201 Fathomer : Drops Ramu 6 gauge shotgun, a bunch of 6g longshot ammo, and sacrificial armor
/mob/living/basic/trooper/gakster/ranged/fathomer
	name = "201 Fathomer"
	desc = "Armed with a Ramu 6 gauge shotgun, this gakster is notorious for their potency in close quarters combat."
	maxHealth = 450
	health = 450
	loot = list(/obj/effect/mob_spawn/corpse/human/fathomer, /obj/item/gun/ballistic/shotgun/ramu, /obj/item/ammo_box/magazine/ammo_stack/s6gauge/prefilled/longshot = 2)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/fathomer
	r_hand = /obj/item/gun/ballistic/shotgun/ramu
	casingtype = /obj/item/ammo_casing/s6gauge/longshot
	projectilesound = 'modular_np_lethal/lethalguns/sound/ramu/ramu.wav'
	burst_shots = 1
	ranged_cooldown = 1.3 SECONDS

// 253 Chauchat : Drops a Seiba & ballistic shield alongside ammunition and a full set of type 3 armor + helmet
/mob/living/basic/trooper/gakster/ranged/chauchat
	name = "253 Chauchat"
	desc = "With an ever-imposing ballistic shield and a lightweight submachinegun, this gakster seems prepared to take on nearly any foe."
	maxHealth = 600
	health = 600
	loot = list(/obj/effect/mob_spawn/corpse/human/chauchat, /obj/item/shield/ballistic, /obj/item/gun/ballistic/automatic/seiba_smg, /obj/item/ammo_box/magazine/miecz = 2)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/chauchat
	r_hand = /obj/item/shield/ballistic
	l_hand = /obj/item/gun/ballistic/automatic/seiba_smg
	casingtype = /obj/item/ammo_casing/c27_54cesarzowa
	projectilesound = 'modular_np_lethal/lethalguns/sound/seiba/seiba.wav'
	burst_shots = 3
	ranged_cooldown = 0.4 SECONDS

// 287 Prophet : Drops double energy sword and type five armor - IMMUNE TO RANGED ATTACKS - NO THEY ARENT FUCK YOU!!!
/mob/living/basic/trooper/gakster/melee/prophet
	name = "287 Prophet"
	desc = "A near-mythical triple-digit gakster wielding a rare double-bladed energy sword and clad in the heaviest of armor. Are you certain whatever you're doing is worth it?"
	maxHealth = 600
	health = 600
	loot = list(/obj/effect/mob_spawn/corpse/human/prophet, /obj/item/dualsaber/red)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/prophet
	melee_damage_lower = 40
	melee_damage_upper = 40
	attack_verb_continuous = "eviscerates"
	attack_verb_simple = "eviscerate"
	attack_sound = 'sound/weapons/blade1.ogg'
	r_hand = /obj/item/dualsaber/basicmob
	armour_penetration = 35
	light_range = 6
	light_power = 2.5
	light_color = COLOR_SOFT_RED
