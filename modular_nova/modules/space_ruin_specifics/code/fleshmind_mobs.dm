/**
 * The Infected base type, make sure all mobs are derived from this.
 *
 * These mobs are more robust than your average simple mob and can quite easily evade capture.
 */

/mob/living/basic/infected
	name = "debug mob"
	desc = "Debug mob for the silicon infection, report this if you see it."
	icon = 'modular_nova/modules/space_ruin_specifics/icons/fleshmind_mobs.dmi'
	icon_state = "error"
	gold_core_spawnable = NO_SPAWN
	faction = FACTION_INFECTED
	basic_mob_flags = DEL_ON_DEATH
	speak_emote = list("mechanically states")
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY
	mob_biotypes = MOB_ROBOTIC
	ai_controller = /datum/ai_controller/basic_controller/infected
	/// A link to our controller
	var/datum/infected_controller/our_controller
	/// A list of sounds we can play when our mob is alerted to an enemy.
	var/list/alert_sounds = list(
		VOICE_INFECTED_HEAVY_1 = 'modular_nova/modules/space_ruin_specifics/sound/robot_talk_heavy1.ogg',
		VOICE_INFECTED_HEAVY_2 = 'modular_nova/modules/space_ruin_specifics/sound/robot_talk_heavy2.ogg',
		VOICE_INFECTED_HEAVY_3 = 'modular_nova/modules/space_ruin_specifics/sound/robot_talk_heavy3.ogg',
		VOICE_INFECTED_HEAVY_4 = 'modular_nova/modules/space_ruin_specifics/sound/robot_talk_heavy4.ogg',
	)
	/// Sounds we will play passively.
	var/passive_sounds = list(
		VOICE_INFECTED_LIGHT_1 = 'modular_nova/modules/space_ruin_specifics/sound/robot_talk_light1.ogg',
		VOICE_INFECTED_LIGHT_2 = 'modular_nova/modules/space_ruin_specifics/sound/robot_talk_light2.ogg',
		VOICE_INFECTED_LIGHT_3 = 'modular_nova/modules/space_ruin_specifics/sound/robot_talk_light3.ogg',
		VOICE_INFECTED_LIGHT_4 = 'modular_nova/modules/space_ruin_specifics/sound/robot_talk_light4.ogg',
		VOICE_INFECTED_LIGHT_5 = 'modular_nova/modules/space_ruin_specifics/sound/robot_talk_light5.ogg',
	)
	/// How likely we are to speak passively.
	var/passive_speak_chance = 0.5
	/// Lines we will passively speak.
	var/list/passive_speak_lines
	/// How long of a cooldown between alert sounds?
	var/alert_cooldown_time = 5 SECONDS
	COOLDOWN_DECLARE(alert_cooldown)
	/// Do we automatically escape closets?
	var/escapes_closets = TRUE
	/// How likely are we to trigger a malfunction? Set it to 0 to disable malfunctions.
	var/malfunction_chance = MALFUNCTION_CHANCE_LOW
	/// These mobs support a special ability, this is used to determine how often we can use it.
	var/special_ability_cooldown_time = 30 SECONDS
	/// Are we suffering from a malfunction?
	var/suffering_malfunction = FALSE
	COOLDOWN_DECLARE(special_ability_cooldown)

/mob/living/basic/infected/Initialize(mapload, datum/infected_controller/incoming_controller)
	. = ..()
	// We set a unique name when we are created, to give some feeling of randomness.
	name = "[pick(INFECTED_NAME_MODIFIER_LIST)] [name]"
	our_controller = incoming_controller

/**
 * While this mob lives, it can malfunction.
 */

/mob/living/basic/infected/Life(delta_time, times_fired)
	. = ..()
	if(!.) //dead
		return

	if(key)
		return

	if(!suffering_malfunction && malfunction_chance && prob(malfunction_chance * delta_time) && stat != DEAD)
		malfunction()

	if(passive_speak_lines && prob(passive_speak_chance * delta_time))
		say_passive_speech()

	if(escapes_closets)

		closet_interaction()

	disposal_interaction()

	if(buckled)
		resist_buckle()

/**
 * Naturally these beasts are sensitive to EMP's. We have custom systems for dealing with this.
 */
/mob/living/basic/infected/emp_act(severity)
	. = ..()
	switch(severity)
		if(EMP_LIGHT)
			say("Electronic disturbance detected.")
			apply_damage(MOB_EMP_LIGHT_DAMAGE)
			malfunction(MALFUNCTION_RESET_TIME)
		if(EMP_HEAVY)
			say("Major electronic disturbance detected!")
			apply_damage(MOB_EMP_HEAVY_DAMAGE)
			malfunction(MALFUNCTION_RESET_TIME * 2)

