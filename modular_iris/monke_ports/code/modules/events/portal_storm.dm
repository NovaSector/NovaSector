/datum/round_event_control/portal_storm_monkey
	name = "Random Chimp Event"
	typepath = /datum/round_event/portal_storm/portal_storm_monkey
	weight = 15
	max_occurrences = 2
	earliest_start = 20 MINUTES
	category = EVENT_CATEGORY_ENTITIES
	//track = EVENT_TRACK_MAJOR //add this back in when we get storytellers
	description = "Angry monkies pour out of portals."

/datum/round_event/portal_storm/portal_storm_monkey
	boss_types = list(/mob/living/basic/gorilla/lesser = 1)
	hostile_types = list(
		/mob/living/carbon/human/species/monkey/angry = 10,
	)

/datum/round_event/portal_storm/portal_storm_monkey/announce(fake)
	set waitfor = 0
	sound_to_playing_players('sound/music/antag/monkey.ogg')
	sleep(7 SECONDS)
	priority_announce("Random Chimp Event detected en route to [station_name()]. Brace for mad apes.")
	sleep(2 SECONDS)
	sound_to_playing_players('modular_iris/monke_ports/sound/misc/monkeystorm.ogg')

/datum/round_event_control/portal_storm_kobold //weaker monke storm
	name = "Kobold Invasion"
	typepath = /datum/round_event/portal_storm/portal_storm_kobold
	weight = 30 //no boss type enemies
	max_occurrences = 3
	earliest_start = 20 MINUTES
	category = EVENT_CATEGORY_ENTITIES
	//track = EVENT_TRACK_MAJOR
	description = "My Captain! A second Kobold hit the station!"

/datum/round_event/portal_storm/portal_storm_kobold
	hostile_types = list(
		/mob/living/carbon/human/species/monkey/kobold/angry = 10,
	)

/datum/round_event/portal_storm/portal_storm_kobold/announce(fake)
	set waitfor = 0
	sound_to_playing_players('sound/music/antag/monkey.ogg')
	sleep(7 SECONDS)
	priority_announce("Kobold Invasion detected en route to [station_name()].")
	sleep(2 SECONDS)
	sound_to_playing_players('modular_iris/monke_ports/sound/misc/monkeystorm.ogg')
