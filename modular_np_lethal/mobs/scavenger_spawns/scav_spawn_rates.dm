/obj/item/gun/Initialize(mapload)
	. = ..()

	var/list/gakster_spawns = list(
		/mob/living/basic/trooper/gakster/melee = 2,
		/mob/living/basic/trooper/gakster/ranged = 8,
	)

	AddComponent(/datum/component/spawn_scavenger, scav = pick_weight(gakster_spawns), duration = 5 MINUTES, spawn_area = list(/area/gakster_location/war), random_area_spawn = TRUE, delete_after = FALSE)

/obj/item/melee/Initialize(mapload)
	. = ..()

	var/list/gakster_spawns = list(
		/mob/living/basic/trooper/gakster/melee = 8,
		/mob/living/basic/trooper/gakster/ranged = 2,
	)

	AddComponent(/datum/component/spawn_scavenger, scav = pick_weight(gakster_spawns), duration = 5 MINUTES, spawn_area = list(/area/gakster_location/war), random_area_spawn = TRUE, delete_after = FALSE)

/obj/item/grenade/Initialize(mapload)
	. = ..()

	var/list/gakster_spawns = list(
		/mob/living/basic/trooper/gakster/melee = 4,
		/mob/living/basic/trooper/gakster/ranged = 4,
		/mob/living/basic/trooper/gakster/suicide = 2,
	)

	AddComponent(/datum/component/spawn_scavenger, scav = pick_weight(gakster_spawns), duration = 5 MINUTES, spawn_area = list(/area/gakster_location/war), random_area_spawn = TRUE, delete_after = FALSE)
