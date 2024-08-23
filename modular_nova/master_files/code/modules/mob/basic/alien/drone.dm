/mob/living/basic/alien/drone/Initialize(mapload)
	. = ..()
	switch(rand(1,5))
		if(1)
			name = "alien drone"
			icon_state = "aliendrone"
			icon_living = "aliendrone"
			icon_dead = "aliendrone_dead"
			health = 150
			maxHealth = 150
			melee_damage_lower = 15
			melee_damage_upper = 15
			unique_name = TRUE
			pixel_x = -16
			base_pixel_x = -16
		if(2)
			name = "alien warrior"
			icon_state = "alienwarrior"
			icon_living = "alienwarrior"
			icon_dead = "alienwarrior_dead"
			health = 175
			maxHealth = 175
			unique_name = TRUE
			mob_size = MOB_SIZE_LARGE
			pixel_x = -16
			base_pixel_x = -16
		if(3)
			name = "alien runner"
			icon_state = "alienrunner"
			icon_living = "alienrunner"
			icon_dead = "alienrunner_dead"
			health = 125
			maxHealth = 125
			melee_damage_lower = 10
			melee_damage_upper = 15
			unique_name = TRUE
			pixel_x = -16
			base_pixel_x = -16
		if(4)
			name = "alien defender"
			icon_state = "aliendefender"
			icon_living = "aliendefender"
			icon_dead = "aliendefender_dead"
			health = 225
			maxHealth = 225
			melee_damage_lower = 10
			melee_damage_upper = 15
			unique_name = TRUE
			mob_size = MOB_SIZE_LARGE
			pixel_x = -16
			base_pixel_x = -16
		if(5)
			name = "alien ravager"
			icon_state = "alienravager"
			icon_living = "alienravager"
			icon_dead = "alienravager_dead"
			health = 200
			maxHealth = 200
			unique_name = TRUE
			mob_size = MOB_SIZE_LARGE
			pixel_x = -16
			base_pixel_x = -16
