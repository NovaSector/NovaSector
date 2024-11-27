SUBSYSTEM_DEF(spacemap)
	name = "Spacemap"
	init_order = INIT_ORDER_SPACEMAP
	flags = SS_NO_FIRE

	/// A list of all of the roundstart partitionned space z-levels.
	var/list/datum/space_level/partition/roundstart_space_partitions = list()
	/// A list of all of the roundstart space zones.
	var/list/datum/space_zone/roundstart_space_zones = list()
	/// A list of all of the rift space partition z-levels, which aren't meant
	/// to spawn ruins right away, but will instead spawn them (and delete
	/// them) on demand.
	var/list/datum/space_level/partition/rift/rift_space_partitions = list()
	/// A list of all of the rift space zones.
	var/list/datum/space_zone/rift/rift_space_zones = list()


/datum/controller/subsystem/spacemap/Initialize()
	return SS_INIT_SUCCESS // Change this once we have to actually initialize some stuff here too.


/**
 * Helper that simply handles the creation of all of the necessary partitioned
 * space z-levels necessary for Spacemap to function properly.
 */
/datum/controller/subsystem/spacemap/proc/generate_spacemap_partitions()
	var/count = 0
	var/max_big_partitions = CONFIG_GET(number/spacemap_big_partitions_count)

	while (count < max_big_partitions)
		roundstart_space_partitions.Add(SSmapping.add_new_zlevel("Big Space Partition [count + 1]", z_type = /datum/space_level/partition/four))
		count++

	count = 0
	var/max_average_partitions = CONFIG_GET(number/spacemap_average_partitions_count)
	while (count < max_average_partitions)
		roundstart_space_partitions.Add(SSmapping.add_new_zlevel("3x3 Space Partition [count + 1]", z_type = /datum/space_level/partition/nine))
		count++

	count = 0
	var/max_rift_partitions = CONFIG_GET(number/spacemap_rift_partitions_count)
	while (count < max_rift_partitions)
		rift_space_partitions.Add(SSmapping.add_new_zlevel("Rift Space Partition [count + 1]", z_type = /datum/space_level/partition/rift/nine))
		count++


/**
 * Handles spawning ruins in the spacemap partitions at roundstart.
 */
/datum/controller/subsystem/spacemap/proc/spawn_ruins_in_partitions()
	var/list/initial_ruins = SSmapping.themed_ruins[ZTRAIT_SPACE_RUINS]
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


/**
 * Registers a space zone into the subsystem, so it remains aware of its existence.
 *
 * Arguments:
 * * zone_to_register - The /datum/space_zone to register in the subsystem.
 * * is_rift - Whether or not this space zone is considered a "rift" zone, and
 * as such is meant to be temporary. Defaults to `FALSE`.
 */
/datum/controller/subsystem/spacemap/proc/register_space_zone(datum/space_zone/zone_to_register, is_rift = FALSE)
	if(!zone_to_register || !istype(zone_to_register))
		CRASH("Tried to register invalid space zone ([zone_to_register ? zone_to_register.type : "NULL"]).")

	if(is_rift)
		rift_space_zones.Add(zone_to_register)

	else
		roundstart_space_zones.Add(zone_to_register)


/**
 * Prints a list of all of the generated space zones with their generated ruins to ADMIN LOG.
 */
/datum/controller/subsystem/spacemap/proc/print_space_zones()
	var/list/output = list()

	output.Add("Roundstart:")

	var/roundstart_count = 0
	for(var/datum/space_zone/space_zone as anything in roundstart_space_zones)
		var/list/display_strings = list(
			"[space_zone.can_fit_big_ruins ? "Big" : "Regular"]: ",
			"[space_zone.ruin_name ? space_zone.ruin_name : "Empty"]",
			space_zone.spacemap_icon ? " - [space_zone.spacemap_icon]" : "",
			" - ([space_zone.start_x], [space_zone.start_y], [space_zone.z]) to ([space_zone.end_x], [space_zone.end_y], [space_zone.z])",
		)

		output.Add(display_strings.Join(""))
		roundstart_count++

	output.Add("Rifts:")

	var/rift_count = 0
	for(var/datum/space_zone/rift/space_zone as anything in rift_space_zones)
		var/list/display_strings = list(
			"Rift: ",
			"[space_zone.ruin_name ? space_zone.ruin_name : "Empty"]",
			space_zone.spacemap_icon ? " - [space_zone.spacemap_icon]" : "",
			" - ([space_zone.start_x], [space_zone.start_y], [space_zone.z]) to ([space_zone.end_x], [space_zone.end_y], [space_zone.z])",
		)

		output.Add(display_strings.Join(""))
		rift_count++

	output.Add("Total: [roundstart_count + rift_count] - Roundstart: [roundstart_count] - Rifts: [rift_count]")

	message_admins(output.Join("\n"))
