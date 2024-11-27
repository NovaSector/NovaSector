/**
 * This is what contains all of the pertinent information about a spaceship
 * and its components, tying everything up together.
 */
/datum/spaceship
	/// The name of the spaceship, useful for hailing and for the signal on
	/// the spacemap.
	var/name
	/// The attached docking port. Very important to move the shuttle around.
	var/obj/docking_port/mobile/ship_docking_port
