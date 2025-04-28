/obj/item/firing_pin/wastes
	name = "\improper Wastes firing pin"
	desc = "This safety firing pin allows weapons to be fired only on areas away from the station."
	fail_message = "Wastes check failed! - Try getting further from the station first."
	pin_hot_swappable = FALSE
	pin_removable = FALSE
	var/list/wastes = list(
			/area/forestplanet/outdoors/unexplored,
			/area/icemoon/surface/outdoors,
			/area/icemoon/underground/unexplored,
			/area/icemoon/underground/explored,
			/area/lavaland/surface/outdoors,
			/area/ocean/generated,
			/area/ruin,
	)

/obj/item/firing_pin/wastes/pin_auth(mob/living/user)
	if(!istype(user))
		return FALSE
	if (is_type_in_list(get_area(user), wastes))
		return TRUE
	var/turf/station_check = get_turf(user)
	if(!station_check || is_station_level(station_check.z))
		return FALSE
	return TRUE
