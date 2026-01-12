/mob/living/basic/zombie
	var/no_corpse = FALSE

/mob/living/basic/zombie/nocorpse
	no_corpse = TRUE

/mob/living/basic/zombie/cheesezombie
	name = "Cheese Zombie"
	desc = "Oh God it stinks!!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "cheesezomb"
	icon_living = "cheesezomb"
	maxHealth = 100
	health = 100
	basic_mob_flags = DEL_ON_DEATH
	no_corpse = TRUE

/mob/living/basic/zombie/cheesezombie/Initialize(mapload)
	. = ..()
	icon = initial(icon)
	icon_state = initial(icon_state)
	icon_living = initial(icon_living)
	cut_overlays()
	AddElement(/datum/element/death_drops, string_list(list(/mob/living/basic/mouse/rat))) //the pilot of the cheese mech
