/datum/round_event_control/storyteller_control
	name = "storyteller contoled event"

/datum/round_event_control/storyteller_control/valid_for_map()
	return TRUE

/datum/round_event_control/storyteller_control/can_spawn_event(players_amt, allow_magic)
	SHOULD_CALL_PARENT(FALSE)
	return TRUE

/datum/round_event
	//Should event be avaible for random selection? by default? FALSE - It's mean only storyteller can handle with it.
	var/allow_random = TRUE


// Overrading control of the event to the storyteller system
/datum/round_event/proc/__setup_for_storyteller(threat_points, ...)
	SHOULD_CALL_PARENT(TRUE)
	setup()
	SSevents.running -= src

/datum/round_event/proc/__announce_for_storyteller()


/datum/round_event/proc/__start_for_storyteller()
	SHOULD_CALL_PARENT(TRUE)