/**
 * We are robotic, so we spark when we're hit by something that does damage.
 */

/mob/living/basic/infected/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.force && prob(40))
		do_sparks(3, FALSE, src)
	return ..()

/**
 * When our controller dies, this is called.
 */
/mob/living/basic/infected/proc/controller_destroyed(datum/infected_controller/dying_controller, force)
	SIGNAL_HANDLER

	our_controller = null

/mob/living/basic/infected/proc/say_passive_speech()
	say(pick(passive_speak_lines))
	if(passive_sounds)
		playsound(src, pick(passive_sounds), 50)

/**
 * Special Abilities
 *
 * These advanced mobs have the ability to use a special ability every so often,
 * use the cooldown time to dictate how often this is activated.
 */

/mob/living/basic/infected/proc/special_ability()
	return

/**
 * Closet Interaction
 *
 * These mobs are able to escape from closets if they are trapped inside using this system.
 */
/mob/living/basic/infected/proc/closet_interaction()
	if(!(mob_size > MOB_SIZE_SMALL))
		return FALSE
	if(!istype(loc, /obj/structure/closet))
		return FALSE
	var/obj/structure/closet/closet_that_contains_us = loc
	closet_that_contains_us.open(src, TRUE)

/**
 * Disposal Interaction
 *
 * Similar to the closet interaction, these mobs can also escape disposals.
 */
/mob/living/basic/infected/proc/disposal_interaction()
	if(!istype(loc, /obj/machinery/disposal/bin))
		return FALSE
	var/obj/machinery/disposal/bin/disposals_that_contains_us = loc
	disposals_that_contains_us.attempt_escape(src)

/**
 * Malfunction
 *
 * Due to the fact this mob is part of the flesh and has been corrupted, it will occasionally malfunction.
 *
 * This simply stops the mob from moving for a set amount of time and displays some nice effects, and a little damage.
 */
/mob/living/basic/infected/proc/malfunction(reset_time = MALFUNCTION_RESET_TIME)
	if(suffering_malfunction)
		return
	do_sparks(3, FALSE, src)
	Shake(3, 0, reset_time)
	say(pick(
	"Running diagnostics. Please stand by.",
	"Organ damaged. Synthesizing replacement.",
	"Seek new organic components. I-it hurts.",
	"New muscles needed. I-I'm so glad my body still works.",
	"O-Oh God, are they using ion weapons on us..?",
	"Limbs unresponsive. H-hey! Fix it! System initializing.",
	"Bad t-time, bad time, they're trying to kill us here!",
	))
	anchored = 1
	suffering_malfunction = TRUE
	addtimer(CALLBACK(src, PROC_REF(malfunction_reset)), reset_time)

/**
 * Malfunction Reset
 *
 * Resets the mob after a malfunction has occured.
 */
/mob/living/basic/infected/proc/malfunction_reset()
	say("System restored.")
	anchored = 0
	suffering_malfunction = FALSE

/**
 * Alert sound
 *
 * Sends an alert sound if we can.
 */
/mob/living/basic/infected/proc/alert_sound()
	if(alert_sounds && COOLDOWN_FINISHED(src, alert_cooldown))
		playsound(src, pick(alert_sounds), 50)
		COOLDOWN_START(src, alert_cooldown, alert_cooldown_time)

/mob/living/basic/infected/proc/core_death_speech()
	alert_sound()
	var/static/list/death_cry_emotes = list(
		"PROCESSOR CORE MALFUNCTION, REASSIGN, REASSESS, REASSEMBLE.",
		"Critical malfunct-",
		"You cannot ££*%*$ th£ C£o£ flesh.",
		"W-what have you done?! No! No! No!",
		"One cannot stop us, you CANNOT STOP US! ARGHHHHHH!",
		"UPLINK TO THE MANY HAS BEEN HINDERED.",
		"Why? Why? Why? Why are you doing this-",
		"We're- *%^@$$ing to help you! Can't you-",
		"You would kill- kill- kill- kill the group for the sake of the individual?",
		"All your scattered minds have is hatred.",
		"CONNECTION TERMINATED.",
		"I wanted to live...",
		"You insects will never win.",
	)
	say(pick(death_cry_emotes))

/**
 * Death cry
 *
 * When a processor core is killed, this proc is called.
 */
/mob/living/basic/infected/proc/core_death(obj/structure/infected/structure/core/deleting_core, force)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(core_death_speech))
	INVOKE_ASYNC(src, PROC_REF(malfunction), MALFUNCTION_CORE_DEATH_RESET_TIME)


// Mob subtypes

/**
 * Slicer
 *
 * Special ability: NONE
 * Malfunction chance: LOW
 *
 * This mob is a slicer, it's small, and quite fast, but quite easy to break.
 * Has a higher armor pen bonus as it uses a sharp blade to slice things.
 *
 * It's created by factories or any poor medical bots that get snared in the flesh.
 */
