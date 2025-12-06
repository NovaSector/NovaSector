/obj/projectile/bullet/c85x20mm/rubber
	name = "85x20mm rubber slug"
	damage = 20
	ricochets_max = 8
	ricochet_chance = 150
	ricochet_incidence_leeway = 35
	ricochet_decay_chance = 0.6
	weak_against_armour = TRUE
	wound_bonus = -60
	exposed_wound_bonus = 10
	wound_falloff_tile = -6
	speed = 1
	//knockback?

/obj/projectile/bullet/rocket/c250x40mm
	name = "250x40mm sabot slug"
	icon_state = "gaussstrong"
	damage = 60
	anti_armour_damage = 120
	armour_penetration = 100
	wound_bonus = 80
	wound_falloff_tile = 0
	hitsound = 'sound/effects/bang.ogg'
	hitsound_wall = 'sound/effects/bang.ogg'
	max_pierces = 3
	speed = 4
	random_crits_enabled = FALSE
	//knockback?

/obj/projectile/bullet/rocket/c250x40mm/do_boom(atom/target, blocked = FALSE)
	if(issilicon(target))
		// Loud kinetic impact, no explosion
		explosion(target, light_impact_range = 1, flash_range = 1, explosion_cause = src)
		return

	if(isstructure(target) || isvehicle(target) || isclosedturf(target) || ismachinery(target))
		if(target.density)
			// Dense targets get a heavier kinetic shock
			explosion(target, heavy_impact_range = 1, light_impact_range = 1, flash_range = 1, explosion_cause = src)
		else
			// Light structures still get breached
			explosion(target, light_impact_range = 1, flash_range = 1, explosion_cause = src)
		return

/obj/projectile/ion/small
	name = "small ion bolt"
	emp_radius = 0
