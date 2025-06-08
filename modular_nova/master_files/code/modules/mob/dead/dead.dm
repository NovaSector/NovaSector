/mob/dead/get_status_tab_items()
	. = ..()
	if(SSticker.HasRoundStarted())
		return
	var/time_remaining = SSticker.GetTimeLeft()
	if(time_remaining > 0)
		. += "Time To Start: [round(time_remaining/10)]s"
	else if(time_remaining == -10)
		. += "Time To Start: DELAYED"
	else
		. += "Time To Start: SOON"

	. += "Players: [LAZYLEN(GLOB.clients)]"
	if(client.holder)
		. += "Players Ready: [SSticker.totalPlayersReady]"
		. += "Admins Ready: [SSticker.total_admins_ready] / [length(GLOB.admins)]"

