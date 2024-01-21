#define HAS_JUKEBOX_PREF(mob) (!QDELETED(mob) && !isnull(mob.client) && mob.client.prefs.read_preference(/datum/preference/toggle/sound_jukebox) && mob.can_hear())

SUBSYSTEM_DEF(jukeboxes)
	name = "Jukeboxes"
	wait = 5
	var/list/songs = list()
	var/list/activejukeboxes = list()
	var/list/freejukeboxchannels = list()

/datum/track
	var/song_associated_id = null

/datum/controller/subsystem/jukeboxes/proc/addjukebox(obj/machinery/jukebox/jukebox, datum/track/track, jukefalloff = 1)
	if(!istype(track))
		CRASH("[src] tried to play a song with a nonexistant track")
	var/channeltoreserve = pick(freejukeboxchannels)
	if(!channeltoreserve)
		return FALSE
	freejukeboxchannels -= channeltoreserve
	var/list/youvegotafreejukebox = list(track, channeltoreserve, jukebox, jukefalloff)
	activejukeboxes.len++
	activejukeboxes[activejukeboxes.len] = youvegotafreejukebox

	//Due to changes in later versions of 512, SOUND_UPDATE no longer properly plays audio when a file is defined in the sound datum. As such, we are now required to init the audio before we can actually do anything with it.
	//Downsides to this? This means that you can *only* hear the jukebox audio if you were present on the server when it started playing, and it means that it's now impossible to add loops to the jukebox track list.
	var/sound/song_to_init = sound(track.song_path)
	song_to_init.status = SOUND_MUTE

	// Collect mobs to play the song to, stores weakrefs of them in rangers
	for(var/mob/to_play_to in range(world.view, jukebox))
		if(!HAS_JUKEBOX_PREF(to_play_to))
			continue
		var/datum/weakref/weak_playing_to = WEAKREF(to_play_to)
		if(jukebox.rangers[weak_playing_to])
			continue
		jukebox.rangers[weak_playing_to] = TRUE
		// This plays the sound directly underneath the mob because otherwise it'd get stuck in their left ear or whatever
		// Would be neat if it sourced from the box itself though
		to_play_to.playsound_local(get_turf(to_play_to), null, jukebox.volume, channel = youvegotafreejukebox[2], sound_to_use = song_to_init, use_reverb = FALSE)

	return activejukeboxes.len

/datum/controller/subsystem/jukeboxes/proc/removejukebox(IDtoremove)
	if(islist(activejukeboxes[IDtoremove]))
		var/jukechannel = activejukeboxes[IDtoremove][2]
		freejukeboxchannels |= jukechannel
		activejukeboxes.Cut(IDtoremove, IDtoremove+1)
		return TRUE
	else
		CRASH("Tried to remove jukebox with invalid ID")

/datum/controller/subsystem/jukeboxes/proc/findjukeboxindex(obj/machinery/jukebox)
	if(length(activejukeboxes))
		for(var/list/jukeinfo in activejukeboxes)
			if(jukebox in jukeinfo)
				return activejukeboxes.Find(jukeinfo)
	return FALSE

/datum/controller/subsystem/jukeboxes/proc/findjukeboxchannel(obj/machinery/jukebox)
	if(length(activejukeboxes))
		for(var/list/jukeinfo in activejukeboxes)
			if(jukebox in jukeinfo)
				return jukeinfo[2]
	return FALSE

/datum/controller/subsystem/jukeboxes/Initialize()
	var/list/tracks = flist("[global.config.directory]/jukebox_music/sounds/")
	for(var/song in tracks)
		var/datum/track/track = new()
		track.song_path = file("[global.config.directory]/jukebox_music/sounds/[song]")
		var/list/song_data = splittext(song,"+")
		if(song_data.len != 4)
			continue
		track.song_name = song_data[1]
		track.song_length = text2num(song_data[2])
		track.song_beat = text2num(song_data[3])
		track.song_associated_id = song_data[4]
		songs |= track
	for(var/i in CHANNEL_JUKEBOX_START to CHANNEL_JUKEBOX)
		freejukeboxchannels |= i
	return SS_INIT_SUCCESS

/datum/controller/subsystem/jukeboxes/fire()
	if(!length(activejukeboxes))
		return
	for(var/list/jukeinfo in activejukeboxes)
		if(!length(jukeinfo))
			stack_trace("Active jukebox without any associated metadata.")
			continue
		var/datum/track/juketrack = jukeinfo[1]
		if(!istype(juketrack))
			stack_trace("Invalid jukebox track datum.")
			continue
		var/obj/machinery/jukebox/jukebox = jukeinfo[3]
		if(!istype(jukebox))
			stack_trace("Nonexistant or invalid object associated with jukebox.")
			continue
		var/sound/song_played = sound(juketrack.song_path)

		song_played.falloff = jukeinfo[4]

		// Goes through existing mobs in rangers to determine if they should not be played to
		for(var/datum/weakref/weak_to_hide_from as anything in jukebox.rangers)
			var/mob/to_hide_from = weak_to_hide_from?.resolve()
			if(!HAS_JUKEBOX_PREF(to_hide_from) || get_dist(jukebox, get_turf(to_hide_from)) > 10)
				jukebox.rangers -= weak_to_hide_from
				to_hide_from?.stop_sound_channel(jukeinfo[2])

		// Collect mobs to play the song to, stores weakrefs of them in rangers
		for(var/mob/to_play_to in range(world.view, jukebox))
			if(!HAS_JUKEBOX_PREF(to_play_to))
				continue
			var/datum/weakref/weak_playing_to = WEAKREF(to_play_to)
			if(jukebox.rangers[weak_playing_to])
				continue
			jukebox.rangers[weak_playing_to] = TRUE
			// This plays the sound directly underneath the mob because otherwise it'd get stuck in their left ear or whatever
			// Would be neat if it sourced from the box itself though
			to_play_to.playsound_local(get_turf(to_play_to), null, jukebox.volume, channel = jukeinfo[2], sound_to_use = song_played, use_reverb = FALSE)

			CHECK_TICK
	return

#undef HAS_JUKEBOX_PREF