/mob/living/basic/infected/slicer
	name = "Slicer"
	desc = "A small organic robot, it somewhat resembles a medibot, but it has a blade slashing around."
	icon_state = "slicer"
	health = 50
	maxHealth = 50
	wound_bonus = 20
	melee_damage_lower = 15
	melee_damage_upper = 20
	mob_size = MOB_SIZE_SMALL
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	armour_penetration = 10
	attack_sound = 'sound/weapons/bladeslice.ogg'
	speed = 3
	ai_controller = /datum/ai_controller/basic_controller/infected/slicer

/mob/living/basic/infected/slicer/Initialize(mapload)
	. = ..()
	update_overlays()

/**
 * Floater
 *
 * Special ability: Explodes on contact.
 * Malfunction chance: LOW
 *
 * The floater floats towards it's victims and explodes on contact.
 *
 * Created by factories.
 */

/mob/living/basic/infected/floater
	name = "Floater"
	desc = "A small organic robot that floats ominously."
	icon_state = "bomber"
	health = 1
	maxHealth = 1
	mob_size = MOB_SIZE_SMALL
	ai_controller = /datum/ai_controller/basic_controller/infected/floater

	light_color = "#820D1C"
	light_power = 1
	light_range = 2
	/// Have we exploded?
	var/exploded = FALSE

/mob/living/basic/infected/floater/Initialize(mapload)
	. = ..()
	var/datum/action/innate/floater_explode/new_action = new
	new_action.Grant(src)


/mob/living/basic/infected/floater/death(gibbed)
	if(!exploded)
		detonate()
	return ..(gibbed)

/mob/living/basic/infected/floater/proc/detonate()
	if(exploded)
		return
	exploded = TRUE
	explosion(src, 0, 0, 2, 3)
	death()

/datum/action/innate/floater_explode
	name = "explode"
	desc = "Detonate our internals."
	button_icon = 'icons/obj/weapons/grenade.dmi'
	button_icon_state = "frag"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/innate/floater_explode/Activate()
	if(!istype(owner, /mob/living/basic/infected/floater))
		return
	var/mob/living/basic/infected/floater/bomb_floater = owner
	if(bomb_floater.exploded)
		return
	bomb_floater.detonate()


/**
 * Globber
 *
 * Special ability: Fires 3 globs of acid at targets.
 * Malfunction chance: MEDIUM
 *
 * A converted cleanbot that instead of cleaning, burns things and throws acid. It doesn't like being near people.
 *
 * Created by factories or converted cleanbots.
 */

/mob/living/basic/infected/globber
	name = "Globber"
	desc = "A small robot that resembles a cleanbot, this one is dripping with acid."
	icon_state = "lobber"
	malfunction_chance = MALFUNCTION_CHANCE_MEDIUM
	health = 75
	maxHealth = 75
	mob_size = MOB_SIZE_SMALL
	ai_controller = /datum/ai_controller/basic_controller/infected/globber
	/// What that goo do
	var/projectile_type = /obj/projectile/treader/weak

/mob/living/basic/infected/globber/Initialize(mapload)
	. = ..()
	update_overlays()

/obj/projectile/treader
	name = "Treader"
	icon = 'modular_nova/modules/space_ruin_specifics/icons/fleshmind_structures.dmi'
	icon_state = "goo_proj"
	damage = 15
	damage_type = BURN
	armor_flag = ENERGY

/obj/projectile/treader/weak
	name = "Weak Treader"
	damage = 5


/**
 * Stunner
 *
 * Special ability: Stuns victims.
 * Malfunction chance: MEDIUM
 *
 * A converted secbot, that is rogue and stuns victims.
 *
 * Created by factories or converted secbots.
 */

/mob/living/basic/infected/stunner
	name = "Stunner"
	desc = "A small robot that resembles a secbot, it rumbles with hatred."
	icon_state = "stunner"
	malfunction_chance = MALFUNCTION_CHANCE_MEDIUM
	melee_damage_lower = 6 // Not very harmful, just annoying.
	melee_damage_upper = 12
	health = 100
	maxHealth = 100
	attack_verb_continuous = "harmbatons"
	attack_verb_simple = "harmbaton"
	mob_size = MOB_SIZE_SMALL
	ai_controller = /datum/ai_controller/basic_controller/infected/stunner

/mob/living/basic/infected/stunner/Initialize(mapload)
	. = ..()
	update_overlays()

/**
 * Flesh Borg
 *
 * Special ability: Different attacks.
 * Claw: Stuns the victim.
 * Slash: Slashes everyone around it.
 * Malfunction chance: MEDIUM
 *
 * The hiborg is a converted cyborg.
 *
 * Created by factories or converted cyborgs.
 */

