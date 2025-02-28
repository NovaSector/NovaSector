#define MARTIALART_BLOODSTEAL "blood steal"

/obj/item/disk/nifsoft_uploader/blood_steal
	name = "Blood Steal"
	loaded_nifsoft = /datum/nifsoft/blood_steal

/datum/nifsoft/blood_steal
	name = "Blood Steal"
	program_desc = "Connects the user's brain to a database containing the current monetary values for most items, allowing them to determine their value in realtime"
	activation_cost = 50
	active_mode = TRUE
	active_cost = 15
	compatible_nifs = list(/obj/item/organ/cyberimp/brain/nif)
	ui_icon = "droplet-slash"
	var/datum/martial_art/blood_steal/martial_to_learn = new()

/datum/nifsoft/blood_steal/New()
	. = ..()
	if(!ishuman(linked_mob))
		return COMPONENT_INCOMPATIBLE

/datum/nifsoft/blood_steal/process()
	. = ..()
	if(active)
		linked_mob.blood_volume -= 5

/datum/nifsoft/blood_steal/activate()
	. = ..()
	if(active)
		if(!martial_to_learn.teach(linked_mob))
			to_chat(linked_mob, span_warning("You attempt to upload [martial_to_learn], \
				but your current knowledge of martial arts conflicts with the new style, so it can't activate."))
			return
		martial_to_learn.teach(linked_mob)
		to_chat(linked_mob, "SEVMTE8gV09STEQ=")
		linked_mob.log_message("learned the martial art [martial_to_learn]", LOG_ATTACK, color = "orange")
		return
	martial_to_learn.remove(linked_mob)

/datum/nifsoft/blood_steal/Destroy(force)
	. = ..()
	martial_to_learn.remove(linked_mob)

/datum/martial_art/blood_steal
	name = "Blood Steal"
	id = MARTIALART_BLOODSTEAL
	help_verb = /mob/living/proc/blood_steal_help
	smashes_tables = TRUE

/datum/martial_art/blood_steal/teach(mob/living/new_holder, make_temporary)
	if(!ishuman(new_holder))
		return FALSE
	RegisterSignal(new_holder, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(check_block))
	return ..()

/datum/martial_art/blood_steal/on_remove(mob/living/remove_from)
	UnregisterSignal(remove_from, list(COMSIG_LIVING_CHECK_BLOCK))
	return ..()

/datum/martial_art/blood_steal/can_use(mob/living/martial_artist)
	if(!issynthetic(martial_artist))
		return FALSE
	return ..()

