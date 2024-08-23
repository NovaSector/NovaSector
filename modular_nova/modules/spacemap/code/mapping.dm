/datum/controller/subsystem/mapping
	/// A list of all of the roundstart partitionned space z-levels.
	var/list/datum/space_level/partition/roundstart_space_partitions = list()
	/// A list of all of the rift space partition z-levels, which aren't meant
	/// to spawn ruins right away, but will instead spawn them (and delete
	/// them) on demand.
	var/list/datum/space_level/partition/rift/rift_space_partitions = list()

/**
 * Helper that simply handles the creation of all of the necessary partitioned
 * space z-levels necessary for Spacemap to function properly.
 */
/datum/controller/subsystem/mapping/proc/generate_spacemap_partitions()
	var/count = 0
	var/max_big_partitions = CONFIG_GET(number/spacemap_big_partitions_count)

	while (count < max_big_partitions)
		roundstart_space_partitions.Add(add_new_zlevel("Big Space Partition", z_type = /datum/space_level/partition/four))
		count++

	count = 0
	var/max_average_partitions = CONFIG_GET(number/spacemap_average_partitions_count)
	while (count < max_average_partitions)
		roundstart_space_partitions.Add(add_new_zlevel("3x3 Space Partition [count + 1]", z_type = /datum/space_level/partition/nine))
		count++

	count = 0
	var/max_rift_partitions = CONFIG_GET(number/spacemap_rift_partitions_count)
	while (count < max_rift_partitions)
		rift_space_partitions.Add(add_new_zlevel("Rift Space Partition", z_type = /datum/space_level/partition/nine))
		count++


/**
 * Handles spawning ruins in the spacemap partitions at roundstart.
 */
/datum/controller/subsystem/mapping/proc/spawn_ruins_in_partitions()
	var/list/initial_ruins = themed_ruins[ZTRAIT_SPACE_RUINS]
	var/list/possible_ruins = initial_ruins.Copy()
	var/list/small_ruins_available = list()
	var/list/big_ruins_available = list()
	var/list/forced_small_ruins = list()
	var/list/forced_big_ruins = list()

	var/list/whitelist_typecache = typecacheof(list(/area/space))

	for(var/key in possible_ruins)
		var/datum/map_template/ruin/space/ruin = possible_ruins[key]

		if(PERFORM_ALL_TESTS(log_mapping))
			ruin.cost = 0
			ruin.allow_duplicates = FALSE // no multiples for testing
			ruin.always_place = !ruin.unpickable // unpickable ruin means it spawns as a set with another ruin

		if(ruin.always_place)
			if(ruin.requires_big_zone)
				forced_big_ruins += ruin
			else
				forced_small_ruins += ruin
			continue

		if(ruin.unpickable)
			continue

		if(ruin.requires_big_zone)
			big_ruins_available[ruin] = ruin.placement_weight
			continue

		small_ruins_available[ruin] = ruin.placement_weight

	for(var/datum/space_level/partition/space_partition in roundstart_space_partitions)
		if(space_partition.big_zones)
			space_partition.populate_ruins(big_ruins_available, forced_big_ruins, whitelist_typecache)
			continue

		space_partition.populate_ruins(small_ruins_available, forced_small_ruins, whitelist_typecache)


/datum/controller/subsystem/mapping/setup_ruins()
	. = ..()

	spawn_ruins_in_partitions()