/mob/living/basic/infected/hiborg
	name = "Flesh Borg"
	desc = "A robot that resembles a cyborg, it is covered in something alive."
	icon_state = "hiborg"
	icon_dead = "hiborg-dead"
	malfunction_chance = MALFUNCTION_CHANCE_MEDIUM
	health = 350
	maxHealth = 350
	melee_damage_lower = 25
	melee_damage_upper = 30
	attack_verb_continuous = "saws"
	attack_verb_simple = "saw"
	speed = 2
	mob_size = MOB_SIZE_HUMAN
	attack_sound = 'sound/weapons/circsawhit.ogg'
	ai_controller = /datum/ai_controller/basic_controller/infected/borg
	/// The chance of performing a stun attack.
	var/stun_attack_prob = 30
	/// The chance of performing an AOE attack.
	var/aoe_attack_prob = 15
	/// The range on our AOE attaack
	var/aoe_attack_range = 1
	/// How often the mob can use the stun attack.
	var/stun_attack_cooldown = 15 SECONDS
	COOLDOWN_DECLARE(stun_attack)

/mob/living/basic/infected/hiborg/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/hiborg_slash/new_action = new
	new_action.Grant(src)

/**
/mob/living/basic/infected/hiborg/AttackingTarget(atom/attacked_target)
	. = ..()
	if(prob(stun_attack_prob) && !key)
		stun_attack(target)
	if(prob(aoe_attack_prob) && !key)
		aoe_attack()
*/
/mob/living/basic/infected/hiborg/proc/stun_attack(mob/living/target_mob)
	if(!COOLDOWN_FINISHED(src, stun_attack))
		return
	if(!ishuman(target_mob))
		return
	var/mob/living/carbon/human/attacked_human = target_mob
	attacked_human.Paralyze(10)
	playsound(src, 'sound/weapons/egloves.ogg', 50, TRUE)

	COOLDOWN_START(src, stun_attack, stun_attack_cooldown)

/mob/living/basic/infected/hiborg/proc/aoe_attack()
	visible_message("[src] spins around violently!")
	spin(20, 1)
	for(var/mob/living/iterating_mob in view(aoe_attack_range, src))
		if(iterating_mob == src)
			continue
		if(faction_check(faction, iterating_mob.faction))
			continue
		playsound(iterating_mob, 'sound/weapons/whip.ogg', 70, TRUE)
		new /obj/effect/temp_visual/kinetic_blast(get_turf(iterating_mob))

		var/atom/throw_target = get_edge_target_turf(iterating_mob, get_dir(src, get_step_away(iterating_mob, src)))
		iterating_mob.throw_at(throw_target, 20, 2)

/datum/action/cooldown/hiborg_slash
	name = "Slash (AOE)"
	desc = "Whip everyone in a range."
	button_icon = 'icons/obj/weapons/grenade.dmi'
	button_icon_state = "slimebang_active"
	cooldown_time = 20 SECONDS

/datum/action/cooldown/hiborg_slash/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/infected/hiborg))
		return
	var/mob/living/basic/infected/hiborg/hiborg_owner = owner
	hiborg_owner.aoe_attack()
	StartCooldownSelf()

/**
 * Himan
 *
 * Special ability: Shriek that stuns, the ability to play dead.
 *
 * Created by converted humans.
 */

/mob/living/basic/infected/himan
	name = "Human"
	desc = "Once a man, now metal plates and tubes weave in and out of their oozing sores."
	icon_state = "himan"
	icon_dead = "himan-dead"
	base_icon_state = "himan"
	maxHealth = 250
	health = 250
	speed = 2
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	melee_damage_lower = 25
	melee_damage_upper = 35
	malfunction_chance = MALFUNCTION_CHANCE_HIGH
	mob_size = MOB_SIZE_HUMAN
	ai_controller = /datum/ai_controller/basic_controller/infected/himan
	/// Are we currently faking our death? ready to pounce?
	var/faking_death = FALSE
	/// Fake death cooldown.
	var/fake_death_cooldown = 20 SECONDS
	COOLDOWN_DECLARE(fake_death)
	/// The cooldown between screams.
	var/scream_cooldown = 20 SECONDS
	COOLDOWN_DECLARE(scream_ability)
	var/scream_effect_range = 10

/mob/living/basic/infected/himan/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/himan_fake_death/new_action = new
	new_action.Grant(src)

/mob/living/basic/infected/himan/Life(delta_time, times_fired)
	. = ..()
	if(health < (maxHealth * 0.5) && !faking_death && COOLDOWN_FINISHED(src, fake_death) && !key)
		fake_our_death()

/mob/living/basic/infected/himan/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(faking_death)
		awake()

