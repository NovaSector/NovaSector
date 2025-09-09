#define MARTIALART_BLOODSTEAL "blood steal"

/obj/item/disk/nifsoft_uploader/mil_grade/blood_steal
	name = "Blood Steal"
	desc = "A high-performance, impact-resistant drive that can be used to upload a loaded NIFSoft to the user's NIF. <br> \
		An overly long beginning of an elaborate name stamped into its side, and what seemed to be a beginning of a patent number, were scratched off. \
		Instead, a label is stuck on its side, reading 'Blood Steal'."
	icon_state = "hc_mil_disk"
	loaded_nifsoft = /datum/nifsoft/blood_steal

/datum/nifsoft/blood_steal
	name = "PHMS_v0.4 //TBD: rename" //don't rename
	program_desc = "Pseudoalchemical Hemodecompositional Maintenance System is a combat-oriented nanite package for use by the CQB-oriented synthetic units as a last resort means \
		of protection, as well as a tactical self-repair and maintenance system by the means of hemodecomposition and chemical infusion. While the exact specifics of the \
		design were not provided by the higher management, citing high confidentiality, the post-activation changes to synthetic design allow us to speculate on its inner workings. \
		Upon activation, test subjects' body is impregnated with a thin web of microscopic needle-vessels going through the entire outer casing, be it synthetic skin, \
		polymers from rubber to bulletproof plastic, or metallic alloys; specialised blood banks connected with the synthetic's bioreactors and hydraulic pumps; \
		and quick-reaction nanite chambers inside the right, and left wrists. This results in their hands being capable to absorb blood through excessive kinetic force, \
		or produce small-scale kinetic shockwaves to propel their target. Limb integrity is preserved by the aforementioned nanite chambers, enveloping the impact zone before contact \
		to mitigate immediate damage to the machine. Further testing allowed to conclude that, after further testing, the following increase in temporary durability allows units \
		to 'parry' high-velocity projectiles with high chance of success. Organic volunteer experimentation pending approval, but deemed 'inhumane' by most project participants, \
		and outside of the planned budget for this quarter. //TBD: write a user friendly description"
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
			to_chat(linked_mob, span_warning("Organic tissue detected! Augmentation might result in:"))
			to_chat(linked_mob, span_warning("Tissue necrosis, post-application open fractures and avulsions, acute hemolytic transfusion reaction, spontaneous outbursts of pain, and severe psychosis."))
			to_chat(linked_mob, span_warning("Advised program uninstallation. Have a secure day."))
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
	///Weakref to a machine that's just parried
	VAR_PRIVATE/datum/weakref/parrying_machine

	COOLDOWN_DECLARE(parry_cooldown_timer)

/datum/martial_art/blood_steal/activate_style(mob/living/new_holder)
	. = ..()
	RegisterSignal(new_holder, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(attempt_parry), override = TRUE)

/datum/martial_art/blood_steal/deactivate_style(mob/living/remove_from)
	UnregisterSignal(remove_from, list(COMSIG_ATOM_PRE_BULLET_ACT))
	return ..()

/datum/martial_art/blood_steal/harm_act(mob/living/attacker, mob/living/defender)
	feedbacker(attacker, defender)

	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/blood_steal/disarm_act(mob/living/attacker, mob/living/defender)
	knuckleblaster(attacker, defender)

	return MARTIAL_ATTACK_SUCCESS

/// Performs a blood steal punch attack that deals extra damage and steals blood from the target
/// Arguments:
/// * attacker - The mob performing the attack
/// * defender - The mob being attacked
/// Returns TRUE if the attack was successful, FALSE if it missed
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
	var/defender_has_blood = HAS_TRAIT(defender, TRAIT_NOBLOOD)
	var/attacker_has_blood = isliving(attacker) && HAS_TRAIT(attacker, TRAIT_NOBLOOD)

	// Blood drain effects on defender
	if(defender_has_blood && defender.blood_volume >= BLOOD_VOLUME_SURVIVE)
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

	// Healing effects on attacker
	if(!isliving(attacker))
		return
	var/mob/living/living_attacker = attacker
	living_attacker.heal_ordered_damage(5, damage_heal_order)

	// Blood transfer effects
	if(attacker_has_blood && living_attacker.blood_volume < BLOOD_VOLUME_MAXIMUM)
		living_attacker.blood_volume += 5
	if(isbodypart(active_arm) && !IS_ROBOTIC_LIMB(active_arm))
		living_attacker.apply_damage(damage*0.75, TOX, forced = TRUE)
		if(attacker_has_blood)
			living_attacker.blood_volume -= 7

	new /obj/effect/temp_visual/crit(get_turf(defender))

	return TRUE

