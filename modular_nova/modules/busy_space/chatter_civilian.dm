/datum/atc_chatter/traveladvisory/squak()
	//Control event: travel advisory
	switch(phase)
		if(1)
			say_line("[callname], all vessels in the Nova Sector system. Priority travel advisory follows.", "control")
			next_line()
		else
			var/flightwarning = pick(
				"Solar flare activity is spiking and expected to cause issues along main flight lanes [rand(1,33)], [rand(34,67)], and [rand(68,100)]",
				"Pirate activity is on the rise, stay close to System Defense vessels",
				"We're seeing a rise in illegal salvage operations, please report any unusual activity to the nearest SDF vessel via channel [SSatc.sdfchannel]",
				"A quarantined [pick("fleet","convoy")] is passing through the system along route [rand(1,100)], please observe minimum safe distance",
				"A prison [pick("fleet","convoy")] is passing through the system along route [rand(1,100)], please observe minimum safe distance",
				"Traffic volume is higher than normal, expect processing delays",
				"Anomalous bluespace activity detected [pick("along route [rand(1,100)]","in sector [rand(1,100)]")], exercise caution",
				"Smugglers have been particularly active lately, expect increased security scans",
				"Depots are currently experiencing a fuel shortage, expect delays and higher rates",
				"Asteroid mining has displaced debris dangerously close to main flight lanes on route [rand(1,100)], watch for potential impactors",
				"A [pick("fuel tanker","cargo liner","passenger liner","freighter","transport ship","mining barge","salvage trawler")] has collided with [pick("a fuel tanker","a cargo liner","a passenger liner","a freighter","a transport ship","a mining barge","a salvage trawler","a meteoroid","a cluster of space debris","an asteroid","an ice-rich comet")] near route [rand(1,100)], watch for debris and do not impede emergency service vessels",
				"A [pick("fuel tanker","cargo liner","passenger liner","freighter","transport ship","mining barge","salvage trawler")] on route [rand(1,100)] has experienced total engine failure. Emergency response teams are en route, please observe minimum safe distances and do not impede emergency service vessels",
				"Transit routes have been recalculated to adjust for planetary drift. Please synch your astronav computers as soon as possible to avoid delays and difficulties",
				"[pick("Bounty hunters","System Defense officers","Mercenaries")] are currently searching for a wanted fugitive, report any sightings of suspicious activity to System Defense via channel [SSatc.sdfchannel]",
				"It's space [pick("carp","shark")] breeding season. [pick("Stars","Skies","Gods","God","Goddess","Fates")] have mercy on you all",
				"We're reading [pick("void","drive","sensor")] echoes that are consistent with illegal cloaking devices, be alert for suspicious activity in your sector",
			)
			say_line("[flightwarning]. Control out.", "control")
			finish()

/datum/atc_chatter/pathwarning/squak()
	//Control event: warning to a specific vessel
	switch(phase)
		if(1)
			var/navhazard = pick("a pocket of intense radiation","a pocket of unstable gas","a debris field","a secure installation","an active combat zone","a quarantined ship","a quarantined installation","a quarantined sector","a live-fire SDF training exercise","an ongoing Search & Rescue operation","a hazardous derelict","an intense electrical storm","an intense ion storm","a shoal of space carp","a pack of space sharks","an asteroid infested with gnat hives","a protected space ray habitat","a region with anomalous bluespace activity","a rogue comet")
			say_line("[combined_first_name], [callname]. Your [pick("ship","vessel","starship")] is approaching [navhazard], observe minimum safe distance and adjust your heading appropriately.", "control")
			next_line()
		if(2)
			var/confirm = pick("Understood","Roger that","Affirmative","Our bad","Thanks for the heads up")
			say_line("[confirm] [callname], adjusting course.", "vessel")
			next_line()
		else
			say_line("Your compliance is appreciated, [combined_first_name].", "control")
			finish()

/datum/atc_chatter/civvieleaks/squak()
	//Civil event: leaky chatter
	switch(phase)
		if(1)
			var/commleak = pick("thatsmywife","missingkit","pipeleaks","weirdsmell","weirdsmell2","scug","teppi")
			switch(commleak)
				if("thatsmywife")
					say_line("-so then I says to him, |that's no [pick("space carp","space shark","vox","garbage scow","freight liner","cargo hauler","superlifter")], that's my +wife!+| And he-", "vessel")
					next_line()
				if("missingkit")
					say_line("-did you get the kit from down on deck [rand(1,4)]? I need th-", "vessel")
					next_line()
				if("pipeleaks")
					say_line("I swear if these pipes keep leaking I'm going to-", "vessel")
					next_line()
				if("weirdsmell")
					say_line("-and where the hell is that smell coming fr-", "vessel")
					next_line()
				if("weirdsmell2")
					say_line("-hat in the [pick("three","five","seven","nine")] hells did you |eat| [pick("ensign","crewman")]? This compartment reeks of-", "vessel")
					next_line()
				if("scug")
					say_line("-and if that weird cat of yours keeps crawling into the pipes we-", "vessel")
					next_line()
				if("teppi")
					say_line("-at are we supposed to do with this damn cow?", "vessel")
					next_line(1, PROC_REF(teppi_next))
		if(2)
			say_line("[combined_first_name], your internal comms are leaking[pick("."," again.",", again.",". |Again|.")]", "control")
			next_line()
		else
			say_line("Sorry Control, won't happen again.", "vessel")
			finish()

/datum/atc_chatter/civvieleaks/proc/teppi_next()
	say_line("I don't think it's a cow, sir, it looks more like a-", "vessel")
	next_line()

/datum/atc_chatter/slogan/squak()
	switch(phase)
		if(1)
			say_line("The following is a sponsored message from [name].", "control")
			next_line()
		else
			say_line("[slogan]", "control")
			finish()

/datum/atc_chatter/misc/squak()
	//time for generic message
	switch(phase)
		if(1)
			say_line("[callname], [combined_first_name] on [mission] [pick(mission_noun)] to [destname], requesting [request].", "vessel")
			next_line()
		if(2)
			say_line("[combined_first_name], [callname], [response].", "control")
			next_line()
		else
			say_line("[callname], [yes ? "thank you" : "understood"], out.", "vessel")
			finish()