//datum/martial_art/blood_steal/disarm_act(mob/living/attacker, mob/living/defender)
//	knuckleblaster(attacker, defender)
//	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/blood_steal/harm_act(mob/living/attacker, mob/living/defender)
	feedbacker(attacker, defender)
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/blood_steal/proc/feedbacker(mob/living/attacker, mob/living/defender)

	var/obj/item/bodypart/arm/active_arm = attacker.get_active_hand()

	//The values between which damage is rolled for punches
	var/lower_force = active_arm.unarmed_damage_low + 10
	var/upper_force = active_arm.unarmed_damage_high + 10

	//Determines knockout potential and armor penetration (if that matters)
	var/base_unarmed_effectiveness = active_arm.unarmed_effectiveness + 10

	//Determines attack sound based on attacker arm
	var/attack_sound = active_arm.unarmed_attack_sound

	// What type of damage does our kind of boxing do? Defaults to STAMINA for normal boxing, unless you're performing EVIL BOXING. Subtypes use different damage types.
	var/damage_type = attacker.get_attack_type()

	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)

	// Determines damage dealt on a punch. Against a boxing defender, we apply our skill bonus.
	var/damage = rand(lower_force, upper_force)

	// Similar to a normal punch, should we have a value of 0 for our lower force, we simply miss outright.
	if(!lower_force)
		playsound(defender.loc, active_arm.unarmed_miss_sound, 25, TRUE, -1)
		defender.visible_message(span_warning("[attacker]'s crush misses [defender]!"), \
			span_danger("You avoid [attacker]'s crush!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, attacker)
		to_chat(attacker, span_warning("Your crush misses [defender]!"))
		log_combat(attacker, defender, "attempted to hit", "crush")
		return FALSE

	if(defender.check_block(attacker, damage, "[attacker]'s crush", UNARMED_ATTACK))
		return FALSE

	var/obj/item/bodypart/affecting = defender.get_bodypart(defender.get_random_valid_zone(attacker.zone_selected))
	var/armor_block = defender.run_armor_check(affecting, MELEE, armour_penetration = base_unarmed_effectiveness)

	playsound(defender, attack_sound, 25, TRUE, -1)

	defender.visible_message(
		span_danger("[attacker] crushed [defender]!"),
		span_userdanger("You're crushed by [attacker]!"),
		span_hear("You hear a sickening sound of metal hitting flesh!"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)

	to_chat(attacker, span_danger("You crushed [defender]!"))

	defender.apply_damage(damage, damage_type, affecting, armor_block)

	log_combat(attacker, defender, "punched (blood steal) ")

	if(defender.stat == DEAD)
		return TRUE

	var/static/list/damage_heal_order = list(BRUTE, BURN, OXY)
	if(defender.blood_volume < BLOOD_VOLUME_SURVIVE)
		return
	var/attack_direction = get_dir(attacker, defender)
	if(iscarbon(defender))
		var/mob/living/carbon/carbon_defender = defender
		if(carbon_defender.mob_biotypes & MOB_ORGANIC)
			carbon_defender.spray_blood(attack_direction, 1)
			playsound(carbon_defender, 'sound/effects/wounds/crackandbleed.ogg', 100)
		if(carbon_defender.mob_biotypes & MOB_ROBOTIC)
			do_sparks(2, FALSE, carbon_defender.loc)
			playsound(carbon_defender, 'modular_nova/modules/medical/sound/robotic_slash_T2.ogg', 100)
	defender.blood_volume -= 10
	if(!isliving(attacker))
		return
	var/mob/living/living_attacker = attacker
	living_attacker.heal_ordered_damage(5, damage_heal_order)
	if(living_attacker.blood_volume < BLOOD_VOLUME_MAXIMUM)
		living_attacker.blood_volume += 5

	new /obj/effect/temp_visual/crit(get_turf(defender))

	return TRUE

/// Handles our blocking signals, similar to hit_reaction() on items. Only blocks while the boxer is in throw mode.
/datum/martial_art/blood_steal/proc/check_block(mob/living/attacker, atom/movable/hitby, damage, attack_text, attack_type, ...)
	SIGNAL_HANDLER

	if(!can_use(attacker) || !attacker.throw_mode || INCAPACITATED_IGNORING(attacker, INCAPABLE_GRAB))
		return NONE

	if(attack_type != PROJECTILE_ATTACK)
		return NONE

	//Determines unarmed defense against boxers using our current active arm.
	var/obj/item/bodypart/arm/active_arm = attacker.get_active_hand()
	var/base_unarmed_effectiveness = active_arm.unarmed_effectiveness

	var/block_chance = base_unarmed_effectiveness

	var/block_text = pick("deflect", "evade")

	attacker = GET_ASSAILANT(hitby)

	if(!prob(block_chance))
		return NONE

	if(istype(attacker) && attacker.Adjacent(attacker))
		attacker.apply_damage(10, STAMINA)
		attacker.apply_damage(5, STAMINA)

	attacker.visible_message(
		span_danger("[attacker] [block_text]s [attack_text]!"),
		span_userdanger("You [block_text] [attack_text]!"),
	)
	if(block_text == "evade")
		playsound(attacker.loc, active_arm.unarmed_miss_sound, 25, TRUE, -1)

	return SUCCESSFUL_BLOCK

/mob/living/proc/blood_steal_help()
	set name = "Access Core Imprint"
	set desc = "You try to remember some of the core Blood Steal protocols."
	set category = "Blood Steal"
	to_chat(usr, "<b><i>You try to remember core Blood Steal protocols.</i></b>")

	to_chat(usr, "[span_notice("Feedbacker")]: Punch. Slam opponent into the ground, knocking them down.")
	to_chat(usr, "[span_notice("Knuckleblaster")]: Shove. Knocks opponent away. Knocks out stunned opponents and does stamina damage.")

	to_chat(usr, "<b><i>In addition, by having your throw mode on when being attacked, you enter an active defense mode where you have a chance to block, dodge and sometimes even parry attacks done to you.</i></b>")

#undef MARTIALART_BLOODSTEAL