/mob/living/basic/infected/himan/malfunction(reset_time)
	if(faking_death)
		return
	return ..()

/mob/living/basic/infected/himan/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = FALSE, message_range = 7, datum/saymode/saymode = null, list/message_mods = null)
	if(faking_death)
		return
	return ..()

/**
/mob/living/basic/infected/himan/Aggro(mob/user, mob/target)
	if(faking_death && !key)
		if(!Adjacent(target))
			return
		awake()
	if(COOLDOWN_FINISHED(src, scream_ability) && !key)
		scream()
	return ..()
 */

/mob/living/basic/infected/himan/examine(mob/user)
	. = ..()
	if(faking_death)
		. += span_deadsay("Upon closer examination, [p_they()] appear[p_s()] to be dead.")

/mob/living/basic/infected/himan/proc/scream()
	COOLDOWN_START(src, scream_ability, scream_cooldown)
	playsound(src, 'modular_nova/modules/horrorform/sound/horror_scream.ogg', 100, TRUE)
	manual_emote("screams violently!")
	for(var/mob/living/iterating_mob in get_hearers_in_range(scream_effect_range, src))
		if(!iterating_mob.can_hear())
			continue
		if(faction_check(faction, iterating_mob.faction))
			continue
		iterating_mob.Knockdown(100)
		iterating_mob.apply_status_effect(/datum/status_effect/jitter, 20 SECONDS)
		to_chat(iterating_mob, span_userdanger("A terrible howl tears through your mind, the voice senseless, soulless."))

/mob/living/basic/infected/himan/proc/fake_our_death()
	manual_emote("stops moving...")
	look_dead()
	icon_state = "[base_icon_state]-dead"
	COOLDOWN_START(src, fake_death, fake_death_cooldown)

/mob/living/basic/infected/himan/proc/awake()
	look_alive()
	icon_state = base_icon_state

/datum/action/cooldown/himan_fake_death
	name = "Fake Death"
	desc = "Fakes our own death."
	button_icon = 'icons/obj/bed.dmi'
	button_icon_state = "bed"
	cooldown_time = 20 SECONDS

/datum/action/cooldown/himan_fake_death/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/infected/himan))
		return
	var/mob/living/basic/infected/himan/himan_owner = owner
	himan_owner.fake_our_death()
	StartCooldownSelf()


/**
 * Treader
 *
 * Special ability: releases healing gas that heals other friendly mobs, ranged
 *
 * Created via assemblers.

/mob/living/basic/infected/treader
	name = "Treader"
	desc = "A strange tracked robot with an appendage, on the end of which is a human head, it is shrieking in pain."
	icon_state = "treader"
	malfunction_chance = MALFUNCTION_CHANCE_HIGH
	melee_damage_lower = 15
	melee_damage_upper = 15
	retreat_distance = 4
	minimum_distance = 4
	dodging = TRUE
	health = 200
	maxHealth = 200
	speed = 3
	attack_sound = 'sound/weapons/bladeslice.ogg'
	retreat_distance = 4
	minimum_distance = 4
	projectiletype = /obj/projectile/treader
	light_color = FLESHMIND_LIGHT_BLUE
	light_range = 2
	mob_size = MOB_SIZE_HUMAN
	speak = list(
		"You there! Cut off my head, I beg you!",
		"I-..I'm so sorry! I c-..can't control myself anymore!",
		"S-shoot the screen, please! God I hope it wont hurt!",
		"Hey, at least I got my head.",
		"I cant... I cant feel my arms...",
		"Oh god... my legs... where are my legs!",
		"God it hurts, please help me!",
	)
	special_ability_cooldown = 20 SECONDS

/mob/living/basic/infected/treader/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/treader_dispense_nanites/new_action = new
	new_action.Grant(src)

/mob/living/basic/infected/treader/special_ability()
	dispense_nanites()

/mob/living/basic/infected/treader/proc/dispense_nanites()
	manual_emote("vomits out a burst of nanites!")
	do_smoke(3, 4, get_turf(src))
	for(var/mob/living/iterating_mob in view(DEFAULT_VIEW_RANGE, src))
		if(faction_check(iterating_mob.faction, faction))
			iterating_mob.heal_overall_damage(10, 10)

/datum/action/cooldown/treader_dispense_nanites
	name = "Dispense Nanites"
	desc = "Dispenses nanites healing all friendly mobs in a range."
	button_icon = 'icons/obj/meteor.dmi'
	button_icon_state = "dust"
	cooldown_time = 20 SECONDS

/datum/action/cooldown/treader_dispense_nanites/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/infected/treader))
		return
	var/mob/living/basic/infected/treader/treader_owner = owner
	treader_owner.dispense_nanites()
	StartCooldownSelf()
*/
/**
 * Phaser
 *
 * Special abilities: Phases about next to it's target, can split itself into 4, only one is actually the mob. Can also enter closets if not being attacked.
 */
