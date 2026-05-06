//minimum and maximum message delays, typically tracked in seconds
#define MIN_MSG_DELAY 3
#define MAX_MSG_DELAY 6

/datum/atc_chatter
	VAR_PROTECTED/phase = 1 // phase of dialog being displayed
	// Docks and zones
	VAR_PROTECTED/yes = FALSE
	VAR_PROTECTED/request = ""
	VAR_PROTECTED/callname = ""
	VAR_PROTECTED/response = ""
	VAR_PROTECTED/number = 1
	VAR_PROTECTED/zone = ""
	VAR_PROTECTED/landing_zone = ""
	VAR_PROTECTED/landing_type = ""
	VAR_PROTECTED/landing_move = ""
	VAR_PROTECTED/landing_short = ""
	// Ship identities
	VAR_PROTECTED/name = ""
	VAR_PROTECTED/owner = ""
	VAR_PROTECTED/prefix = ""
	VAR_PROTECTED/firstid = ""
	VAR_PROTECTED/mission = ""
	VAR_PROTECTED/shipname = ""
	VAR_PROTECTED/destname = ""
	VAR_PROTECTED/slogan = ""
	VAR_PROTECTED/org_type = ""
	// Second ship identity
	VAR_PROTECTED/secondname = ""
	VAR_PROTECTED/secondowner = ""
	VAR_PROTECTED/secondprefix = ""
	VAR_PROTECTED/secondid = ""
	VAR_PROTECTED/secondshipname = ""
	VAR_PROTECTED/org_type2 = ""
	// Combined data
	VAR_PROTECTED/combined_first_name = ""
	VAR_PROTECTED/short_first_name = ""
	VAR_PROTECTED/comm_first_name = ""
	VAR_PROTECTED/combined_second_name = ""
	VAR_PROTECTED/comm_second_name = ""
	VAR_PROTECTED/short_second_name = ""
	VAR_PROTECTED/mission_noun = ""
	// Talking head data
	VAR_PROTECTED/current_speaker = null
	VAR_PROTECTED/current_target = null
	VAR_PROTECTED/next_message_delay = 3 SECONDS
	VAR_PROTECTED/message_timer = null

/datum/atc_chatter/New(var/datum/lore/organization/source, var/datum/lore/organization/secondary)
	if(source && secondary) // Evac shuttle atc passes nothing in and only uses map datum for names!
		/////////////////////////////////////////////////////////////////////
		// Get the docking bay or zone in space the ships are passing into
		/////////////////////////////////////////////////////////////////////
		//First response is 'yes', second is 'no'
		var/requests = list(
					"special flight rules" = list("authorizing special flight rules", "denying special flight rules, not allowed for your traffic class"),
					"current solar weather info" = list("sending you the relevant information via tightbeam", "your request has been queued, stand by"),
					"sector aerospace priority" = list("affirmative, sector aerospace priority is yours", "negative, another vessel in your sector has priority right now"),
					"system traffic info" = list("sending you current traffic info", "request queued, please hold"),
					"refueling information" = list("sending refueling information now", "depots currently experiencing fuel shortages, advise you move on"),
					"a current system time sync" = list("sending time sync ping to you now", "your ship isn't compatible with our time sync, set time manually"),
					"current system starcharts" = list("transmitting current starcharts", "your request is queued, overloaded right now")
					)
		request = pick(requests)
		yes = prob(90) //Chance for them to say yes vs no
		callname = "Traffic Control"
		response = requests[request][yes ? 1 : 2] //1 is yes, 2 is no
		number = rand(1,42)
		zone = pick("Alpha","Beta","Gamma","Delta","Epsilon","Zeta","Eta","Theta","Iota","Kappa","Lambda","Mu","Nu","Xi","Omicron","Pi","Rho","Sigma","Tau","Upsilon","Phi","Chi","Psi","Omega")
		//fallbacks in case someone sets the dock_type on the map datum to null- it defaults to "station" normally
		landing_zone = "LZ [zone]"
		landing_type = "landing zone"
		landing_move = "landing request"
		landing_short = "land"
		if(!SSmapping.is_planetary())
			landing_zone = "docking bay [number]"
			landing_type = "docking bay"
			landing_move = "docking request"
			landing_short = "dock"
			callname = "Traffic Control"
		else
			landing_zone = "landing pad [number]"
			landing_type = "landing pad"
			landing_move = "landing request"
			landing_short = "land"
			callname = "Traffic Tower"

		/////////////////////////////////////////////////////////////////////
		// Construct the two ships involved from their loremaster organization data
		/////////////////////////////////////////////////////////////////////
		//Let's get some mission parameters, pick our first ship
		name = source.name					//get the name
		owner = source.short_name				//Use the short name
		prefix = pick(source.ship_prefixes)			//Pick a random prefix
		firstid = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
		mission = source.ship_prefixes[prefix]		//The value of the prefix is the mission type that prefix does
		shipname = pick(source.ship_names)			//Pick a random ship name
		destname = pick(source.destination_names)		//destination is where?
		slogan = pick(source.slogans)			//god help you all
		org_type = source.org_type				//which group do we belong to?
		//pick our second ship
		secondname = secondary.name			//not used atm, commented out to suppress errors
		secondowner = secondary.short_name
		secondprefix = pick(secondary.ship_prefixes)	//Pick a random prefix
		secondid = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
		secondshipname = pick(secondary.ship_names)		//Pick a random ship name
		org_type2 = secondary.org_type

		//DEBUG BLOCK
		//to_world("DEBUG OUTPUT 1: [name], [owner], [prefix], [firstid], [mission], [shipname], [org_type], [destname]")
		//to_world("DEBUG OUTPUT 2: [secondowner], [secondprefix], [secondid], [secondshipname], [org_type2]")
		//to_world("DEBUG OUTPUT 3: Chose [chatter_type]")
		//DEBUG BLOCK ENDS

		combined_first_name = "[prefix] [firstid] |[shipname]|"	//formal traffic control identifier for use in messages
		short_first_name = "[prefix] |[shipname]|"	//special variant for certain events
		comm_first_name = "[owner] [shipname]"	//corpname + shipname for speaker identity in log
		combined_second_name = "[secondprefix] [secondid] |[secondshipname]|"
		comm_second_name = "[secondowner] [secondshipname]"
		short_second_name = "[secondprefix] |[secondshipname]|"	//not actually used for now

		mission_noun = pick(source.flight_types)		//pull from a list of owner-specific flight ops, to allow an extra dash of flavor
		if(source.complex_tasks)				//if our source has the complex_tasks flag, regenerate with a two-stage assignment
			mission_noun = "[pick(source.task_types)] [pick(source.flight_types)]"

	// Get the ball rolling
	squak()

