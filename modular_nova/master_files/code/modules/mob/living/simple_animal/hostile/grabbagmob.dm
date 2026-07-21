// Syndicate

/mob/living/basic/trooper/syndicate/melee/anthro
	name = "Syndicate Shanker"
	desc = "An anthromorphic red panda member of the Syndicate, wielding a knife."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndiredpan"
	icon_living = "syndiredpan"

/mob/living/basic/trooper/syndicate/melee/sword/anthro
	name = "Syndicate Sword Beast"
	desc = "An anthromorphic fennec member of the Syndicate, wielding an energy sword and shield."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndifennec"
	icon_living = "syndifennec"

/mob/living/basic/trooper/syndicate/ranged/anthro
	name = "Syndicate Pistoleer"
	desc = "An anthromorphic member of the Syndicate, wielding a pistol."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndisquirrel"
	icon_living = "syndisquirrel"

/mob/living/basic/trooper/syndicate/ranged/smg/anthro
	name = "Syndicate Rapid Gunnder"
	desc = "A moth-person member of the Syndicate, wielding an SMG."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndimoth"
	icon_living = "syndimoth"

/mob/living/basic/trooper/syndicate/melee/space/anthro/lizard
	name = "Syndicate Commando Lizard"
	desc = "A reptilian member of the Syndicate!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndilizard"
	icon_living = "syndilizard"

/mob/living/basic/trooper/syndicate/ranged/space/anthro/cat
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndicat"
	icon_living = "syndicat"
	name = "Syndicate Commando Feline"
	desc = "An anthromorphic feline member of the Syndicate."

/mob/living/basic/trooper/syndicate/ranged/shotgun/space/stormtrooper/anthro/fox
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "syndifox"
	icon_living = "syndifox"
	name = "Syndicate Stormtrooper Fox"
	desc = "An anthromorphic fox member of the Syndicate."

// Beasts

/mob/living/basic/bigcrab
	name = "giant crab"
	desc = "Clickity Clack!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "giantcrab"
	icon_living = "giantcrab"
	icon_dead = "giantcrab_d"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	butcher_results = list(/obj/item/food/meat/slab/rawcrab = 8, /obj/item/stack/sheet/bone = 4)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = 2
	maxHealth = 150
	health = 150
	obj_damage = 40
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "claws"
	attack_verb_simple = "pinch"
	attack_sound = 'sound/items/weapons/genhit2.ogg'
	speak_emote = list("gnashes")
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	faction = list(FACTION_HOSTILE)
	gold_core_spawnable = HOSTILE_SPAWN
	basic_mob_flags = DEL_ON_DEATH
	combat_mode = TRUE
	ai_controller = /datum/ai_controller/basic_controller/bigcrab

/datum/ai_controller/basic_controller/bigcrab
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/living/simple_animal/hostile/bigcrab.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/bigcrab
	speech_chance = 30
	emote_see = list("snaps")

/mob/living/basic/trog
	name = "mutated human"
	desc = "Either some kind of experiment gone wrong, or the result of mutations from plasma exposure."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "trog"
	icon_living = "trog"
	icon_dead = "trog_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	butcher_results = list(/obj/item/food/meat/slab/human = 4)
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "shoos away"
	response_disarm_simple = "shoo away"
	speed = 0
	maxHealth = 80
	health = 80
	obj_damage = 30
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("screeches")
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	faction = list(FACTION_HOSTILE)
	gold_core_spawnable = HOSTILE_SPAWN
	basic_mob_flags = DEL_ON_DEATH
	combat_mode = TRUE
	ai_controller = /datum/ai_controller/basic_controller/trog

/mob/living/basic/trog/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/datum/ai_controller/basic_controller/trog
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/living/simple_animal/hostile/trog.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/trog
	speech_chance = 30
	emote_see = list("screeches")