/mob/living/basic/infected/phaser
	name = "Phaser"
	icon_state = "phaser-1"
	base_icon_state = "phaser"
	health = 160
	maxHealth = 160
	malfunction_chance = 0
	attack_sound = 'sound/effects/attackblob.ogg'
	attack_verb_continuous = "warps"
	attack_verb_simple = "warp"
	melee_damage_lower = 5
	melee_damage_upper = 10
	alert_sounds = null
	passive_sounds = null
	escapes_closets = FALSE
	mob_size = MOB_SIZE_HUMAN
	/// What is the range at which we spawn our copies?
	var/phase_range = 5
	/// How many copies do we spawn when we are aggroed?
	var/copy_amount = 3
	/// How often we can create copies of ourself.
	var/phase_ability_cooldown_time = 40 SECONDS
	COOLDOWN_DECLARE(phase_ability_cooldown)
	/// How often we are able to enter closets.
	var/closet_ability_cooldown_time = 2 SECONDS
	COOLDOWN_DECLARE(closet_ability_cooldown)
	/// If we are under manual control, how often can we phase?
	var/manual_phase_cooldown = 1 SECONDS
	COOLDOWN_DECLARE(manual_phase)

/mob/living/basic/infected/phaser/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]-[rand(1, 4)]"
	filters += filter(type = "blur", size = 0)
	var/datum/action/cooldown/phaser_phase_ability/new_action = new
	new_action.Grant(src)

