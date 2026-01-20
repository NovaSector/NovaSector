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
	area_flags_mapping = parent_type::area_flags_mapping|FLORA_ALLOWED|CAVES_ALLOWED

/area/ocean/generated/friendly_mobs
	map_generator = /datum/map_generator/cave_generator/lagoon/friendly_mobs
	area_flags_mapping = parent_type::area_flags_mapping|MOB_SPAWN_ALLOWED

/area/ocean/generated/hostile_mobs
	map_generator = /datum/map_generator/cave_generator/lagoon/hostile_mobs
	area_flags_mapping = parent_type::area_flags_mapping|MOB_SPAWN_ALLOWED

/area/ocean/generated/friendly_mobs/wilderness
	map_generator = /datum/map_generator/cave_generator/lagoon/friendly_mobs/wilderness

/area/ocean/generated/hostile_mobs/wilderness
	map_generator = /datum/map_generator/cave_generator/lagoon/hostile_mobs/wilderness

/area/ocean/monestary
	name = "\improper Monastery Isle"

/area/ruin/ocean
	default_gravity = STANDARD_GRAVITY
	area_flags = NONE
