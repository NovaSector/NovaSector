// Cult
/mob/living/basic/cult
	name = "Blood Cultist"
	desc = "A follower of the Blood Mother."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "cult"
	icon_living = "cult"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speed = 2.5
	maxHealth = 100
	health = 100
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	faction = list(FACTION_HOSTILE, FACTION_CULT)
	///does this type do range attacks?
	var/ranged_attacker = FALSE
	/// How often can we shoot?
	var/ranged_attack_cooldown = 3 SECONDS
	ai_controller =/datum/ai_controller/basic_controller/cult

/mob/living/basic/cult/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/gibspawner/human,
		)
	ADD_TRAIT(src,TRAIT_LAVA_IMMUNE, TRAIT_ASHSTORM_IMMUNE)
	AddElement(/datum/element/death_drops, death_loot)

/*
* Spookyyyyyy
*/

/mob/living/basic/cult/ghost
	name = "Blood Ghost"
	desc = "A ghostly follower of the Blood Mother."
	icon_state = "cultghost"
	icon_living = "cultghost"
	maxHealth = 75
	health = 75
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	ai_controller =/datum/ai_controller/basic_controller/cult

/*
* Are they even alive
*/

/mob/living/basic/cult/mannequin
	name = "Runed Doll"
	desc = "A construct of runed metal and red crystals, a living mannequin."
	icon_state = "mannequin_cult"
	icon_living = "mannequin_cult"
	maxHealth = 120
	health = 120
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	ai_controller =/datum/ai_controller/basic_controller/cult

/mob/living/basic/cult/mannequin/Initialize(mapload)
	. = ..()
	var/static/list/death_loot = list(
		/obj/effect/gibspawner/robot,
		)
	AddElement(/datum/element/death_drops, death_loot)

/*
* Call the ambulance
*/

/mob/living/basic/cult/horror
	name = "Malformed Cultist"
	desc = "A follower of the Blood Mother, either experimented on or just devout enough to be turned into a monster."
	icon_state = "culthorror"
	icon_living = "culthorror"
	maxHealth = 150
	health = 150
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	ai_controller =/datum/ai_controller/basic_controller/cult

/*
* Bro has a SWORD
*/

/mob/living/basic/cult/warrior
	name = "Cultist Warrior"
	desc = "A follower of the Blood Mother, covered in thick armor and armed with a sword and shield."
	icon_state = "cultwarrior"
	icon_living = "cultwarrior"
	maxHealth = 180
	health = 180
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	ai_controller =/datum/ai_controller/basic_controller/cult

/*
* Bro has a spear!!
*/

/mob/living/basic/cult/spear
	name = "Cultist Spearmen"
	desc = "A follower of the Blood Mother, armed with a blood-spear."
	icon_state = "cultspear"
	icon_living = "cultspear"
	maxHealth = 125
	health = 125
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	ai_controller =/datum/ai_controller/basic_controller/cult

/*
* The lizards are here for revenge
*/

/mob/living/basic/cult/assassin
	name = "Cultist Assassin"
	desc = "A follower of the Blood Mother, armed with two ritual daggers."
	icon_state = "cultliz"
	icon_living = "cultliz"
	maxHealth = 125
	health = 125
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	ai_controller =/datum/ai_controller/basic_controller/cult

/*
* pewpew
*/

// magic user
/mob/living/basic/cult/magic
	name = "Cult Blood Mage"
	desc = "A cultist with command over blood magic."
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "cultmage"
	icon_living = "cultmage"
	attack_sound = 'sound/effects/magic/ethereal_enter.ogg'
	maxHealth = 115
	health = 115
	obj_damage = 20
	melee_damage_lower = 12
	melee_damage_upper = 12
	attack_verb_continuous = "punches"
	attack_sound = 'sound/effects/magic/magic_missile.ogg'
	ai_controller = /datum/ai_controller/basic_controller/cult/magic


/obj/projectile/magic/spell/magic_missile/lesser
	color = "red"

/mob/living/basic/cult/magic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/magic/arcane_barrage, cooldown_time = ranged_attack_cooldown)

/*
* FIREBALL USE FIREBALL JUST FIREBALL
*/

/mob/living/basic/cult/magic/elite
	name = "Cult Master"
	desc = "A cultist with powerful command over blood magic, seeming to be at a much higher rank in the cult."
	icon_state = "cultelite"
	icon_living = "cultelite"
	maxHealth = 200
	health = 200
	attack_sound = 'sound/items/weapons/barragespellhit.ogg'

/mob/living/basic/cult/magic/elite/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/magic/fireball, cooldown_time = ranged_attack_cooldown)

/*
* People are way too... 'into' this ones sprite
*/

/mob/living/basic/cult/engorge
	name = "Talon Demon"
	desc = "A demonic creature that moves relatively fast, but doesn't do a lot of damage."
	icon = 'modular_nova/master_files/icons/mob/newmobs32x64.dmi'
	icon_state = "engorgedemon"
	icon_living = "engorgedemon"
	icon_dead = "demondead"
	mob_biotypes = MOB_SPIRIT
	butcher_results = list(/obj/item/stack/sheet/runed_metal/ten = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speak_emote = list("cackles manically")
	maxHealth = 200
	health = 200
	speed = 2
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 25
	attack_verb_continuous = "claws"
	attack_verb_simple = "slice"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'

/*
* the ugly one
*/

/mob/living/basic/cult/engorge/devourdem
	name = "Devour Lord"
	desc = "This creature is terror itself, a manifestation of the raw hunger and avarice of mortals."
	icon = 'modular_nova/master_files/icons/mob/newmobs32x64.dmi'
	icon_state = "devourdemon"
	icon_living = "devourdemon"
	icon_dead = "demondead"
	mob_biotypes = MOB_SPIRIT
	butcher_results = list(/obj/item/stack/sheet/runed_metal/ten = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = 2
	maxHealth = 450
	health = 450
	obj_damage = 80
	melee_damage_lower = 35
	melee_damage_upper = 35
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	attack_sound = 'sound/effects/wounds/crackandbleed.ogg'
	speak_emote = list("hums ominously")
