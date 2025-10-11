/datum/event_admin_setup/listed_options/random_ship
	input_text = "Select Random Ship Event"
	normal_run_option = "Random Random Ship Event"

/datum/event_admin_setup/listed_options/random_ship/get_list()
	return subtypesof(/datum/random_ship_event)

/datum/event_admin_setup/listed_options/random_ship/apply_to_event(datum/round_event/random_ship_event/event)
	if(isnull(chosen))
		// If no specific ship type is chosen, let the event pick a random one
		event.ship_type = null
	else
		event.ship_type = chosen
