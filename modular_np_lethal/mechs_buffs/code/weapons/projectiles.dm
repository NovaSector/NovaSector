//default mech laser

/obj/projectile/beam/laser/lethallaser
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser
	damage = 15

//mech heavy laser

/obj/projectile/beam/laser/heavy/lethalheavy
	damage = 65
	impact_effect_type = /obj/effect/temp_visual/impact_effect/yellow_laser
	speed = 0.5
	light_range = 2
	light_color = COLOR_RED
	wound_falloff_tile = 0.1


//default mech ac2 shot
/obj/projectile/bullet/lmg
	damage = 25
	armour_penetration = 5


// lbx pellet mechs
/obj/projectile/bullet/scattershot
	icon_state = "pellet"
	damage = 15
	range = 12
	damage_falloff_tile = -0.10


//mech ac20
/obj/projectile/bullet/lmg/ac20b
	damage = 120
	damage_falloff_tile = -0.1
	speed = 2
	icon_state = "cannonball"


//mech hitscan laser
/obj/projectile/beam/laser/hitlaser
	damage = 50

	impact_effect_type = /obj/effect/temp_visual/impact_effect/yellow_laser
	hitscan = TRUE
	hitscan_light_intensity = 3
	hitscan_light_range = 0.75
	hitscan_light_color_override = COLOR_RED



//scuffed ass trickshot """"laser"""""
/obj/projectile/bullet/lmg/tricklaser
	damage = 30
	range = 200
	hitscan = TRUE
	hitscan_light_intensity = 2
	hitscan_light_range = 0.75
	ricochets_max = 3
	ricochet_chance = 200
	ricochet_auto_aim_angle = 30
	ricochet_auto_aim_range = 5
	ricochet_decay_damage = 2
	ricochet_decay_chance = 1
	icon_state = "u_laser"
	tracer_type = /obj/effect/projectile/tracer/laser/blue
	muzzle_type = /obj/effect/projectile/muzzle/laser/blue
	impact_type = /obj/effect/projectile/impact/laser/blue
	hitscan_light_color_override = COLOR_BLUE_LIGHT
	ricochet_shoots_firer = TRUE


// mech rebar railgun
/obj/projectile/bullet/rebar/r500
	name = "rebar"
	icon_state = "rebar"
	damage = 80
	speed = 0.3
	armour_penetration = 10
	wound_bonus = -20
	bare_wound_bonus = 20
	embedding = list(embed_chance=60, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=3, jostle_pain_mult=2, rip_time=10)
	embed_falloff_tile = -5
	wound_falloff_tile = -2
	shrapnel_type = /obj/item/stack/rods
	light_range = 2
	light_color = COLOR_YELLOW

 // PEP missles, getting a slight buff to organic damage anbd now they uh, actually explode on walls.
/obj/projectile/bullet/rocket/pep
	name = "precise explosive missile"
	desc = "Human friendly, metal unfriendly."
	icon_state = "low_yield_rocket"
	damage = 40
	anti_armour_damage = 80 //Doesn't (probably) kill borgs in one shot, but it will hurt
	random_crits_enabled = FALSE //yeah, no

