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

/mob/living/simple_animal/hostile/bigcrab
	name = "giant crab"
	desc = "Clickity Clack!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "giantcrab"
	icon_living = "giantcrab"
	icon_dead = "giantcrab_d"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/food/meat/slab/rawcrab = 8, /obj/item/stack/sheet/bone = 4)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("snaps")
	taunt_chance = 30
	move_to_delay = 20
	speed = 2
	maxHealth = 150
	health = 150
	harm_intent_damage = 3
	obj_damage = 40
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "claws"
	attack_verb_simple = "pinch"
	attack_sound = 'sound/items/weapons/genhit2.ogg'
	speak_emote = list("gnashes")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/trog
	name = "mutated human"
	desc = "Either some kind of experiment gone wrong, or the result of mutations from plasma exposure."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "trog"
	icon_living = "trog"
	icon_dead = "trog_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/food/meat/slab/human = 4)
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "shoos away"
	response_disarm_simple = "shoo away"
	emote_taunt = list("screeches")
	taunt_chance = 30
	speed = 0
	maxHealth = 80
	health = 80
	harm_intent_damage = 8
	obj_damage = 30
	melee_damage_lower = 18
	melee_damage_upper = 18
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("screeches")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/trog/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/plantmutant
	name = "plant mutant"
	desc = "Some sort of humanoid mutated by plants or fungus spores into a horrific monster."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "plantmonster"
	icon_living = "plantmonster"
	icon_dead = "plantmonster_dead"
	mob_biotypes = MOB_ORGANIC|MOB_PLANT
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/food/meat/slab/human/mutant/plant = 4)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("gnashes")
	taunt_chance = 30
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
	atmos_requirements = list("min_oxy" = 10, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(FACTION_HOSTILE, "vines", "plants")
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/plantmutant/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/cazador
	name = "cazador"
	desc = "You feel a little whoozy..."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "cazador"
	icon_living = "cazador"
	icon_dead = "cazador_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	speak_chance = 0
	turns_per_move = 5
	loot = list(/obj/item/reagent_containers/cup/bottle/rezadone)
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("buzzes")
	taunt_chance = 30
	speed = 0
	maxHealth = 60
	health = 60
	melee_damage_type = TOX
	melee_damage_lower = 25
	melee_damage_upper = 25
	move_to_delay = 4
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"
	attack_sound = 'sound/items/weapons/genhit2.ogg'
	speak_emote = list("buzzes")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 800
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/cazador/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/mutantliz
	name = "mutant lizard"
	desc = "A large, mutated lizard-creature with jagged teeth and sharp claws."
	icon = 'modular_nova/master_files/icons/mob/newmobs64x64.dmi'
	icon_state = "mutantliz"
	icon_living = "mutantliz"
	icon_dead = "mutantliz_d"
	mob_biotypes = MOB_ORGANIC|MOB_REPTILE
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/food/meat/slab/human/mutant/lizard = 6)
	response_help_continuous = "pats"
	response_help_simple = "pat"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("roars")
	taunt_chance = 30
	speed = 1
	maxHealth = 250
	health = 250
	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	speak_emote = list("growls")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 800
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/hostile/scorpion
	name = "big scorpion"
	desc = "An abnormally large scorpion. Watch that stinger!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "scorpion"
	icon_living = "scorpion"
	icon_dead = "scorpion_d"
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = 0
	maxHealth = 75
	health = 75
	melee_damage_type = TOX
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"
	attack_sound = 'sound/items/weapons/genhit2.ogg'
	speak_emote = list("chitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 900
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/syndimouse
	name = "Syndicate Mousepretive"
	desc = "A mouse in a Syndicate combat MODsuit, built for mice!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "mouse_operative"
	icon_living = "mouse_operative"
	icon_dead = "mouse_operative_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("aggressively squeaks")
	taunt_chance = 30
	speed = 0
	maxHealth = 30
	health = 30
	harm_intent_damage = 5
	obj_damage = 25
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "bosses"
	attack_verb_simple = "boss"
	attack_sound = 'sound/items/weapons/cqchit2.ogg'
	speak_emote = list("squeaks")
	emote_see = list("squeaks.", "practices CQC.", "cocks the bolt of a tiny CR20.", "plots to steal DAT DISK!", "fiddles with a tiny radio.")
	speak_chance = 1
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(ROLE_SYNDICATE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/syndimouse/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/mannequin
	name = "living mannequin"
	desc = "A strange, living, wooden mannequin. Spooky!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "mannequin"
	icon_living = "mannequin"
	mob_biotypes = MOB_UNDEAD
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "poke"
	response_help_simple = "poke"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = 2
	maxHealth = 50
	health = 50
	harm_intent_damage = 3
	obj_damage = 15
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/cqchit1.ogg'
	speak_emote = list("clacks")
	atmos_requirements = null
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(FACTION_HOSTILE)
	pressure_resistance = 200
	gold_core_spawnable = HOSTILE_SPAWN
