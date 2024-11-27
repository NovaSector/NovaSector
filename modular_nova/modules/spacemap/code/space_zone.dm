/**
 * Datum holding the information on a zone of space, for partitioned space
 * to handle ruins generation and the likes for Spacemap.
 */
/datum/space_zone
	/// Name of the ruin contained within this space zone. Determined by the loaded ruin.
	var/ruin_name
	/// Ruin icon for this space zone. Determined by the loaded ruin.
	var/spacemap_icon
	/// Whether or not this space zone starts discovered for everyone. Defaults to FALSE.
	var/starts_discovered = FALSE
	/// Whether or not this space zone is for a rift.
	var/is_rift = FALSE
	/// z coordinate of the zone.
	var/z
	/// Lowest x coordinate of the zone.
	var/start_x
	/// Highest x coordinate of the zone.
	var/end_x
	/// Lowest y coordinate of the zone.
	var/start_y
	/// Highest y coordinate of the zone.
	var/end_y
	/// x coordinate of the center of the zone.
	var/middle_x
	/// y coordinate of the center of the zone.
	var/middle_y
	/// Can this zone fit big ruins?
	var/can_fit_big_ruins = FALSE


/datum/space_zone/New(z, start_x, end_x, start_y, end_y)
	. = ..()
	src.z = z
	src.start_x = start_x
	src.end_x = end_x
	src.start_y = start_y
	src.end_y = end_y

	middle_x = floor(start_x + (end_x - start_x) / 2)
	middle_y = floor(start_y + (end_y - start_y) / 2)

	SSspacemap.register_space_zone(src, is_rift)

/**
 * Simple proc that handles spawning the ruin in the middle of the zone.
 *
 * Arguments:
 * * ruin_to_spawn - The ruin we're trying to spawn.
 * * area_whitelist - The area whitelist typecache to use for
 * `ruin.try_to_place()`
 */
/datum/space_zone/proc/spawn_ruin(datum/map_template/ruin/space/ruin_to_spawn, list/area_whitelist)
	var/turf/central_turf = locate(middle_x, middle_y, z)
	ruin_to_spawn.try_to_place(z, area_whitelist, central_turf, FALSE)

	ruin_name = ruin_to_spawn.name
	ruin_name = replacetext(ruin_name, "Space-Ruin ", "")
	spacemap_icon = ruin_to_spawn.spacemap_icon
	starts_discovered = ruin_to_spawn.starts_discovered


// For space zones that are intended for rifts.
/datum/space_zone/rift
	is_rift = TRUE
