///This is quite franlky the most important proc relating to global sounds, it uses area definition to play sounds depending on your location, and respects the players announcement volume. Generally if you're sending an announcement you want to use priority_announce.
/proc/alert_sound_to_playing(soundin, volume = 50, vary = FALSE, frequency = 0, channel = 0, pressure_affected = FALSE, sound/sound_to_use, override_volume = FALSE, list/players)
	if(!sound_to_use)
		sound_to_use = sound(get_sfx(soundin))

	if(!players)
		players = GLOB.player_list

	var/static/list/quiet_areas = typecacheof(typesof(/area/station/maintenance) + typesof(/area/space) + typesof(/area/station/commons/dorms))

	for(var/player in players)
		if(!ismob(player) || isnewplayer(player))
			continue

		var/mob/player_mob = player

		if(!player_mob.client?.prefs.read_preference(/datum/preference/toggle/sound_announcements) || !player_mob.can_hear())
			continue

		var/volume_for_player = volume
		var/area/target_area = get_area(player_mob)

		if(!override_volume && is_type_in_typecache(target_area, quiet_areas))
			volume_for_player = 10

		player_mob.playsound_local(get_turf(player_mob), sound_to_use, volume_for_player, vary, frequency, channel = channel, pressure_affected = pressure_affected, sound_to_use = sound_to_use)