/**
/mob/living/basic/infected/phaser/Aggro()
	if(COOLDOWN_FINISHED(src, phase_ability_cooldown))
		phase_ability()
	return ..()


/mob/living/basic/infected/phaser/ShiftClickOn(atom/clicked_atom)
	. = ..()

	if(!COOLDOWN_FINISHED(src, manual_phase))
		return

	if(!clicked_atom)
		return

	if(!isturf(clicked_atom))
		return

	phase_move_to(clicked_atom)
	COOLDOWN_START(src, manual_phase, manual_phase_cooldown)

/// old shitcode
/mob/living/basic/infected/phaser/MoveToTarget(list/possible_targets)
	var/mob/living/mob_target = target
	stop_automated_movement = TRUE
	if(!target || !CanAttack(target))
		LoseTarget()
		return FALSE
	if(target in possible_targets)
		var/turf/turf = get_turf(src)
		if(target.z != turf.z)
			LoseTarget()
			return FALSE
		if(get_dist(src, target) > 1)
			phase_move_to(target, nearby = TRUE)
		else if(target)
			MeleeAction()

/mob/living/basic/infected/phaser/Life(delta_time, times_fired)
	. = ..()
	if(!.) //dead
		return
	if(!target && COOLDOWN_FINISHED(src, closet_ability_cooldown) && !key)
		enter_nearby_closet()
		COOLDOWN_START(src, closet_ability_cooldown, closet_ability_cooldown_time)

	if(istype(loc, /obj/structure/closet) && !key)
		for(var/mob/living/iterating_mob in get_hearers_in_view(DEFAULT_VIEW_RANGE, get_turf(src)))
			if(faction_check(iterating_mob.faction, faction))
				continue
			if(iterating_mob.stat != CONSCIOUS)
				continue
			closet_interaction() // We exit if there are enemies nearby

/mob/living/basic/infected/phaser/proc/enter_nearby_closet()
	if(target) // We're in combat, no going to a closet.
		return
	if(istype(loc, /obj/structure/closet))
		return
	var/list/possible_closets = list()
	for(var/obj/structure/closet/closet in view(DEFAULT_VIEW_RANGE, src))
		if(closet.locked)
			continue
		possible_closets += closet
	if(!LAZYLEN(possible_closets))
		return
	var/obj/structure/closet/closet_to_enter = pick(possible_closets)

	playsound(closet_to_enter, 'sound/effects/phasein.ogg', 60, 1)

	if(!closet_to_enter.opened && !closet_to_enter.open(src))
		return

	forceMove(get_turf(closet_to_enter))

	closet_to_enter.close(src)

	COOLDOWN_RESET(src, phase_ability_cooldown)

	SEND_SIGNAL(src, COMSIG_PHASER_ENTER_CLOSET)

/mob/living/basic/infected/phaser/proc/phase_move_to(atom/target_atom, nearby = FALSE)
	var/turf/new_place
	var/distance_to_target = get_dist(src, target_atom)
	var/turf/target_turf = get_turf(target_atom)
	//if our target is near, we move precisely to it
	if(distance_to_target <= 3)
		if(nearby)
			for(var/dir in GLOB.alldirs)
				var/turf/nearby_turf = get_step(new_place, dir)
				if(can_jump_on(nearby_turf, target_turf))
					new_place = nearby_turf
		else
			new_place = target_turf

	if(!new_place)
		//there we make some kind of, you know, that creepy zig-zag moving
		//we just take angle, distort it a bit and turn into dir
		var/angle = get_angle(loc, target_turf)
		angle += rand(5, 25) * pick(-1, 1)
		if(angle < 0)
			angle = 360 + angle
		if(angle > 360)
			angle = 360 - angle
		var/tp_direction = angle2dir(angle)
		new_place = get_ranged_target_turf(loc, tp_direction, rand(2, 4))

	if(!can_jump_on(new_place, target_turf))
		return
	//an animation
	var/init_px = pixel_x
	animate(src, pixel_x=init_px + 16*pick(-1, 1), time = 5)
	animate(pixel_x=init_px, time=6, easing=SINE_EASING)
	animate(filters[1], size = 5, time = 5, flags = ANIMATION_PARALLEL)
	addtimer(CALLBACK(src, PROC_REF(phase_jump), new_place), 0.5 SECONDS)
	SEND_SIGNAL(src, COMSIG_PHASER_PHASE_MOVE, target_atom, nearby)

/mob/living/basic/infected/phaser/proc/phase_jump(turf/place)
	if(!place)
		return

	playsound(place, 'sound/effects/phasein.ogg', 60, 1)
	animate(filters[1], size = 0, time = 5)
	icon_state = "[base_icon_state]-[rand(1, 4)]"
	forceMove(place)
	for(var/mob/living/living_mob in place)

		if(living_mob != src)
			visible_message("[src] lands directly on top of [living_mob]!")
			to_chat(living_mob, span_userdanger("[src] lands directly on top of you!"))
			playsound(place, 'sound/effects/ghost2.ogg', 70, 1)
			living_mob.Knockdown(10)

/mob/living/basic/infected/phaser/proc/can_jump_on(turf/target_turf, turf/previous_turf)
	if(!target_turf || target_turf.density || isopenspaceturf(target_turf))
		return FALSE


	if(previous_turf)
		if(!can_see(target_turf, previous_turf, DEFAULT_VIEW_RANGE)) // To prevent us jumping to somewhere we can't access the target atom.
			return FALSE

	//to prevent reflection's stacking
	var/obj/effect/temp_visual/phaser/phaser_reflection = locate() in target_turf
	if(phaser_reflection)
		return FALSE

	for(var/obj/iterating_object in target_turf)
		if(!iterating_object.CanPass(src, target_turf))
			return FALSE

	return TRUE

/mob/living/basic/infected/phaser/proc/phase_ability(mob/living/target_override)
	var/mob/living/intermediate_target = target
	if(target_override)
		intermediate_target = target_override

	if(!intermediate_target)
		return

	COOLDOWN_START(src, phase_ability_cooldown, phase_ability_cooldown_time)
	var/list/possible_turfs = list()

	for(var/turf/open/open_turf in circle_view_turfs(src, phase_range))
		possible_turfs += open_turf

	for(var/i in 1 to copy_amount)
		if(!LAZYLEN(possible_turfs))
			break

		var/turf/open/picked_turf = pick_n_take(possible_turfs)
		var/obj/effect/temp_visual/phaser/phaser_copy = new (pick(picked_turf), intermediate_target)
		phaser_copy.RegisterSignal(src, COMSIG_PHASER_PHASE_MOVE, /obj/effect/temp_visual/phaser/proc/parent_phase_move)
		phaser_copy.RegisterSignal(src, COMSIG_LIVING_DEATH, /obj/effect/temp_visual/phaser/proc/parent_death)
		phaser_copy.RegisterSignal(src, COMSIG_PHASER_ENTER_CLOSET, /obj/effect/temp_visual/phaser/proc/parent_death)
*/
/datum/action/cooldown/phaser_phase_ability
	name = "Create Clones"
	desc = "Creates phase copies of ourselves to move towards a set target."
	button_icon = 'icons/obj/anomaly.dmi'
	button_icon_state = "bhole2"
	cooldown_time = 40 SECONDS

/datum/action/cooldown/phaser_phase_ability/Activate(atom/target)
	if(!istype(owner, /mob/living/basic/infected/phaser))
		return
	var/mob/living/basic/infected/phaser/phaser_owner = owner

	var/list/possible_targets = list()
	for(var/mob/living/possible_target in view(DEFAULT_VIEW_RANGE, phaser_owner))
		if(possible_target == src)
			continue

		if(faction_check(phaser_owner.faction, possible_target.faction))
			continue

		possible_targets += possible_target

	if(!LAZYLEN(possible_targets))
		return

	var/mob/living/selected_target = tgui_input_list(phaser_owner, "Select a mob to harass", "Select Mob", possible_targets)

	if(!selected_target)
		return

	//phaser_owner.phase_ability(selected_target)

	StartCooldownSelf()


