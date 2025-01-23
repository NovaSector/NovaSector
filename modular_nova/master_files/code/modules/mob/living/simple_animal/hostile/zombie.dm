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

/mob/living/basic/zombie/cheesezombie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/death_drops, string_list(list(/obj/effect/gibspawner/human)))

