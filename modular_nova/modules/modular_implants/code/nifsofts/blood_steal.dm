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
	ui_icon = "droplet-slash"
	var/datum/martial_art/blood_steal/martial_to_learn = new()

/datum/nifsoft/blood_steal/New()
	. = ..()
	if(!ishuman(linked_mob))
		return COMPONENT_INCOMPATIBLE

/datum/nifsoft/blood_steal/activate()
	. = ..()
	if(active)
		if(!issynthetic(linked_mob))
			to_chat(linked_mob, span_warning("Organic tissue detected! Augmentation aborted."))
			installed_nif.power_usage -= active_cost
			active = FALSE
			return FALSE
		martial_to_learn.teach(linked_mob)
		linked_mob.log_message("learned the martial art [martial_to_learn]", LOG_ATTACK, color = "orange")
		to_chat(linked_mob, span_danger("SEVMTE8gV09STEQ="))
		to_chat(linked_mob, span_danger("QkxPT0QgSVMgRlVFTA=="))
		to_chat(linked_mob, span_danger("TWFkZSBieTo="))
		to_chat(linked_mob, span_danger("SEMgU3ludGhldGljIEVuaGFuY2VtZW50IEJ1cmVhdQ=="))
		return
	martial_to_learn.unlearn(linked_mob)

/datum/nifsoft/blood_steal/Destroy(force)
	. = ..()
	martial_to_learn.unlearn(linked_mob)

/datum/martial_art/blood_steal
	name = "Blood Steal"
	id = MARTIALART_BLOODSTEAL
	help_verb = /mob/living/proc/blood_steal_help
	smashes_tables = TRUE

	COOLDOWN_DECLARE(parry_cooldown_timer)

/datum/martial_art/blood_steal/activate_style(mob/living/new_holder)
	. = ..()
	RegisterSignal(new_holder, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(attempt_parry), override = TRUE)

/datum/martial_art/blood_steal/deactivate_style(mob/living/remove_from)
	UnregisterSignal(remove_from, list(COMSIG_ATOM_PRE_BULLET_ACT))
	return ..()

/datum/martial_art/blood_steal/disarm_act(mob/living/attacker, mob/living/defender)
	knuckleblaster(attacker, defender)
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/blood_steal/harm_act(mob/living/attacker, mob/living/defender)
	feedbacker(attacker, defender)
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/blood_steal/proc/feedbacker(mob/living/attacker, mob/living/defender)

	var/obj/item/bodypart/arm/active_arm = attacker.get_active_hand()

	//The values between which damage is rolled for punches
	var/lower_force = active_arm.unarmed_damage_low + 5
	var/upper_force = active_arm.unarmed_damage_high + 5

	//Determines knockout potential and armor penetration (if that matters)
	var/base_unarmed_effectiveness = active_arm.unarmed_effectiveness + 10

	//Determines attack sound based on attacker arm
	var/attack_sound = active_arm.unarmed_attack_sound

	var/damage_type = attacker.get_attack_type()

	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)

	//Determines damage dealt on a punch.
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

	to_chat(attacker, span_danger("You've crushed [defender]!"))

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

/datum/martial_art/blood_steal/proc/knuckleblaster(mob/living/attacker, mob/living/defender)

	attacker.do_attack_animation(defender)
	defender.visible_message(
		span_danger("[attacker] blasts [defender] back!"),
		span_userdanger("You're blasted back by [attacker]!"),
		span_hear("You hear a sickening sound of metal hitting flesh!"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	to_chat(attacker, span_danger("You blast [defender] back!"))
	playsound(attacker, 'sound/effects/pop_expl.ogg', 50, TRUE)
	var/atom/throw_target = get_edge_target_turf(defender, attacker.dir)
	new /obj/effect/temp_visual/explosion/fast(get_turf(defender))
	defender.throw_at(throw_target, 2, 7, attacker)
	defender.apply_damage(attacker == defender ? 20 : 10, attacker.get_attack_type())
	defender.adjustStaminaLoss(10)
	log_combat(attacker, defender, "knuckleblasted")

	return TRUE

/datum/martial_art/blood_steal/proc/can_deflect(mob/living/attacker)
	if(!can_use(attacker) || !attacker.throw_mode)
		return FALSE
	if(!COOLDOWN_FINISHED(src, parry_cooldown_timer))
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

/// Handles our parrying signals, similar to hit_reaction() on items. Only parries while not-V1 is in throw mode.
/datum/martial_art/blood_steal/proc/attempt_parry(mob/living/attacker, obj/projectile/hitting_projectile, def_zone)
	SIGNAL_HANDLER

	if(QDELETED(hitting_projectile) || hitting_projectile.deletion_queued)
		return NONE

	if(!can_deflect(attacker))
		return NONE

	hitting_projectile.set_angle((hitting_projectile.angle + 180) % 360 + rand(-3, 3))
	hitting_projectile.visible_message(span_warning("[attacker] expertly parries [hitting_projectile] with [attacker.p_their()] bare hand!"))
	hitting_projectile.firer = attacker
	hitting_projectile.speed *= 1.25
	hitting_projectile.damage *= 1.25
	hitting_projectile.icon = 'icons/obj/weapons/guns/projectiles.dmi' //In case of modular projectiles.
	hitting_projectile.icon_state = "redtrac"
	hitting_projectile.add_atom_colour(COLOR_RED_LIGHT, TEMPORARY_COLOUR_PRIORITY)
	attacker.overlay_fullscreen("projectile_parry", /atom/movable/screen/fullscreen/crit/projectile_parry, 2)
	addtimer(CALLBACK(attacker, TYPE_PROC_REF(/mob, clear_fullscreen), "projectile_parry"), 0.25 SECONDS)
	playsound(attacker, 'sound/effects/parry.ogg', 75, TRUE)
	COOLDOWN_START(src, parry_cooldown_timer, 5 SECONDS)
	return COMPONENT_BULLET_PIERCED

/mob/living/proc/blood_steal_help()
	set name = "Access Core Imprint"
	set desc = "You try to remember some of the core Blood Steal protocols."
	set category = "Blood Steal"
	to_chat(usr, "<b><i>You try to remember core Blood Steal protocols.</i></b>")

	to_chat(usr, "[span_notice("Feedbacker")]: Punch. Deal extra damage and steal blood, converting some damage dealt as health.")
	to_chat(usr, "[span_notice("Knuckleblaster")]: Shove. Knocks opponent away. Deals negligible brute and stamina damage.")

	to_chat(usr, "<b><i>In addition, by having your throw mode on when being shot at, you enter an active defense mode where you have a perfect, yet single-projectile parry with a moderately long refresh cooldown.</i></b>")

#undef MARTIALART_BLOODSTEAL
