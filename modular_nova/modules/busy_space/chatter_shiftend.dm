/datum/atc_chatter/shift_end
	var/crew_transfer

/datum/atc_chatter/shift_end/squak()
	switch(SSshuttle.emergency.mode)
		if(SHUTTLE_ESCAPE)
			if(crew_transfer)
				say_line("[GLOB.station_name], this is Traffic Control, you are cleared to complete routine transfer from [GLOB.station_name] to Interlink.", "control")
			else
				say_line("[GLOB.station_name], this is Traffic Control. Emergency shuttle request received and acknowledged. Estimated time to arrival: [SSshuttle.emergency.timeLeft(60)] minutes. All crew are advised to proceed to evacuation checkpoints.", "control")
		if(SHUTTLE_RECALL)
			say_line("[GLOB.station_name], this is Traffic Control. Emergency shuttle recall confirmed. Resume normal operations.", "control")
		if(SHUTTLE_IGNITING)
			say_line("[GLOB.station_name] departing for Interlink on routine transfer route. Estimated time to arrival: [SSshuttle.emergency.timeLeft(60)] minutes.", "control")
	finish()
