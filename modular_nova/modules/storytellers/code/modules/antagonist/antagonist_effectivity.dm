/datum/antagonist/proc/get_effectivity()
	return 1



/datum/antagonist/traitor/get_effectivity()
	var/total = 0
	var/datum/uplink_handler/uplink = uplink_handler

	if(!uplink)




	if(!uplink.has_progression)
		total *= 0.5
	return total
