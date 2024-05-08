/turf
	/// The biome this turf was generated in, if any. null by default.
	var/datum/biome/biome = null

/turf/Destroy(force)
	. = ..()
	biome = null


//the random offset applied to square coordinates, causes intermingling at biome borders
#define BIOME_RANDOM_SQUARE_DRIFT 2


/datum/map_generator/cave_generator/biome
	name = "Cave Biome Generator"
	/// The turf types to replace with a biome-related turf, as an associative list of type = TRUE. Leave empty for all open turfs (but not closed turfs) to be hijacked.
	var/list/turf/open/turfs_affected_by_biome = list()
	/// 2D list of all biomes based on heat and humidity combos.
	var/list/possible_biomes = list(
		BIOME_LOW_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/plains,
			BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/mudlands,
			BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mudlands,
			BIOME_HIGH_HUMIDITY = /datum/biome/water
		),
		BIOME_LOWMEDIUM_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/plains,
			BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/jungle,
			BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/jungle,
			BIOME_HIGH_HUMIDITY = /datum/biome/mudlands
		),
		BIOME_HIGHMEDIUM_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/plains,
			BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/plains,
			BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/jungle/deep,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle
		),
		BIOME_HIGH_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/wasteland,
			BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/plains,
			BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/jungle,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/deep
		)
	)
	///Used to select "zoom" level into the perlin noise, higher numbers result in slower transitions
	var/perlin_zoom = 65