/mob/living/basic/plantmutant
	name = "plant mutant"
	desc = "Some sort of humanoid mutated by plants or fungus spores into a horrific monster."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "plantmonster"
	icon_living = "plantmonster"
	icon_dead = "plantmonster_dead"
	mob_biotypes = MOB_ORGANIC|MOB_PLANT
	butcher_results = list(/obj/item/food/meat/slab/human/mutant/plant = 4)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = 0
	maxHealth = 90
	health = 90
	obj_damage = 10
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "bites"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("gurlges")
	habitable_atmos = list("min_oxy" = 10, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	faction = list(FACTION_HOSTILE, "vines", "plants")
	gold_core_spawnable = HOSTILE_SPAWN
	basic_mob_flags = DEL_ON_DEATH
	combat_mode = TRUE
	ai_controller = /datum/ai_controller/basic_controller/plantmutant

/mob/living/basic/plantmutant/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/datum/ai_controller/basic_controller/plantmutant
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/living/simple_animal/hostile/plantmutant.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/plantmutant
	speech_chance = 30
	emote_see = list("gnashes")

/mob/living/basic/cazador
	name = "cazador"
	desc = "You feel a little whoozy..."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "cazador"
	icon_living = "cazador"
	icon_dead = "cazador_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	/// Loot this mob drops on death.
	var/list/loot = list(/obj/item/reagent_containers/cup/bottle/rezadone)
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = 0
	maxHealth = 60
	health = 60
	melee_damage_type = TOX
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"
	attack_sound = 'sound/items/weapons/genhit2.ogg'
	speak_emote = list("buzzes")
	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 800
	faction = list(FACTION_HOSTILE)
	gold_core_spawnable = HOSTILE_SPAWN
	basic_mob_flags = DEL_ON_DEATH
	combat_mode = TRUE
	ai_controller = /datum/ai_controller/basic_controller/cazador

/mob/living/basic/cazador/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	if(LAZYLEN(loot))
		loot = string_list(loot)
		AddElement(/datum/element/death_drops, loot)

/datum/ai_controller/basic_controller/cazador
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/living/simple_animal/hostile/cazador.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/cazador
	speech_chance = 30
	emote_see = list("buzzes")

/mob/living/basic/mutantliz
	name = "mutant lizard"
	desc = "A large, mutated lizard-creature with jagged teeth and sharp claws."
	icon = 'modular_nova/master_files/icons/mob/newmobs64x64.dmi'
	icon_state = "mutantliz"
	icon_living = "mutantliz"
	icon_dead = "mutantliz_d"
	mob_biotypes = MOB_ORGANIC|MOB_REPTILE
	butcher_results = list(/obj/item/food/meat/slab/human/mutant/lizard = 6)
	response_help_continuous = "pats"
	response_help_simple = "pat"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = 1
	maxHealth = 250
	health = 250
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	speak_emote = list("growls")
	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 800
	faction = list(FACTION_HOSTILE)
	gold_core_spawnable = NO_SPAWN
	basic_mob_flags = DEL_ON_DEATH
	combat_mode = TRUE
	ai_controller = /datum/ai_controller/basic_controller/mutantliz

/datum/ai_controller/basic_controller/mutantliz
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/living/simple_animal/hostile/mutantliz.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/mutantliz
	speech_chance = 30
	emote_see = list("roars")

/mob/living/basic/scorpion
	name = "big scorpion"
	desc = "An abnormally large scorpion. Watch that stinger!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "scorpion"
	icon_living = "scorpion"
	icon_dead = "scorpion_d"
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = 0
	maxHealth = 75
	health = 75
	melee_damage_type = TOX
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"
	attack_sound = 'sound/items/weapons/genhit2.ogg'
	speak_emote = list("chitters")
	habitable_atmos = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 900
	faction = list(FACTION_HOSTILE)
	gold_core_spawnable = HOSTILE_SPAWN
	basic_mob_flags = DEL_ON_DEATH
	combat_mode = TRUE
	ai_controller = /datum/ai_controller/basic_controller/scorpion

/datum/ai_controller/basic_controller/scorpion
	behavior_tree_json = "code/datums/ai/basic_mobs/simple_hostile_obstacles.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance

/mob/living/basic/syndimouse
	name = "Syndicate Mousepretive"
	desc = "A mouse in a Syndicate combat MODsuit, built for mice!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "mouse_operative"
	icon_living = "mouse_operative"
	icon_dead = "mouse_operative_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = 0
	maxHealth = 30
	health = 30
	obj_damage = 25
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "bosses"
	attack_verb_simple = "boss"
	attack_sound = 'sound/items/weapons/cqchit2.ogg'
	speak_emote = list("squeaks")
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1500
	faction = list(ROLE_SYNDICATE)
	gold_core_spawnable = HOSTILE_SPAWN
	basic_mob_flags = DEL_ON_DEATH
	combat_mode = TRUE
	ai_controller = /datum/ai_controller/basic_controller/syndimouse

/mob/living/basic/syndimouse/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/datum/ai_controller/basic_controller/syndimouse
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/living/simple_animal/hostile/syndimouse.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	ai_movement = /datum/ai_movement/basic_avoidance

/datum/bt_node/ai_behavior/random_speech/syndimouse
	speech_chance = 30
	emote_hear = list("aggressively squeaks")
	emote_see = list("squeaks.", "practices CQC.", "cocks the bolt of a tiny CR20.", "plots to steal DAT DISK!", "fiddles with a tiny radio.")
