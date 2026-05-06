/datum/atc_chatter/shift_end/squak()
	switch(phase)
		if(1)
			say_line("[GLOB.station_name], this is Traffic Control, you are cleared to complete routine transfer from [GLOB.station_name] to Interlink.", "control")
			next_line()
		else
			say_line("[GLOB.station_name] departing for Interlink on routine transfer route. Estimated time to arrival: ten minutes.", "control")
			finish()
