/obj/projectile
	/// If this should be able to hit the target even on direct firing when `ignored_factions` applies
	var/ignore_direct_target = FALSE

/obj/projectile/bullet
	tracer_type = /obj/effect/projectile/tracer/sniper
	hitscan = TRUE
	hitscan_light_intensity = 0.5

/obj/projectile/beam
	tracer_type = /obj/effect/projectile/tracer/laser
	hitscan = TRUE
	hitscan_light_intensity = 0.75

/obj/projectile/plasma
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	hitscan = TRUE
	hitscan_light_intensity = 0.75

/obj/projectile/bullet/coin
	hitscan = FALSE

/obj/projectile/bullet/gyro
	hitscan = FALSE

/obj/projectile/bullet/rocket
	hitscan = FALSE

/obj/projectile/bullet/a40mm
	hitscan = FALSE

/obj/projectile/bullet/reusable
	hitscan = FALSE

/obj/projectile/bullet/ciws
	hitscan = FALSE

/obj/projectile/energy/bolt
	hitscan = FALSE

/obj/projectile/beam/laser/accelerator
	hitscan = FALSE

/obj/projectile/colossus
	hitscan = FALSE

/obj/projectile/temp/basilisk
	hitscan = FALSE
