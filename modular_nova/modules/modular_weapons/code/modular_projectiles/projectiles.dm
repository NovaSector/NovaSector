// .38

/obj/projectile/bullet/c38
	// tg base damage 25, wound bonus -20
	// 25*1.35 = 35
	damage = 35
	wound_bonus = -10

/obj/projectile/bullet/c38/match/bouncy
	// tg base damage 10, stamina 30
	// 10*1.35 = 13.5, rounded up
	// stamina mildly buffed for funsies
	damage = 15
	stamina = 35

/obj/projectile/bullet/c38/match/true
	// tg base damage 15
	// 15*1.35 = 20.25, rounded down
	damage = 20

/obj/projectile/bullet/c38/dumdum
	// tg base damage 15, embed falloff -15
	damage = 20
	embed_falloff_tile = -10

/datum/embedding/bullet/c38/dumdum
	// tg base embed chance 75
	embed_chance = 85

/obj/projectile/bullet/c38/hotshot
	// tg base damage 20
	// 20*1.35 = 27, rounding up
	damage = 30

/obj/projectile/bullet/c38/iceblox
	damage = 30 // originally 20 on TG

/obj/projectile/bullet/c38/haywire
	name = ".38 haywire bullet"
	damage = 20
	ricochets_max = 0
	embed_type = null
	/// EMP radius when this bullet hits a target.
	var/emp_radius = 0

/obj/projectile/bullet/c38/haywire/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	empulse(target, 0, emp_radius)
	new /obj/effect/temp_visual/emp/pulse(get_turf(target))

// .357

/obj/projectile/bullet/c357/haywire
	name = ".357 Haywire+ bullet"
	damage = 40
	ricochets_max = 0
	embed_type = null
	/// EMP radius when this bullet hits a target.
	var/emp_radius = 1

/obj/projectile/bullet/c357/haywire/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	empulse(target, emp_radius, emp_radius)
	new /obj/effect/temp_visual/emp/pulse(get_turf(target))

// .45

/obj/projectile/bullet/c45/rubber
	name = ".45 rubber bullet"
	damage = 10
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embed_data = null
	wound_bonus = -50

// 9mm

/obj/projectile/bullet/c9mm/ihdf
	name = "9mm IHDF bullet"
	damage = 30
	damage_type = STAMINA
	embed_type = /datum/embedding/c9mm_ihdf

/datum/embedding/c9mm_ihdf
	embed_chance = 0
	fall_chance = 3
	jostle_chance = 4
	pain_mult = 5
	pain_stam_pct = 0.4
	ignore_throwspeed_threshold = TRUE
	jostle_pain_mult = 6
	rip_time = 1 SECONDS

/obj/projectile/bullet/c9mm/rubber
	name = "9mm rubber bullet"
	icon_state = "pellet"
	damage = 5
	stamina = 25
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_type = null

// 10mm

/obj/projectile/bullet/c10mm/rubber
	name = "10mm rubber bullet"
	damage = 10
	stamina = 35
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_type = null

/obj/projectile/bullet/c10mm/ihdf
	name = "10mm IHDF bullet"
	damage = 40
	damage_type = STAMINA
	embed_type = /datum/embedding/c10mm_ihdf

/datum/embedding/c10mm_ihdf
	embed_chance = 0
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS

/obj/projectile/bullet/c10mm/downer
	name = "10mm downer bullet"
	damage = 45
	damage_type = STAMINA
	embed_type = null

/obj/projectile/bullet/c10mm/downer/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if((blocked != 100) && isliving(target))
		var/mitigate_percent = 1 - (blocked / 100)
		var/mob/living/living_guy = target
		// make them drowsy, scaling with how much was mitigated
		// future todo: revisit this. dizzy/mute on hit? mitigated by armor?
		living_guy.adjust_drowsiness_up_to(6 SECONDS * mitigate_percent, 12 SECONDS)
		// and see if we can just sleep them outright:
		var/stamcritted_target = HAS_TRAIT_FROM(target, TRAIT_INCAPACITATED, STAMINA)
		var/stamina_ratio = (living_guy.get_stamina_loss() / living_guy.getMaxHealth()) * 50 // 100 / 2
		// if they're stamcrit, sleep them
		if(stamcritted_target)
			living_guy.AdjustSleeping(10 SECONDS) // long naptime for you, buddy
			to_chat(living_guy, span_warning("As [src] hits you, you feel the heavy burden of exhaustion quickly set in..."))
			return
		// or, if they're exhausted, roll to sleep them for a very short time
		else if(prob(stamina_ratio))
			living_guy.AdjustSleeping(1 SECONDS * mitigate_percent) // short naptime but it throws them off something fierce
			to_chat(living_guy, span_warning("As [src] hits you, you feel exhaustion set in."))
			return

// 4.6x30mm

/obj/projectile/bullet/c46x30mm/rubber
	name = "4.6x30mm rubber bullet"
	damage = 3
	stamina = 17
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embed_data = null
	wound_bonus = -50

// .223

/obj/projectile/bullet/a223/rubber
	name = ".223 rubber bullet"
	damage = 10
	armour_penetration = 10
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embed_data = null
	wound_bonus = -50
