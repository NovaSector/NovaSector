///global list of all random ship events that can show up today. they will be taken out of the global list as spawned so dupes cannot spawn.
GLOBAL_LIST_INIT(random_ship_events, init_random_ship_events())

///initializes the random ship events glob list, adding all subtypes that can roll today.
/proc/init_random_ship_events()
	var/list/random_ship_events = list()

	for(var/type in subtypesof(/datum/random_ship_event))
		var/datum/random_ship_event/possible_event = new type
		if(!possible_event.can_roll())
			qdel(possible_event)
		else
			random_ship_events += possible_event
	return random_ship_events

///datum for a random ship event that may approach the station.
/datum/random_ship_event
	///name of this event, for spawning feedback
	var/name = "Random Ship Event"

	///the random ship name chosen from pirates.json
	var/ship_name
	///the ship they load in on.
	var/ship_template_id = "ERROR"
	///the key to the json list of ship names
	var/ship_name_pool = "some_json_key"
	///inbound message title the station receives
	var/message_title = "Incoming Transmission"
	///the contents of the message sent to the station.
	///%SHIPNAME in the content will be replaced with the ship's name
	var/message_content = "This is the %SHIPNAME. We are approaching your station."
	///station receives this message upon the ship's spawn
	var/arrival_announcement = "We have arrived at the station."
	///what the station can say in response, first item accepts the ship, second item rejects it.
	var/list/possible_answers = list("Permission granted, you may dock.", "Permission denied, stay away.")

	///station responds to message and accepts the ship
	var/response_accepted = "Thank you for allowing us to dock."
	///station responds to message and rejects the ship
	var/response_rejected = "Understood, we will not approach."
	///station accepts the ship, but after it already spawned
	var/response_too_late = "We are already approaching, no need for permission now."

	/// Has the ship been accepted?
	var/accepted = FALSE
	/// The colour of their announcements when sent to players
	var/announcement_color = "blue"

/datum/random_ship_event/New()
	. = ..()
	ship_name = pick(strings("pirates.json", ship_name_pool))

///whether this random ship event can roll today. this is called when the global list initializes, so
///returning FALSE means it cannot show up at all for the entire round.
/datum/random_ship_event/proc/can_roll()
	return TRUE

///returns a new comm_message datum from this random ship event
/datum/random_ship_event/proc/generate_message()
	var/built_message_content = replacetext(message_content, "%SHIPNAME", ship_name)
	return new /datum/comm_message(message_title, built_message_content, possible_answers)

/// Placeholder ship event that reuses the existing pirate datum's default pirates, being /datum/pirate_gang/rogues.
/datum/random_ship_event/rogue_ship
	name = "Rogue Trader Ship"

	ship_template_id = "default"
	ship_name_pool = "rogue_names"

	message_title = "Trade Request"
	message_content = "Hey, this is the %SHIPNAME. We're a group of independent traders looking to do business with your station. May we approach and dock?"
	arrival_announcement = "Thank you for your hospitality. We're preparing to dock now."
	possible_answers = list("Permission granted, you may dock.", "Permission denied, stay away.")

	response_accepted = "Thank you for your cooperation. We look forward to profitable trade."
	response_rejected = "Understood. We'll take our business elsewhere."
	response_too_late = "We're already committed to our approach vector. Prepare for docking."

	announcement_color = "green"
