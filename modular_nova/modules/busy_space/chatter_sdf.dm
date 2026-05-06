/datum/atc_chatter/sdfpatrolupdate/squak()
	//SDF event: patrol update
	switch(phase)
		if(1)
			var/statusupdate = pick("nothing unusual so far","nothing of note","everything looks clear so far","ran off some [pick("pirates","scavengers")] near route [pick(1,100)], [pick("no","minor")] damage sustained, continuing patrol","situation normal, no suspicious activity yet","minor incident on route [pick(1,100)]","Code 7-X [pick("on route","in sector")] [pick(1,100)], situation is under control","seeing a lot of traffic on route [pick(1,100)]","caught a couple of smugglers [pick("on route","in sector")] [pick(1,100)]","sustained some damage in a skirmish just now, we're heading back for repairs")
			say_line("Nova Sector Defense Control, [combined_first_name] reporting in, [statusupdate], over.", "vessel")
			next_line()
		else
			say_line("Nova Sector Defense Control copies, [combined_first_name]. Keep us updated, out.", "control")
			finish()

/datum/atc_chatter/sdfendingpatrol/squak()
	//SDF event: end patrol
	switch(phase)
		if(1)
			say_line("[callname], [combined_first_name], returning from our system patrol route, requesting permission to [landing_short].", "vessel")
			next_line()
		if(2)
			say_line("[combined_first_name], [callname]. Permission granted, proceed to [landing_zone]. Follow the green lights on your way in.", "control")
			next_line()
		else
			var/appreciation = pick("Copy","Understood","Affirmative","10-4","Roger that")
			var/dockingplan = pick("Starting final approach now.","Commencing landing procedures.","Autopilot engaged.","Approach vector locked in.","In the pipe, five by five.")
			say_line("[appreciation], [callname]. [dockingplan]", "vessel")
			finish()

/datum/atc_chatter/sdfchatter
	var/chain = null

/datum/atc_chatter/sdfchatter/squak()
	//SDF event: general chatter
	if(!chain)
		chain = pick("codecheck","commscheck")
	switch(chain)
		if("codecheck")
			switch(phase)
				if(1)
					say_line("Check. Check. |Check|. Uhhh... check? Wait. Wait! Hold on. Yeah, okay, I gotta call this one in.", "vessel")
					next_line()
				if(2)
					say_line("[callname], confirm auth-code... [rand(1,9)][rand(1,9)][rand(1,9)]-[pick("Alpha","Beta","Gamma","Delta","Epsilon","Zeta","Eta","Theta","Iota","Kappa","Lambda","Mu","Nu","Xi","Omicron","Pi","Rho","Sigma","Tau","Upsilon","Phi","Chi","Psi","Omega")]?", "vessel")
					next_line()
				if(3)
					say_line("One moment...", "control")
					next_line()
				if(4)
					say_line("Yeah, that code checks out [combined_first_name].", "control")
					next_line()
				else
					say_line("|(sigh)| Copy that Control. You! Move along!", "vessel")
					finish()
		if("commscheck")
			switch(phase)
				if(1)
					say_line("Control this is [combined_first_name], we're getting some interference in our area. [pick("How's our line?","Do you read?","How copy, over?")]", "vessel")
					next_line()
				if(2)
					say_line("Control reads you loud and clear [combined_first_name].", "control")
					next_line()
				else
					say_line("[pick("Copy that","Thanks,","Roger that")] Control. [combined_first_name] out.", "vessel")
					finish()

/datum/atc_chatter/sdfbeginpatrol/squak()
	//SDF event: starting patrol
	switch(phase)
		if(1)
			var/takeoff = pick("depart","launch","take off","dust off")
			say_line("[callname], [combined_first_name], requesting permission to [takeoff] from [landing_zone] to begin system patrol.", "vessel")
			next_line()
		if(2)
			var/safetravels = pick("Fly safe out there","Good luck","Good hunting","Safe travels","Godspeed","Stars guide you")
			say_line("[combined_first_name], [callname]. Permission granted. Docking clamps released. [safetravels].", "control")
			next_line()
		else
			var/thanks = pick("Appreciated","Thanks","Don't worry about us","We'll be fine","You too")
			say_line("[thanks], [callname]. This is [combined_first_name] beginning system patrol, out.", "vessel")
			finish()
