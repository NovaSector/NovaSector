/obj/effect/landmark/blow_up_interlink_latejoin_markers
	name = "Explode All Interlink Latejoin Markers"

/obj/effect/landmark/blow_up_interlink_latejoin_markers/Initialize(mapload)
	..()
	addtimer(CALLBACK(src, PROC_REF(blow_up_markers)), 1 MINUTES)

/// Looks for every tracked latejoin spot, and deletes it if its on the interlink
/obj/effect/landmark/blow_up_interlink_latejoin_markers/proc/blow_up_markers()
	var/list/markers_to_check = SSjob.latejoin_trackers
	for(var/location in markers_to_check)
		if(get_area(location) == /area/centcom/interlink)
			SSjob.latejoin_trackers.Remove(location)
