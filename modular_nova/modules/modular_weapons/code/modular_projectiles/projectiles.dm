// .38

/obj/projectile/bullet/c38/haywire
	name = ".38 haywire bullet"
	damage = 10
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