/datum/map_generator/cave_generator/biome/generate_terrain(list/turfs, area/generate_in)
	if(!(generate_in.area_flags & CAVES_ALLOWED))
		return

	var/humidity_seed = rand(0, 50000)
	var/heat_seed = rand(0, 50000)

	var/start_time = REALTIMEOFDAY
	string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]") //Generate the raw CA data

	var/list/open_turfs_used = list()

	for(var/turf/gen_turf as anything in turfs) //Go through all the turfs and generate them
		var/closed = string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x] != "0"
		var/turf/new_turf = pick(closed ? closed_turf_types : open_turf_types)

		var/datum/biome/selected_biome

		// Here's the meat of the biome replacement.
		var/drift_x = (gen_turf.x + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom
		var/drift_y = (gen_turf.y + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom

		var/humidity = text2num(rustg_noise_get_at_coordinates("[humidity_seed]", "[drift_x]", "[drift_y]"))
		var/heat = text2num(rustg_noise_get_at_coordinates("[heat_seed]", "[drift_x]", "[drift_y]"))
		var/heat_level //Type of heat zone we're in (LOW-LOWMEDIUM-HIGHMEDIUM-HIGH)
		var/humidity_level  //Type of humidity zone we're in (LOW-LOWMEDIUM-HIGHMEDIUM-HIGH)

		switch(heat)
			if(0 to 0.25)
				heat_level = BIOME_LOW_HEAT
			if(0.25 to 0.5)
				heat_level = BIOME_LOWMEDIUM_HEAT
			if(0.5 to 0.75)
				heat_level = BIOME_HIGHMEDIUM_HEAT
			if(0.75 to 1)
				heat_level = BIOME_HIGH_HEAT

		switch(humidity)
			if(0 to 0.25)
				humidity_level = BIOME_LOW_HUMIDITY
			if(0.25 to 0.5)
				humidity_level = BIOME_LOWMEDIUM_HUMIDITY
			if(0.5 to 0.75)
				humidity_level = BIOME_HIGHMEDIUM_HUMIDITY
			if(0.75 to 1)
				humidity_level = BIOME_HIGH_HUMIDITY

		selected_biome = possible_biomes[heat_level][humidity_level]
		selected_biome = SSmapping.biomes[selected_biome] //Get the instance of this biome from SSmapping

		if((!length(turfs_affected_by_biome) && !closed) || turfs_affected_by_biome[new_turf])
			new_turf = selected_biome.generate_turf_for_terrain(gen_turf)

		else
			// The assumption is this will be faster then changeturf, and changeturf isn't required since by this point
			// The old tile hasn't got the chance to init yet
			new_turf = new new_turf(gen_turf)

		if(!closed)
			open_turfs_used[new_turf.type] = TRUE

		new_turf.biome = selected_biome

		if(gen_turf.turf_flags & NO_RUINS)
			new_turf.turf_flags |= NO_RUINS

		CHECK_TICK

	open_turf_types = assoc_to_keys(open_turfs_used)

	var/message = "[name] terrain generation finished in [(REALTIMEOFDAY - start_time)/10]s!"
	to_chat(world, span_boldannounce("[message]"))
	log_world(message)


/datum/map_generator/cave_generator/populate_terrain(list/turfs, area/generate_in)
	// Area var pullouts to make accessing in the loop faster
	var/flora_allowed = (generate_in.area_flags & FLORA_ALLOWED)
	var/features_allowed = (generate_in.area_flags & FLORA_ALLOWED)
	var/fauna_allowed = (generate_in.area_flags & MOB_SPAWN_ALLOWED)

	var/start_time = REALTIMEOFDAY

	// No sense in doing anything here if nothing is allowed anyway.
	if(!flora_allowed && !features_allowed && !fauna_allowed)
		var/message = "[name] terrain population finished in [(REALTIMEOFDAY - start_time)/10]s!"
		add_startup_message(message)
		log_world(message)
		return


	for(var/turf/target_turf as anything in turfs)
		if(!(target_turf.type in open_turf_types)) //only put stuff on open turfs we generated, so closed walls and rivers and stuff are skipped
			continue

		target_turf.biome?.populate_turf(target_turf, flora_allowed, features_allowed, fauna_allowed)

		// // If we've spawned something yet
		// var/spawned_something = FALSE

		// ///Spawning isn't done in procs to save on overhead on the 60k turfs we're going through.
		// //FLORA SPAWNING HERE
		// if(flora_allowed && prob(flora_spawn_chance))
		// 	var/flora_type = pick(flora_spawn_list)
		// 	new flora_type(target_turf)
		// 	spawned_something = TRUE

		// //FEATURE SPAWNING HERE
		// //we may have generated something from the flora list on the target turf, so let's not place
		// //a feature here if that's the case (because it would look stupid)
		// if(feature_allowed && !spawned_something && prob(feature_spawn_chance))
		// 	var/can_spawn = TRUE

		// 	var/atom/picked_feature = pick(feature_spawn_list)

		// 	for(var/obj/structure/existing_feature in range(7, target_turf))
		// 		if(istype(existing_feature, picked_feature))
		// 			can_spawn = FALSE
		// 			break

		// 	if(can_spawn)
		// 		new picked_feature(target_turf)
		// 		spawned_something = TRUE

		// //MOB SPAWNING HERE
		// if(mobs_allowed && !spawned_something && prob(mob_spawn_chance))
		// 	var/atom/picked_mob = pick(mob_spawn_list)
		// 	var/is_megafauna = FALSE

		// 	if(picked_mob == SPAWN_MEGAFAUNA)
		// 		if(megas_allowed) //this is danger. it's boss time.
		// 			picked_mob = pick(megafauna_spawn_list)
		// 			is_megafauna = TRUE
		// 		else //this is not danger, don't spawn a boss, spawn something else
		// 			picked_mob = pick(mob_spawn_no_mega_list) //What if we used 100% of the brain...and did something (slightly) less shit than a while loop?

		// 	var/can_spawn = TRUE

		// 	// prevents tendrils spawning in each other's collapse range
		// 	if(ispath(picked_mob, /obj/structure/spawner/lavaland))
		// 		for(var/obj/structure/spawner/lavaland/spawn_blocker in range(2, target_turf))
		// 			can_spawn = FALSE
		// 			break
		// 	// if the random is not a tendril (hopefully meaning it is a mob), avoid spawning if there's another one within 12 tiles
		// 	else
		// 		var/list/things_in_range = range(12, target_turf)
		// 		for(var/mob/living/mob_blocker in things_in_range)
		// 			if(ismining(mob_blocker))
		// 				can_spawn = FALSE
		// 				break
		// 		// Also block spawns if there's a random lavaland mob spawner nearby and it's not a mega
		// 		if(!is_megafauna)
		// 			can_spawn = can_spawn && !(locate(/obj/effect/spawner/random/lavaland_mob) in things_in_range)
		// 	//if there's a megafauna within standard view don't spawn anything at all (This isn't really consistent, I don't know why we do this. you do you tho)
		// 	if(can_spawn)
		// 		for(var/mob/living/simple_animal/hostile/megafauna/found_fauna in range(7, target_turf))
		// 			can_spawn = FALSE
		// 			break

		// 	if(can_spawn)
		// 		if(ispath(picked_mob, /mob/living/simple_animal/hostile/megafauna/bubblegum)) //there can be only one bubblegum, so don't waste spawns on it
		// 			weighted_megafauna_spawn_list.Remove(picked_mob)
		// 			megafauna_spawn_list = expand_weights(weighted_megafauna_spawn_list)
		// 			megas_allowed = megas_allowed && length(megafauna_spawn_list)
		// 		new picked_mob(target_turf)
		// 		spawned_something = TRUE
		CHECK_TICK

	var/message = "[name] terrain population finished in [(REALTIMEOFDAY - start_time)/10]s!"
	add_startup_message(message)
	log_world(message)


/datum/biome
	/// Base chance of spawning features
	var/feature_spawn_chance = 0
	/// Weighted list of extra features that can spawn in the area, such as geysers.
	var/list/weighted_feature_spawn_list
	/// Expanded list of extra features that can spawn in the area. Reads from the weighted list
	var/list/feature_spawn_list


/datum/biome/New()
	. = ..()
	if(length(flora_types) && !quick_is_list_associative(flora_types))
		flora_types = expand_weights(fill_with_ones(flora_types))

	if(length(fauna_types) && !quick_is_list_associative(fauna_types))
		fauna_types = expand_weights(fill_with_ones(fauna_types))

	if(!length(weighted_feature_spawn_list))
		return

	feature_spawn_list = expand_weights(weighted_feature_spawn_list)


/proc/quick_is_list_associative(list/list_to_check)
	return length(list_to_check) && list_to_check[list_to_check[1]] != null

/// This proc handles the creation of a turf of a specific biome type, assuming
/// that the turf has not been initialized yet. Don't call this unless you know
/// what you're doing.
/datum/biome/proc/generate_turf_for_terrain(turf/gen_turf)
	var/turf/new_turf = new turf_type(gen_turf)
	return new_turf

/// This proc handles populating the given turf based on whether flora,
/// features and fauna are allowed. Does not take megafauna into account.
/datum/biome/proc/populate_turf(turf/target_turf, flora_allowed, features_allowed, fauna_allowed)
	if(flora_allowed && length(flora_types) && prob(flora_density))
		var/obj/structure/flora = pick(flora_types)
		new flora(target_turf)
		return TRUE

	if(features_allowed && prob(feature_spawn_chance))
		var/can_spawn = TRUE

		var/atom/picked_feature = pick(feature_spawn_list)

		for(var/obj/structure/existing_feature in range(7, target_turf))
			if(istype(existing_feature, picked_feature))
				can_spawn = FALSE
				break

		if(can_spawn)
			new picked_feature(target_turf)
			return TRUE

	if(fauna_allowed && length(fauna_types) && prob(fauna_density))
		var/mob/picked_mob = pick(fauna_types)

		// prevents tendrils spawning in each other's collapse range
		if(ispath(picked_mob, /obj/structure/spawner/lavaland))
			for(var/obj/structure/spawner/lavaland/spawn_blocker in range(2, target_turf))
				return FALSE

		// if the random is not a tendril (hopefully meaning it is a mob), avoid spawning if there's another one within 12 tiles
		else
			var/list/things_in_range = range(12, target_turf)
			for(var/mob/living/mob_blocker in things_in_range)
				if(ismining(mob_blocker))
					return FALSE

			// Also block spawns if there's a random lavaland mob spawner nearby
			if(locate(/obj/effect/spawner/random/lavaland_mob) in things_in_range)
				return FALSE

		new picked_mob(target_turf)
		return TRUE

	return FALSE


// /datum/map_generator/cave_generator/biome/proc/get_open_turf_for_biome()
// 	var/drift_x = (gen_turf.x + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom
// 	var/drift_y = (gen_turf.y + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom

// 	var/datum/biome/selected_biome
// 	var/humidity = text2num(rustg_noise_get_at_coordinates("[humidity_seed]", "[drift_x]", "[drift_y]"))
// 	var/heat = text2num(rustg_noise_get_at_coordinates("[heat_seed]", "[drift_x]", "[drift_y]"))
// 	var/heat_level //Type of heat zone we're in (LOW-LOWMEDIUM-HIGHMEDIUM-HIGH)
// 	var/humidity_level  //Type of humidity zone we're in (LOW-LOWMEDIUM-HIGHMEDIUM-HIGH)

// 	switch(heat)
// 		if(0 to 0.25)
// 			heat_level = BIOME_LOW_HEAT
// 		if(0.25 to 0.5)
// 			heat_level = BIOME_LOWMEDIUM_HEAT
// 		if(0.5 to 0.75)
// 			heat_level = BIOME_HIGHMEDIUM_HEAT
// 		if(0.75 to 1)
// 			heat_level = BIOME_HIGH_HEAT

// 	switch(humidity)
// 		if(0 to 0.25)
// 			humidity_level = BIOME_LOW_HUMIDITY
// 		if(0.25 to 0.5)
// 			humidity_level = BIOME_LOWMEDIUM_HUMIDITY
// 		if(0.5 to 0.75)
// 			humidity_level = BIOME_HIGHMEDIUM_HUMIDITY
// 		if(0.75 to 1)
// 			humidity_level = BIOME_HIGH_HUMIDITY

// 	selected_biome = possible_biomes[heat_level][humidity_level]
// 	selected_biome = SSmapping.biomes[selected_biome] //Get the instance of this biome from SSmapping

// 	return selected_biome.turf_type

/datum/map_generator/cave_generator/biome/forest/mushroom
	name = "Mushroom Cave Biome Generator"
	weighted_open_turf_types = list(/turf/open/misc/dirt/forest = 3, /turf/open/misc/asteroid/forest/mushroom = 2)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/forest = 1)
	flora_spawn_chance = 35
	initial_closed_chance = 53
	birth_limit = 5
	death_limit = 4
	smoothing_iterations = 10

	mob_spawn_chance = 0 //planning to increase this once we have custom mushroom mobs to increase diversity
	flora_spawn_chance = 15

	turfs_affected_by_biome = list(
		/turf/open/misc/asteroid/forest/mushroom = TRUE,
	)
	possible_biomes = list(
		BIOME_LOW_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/mushroom_cave,
			BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/mushroom_cave,
			BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mushroom_cave/green,
			BIOME_HIGH_HUMIDITY = /datum/biome/mushroom_cave/blue
		),
		BIOME_LOWMEDIUM_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/mushroom_cave,
			BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/mushroom_cave,
			BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mushroom_cave/green,
			BIOME_HIGH_HUMIDITY = /datum/biome/mushroom_cave/blue
		),
		BIOME_HIGHMEDIUM_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/mushroom_cave,
			BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/mushroom_cave/green,
			BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mushroom_cave/green,
			BIOME_HIGH_HUMIDITY = /datum/biome/mushroom_cave/blue
		),
		BIOME_HIGH_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/mushroom_cave,
			BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/mushroom_cave/green,
			BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mushroom_cave/blue,
			BIOME_HIGH_HUMIDITY = /datum/biome/mushroom_cave/blue
		)
	)

	weighted_mob_spawn_list = list(
		/obj/effect/spawner/random/lavaland_mob/goliath = 3,
		/mob/living/basic/mining/goldgrub = 1,
	)
	weighted_flora_spawn_list = list(
		/obj/structure/flora/tree/mushroom = 4,
		/obj/structure/flora/tree/mushroom/reverse = 4,
		/obj/structure/flora/ash/fireblossom = 2,
		/obj/structure/flora/ash/cap_shroom = 1,
		/obj/structure/flora/ash/leaf_shroom = 1,
		/obj/structure/flora/ash/seraka = 1,
		/obj/structure/flora/ash/stem_shroom = 1,
		/obj/structure/flora/ash/tall_shroom = 1,
	)


