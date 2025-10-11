// We override /obj/effect/mob_spawn/corpse/human/legioninfested/skeleton/charred here and instead put one of the proyectile mobs that despawn naturally. For performance.

/mob/living/basic/mining/legion/spawner_made
	corpse_type = /mob/living/basic/mining/legion_brood

/mob/living/basic/mining/legion/snow/spawner_made
	corpse_type = /mob/living/basic/mining/legion_brood/snow
