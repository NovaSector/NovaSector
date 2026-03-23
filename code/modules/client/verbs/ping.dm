/client/verb/update_ping(time as num)
	set instant = TRUE
	set name = ".update_ping"
	var/ping = pingfromtime(time)
	lastping = ping
	if (!avgping)
		avgping = ping
	else
		avgping = MC_AVERAGE_SLOW(avgping, ping)

/client/proc/pingfromtime(time)
	return ((world.time+world.tick_lag*TICK_USAGE_REAL/100)-time)*100

/client/verb/display_ping(time as num)
	set instant = TRUE
	set name = ".display_ping"
	//to_chat(src, span_notice("Round trip ping took [round(pingfromtime(time),1)]ms")) // NOVA EDIT REMOVAL
	// NOVA EDIT ADDITION START
	var/ping_in_ms = round(pingfromtime(time),1)
	to_chat(src, span_notice("Round trip ping took [ping_in_ms]ms"))
	if(ping_in_ms >= 110)
		to_chat(src, "NOTE: If you are consistently experiencing high latency, consider connecting using one of our relays. (Use the Connect-to-Relay OOC verb, or click File->Connect to Relay)") // NOVA EDIT ADDITION
	// NOVA EDIT ADDITION END

/client/verb/ping()
	set name = "Ping"
	set category = "OOC"
	winset(src, null, "command=.display_ping+[world.time+world.tick_lag*TICK_USAGE_REAL/100]")
