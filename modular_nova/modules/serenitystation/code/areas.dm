/area/forestplanet
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	ambience_index = AMBIENCE_ICEMOON //TODO fix ambience???
	sound_environment = SOUND_AREA_ICEMOON //TODO fix sound????
	ambient_buzz = 'sound/ambience/magma.ogg'
	name = "Forest Planet"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/forestplanet/outdoors // parent that defines if something is on the exterior of the station.
	name = "Woodlands"
	outdoors = TRUE

/area/forestplanet/outdoors/nospawn // this is the area you use for stuff to not spawn, but if you still want weather.

/area/forestplanet/outdoors/nospawn/New() // unless you roll forested trait lol
	. = ..()

/*/area/forestplanet/outdoors/noruins // when you want random generation without the chance of getting ruins
	icon_state = "noruins"
	area_flags = UNIQUE_AREA | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | CAVES_ALLOWED
	map_generator =  /datum/map_generator/cave_generator/icemoon/surface/noruins //TODO - fix map gen
	*/

/area/forestplanet/outdoors/unexplored //monsters and ruins spawn here
	icon_state = "unexplored"
	area_flags = UNIQUE_AREA | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | CAVES_ALLOWED
	map_generator = /datum/map_generator/cave_generator/forest

