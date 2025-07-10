/area/awaymission/beach/heretic
	name = "heretic beach"
	icon_state = "away2"
	requires_power = FALSE
	static_lighting = TRUE
	area_flags = NOTELEPORT
	default_gravity = 1

/area/awaymission/caves/heretic_laboratory
	name = "heretic lab"
	requires_power = FALSE
	static_lighting = TRUE
	area_flags = NOTELEPORT
	default_gravity = 1

	///A list of rare sound effects to fuck with players. No, it does not contain actual minecraft sounds anymore.
	var/static/list/minecraft_cave_noises = list(
		'sound/machines/airlock/airlock.ogg',
		'sound/effects/snap.ogg',
		'sound/effects/footstep/clownstep1.ogg',
		'sound/effects/footstep/clownstep2.ogg',
		'sound/items/tools/welder.ogg',
		'sound/items/tools/welder2.ogg',
		'sound/items/tools/crowbar.ogg',
		'sound/items/deconstruct.ogg',
		'sound/ambience/misc/source_holehit3.ogg',
		'sound/ambience/misc/cavesound3.ogg',
	)

/area/station/maintenance/play_ambience(mob/M, sound/override_sound, volume)
	if(!M.has_light_nearby() && prob(0.5))
		return ..(M, pick(minecraft_cave_noises))
	return ..()

/**
 * Ambience buzz handling called by either area/Enter() or refresh_looping_ambience()
 */

/mob/proc/update_ambience_area(area/new_area)

	var/old_tracked_area = ambience_tracked_area
	if(old_tracked_area)
		UnregisterSignal(old_tracked_area, COMSIG_AREA_POWER_CHANGE)
		ambience_tracked_area = null
	if(!client)
		return
	if(new_area)
		ambience_tracked_area = new_area
		RegisterSignal(ambience_tracked_area, COMSIG_AREA_POWER_CHANGE, PROC_REF(refresh_looping_ambience), TRUE)

	refresh_looping_ambience()

/mob/proc/refresh_looping_ambience()
	SIGNAL_HANDLER

	if(!client || isobserver(client.mob)) // If a tree falls in the woods. sadboysuss: Don't refresh for ghosts, it sounds bad
		return

	var/area/my_area = get_area(src)
	var/sound_to_use = my_area.ambient_buzz
	var/volume_modifier = client.prefs.read_preference(/datum/preference/numeric/volume/sound_ship_ambience_volume)

	if(!sound_to_use || !(client.prefs.read_preference(/datum/preference/numeric/volume/sound_ship_ambience_volume)))
		SEND_SOUND(src, sound(null, repeat = 0, wait = 0, channel = CHANNEL_BUZZ))
		client.current_ambient_sound = null
		return

	if(!can_hear()) // Can the mob hear?
		SEND_SOUND(src, sound(null, repeat = 0, wait = 0, channel = CHANNEL_BUZZ))
		client.current_ambient_sound = null
		return

	//Station ambience is dependent on a functioning and charged APC with environment power enabled.
	if(!is_mining_level(my_area.z) && ((!my_area.apc || !my_area.apc.operating || !my_area.apc.cell?.charge && my_area.requires_power || !my_area.power_environ)))
		SEND_SOUND(src, sound(null, repeat = 0, wait = 0, channel = CHANNEL_BUZZ))
		client.current_ambient_sound = null
		return
	else
		if(sound_to_use == client.current_ambient_sound) // Don't reset current loops
			return

		client.current_ambient_sound = sound_to_use
		SEND_SOUND(src, sound(my_area.ambient_buzz, repeat = 1, wait = 0, volume = my_area.ambient_buzz_vol * (volume_modifier / 100), channel = CHANNEL_BUZZ))

/area/awaymission/caves/heretic_laboratory_clean
	name = "heretic lab clean"
	icon_state = "away2"
	requires_power = FALSE
	static_lighting = TRUE
	area_flags = NOTELEPORT
	default_gravity = 1
