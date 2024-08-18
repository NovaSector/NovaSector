// Lavaland mob portal storm
/datum/round_event_control/portal_storm_lavaland
	name = "Portal Storm: Curse of Indecipheres"
	typepath = /datum/round_event/portal_storm/lavaland
	min_players = 40 // Not on lowpop please
	earliest_start = 30 MINUTES
	category = EVENT_CATEGORY_ENTITIES
	map_flags = EVENT_SPACE_ONLY // Need lavaland to be there
	description = "The Necropolis curses the station, infesting it with monsters from Indecipheres."

/datum/round_event_control/portal_storm_lavaland/preRunEvent()
	if (SSmapping.is_planetary())
		return EVENT_CANT_RUN
	return ..()

/datum/round_event/portal_storm/lavaland
	boss_types = list(/mob/living/basic/mining/goliath = 1)
	hostile_types = list(
		/mob/living/basic/mining/lobstrosity/lava = 2,
		/mob/living/basic/mining/brimdemon = 3,
		/mob/living/basic/mining/legion = 4,
		/mob/living/basic/mining/watcher = 4,
	)

/datum/round_event/portal_storm/lavaland/announce(fake)
	set waitfor = 0
	sound_to_playing_players('sound/weather/ashstorm/inside/weak_start.ogg')
	sleep(10 SECONDS)
	sound_to_playing_players('sound/weather/ashstorm/inside/weak_mid1.ogg')
	sleep(5 SECONDS)
	priority_announce("Abstract energy signals originating from planet-side detected en route to [station_name()]. Brace for impact.")
	sleep(4 SECONDS)
	sound_to_playing_players('sound/weather/ashstorm/inside/weak_end.ogg')
