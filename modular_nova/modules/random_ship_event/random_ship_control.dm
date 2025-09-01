/datum/round_event_control/random_ship_event
	name = "Random Ship Event"
	typepath = /datum/round_event/random_ship_event
	weight = 10
	max_occurrences = 1
	min_players = 15
	category = EVENT_CATEGORY_SPACE
	description = "A random ship will attempt to contact the station with unknown intentions."
	admin_setup = list(/datum/event_admin_setup/listed_options/random_ship)
	map_flags = EVENT_SPACE_ONLY

/datum/round_event_control/random_ship_event/preRunEvent()
	if (SSmapping.is_planetary())
		return EVENT_CANT_RUN
	return ..()