/// Performs a blast attack that knocks the target back
/// Arguments:
/// * attacker - The mob performing the attack
/// * defender - The mob being attacked
/// Returns TRUE if the attack was successful
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

	var/obj/item/bodypart/arm/active_arm = attacker.get_active_hand()
	var/mob/living/carbon/carbon_attacker = attacker
	if(isbodypart(active_arm) && !IS_ROBOTIC_LIMB(active_arm))
		carbon_attacker.apply_damage(attacker == defender ? 10 : 5, attacker.get_attack_type(), active_arm.body_zone)
		carbon_attacker.cause_wound_of_type_and_severity(WOUND_BLUNT, active_arm, WOUND_SEVERITY_SEVERE)

	log_combat(attacker, defender, "knuckleblasted")

	return TRUE

/// Checks if the attacker is capable of deflecting a projectile
/// Arguments:
/// * attacker - The mob to check for deflect capability
/// Returns TRUE if the attacker can deflect, FALSE otherwise
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
/// Attempts to parry an incoming projectile
/// Arguments:
/// * attacker - The mob attempting to parry
/// * hitting_projectile - The projectile being parried
/// Returns COMPONENT_BULLET_ACTED if the projectile was destroyed, COMPONENT_BULLET_PIERCED if deflected, or NONE if parry failed
/datum/martial_art/blood_steal/proc/attempt_parry(mob/living/attacker, obj/projectile/hitting_projectile)
	SIGNAL_HANDLER

	if(QDELETED(hitting_projectile) || hitting_projectile.deletion_queued)
		return NONE

	if(!can_deflect(attacker))
		return NONE

	var/obj/item/bodypart/affecting = attacker.get_active_hand()
	if(isbodypart(affecting) && !IS_ROBOTIC_LIMB(affecting))
		var/new_def_zone = affecting.body_zone
		hitting_projectile.def_zone = new_def_zone
		attacker.visible_message(span_warning("[attacker] attempts parrying [hitting_projectile] with [attacker.p_their()] bare hand... and cloves it asunder!"))
		COOLDOWN_START(src, parry_cooldown_timer, 5 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(parry_availability), attacker), 5 SECONDS)
		attacker.projectile_hit(hitting_projectile, new_def_zone)
		return COMPONENT_BULLET_ACTED

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
	addtimer(CALLBACK(src, PROC_REF(parry_availability), attacker), 5 SECONDS)
	return COMPONENT_BULLET_PIERCED

/// Notifies the attacker when their parry ability is available again after cooldown
/// Arguments:
/// * attacker - The mob to notify about parry availability
/datum/martial_art/blood_steal/proc/parry_availability(mob/living/attacker)
	if(COOLDOWN_FINISHED(src, parry_cooldown_timer))
		attacker.balloon_alert(holder, "parry refreshed!")

/// Displays help information about the Blood Steal martial art abilities
/// This verb shows the user information about the Feedbacker and Knuckleblaster attacks,
/// as well as the active defense mode for parrying projectiles
/mob/living/proc/blood_steal_help()
	set name = "Access Core Imprint"
	set desc = "You try to remember some of the core Blood Steal protocols."
	set category = "Blood Steal"
	to_chat(usr, "<b><i>You try to remember core Blood Steal protocols.</i></b>")

	to_chat(usr, "[span_notice("Feedbacker")]: Punch. Deal extra damage and steal blood, converting some damage dealt as health.")
	to_chat(usr, "[span_notice("Knuckleblaster")]: Shove. Knocks opponent away. Deals negligible brute and stamina damage.")

	to_chat(usr, "<b><i>In addition, by having your throw mode on when being shot at, you enter an active defense mode where you have a perfect, yet single-projectile parry with a moderately long refresh cooldown.</i></b>")

#undef MARTIALART_BLOODSTEAL
