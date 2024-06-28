/obj/effect/mob_spawn/corpse/human/special(mob/living/carbon/human/spawned_human)
	. = ..()
	for (var/obj/item/organ/internal/part in spawned_human.organs)
		part.organ_flags |= ORGAN_UNREMOVABLE

	// clean up corpses after 5 minutes
	spawned_human.AddElement(/datum/element/temporary_atom, 5 MINUTES)

/mob/living/basic/trooper/gakster
	name = "Gakster"
	desc = "This assclown looks like they barely know what they're doing."
	maxHealth = 110
	health = 110
	faction = list(ROLE_SYNDICATE)
	ai_controller = /datum/ai_controller/basic_controller/trooper/gakster
	loot = list(/obj/effect/mob_spawn/corpse/human/gakstermob)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/gakstermob
	mob_size = MOB_SIZE_HUGE
	move_resist = MOVE_FORCE_NORMAL
	speed = 0.8
	// What range do we want this NPC to operate at?
	var/effective_range = 1
	// How long do we take before regenerating after no damage? Mostly to avoid cheese.
	var/regen_delay = 30 SECONDS
	// A list of our melee taunts
	var/list/melee_taunts = list(
		"Eat this, bastard!",
		"Sit the fuck down!",
		"You like that?!",
		"Get fucked!",
		"You ain't shit!",
		"Gimme a hug!",
		"Bitch!",
		"Fuck off!",
		"Die already!",
		"Get bent!",
		"Die, bitch!",
		"Die!",
		"Motherfucker!",
		"Stop struggling!",
		"Hold still!",
		"Stop moving, dammit!",
		"Fuck you!",
	)
	// A list of our taunts we hurl when hurt
	var/list/pain_taunts = list(
		"FUCK!",
		"-Agh, shit!",
		"Ow, fuck!",
		"-Dammit!",
		"Ough-",
		"Fuck-",
		"Ough, shit-",
		"Bastard-",
		"-fuck!",
		"-owh, my arm!",
		"Agh-",
		"Shit-",
		"Fucker!",
		"Can't feel a thing!",
		"Try harder!",
		"Stop resisting!",
		"Fuck you!",
	)
	// A list of our ranged subunit taunts
	var/list/ranged_taunts = list(
		"Get fucked!",
		"Opening fire!",
		"Hostile identified!",
		"Get the fuck down!",
		"On your knees!",
		"I'll make this quick!",
		"Hey, get over here!",
		"Bitch!",
		"Motherfucker!",
		"Get bent!",
		"Die, bitch!",
		"Die!",
		"Firing!",
		"Shoot 'em!",
		"Fucker!",
		"Bastard!",
	)

/mob/living/basic/trooper/gakster/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/regenerator, regeneration_delay = regen_delay, brute_per_second = 8, outline_colour = COLOR_SOFT_RED)
	AddComponent(/datum/component/aggro_speech, speech_list = list(
		"Enemy identified!",
		"Target spotted!",
		"Hostile on scope!",
		"Shit, enemy!",
		"Shit!",
		"Fuck!",
		"Hostile!",
		"Get out of here, Gakster!",
		"Oh, shit!",
		"Drop dead!",
		"Enemy!",
		"Hostile spotted!",
		"Enemy spotted!",
	), speech_chance = 95, subtract_chance = 5, minimum_chance = 15)
	var/datum/callback/retaliate_callback = CALLBACK(src, PROC_REF(gakster_retaliate))
	AddComponent(/datum/component/ai_retaliate_advanced, retaliate_callback)
	AddElement(/datum/element/ai_flee_while_injured)

/mob/living/basic/trooper/gakster/melee_attack(mob/living/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target))
		return
	taunt_target_melee()

/mob/living/basic/trooper/gakster/proc/taunt_target_melee()
	if(prob(5))
		say(language = /datum/language/gutter, message = pick(melee_taunts))

/mob/living/basic/trooper/gakster/apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, attack_direction, attacking_item)
	. = ..()
	taunt_pain()

/mob/living/basic/trooper/gakster/proc/taunt_pain()
	if(prob(5))
		say(language = /datum/language/gutter, message = pick(pain_taunts))

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
	speed = 0.5

/mob/living/basic/trooper/gakster/ranged
	desc = "A gakster armed with a Seiba .27-54 submachinegun. They look pretty angry."
	loot = list(/obj/effect/mob_spawn/corpse/human/gakstermob, /obj/item/gun/ballistic/automatic/seiba_smg, /obj/item/ammo_box/magazine/miecz)
	ai_controller = /datum/ai_controller/basic_controller/trooper/gakster/ranged
	r_hand = /obj/item/gun/ballistic/automatic/seiba_smg
	var/casingtype = /obj/item/ammo_casing/c27_54cesarzowa
	var/projectilesound = 'modular_np_lethal/lethalguns/sound/seiba/seiba.wav'
	var/burst_shots = 2
	var/ranged_cooldown = 0.8 SECONDS
	speed = 0.9
	effective_range = 4

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

/mob/living/basic/trooper/gakster/ranged/RangedAttack(atom/A, modifiers)
	. = ..()
	taunt_target_ranged()

/mob/living/basic/trooper/gakster/ranged/proc/taunt_target_ranged()
	if(prob(5))
		say(language = /datum/language/gutter, message = pick(ranged_taunts))

