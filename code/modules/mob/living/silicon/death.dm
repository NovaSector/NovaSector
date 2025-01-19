/mob/living/silicon/spawn_gibs()
	new /obj/effect/gibspawner/robot(drop_location(), src)

/mob/living/silicon/spawn_dust(just_ash)
	if(just_ash)
		return ..()

	var/obj/effect/decal/remains/robot/robones = new(loc)
	robones.pixel_z = -6
	robones.pixel_w = rand(-1, 1)

/mob/living/silicon/death(gibbed)
	diag_hud_set_status()
	diag_hud_set_health()
	update_health_hud()
	return ..()