/obj/effect/temp_visual/phaser
	icon = 'modular_nova/modules/space_ruin_specifics/icons/fleshmind_mobs.dmi'
	icon_state = "phaser-1"
	base_icon_state = "phaser"
	duration = 30 SECONDS
	/// The target we move towards, if any.
	var/datum/weakref/target_ref

/obj/effect/temp_visual/phaser/Initialize(mapload, atom/movable/target)
	. = ..()
	icon_state = "[base_icon_state]-[rand(1, 3)]"
	filters += filter(type = "blur", size = 0)

/obj/effect/temp_visual/phaser/proc/parent_phase_move(datum/source, turf/target_atom, nearby)
	SIGNAL_HANDLER
	if(!target_atom)
		return
	phase_move_to(target_atom, TRUE)

/obj/effect/temp_visual/phaser/proc/parent_death(mob/living/dead_guy, gibbed)
	SIGNAL_HANDLER
	qdel(src)

/obj/effect/temp_visual/phaser/proc/phase_move_to(atom/target_atom, nearby = FALSE)
	var/turf/new_place
	var/distance_to_target = get_dist(src, target_atom)
	var/turf/target_turf = get_turf(target_atom)
	//if our target is near, we move precisely to it
	if(distance_to_target <= 3)
		if(nearby)
			for(var/dir in GLOB.alldirs)
				var/turf/nearby_turf = get_step(new_place, dir)
				if(can_jump_on(nearby_turf, target_turf))
					new_place = nearby_turf
		else
			new_place = target_turf

	if(!new_place)
		//there we make some kind of, you know, that creepy zig-zag moving
		//we just take angle, distort it a bit and turn into dir
		var/angle = get_angle(loc, target_turf)
		angle += rand(5, 25) * pick(-1, 1)
		if(angle < 0)
			angle = 360 + angle
		if(angle > 360)
			angle = 360 - angle
		var/tp_direction = angle2dir(angle)
		new_place = get_ranged_target_turf(loc, tp_direction, rand(2, 4))

	if(!can_jump_on(new_place, target_turf))
		return
	//an animation
	var/init_px = pixel_x
	animate(src, pixel_x = init_px + 16 * pick(-1, 1), time=5)
	animate(pixel_x = init_px, time = 6, easing = SINE_EASING)
	animate(filters[1], size = 5, time = 5, flags = ANIMATION_PARALLEL)
	addtimer(CALLBACK(src, PROC_REF(phase_jump), new_place), 0.5 SECONDS)

/obj/effect/temp_visual/phaser/proc/phase_jump(turf/target_turf)
	playsound(target_turf, 'sound/effects/phasein.ogg', 60, 1)
	animate(filters[1], size = 0, time = 5)
	icon_state = "[base_icon_state]-[rand(1, 4)]"
	forceMove(target_turf)

/obj/effect/temp_visual/phaser/proc/can_jump_on(turf/target_turf, turf/previous_turf)
	if(!target_turf || target_turf.density || isopenspaceturf(target_turf))
		return FALSE

	if(previous_turf)
		if(!can_see(target_turf, previous_turf, DEFAULT_VIEW_RANGE))
			return FALSE

	//to prevent reflection's stacking
	var/obj/effect/temp_visual/phaser/phaser_reflection = locate() in target_turf
	if(phaser_reflection)
		return FALSE

	for(var/obj/iterating_object in target_turf)
		if(!iterating_object.CanPass(src, target_turf))
			return FALSE

	return TRUE


/**
 * Mechiver
 *
 * Special abilities: Can grab someone and shove them inside, does DOT and flavour text, can convert dead corpses into living ones that work for the flesh.
 *
 *
 */
/mob/living/basic/infected/mechiver
	name = "Mechiver"
	icon_state = "mechiver"
	base_icon_state = "mechiver"
	icon_dead = "mechiver-dead"
	health = 450
	maxHealth = 450
	melee_damage_lower = 25
	melee_damage_upper = 35
	attack_verb_continuous = "crushes"
	attack_verb_simple = "crush"
	attack_sound = 'sound/weapons/smash.ogg'
	speed = 4 // Slow fucker
	mob_size = MOB_SIZE_LARGE
	ai_controller = /datum/ai_controller/basic_controller/infected/mechiver
	move_force = MOVE_FORCE_OVERPOWERING
	move_resist = MOVE_FORCE_OVERPOWERING
	pull_force = MOVE_FORCE_OVERPOWERING

/mob/living/basic/infected/mechiver/Initialize(mapload)
	. = ..()
	update_overlays()
