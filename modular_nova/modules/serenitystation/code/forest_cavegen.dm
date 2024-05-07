/datum/map_generator/cave_generator/forest
	weighted_open_turf_types = list(/turf/open/misc/asteroid/forest = 1)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/forest = 1)
	flora_spawn_chance = 35
	initial_closed_chance = 53
	birth_limit = 5
	death_limit = 4
	smoothing_iterations = 10

	weighted_mob_spawn_list = list(
		/mob/living/basic/deer/mining = 50,
		/mob/living/basic/mining/megadeer = 15,
		/mob/living/basic/mining/goldgrub = 1,
	)

	weighted_flora_spawn_list = list(
		/obj/structure/flora/ash/fireblossom = 2,
		/obj/structure/flora/grass/jungle/a/style_random = 15,
		/obj/structure/flora/grass/jungle/b/style_random = 30,
		/obj/structure/flora/bush/jungle/a/style_random = 5,
		/obj/structure/flora/bush/jungle/b/style_random = 5,
		/obj/structure/flora/bush/jungle/c/style_random = 5,
		/obj/structure/flora/rock/pile/jungle/style_random = 3,
		/obj/structure/flora/rock/pile/jungle/large/style_random = 1,
		/obj/structure/flora/tree/jungle/style_random = 7,
		/obj/structure/flora/tree/jungle/small/style_random = 3,
	)
	///Note that this spawn list is also in the lavaland generator
	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 10,
		/obj/structure/geyser/plasma_oxide = 10,
		/obj/structure/geyser/protozine = 10,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 10,
	)

/datum/map_generator/cave_generator/forest/deep
	weighted_open_turf_types = list(/turf/open/misc/dirt/forest = 3, /turf/open/misc/asteroid/forest/mushroom = 2)

	mob_spawn_chance = 0 //planning to increase this once we have custom mushroom mobs to increase diversity
	flora_spawn_chance = 15

	weighted_mob_spawn_list = list(
		/obj/effect/spawner/random/lavaland_mob/goliath = 3,
		/mob/living/basic/mining/goldgrub = 1,
	)

	weighted_flora_spawn_list = list(
		/obj/structure/flora/tree/mushroom = 4,
		/obj/structure/flora/tree/mushroom/reverse = 4,
		/obj/structure/flora/ash/fireblossom = 2,

		/obj/structure/flora/ash/cacti = 1,
		/obj/structure/flora/ash/cap_shroom = 1,
		/obj/structure/flora/ash/leaf_shroom = 1,
		/obj/structure/flora/ash/seraka = 1,
		/obj/structure/flora/ash/stem_shroom = 1,
		/obj/structure/flora/ash/tall_shroom = 1,
	)

