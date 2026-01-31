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
	sound_environment = SOUND_AREA_STANDARD_STATION
	flags_1 = NONE
	default_gravity = STANDARD_GRAVITY

/area/ocean/generated
	icon_state = "cordon"
	map_generator = /datum/map_generator/cave_generator/ocean
	area_flags_mapping = parent_type::area_flags_mapping|FLORA_ALLOWED|CAVES_ALLOWED

/area/ocean/generated/deep
	map_generator = /datum/map_generator/cave_generator/ocean/deep

/area/ocean/generated/shallow
	map_generator = /datum/map_generator/cave_generator/ocean/shallow

/area/ocean/generated/rocky
	map_generator = /datum/map_generator/cave_generator/ocean/rocky

/area/ocean/generated/friendly_mobs
	map_generator = /datum/map_generator/cave_generator/ocean/shallow/lagoon/friendly_mobs
	area_flags_mapping = parent_type::area_flags_mapping|MOB_SPAWN_ALLOWED

/area/ocean/generated/hostile_mobs
	map_generator = /datum/map_generator/cave_generator/ocean/shallow/lagoon/hostile_mobs
	area_flags_mapping = parent_type::area_flags_mapping|MOB_SPAWN_ALLOWED

/area/ocean/generated/friendly_mobs/wilderness
	map_generator = /datum/map_generator/cave_generator/ocean/shallow/lagoon/friendly_mobs/wilderness

/area/ocean/generated/hostile_mobs/wilderness
	map_generator = /datum/map_generator/cave_generator/ocean/shallow/lagoon/hostile_mobs/wilderness

/area/ocean/monestary
	name = "\improper Monastery Isle"

/area/station/solars/ocean
	icon_state = "panels"
	requires_power = FALSE
	flags_1 = NONE
	static_lighting = FALSE
	base_lighting_alpha = 255
	outdoors = TRUE
	ambience_index = AMBIENCE_ENGI
	airlock_wires = /datum/wires/airlock/engineering
	sound_environment = SOUND_AREA_STANDARD_STATION
	default_gravity = STANDARD_GRAVITY

/area/station/solars/ocean/aisat
	name = "\improper AI Satellite Solars"
	icon_state = "panelsAI"

/area/station/solars/ocean/starboard
	name = "\improper Starboard Solar Array"
	icon_state = "panelsS"

/area/station/solars/ocean/port
	name = "\improper Port Solar Array"
	icon_state = "panelsP"