/mob/living/basic/trooper/gakster/suicide
	name = "Gakster Suicide Bomber"
	desc = "Oh, fuck, this dude's definitely Yellow Company."
	mob_spawner = /obj/effect/mob_spawn/corpse/human/gakstersuicide
	loot = list(/obj/effect/gibspawner/human)
	ai_controller = /datum/ai_controller/basic_controller/trooper/gakster/suicide
	maxHealth = 80
	health = 80
	speed = 0.8
	melee_damage_lower = 0
	melee_damage_upper = 0
	attack_verb_continuous = "explodes"
	attack_verb_simple = "explode"
	l_hand = /obj/item/grenade/c4
	r_hand = /obj/item/grenade/c4
	var/list/explosive_retorts = list(
		"COME HERE!!",
		"AAAAAAAAAA!!",
		"FOR GLORY!!",
		"DIIIIEEEE!!",
		"CHECK THIS SHIT!!",
		"I'M GONNA BLOW UP!!",
		"BOOM TIME!!",
		"BOOM-BOOM!!",
		"TIME TO DIE!!",
		"TARGET SPOTTED!!",
		"GET 'EM!!",
		"YOUR TIME HAS COME!!",
		"MY MAIN PLAN IS TO BLOW UP!!"
		)

/mob/living/basic/trooper/gakster/suicide/melee_attack(mob/living/target, list/modifiers, ignore_cooldown)
	. = ..()
	explosion(src, 0, 1, 2, 3)
	gib()

/mob/living/basic/trooper/gakster/suicide/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/aggro_speech, speech_list = explosive_retorts, speech_chance = 100, subtract_chance = 5, minimum_chance = 15)

/mob/living/basic/trooper/gakster/filtre
	name = "Blue Company Filtre"
	desc = "This well-armored assclown looks like they barely know what they're doing."
	maxHealth = 300
	health = 300
	faction = list(ROLE_DEATHSQUAD)
	loot = list(/obj/effect/mob_spawn/corpse/human/filtremob)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/filtremob
	speed = 1.2

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
	effective_range = 8
	ranged_cooldown = 0.5 SECONDS
	speed = 1.2

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
	speed = 1
	regen_delay = 5 SECONDS
	effective_range = 5
	ranged_taunts = list(
		"Burn.",
		"BURN!!!",
		"THESE GUNS ARE HOT!!!",
		"ASHES, ASHES!!!",
	)
	pain_taunts = list(
		"THAT BURNS!!!",
		"NOW WE'RE GETTING HEATED!",
		"AUGH!!!",
		"I'M BURNING UP!!!",
	)

// 201 Fathomer : Drops Ramu 6 gauge shotgun, a bunch of 6g longshot ammo, and sacrificial armor
/mob/living/basic/trooper/gakster/ranged/fathomer
	name = "201 Fathomer"
	desc = "Armed with a Ramu 6 gauge shotgun, this gakster is notorious for their potency in close quarters combat."
	maxHealth = 450
	health = 450
	faction = list("UpCloseAndPersonal")
	loot = list(/obj/effect/mob_spawn/corpse/human/fathomer, /obj/item/gun/ballistic/shotgun/ramu, /obj/item/ammo_box/magazine/ammo_stack/s6gauge/prefilled/longshot = 2)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/fathomer
	r_hand = /obj/item/gun/ballistic/shotgun/ramu
	casingtype = /obj/item/ammo_casing/s6gauge/longshot
	projectilesound = 'modular_np_lethal/lethalguns/sound/ramu/ramu.wav'
	regen_delay = 10 SECONDS
	burst_shots = 1
	ranged_cooldown = 1.3 SECONDS
	speed = 0.6
	effective_range = 2
	ranged_taunts = list(
		"Come a little closer...",
		"I don't bite.",
		"Just the way it's gotta be.",
	)
	pain_taunts = list(
		"Ungh...",
		"Not bad.",
		"It's all a dance.",
		"Rrgh...",
	)

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
	burst_shots = 4
	ranged_cooldown = 0.4 SECONDS
	speed = 1.1
	effective_range = 7
	regen_delay = 5 SECONDS
	ranged_taunts = list(
		"You think you can deal with me?",
		"I'M A FUCKING WALL!!!",
		"YOU'RE NOTHING!!!",
		"I'M GOING TO FUCKING KILL YOU!!!",
		"EAT LEAD!!!",
	)
	pain_taunts = list(
		"Didn't even feel it.",
		"Tickles.",
		"Is that all you've got?",
		"Almost felt that one.",
		"May have... been a mistake...",
	)

// 287 Prophet : Drops double energy sword and type five armor
/mob/living/basic/trooper/gakster/melee/prophet
	name = "287 Prophet"
	desc = "A near-mythical triple-digit gakster wielding a rare double-bladed energy sword and clad in the heaviest of armor, who remains lightning fast despite it all. Are you certain whatever you're doing is worth it?"
	maxHealth = 600
	health = 600
	faction = list("NeverShouldHaveComeHere")
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
	speed = 0.1
	regen_delay = 10 SECONDS
	melee_taunts = list(
		"Regret comes.",
		"Why do you fight?",
		"I've lost count.",
		"Just another number.",
		"There's nothing for you here.",
		"This is for your own good.",
		"You aren't ready.",
		"You were never ready.",
	)
	pain_taunts = list(
		"What is this sensation?",
		"I feel again.",
		"Is my journey finally over?",
		"Keep going.",
		"Finally.",
	)
