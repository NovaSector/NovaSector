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

	COOLDOWN_DECLARE(parry_cooldown_timer)

	var/parry_regen_timerid
	var/parries_left = 0
	var/parries_max = 3

/datum/martial_art/blood_steal/teach(mob/living/new_holder, make_temporary)
	if(!ishuman(new_holder))
		return FALSE
	RegisterSignal(new_holder, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(attempt_parry), override = TRUE)
	parry_regen_timerid = addtimer(CALLBACK(src, PROC_REF(add_parries)), 2 SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE)
	return ..()

/datum/martial_art/blood_steal/on_remove(mob/living/remove_from)
	UnregisterSignal(remove_from, list(COMSIG_ATOM_PRE_BULLET_ACT))
	remove_timer()
	return ..()

/datum/martial_art/blood_steal/proc/remove_timer()
	if(!parry_regen_timerid)
		return
	deltimer(parry_regen_timerid)
	parry_regen_timerid = null

/datum/martial_art/blood_steal/proc/add_parries(mob/living/new_holder)
	parries_left = clamp(parries_left + 1, 0, parries_max)
	if(parries_left <= parries_max)
		new_holder.balloon_alert(new_holder, "[parries_left]/[parries_max] parries!")
	addtimer(CALLBACK(src, PROC_REF(add_parries)), 2 SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE)

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

/datum/martial_art/blood_steal/proc/can_deflect(mob/living/attacker)
	if(!can_use(attacker) || !attacker.throw_mode)
		return FALSE
	if(parries_left == 0)
		return FALSE
	if(INCAPACITATED_IGNORING(attacker, INCAPABLE_GRAB)) //NO STUN
		return FALSE
	if(!(attacker.mobility_flags & MOBILITY_USE)) //NO UNABLE TO USE
		return FALSE
	if(HAS_TRAIT(attacker, TRAIT_HULK)) //NO HULK
		return FALSE
	if(!isturf(attacker.loc)) //NO MOTHERFLIPPIN MECHS!
		return FALSE
	return TRUE

/// Handles our blocking signals, similar to hit_reaction() on items. Only blocks while the boxer is in throw mode.
/datum/martial_art/blood_steal/proc/attempt_parry(mob/living/attacker, obj/projectile/hitting_projectile, def_zone)
	SIGNAL_HANDLER

	if(!can_deflect(attacker))
		return NONE

	if (hitting_projectile.firer != attacker)
		if (abs(hitting_projectile.angle - dir2angle(hitting_projectile.dir)) < 15)
			hitting_projectile.set_angle((hitting_projectile.angle + 180) % 360 + rand(-3, 3))
		else
			hitting_projectile.set_angle(dir2angle(hitting_projectile.dir) + rand(-3, 3))
		hitting_projectile.visible_message(span_warning("[hitting_projectile] expertly parries [hitting_projectile] with [hitting_projectile.p_their()] bare hand!"), span_warning("You parry [hitting_projectile] with your hand!"))
	else
		hitting_projectile.visible_message(span_warning("[hitting_projectile] boosts [hitting_projectile] with [hitting_projectile.p_their()] bare hand!"), span_warning("You boost [hitting_projectile] with your hand!"))
	hitting_projectile.firer = hitting_projectile
	hitting_projectile.speed *= (hitting_projectile.firer == hitting_projectile) ? 1.5 : 1.25
	hitting_projectile.damage *= (hitting_projectile.firer == hitting_projectile) ? 1.5 : 1.25
	hitting_projectile.add_atom_colour(COLOR_RED_LIGHT, TEMPORARY_COLOUR_PRIORITY)
	playsound(attacker, 'sound/effects/parry.ogg', 75, TRUE)
	parries_left -= 1
	COOLDOWN_START(src, parry_cooldown_timer, 2 SECONDS)
	return PROJECTILE_INTERRUPT_HIT_PHASE

/mob/living/proc/blood_steal_help()
	set name = "Access Core Imprint"
	set desc = "You try to remember some of the core Blood Steal protocols."
	set category = "Blood Steal"
	to_chat(usr, "<b><i>You try to remember core Blood Steal protocols.</i></b>")

	to_chat(usr, "[span_notice("Feedbacker")]: Punch. Slam opponent into the ground, knocking them down.")
	to_chat(usr, "[span_notice("Knuckleblaster")]: Shove. Knocks opponent away. Knocks out stunned opponents and does stamina damage.")

	to_chat(usr, "<b><i>In addition, by having your throw mode on when being attacked, you enter an active defense mode where you have a chance to block, dodge and sometimes even parry attacks done to you.</i></b>")

#undef MARTIALART_BLOODSTEAL
