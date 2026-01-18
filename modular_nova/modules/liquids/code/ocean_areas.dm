/area/ocean
	name = "Ocean"
	icon_state = "space"
	icon = 'icons/area/areas_misc.dmi'
	requires_power = TRUE
	always_unpowered = TRUE
	static_lighting = FALSE
	base_lighting_alpha = 255
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	outdoors = TRUE
	ambience_index = AMBIENCE_SPACE
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_AREA_SPACE

/area/ocean/generated
	icon_state = "cordon"
	map_generator = /datum/map_generator/cave_generator/ocean

/area/ocean/generated/wilderness
	map_generator = /datum/map_generator/cave_generator/ocean/wilderness

/area/ocean/generated/no_ruins
	icon_state = "unknown"
	map_generator = /datum/map_generator/cave_generator/ocean/noruins

/area/ocean/monestary
	name = "\improper Monastery Beach"

/area/ruin/ocean
	default_gravity = STANDARD_GRAVITY
	area_flags = NONE
