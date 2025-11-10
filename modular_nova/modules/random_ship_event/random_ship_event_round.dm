/datum/round_event/random_ship_event
	///The type of random ship event to spawn
	var/datum/random_ship_event/ship_type
	///The instantiated ship event
	var/datum/random_ship_event/ship_event
	fakeable = FALSE

/datum/round_event/random_ship_event/announce(fake)
	priority_announce("An unknown ship is attempting to contact the station.", sender_override = "Automated Traffic Control System")

/datum/round_event/random_ship_event/start()
	// Create the ship event
	if(!ship_type)
		// If no specific ship type was chosen by admin, pick a random one
		var/list/possible_ships = list()
		for(var/type in subtypesof(/datum/random_ship_event))
			var/datum/random_ship_event/test_ship = new type
			if(test_ship.can_roll())
				possible_ships += type
			qdel(test_ship)

		if(possible_ships.len)
			ship_type = pick(possible_ships)
		else
			// Fallback to a default if no valid ships found
			ship_type = /datum/random_ship_event/hc_police

	ship_event = new ship_type

	// Send the initial message to the station
	var/datum/comm_message/message = ship_event.generate_message()
	// Set up a timer to spawn the ship after a delay, like the pirate event does
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(spawn_random_ship), ship_event), 1000)
	GLOB.communications_controller.send_message(message, print = TRUE, unique = TRUE)

/datum/round_event/random_ship_event/end()
	// The ship spawning is now handled by the timer set up in start()
	// Don't delete the ship_event here, as it's needed for the timer
	return

/datum/round_event/random_ship_event/kill()
	// Don't delete the ship_event here, as it's needed for the timer
	return
