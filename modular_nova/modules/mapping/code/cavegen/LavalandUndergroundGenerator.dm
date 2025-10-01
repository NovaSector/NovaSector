/datum/map_generator/cave_generator/lavaland/underground
	weighted_open_turf_types = list(/turf/open/misc/ashplanet/rocky = 8, /turf/open/misc/ashplanet/ash = 5)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/volcanic/underground = 1)

	weighted_mob_spawn_list = list(
		/obj/effect/spawner/random/lavaland_mob/goliath = 50,
		/obj/effect/spawner/random/lavaland_mob/legion = 30,
		/mob/living/basic/mining/bileworm = 20,
		/mob/living/basic/mining/brimdemon = 20,
		/mob/living/basic/mining/goldgrub = 10,
		/obj/structure/spawner/lavaland = 2,
		/obj/structure/spawner/lavaland/goliath = 2,
		/obj/structure/spawner/lavaland/legion = 2,
	)

	weighted_flora_spawn_list = list(
		/obj/structure/flora/ash/cacti = 1,
		/obj/structure/flora/ash/cap_shroom = 2,
		/obj/structure/flora/ash/fireblossom = 3,
		/obj/structure/flora/ash/leaf_shroom = 3,
		/obj/structure/flora/ash/seraka = 4,
		/obj/structure/flora/ash/stem_shroom = 4,
		/obj/structure/flora/ash/tall_shroom = 4,
	)

	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 10,
		/obj/structure/geyser/plasma_oxide = 10,
		/obj/structure/geyser/protozine = 10,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 10,
		/obj/structure/ore_vent/boss = 1,
	)

	smoothing_iterations = 20
	birth_limit = 4
	death_limit = 3

/datum/map_generator/cave_generator/lavaland/tunnel
	perlin_zoom = 5
	weighted_open_turf_types = list(/turf/open/misc/ashplanet/rocky = 8, /turf/open/misc/ashplanet/ash = 5)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/volcanic/underground = 1)
	flora_spawn_chance = 6
	weighted_mob_spawn_list = null
	initial_closed_chance = 25
	birth_limit = 5
	death_limit = 4
	smoothing_iterations = 50

	weighted_flora_spawn_list = list(
	/obj/structure/flora/ash/cacti = 1,
	/obj/structure/flora/ash/fireblossom = 3,
	/obj/structure/flora/ash/leaf_shroom = 3,
	/obj/structure/flora/ash/tall_shroom = 4,
	)

	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 10,
		/obj/structure/geyser/plasma_oxide = 10,
		/obj/structure/geyser/protozine = 10,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 10,
	)

/datum/map_generator/cave_generator/lavaland/riverside
	flora_spawn_chance = 4
	weighted_mob_spawn_list = null
	initial_closed_chance = 53
	birth_limit = 5
	death_limit = 4
	smoothing_iterations = 10

	weighted_flora_spawn_list = list(
	/obj/structure/flora/ash/fireblossom = 3,
	/obj/structure/flora/rock/style_random = 6,
	/obj/structure/flora/rock/pile/style_random = 6,
	/obj/structure/flora/ash = 1,
	)

