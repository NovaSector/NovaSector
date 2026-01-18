/datum/map_generator/cave_generator/ocean
	weighted_open_turf_types = list(/turf/open/water/deep_beach = 100)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/stationside = 1)
	weighted_flora_spawn_list = list(
		/obj/effect/spawner/ocean_curio = 8,
		/obj/effect/spawner/ocean_curio/rock = 4,
		/obj/structure/flora/ocean/glowweed = 2,
		/obj/structure/flora/ocean/coral = 2,
	)
	weighted_mob_spawn_list = list(
		/mob/living/basic/carp/mega = 5,
		/mob/living/basic/carp = 10,
		/mob/living/basic/turtle = 2,
		/mob/living/basic/axolotl = 1,
	)

/datum/map_generator/cave_generator/ocean/wilderness
	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/low_chance = 3,
		/turf/closed/mineral/random/high_chance = 1,
	)

/datum/map_generator/cave_generator/ocean/noruins //use this for when you don't want ruins to spawn in a certain area
