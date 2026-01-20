/datum/map_generator/cave_generator/ocean
	flora_spawn_chance = 15
	initial_closed_chance = 10
	smoothing_iterations = 3
	feature_spawn_chance = 15
	weighted_open_turf_types = list(/turf/open/water/deep_beach/planet_surface = 100)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/stationside/ocean = 1)
	weighted_flora_spawn_list = list(
		/obj/structure/flora/ocean/seaweed = 10,
		/obj/structure/flora/ocean/longseaweed = 8,
		/obj/structure/flora/ocean/coral = 3,
		/obj/structure/flora/rock/style_random = 1,
	)
	weighted_feature_spawn_list = list(/obj/item/toy/seashell = 100)

/datum/map_generator/cave_generator/ocean/rocky
	initial_closed_chance = 35
	smoothing_iterations = 15
	weighted_open_turf_types = list(
		/turf/open/water/deep_beach/planet_surface = 66,
		/turf/open/misc/ocean_no_liquid = 33,
		)
	weighted_flora_spawn_list = list(/obj/structure/flora/rock/style_random = 100)

/datum/map_generator/cave_generator/lagoon
	flora_spawn_chance = 15
	initial_closed_chance = 40
	smoothing_iterations = 18
	weighted_open_turf_types = list(/turf/open/water/beach/planet_surface = 100)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/stationside/ocean = 1)
	weighted_flora_spawn_list = list(
		/obj/structure/flora/ocean/seaweed = 8,
		/obj/structure/flora/ocean/longseaweed = 6,
		/obj/structure/flora/ocean/coral = 4,
		/obj/structure/flora/rock/style_random = 3,
	)

/datum/map_generator/cave_generator/lagoon/friendly_mobs
	mob_spawn_chance = 0.5
	weighted_mob_spawn_list = list(
		/mob/living/basic/axolotl = 1,
		/mob/living/basic/crab = 5,
	)

/datum/map_generator/cave_generator/lagoon/hostile_mobs
	mob_spawn_chance = 1.75
	weighted_mob_spawn_list = list(
		/mob/living/basic/carp/mega = 5,
		/mob/living/basic/carp = 10,
	)

/datum/map_generator/cave_generator/lagoon/friendly_mobs/wilderness
	feature_spawn_chance = 1
	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/low_chance/ocean = 3,
		/turf/closed/mineral/random/high_chance/ocean = 1,
	)

/datum/map_generator/cave_generator/lagoon/hostile_mobs/wilderness
	mob_spawn_chance = 3
	feature_spawn_chance = 1
	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/low_chance/ocean = 3,
		/turf/closed/mineral/random/high_chance/ocean = 1,
	)
