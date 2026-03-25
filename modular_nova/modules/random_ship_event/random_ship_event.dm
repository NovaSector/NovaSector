///Global list of all random ship events that can show up today. They will be taken out of the global list as spawned so dupes cannot spawn.
GLOBAL_LIST_INIT(random_ship_events, init_random_ship_events())

#define POSITIVE_ANSWER 1
#define NEGATIVE_ANSWER 2

///Initializes the random ship events glob list, adding all subtypes that can roll this shift.
/proc/init_random_ship_events()
	var/list/random_ship_events = list()

	for(var/type in subtypesof(/datum/random_ship_event))
		var/datum/random_ship_event/possible_event = new type
		if(!possible_event.can_roll())
			qdel(possible_event)
		else
			random_ship_events += possible_event
	return random_ship_events

///Random ship datum that may approach the station.
/datum/random_ship_event
	///Name of this event, for spawning feedback.
	var/name = "Random Ship Event"

	///The random ship name chosen from pirates.json.
	var/ship_name
	///The ship they load in on.
	var/ship_template_id = "ERROR"
	///The key to the json list of ship names.
	var/ship_name_pool = "some_json_key"
	///Inbound message title the station receives.
	var/message_title = "Incoming Transmission"
	///The contents of the message sent to the station.
	///%SHIPNAME in the content will be replaced with the ship's name.
	var/message_content = "This is the %SHIPNAME. We are approaching your station."
	///Station receives this message upon the ship's spawn.
	var/arrival_announcement = "We have arrived at the station."
	///What the station can say in response. First item accepts the ship, second item rejects it.
	var/list/possible_answers = list("Permission granted, you may dock.", "Permission denied, stay away.")

	///Station responds to message and accepts the ship.
	var/response_accepted = "Thank you for allowing us to dock."
	///Station responds to message and rejects the ship.
	var/response_rejected = "Understood, we will not approach."
	///Has the ship been accepted?
	var/accepted = FALSE
	///The colour of their announcements when sent to players
	var/announcement_color = "blue"

/datum/random_ship_event/New()
	. = ..()
	ship_name = pick(strings("random_ships_nova.json", ship_name_pool))

///Whether this random ship event can roll today. This is called when the global list initializes.
///Returning FALSE means it cannot show up at all for the entire round.
/datum/random_ship_event/proc/can_roll()
	return TRUE

///Returns a new comm_message datum from this random ship event.
/datum/random_ship_event/proc/generate_message()
	var/built_message_content = replacetext(message_content, "%SHIPNAME", ship_name)
	var/datum/comm_message/message = new /datum/comm_message(message_title, built_message_content, possible_answers)
	message.answer_callback = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(random_ship_event_answered), message, src)
	return message

/proc/random_ship_event_answered(datum/comm_message/message, datum/random_ship_event/event)
	if(!message?.answered)
		return
	if(message.answered == POSITIVE_ANSWER)
		event.accepted = TRUE
		priority_announce(event.response_accepted, sender_override = event.ship_name, color_override = event.announcement_color)
		event.on_accept()
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(spawn_random_ship), event), 1 MINUTES)
	else
		priority_announce(event.response_rejected, sender_override = event.ship_name, color_override = event.announcement_color)
		event.on_refuse()

///Spawns the random ship proper, with the follow-up effects, if you've set any up.
/proc/spawn_random_ship(datum/random_ship_event/event)
	if(!event || !event.accepted)
		return

	var/template_key = "random_ship_[event.ship_template_id]"
	var/datum/map_template/shuttle/random_ship/ship = SSmapping.shuttle_templates[template_key]
	if(!ship)
		template_key = "random_ship_default"
		ship = SSmapping.shuttle_templates[template_key]
		if(!ship)
			CRASH("No valid ship template found for random ship event!")

	var/x = rand(TRANSITIONEDGE, world.maxx - TRANSITIONEDGE - ship.width)
	var/y = rand(TRANSITIONEDGE, world.maxy - TRANSITIONEDGE - ship.height)
	var/z = SSmapping.empty_space.z_value
	var/turf/T = locate(x, y, z)
	if(!T)
		CRASH("Random ship event found no turf to load in")

	if(!ship.load(T))
		CRASH("Loading random ship failed!")

	event.on_ship_spawn()
	priority_announce(event.arrival_announcement, sender_override = event.ship_name, color_override = event.announcement_color)

///Additional effects when the ship is accepted
/datum/random_ship_event/proc/on_accept()
	return

///Additional effects when the ship is refused
/datum/random_ship_event/proc/on_refuse()
	return

///Additional effects when the ship actually spawns
/datum/random_ship_event/proc/on_ship_spawn()
	return
