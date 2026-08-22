/// Lets a home's reservation be told apart from any other block of reserved turfs, the same way
/// /datum/turf_reservation/condo does for condos.
/datum/turf_reservation/player_home
	/// The home currently loaded into these turfs.
	var/datum/home_instance/home