/datum/biome/mushroom_cave
	turf_type = /turf/open/misc/asteroid/forest/mushroom
	flora_density = 15
	feature_spawn_chance = 0.25
	flora_types = list(
		/obj/structure/flora/tree/mushroom = 4,
		/obj/structure/flora/tree/mushroom/reverse = 4,
		/obj/structure/flora/ash/fireblossom = 2,
		/obj/structure/flora/ash/cap_shroom = 1,
		/obj/structure/flora/ash/leaf_shroom = 1,
		/obj/structure/flora/ash/seraka = 1,
		/obj/structure/flora/ash/stem_shroom = 1,
		/obj/structure/flora/ash/tall_shroom = 1,
	)
	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 10,
		/obj/structure/geyser/plasma_oxide = 10,
		/obj/structure/geyser/protozine = 10,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 10,
	)

/datum/biome/mushroom_cave/blue
	turf_type = /turf/open/misc/asteroid/forest/mushroom/blue
	flora_density = 15
	feature_spawn_chance = 0.25
	flora_types = list(
		/obj/structure/flora/tree/mushroom/blue = 4,
		/obj/structure/flora/tree/mushroom/blue/reverse = 4,
		/obj/structure/flora/ash/fireblossom = 2,
		/obj/structure/flora/ash/cap_shroom = 1,
		/obj/structure/flora/ash/leaf_shroom = 1,
		/obj/structure/flora/ash/seraka = 1,
		/obj/structure/flora/ash/stem_shroom = 1,
		/obj/structure/flora/ash/tall_shroom = 1,
	)
	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 10,
		/obj/structure/geyser/plasma_oxide = 10,
		/obj/structure/geyser/protozine = 10,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 10,
	)

/datum/biome/mushroom_cave/green
	turf_type = /turf/open/misc/asteroid/forest/mushroom/green
	flora_density = 15
	feature_spawn_chance = 0.25
	flora_types = list(
		/obj/structure/flora/tree/mushroom/green = 4,
		/obj/structure/flora/tree/mushroom/green/reverse = 4,
		/obj/structure/flora/ash/fireblossom = 2,
		/obj/structure/flora/ash/cap_shroom = 1,
		/obj/structure/flora/ash/leaf_shroom = 1,
		/obj/structure/flora/ash/seraka = 1,
		/obj/structure/flora/ash/stem_shroom = 1,
		/obj/structure/flora/ash/tall_shroom = 1,
	)
	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 10,
		/obj/structure/geyser/plasma_oxide = 10,
		/obj/structure/geyser/protozine = 10,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 10,
	)

#undef BIOME_RANDOM_SQUARE_DRIFT