/datum/atc_chatter/Destroy()
	cleanup_speakers()
	return ..()

/datum/atc_chatter/proc/cleanup_speakers()
	if(current_speaker)
		qdel(current_speaker)
		current_speaker = null
	if(current_target)
		qdel(current_target)
		current_target = null
	if(message_timer)
		deltimer(message_timer)
		message_timer = null

/datum/atc_chatter/proc/squak()
	PROTECTED_PROC(TRUE)
	// calls acknowledge at each message phase until final, where it qdel(src)
	return

/datum/atc_chatter/proc/get_speaker_name(speaker_type, comm_name, combined_name)
	// Returns formatted name for the mob
	switch(speaker_type)
		if("control")
			return "[callname] (Air Traffic Control)"
		if("vessel")
			return "[combined_name] ([comm_name])"
		if("secondary")
			return "[combined_second_name] ([comm_second_name])"
		else
			return "[comm_name]"

/datum/atc_chatter/proc/say_line(message, speaker_type)
	if(!SSatc.talking_head)
		return

	// Set the talking head's name based on speaker type
	switch(speaker_type)
		if("control")
			SSatc.talking_head.name = callname
		if("vessel")
			SSatc.talking_head.name = combined_first_name
		if("secondary")
			return SSatc.talking_head.name = combined_second_name

	// Use the talking head to transmit the message
	SSatc.talking_head.say(message)

	// Log for admin/debug
	log_say("[SSatc.talking_head.name]: [message]")

/datum/atc_chatter/proc/next_line(var/multiplier = 1, var/speaker_type = null, var/text = null)
	SHOULD_NOT_OVERRIDE(TRUE)
	PROTECTED_PROC(TRUE)

	if(message_timer)
		deltimer(message_timer)

	var/delay = (rand(MIN_MSG_DELAY, MAX_MSG_DELAY) SECONDS) * multiplier
	delay = max(delay, next_message_delay)  // Ensure minimum delay between lines

	message_timer = addtimer(CALLBACK(src, PROC_REF(do_next_line), speaker_type, text), delay, TIMER_STOPPABLE)

/datum/atc_chatter/proc/do_next_line(speaker_type, text)
	message_timer = null
	if(text)
		say_line(text, speaker_type)

	// Call the original squak phase advancement
	var/pr_ref = PROC_REF(squak)
	phase++
	addtimer(CALLBACK(src, pr_ref), (rand(MIN_MSG_DELAY, MAX_MSG_DELAY) SECONDS))

/datum/atc_chatter/proc/next(var/multiplier = 1, var/extra_delay = 0, var/pr_ref = null)
	SHOULD_NOT_OVERRIDE(TRUE)
	PROTECTED_PROC(TRUE)
	if(!pr_ref)
		pr_ref = PROC_REF(squak)
		phase++

	var/delay = (rand(MIN_MSG_DELAY, MAX_MSG_DELAY) SECONDS) * multiplier + extra_delay
	addtimer(CALLBACK(src, pr_ref), delay)

/datum/atc_chatter/proc/pause(seconds = 3, var/pr_ref = null)
	if(!pr_ref)
		pr_ref = PROC_REF(squak)
		phase++ // Don't advance phase on pause, just delay next message
	addtimer(CALLBACK(src, pr_ref), seconds SECONDS)

/datum/atc_chatter/proc/finish()
	SHOULD_CALL_PARENT(TRUE)
	PROTECTED_PROC(TRUE)
	qdel(src)

#undef MIN_MSG_DELAY
#undef MAX_MSG_DELAY
