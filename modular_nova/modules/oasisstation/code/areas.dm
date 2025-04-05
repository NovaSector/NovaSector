/area/sandplanet
	name = "Oasis"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "explored"
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA
	ambience_index = AMBIENCE_OASIS
	sound_environment = SOUND_AREA_FOREST
	ambient_buzz = 'sound/ambience/lavaland/magma.ogg'
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS
	static_lighting = FALSE
	base_lighting_alpha = 150

/area/sandplanet/outdoors // parent that defines if something is on the exterior of the station.
	name = "Dunes"
	outdoors = TRUE

/area/sandplanet/outdoors/nospawn

/area/sandplanet/security/yard
	name = "Public Stage"

/area/sandplanet/companystage
	name = "Public Stage"

/area/sandplanet/pond
	name = "Central Pond"

/area/sandplanet/pond/south
	name = "South Pond"

/area/sandplanet/pond/north
	name = "North Pond"

/area/sandplanet/pond/west
	name = "West Pond"

/area/sandplanet/path

/area/sandplanet/path/north
	name = "North Path"

/area/sandplanet/path/east
	name = "East Path"

/area/sandplanet/path/west
	name = "West Path"

/area/sandplanet/path/south
	name = "South Path"

/*
/area/sandplanet/outdoors/unexplored
	icon_state = "unexplored"
	area_flags = UNIQUE_AREA | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | CAVES_ALLOWED
	map_generator = /datum/map_generator/cave_generator/forest

/area/sandplanet/outdoors/unexplored/deep
	name = "Mushroom Caves"
	map_generator = /datum/map_generator/cave_generator/forest/mushroom
	ambience_index = AMBIENCE_MUSHROOM
	sound_environment = SOUND_AREA_MUSHROOM_CAVES
	/// The theme song to play every once in a while.
	var/theme_song = 'modular_nova/master_files/sound/ambience/mushroom/mushroom_theme.ogg'
	/// The additional cooldown to add if the theme song is being played.
	var/theme_song_additional_cooldown = 115 SECONDS // The song is 183 seconds long, and minimum cooldown in this area is 70 seconds.


/area/sandplanet/outdoors/unexplored/deep/play_ambience(mob/listener, sound/override_sound, volume)
	var/play_theme = prob(1/6 * 100) // We handle the theme song separately because it's pretty long, and we don't want it to be cut up by another ambience track.

	if(!play_theme)
		return ..()

	// Time to play the theme song!
	override_sound = theme_song
	min_ambience_cooldown += theme_song_additional_cooldown
	max_ambience_cooldown += theme_song_additional_cooldown

	. = ..()

	min_ambience_cooldown = initial(min_ambience_cooldown)
	max_ambience_cooldown = initial(max_ambience_cooldown)

*/
