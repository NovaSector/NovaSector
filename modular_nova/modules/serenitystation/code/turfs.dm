
/turf/open/misc/asteroid/forest
	gender = PLURAL
	name = "grass"
	desc = "A patch of grass."
	icon = 'icons/turf/floors.dmi'
	icon_state = "grass"
	base_icon_state = "grass"
	baseturfs = /turf/open/misc/sandy_dirt/forest //TODO change to this specific one
	bullet_bounce_sound = null
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_FLOOR_GRASS
	canSmoothWith = SMOOTH_GROUP_FLOOR_GRASS + SMOOTH_GROUP_CLOSED_TURFS
	layer = HIGH_TURF_LAYER
	damaged_dmi = 'icons/turf/damaged.dmi'
	var/smooth_icon = 'icons/turf/floors/grass.dmi'
	initial_gas_mix = FOREST_DEFAULT_ATMOS
	flags_1 = NONE
	planetary_atmos = TRUE
	dig_result = /obj/item/food/grown/grass

/turf/open/misc/asteroid/forest/broken_states()
	return list("grass_damaged")

/turf/open/misc/asteroid/forest/burnt_states()
	return list("grass_damaged")

/turf/open/misc/asteroid/forest/Initialize(mapload)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-9, -9)
		transform = translation
		icon = smooth_icon

	if(is_station_level(z))
		GLOB.station_turfs += src

/turf/open/openspace/forest
	name = "open forest air"
	baseturfs = /turf/open/openspace/forest
	initial_gas_mix = FOREST_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/sandy_dirt/forest
	initial_gas_mix = FOREST_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/closed/mineral/random/forest
	name = "forest mountainside"
	icon = MAP_SWITCH('icons/turf/walls/mountain_wall.dmi', 'icons/turf/mining.dmi')
	icon_state = "mountainrock"
	base_icon_state = "mountain_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = SMOOTH_GROUP_CLOSED_TURFS
	defer_change = TRUE
	turf_type = /turf/open/misc/sandy_dirt/forest
	baseturfs = /turf/open/misc/sandy_dirt/forest
	initial_gas_mix = FOREST_DEFAULT_ATMOS
	weak_turf = TRUE

/turf/closed/mineral/random/forest/Change_Ore(ore_type, random = 0)
	. = ..()
	if(mineralType)
		icon = 'icons/turf/walls/icerock_wall.dmi' //TODO change icon
		icon_state = "icerock_wall-0"
		base_icon_state = "icerock_wall"
		smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER

/turf/closed/mineral/random/forest/mineral_chances()
	return list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/silver = 12,
		/obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/uranium = 5,
	)

/turf/open/floor/engine/hull/reinforced/planetary
	desc = "Sturdy exterior hull plating that separates you from the outside world"
	initial_gas_mix = FOREST_DEFAULT_ATMOS

/turf/open/floor/engine/hull/planetary
	desc = "Sturdy exterior hull plating that separates you from the outside world."
	initial_gas_mix = FOREST_DEFAULT_ATMOS

/turf/open/lava/plasma/forest
	initial_gas_mix = FOREST_DEFAULT_ATMOS
	baseturfs = /turf/open/lava/plasma/forest
	planetary_atmos = TRUE

///here for reference

/*
/turf/open/misc/grass
	name = "grass"
	desc = "A patch of grass."
	icon = 'icons/turf/floors.dmi'
	icon_state = "grass"
	base_icon_state = "grass"
	baseturfs = /turf/open/misc/sandy_dirt
	bullet_bounce_sound = null
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_FLOOR_GRASS
	canSmoothWith = SMOOTH_GROUP_FLOOR_GRASS + SMOOTH_GROUP_CLOSED_TURFS
	layer = HIGH_TURF_LAYER
	damaged_dmi = 'icons/turf/damaged.dmi'
	var/smooth_icon = 'icons/turf/floors/grass.dmi'

/turf/open/misc/grass/broken_states()
	return list("grass_damaged")

/turf/open/misc/grass/burnt_states()
	return list("grass_damaged")

/turf/open/misc/grass/Initialize(mapload)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-9, -9)
		transform = translation
		icon = smooth_icon

	if(is_station_level(z))
		GLOB.station_turfs += src

/turf/open/misc/grass/lavaland
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/open/misc/asteroid/snow
	gender = PLURAL
	name = "snow"
	desc = "Looks cold."
	icon = 'icons/turf/snow.dmi'
	damaged_dmi = 'icons/turf/snow.dmi'
	baseturfs = /turf/open/misc/asteroid/snow
	icon_state = "snow"
	base_icon_state = "snow"
	initial_gas_mix = FROZEN_ATMOS
	slowdown = 2
	flags_1 = NONE
	planetary_atmos = TRUE
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	dig_result = /obj/item/stack/sheet/mineral/snow

/turf/open/misc/asteroid/snow/burn_tile()
	if(!burnt)
		visible_message(span_danger("[src] melts away!."))
		slowdown = 0
		burnt = TRUE
		update_appearance()
		return TRUE
	return FALSE

/turf/open/misc/grass/burnt_states()
	return list("snow_dug")

/turf/open/misc/asteroid/snow/icemoon
	baseturfs = /turf/open/openspace/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	slowdown = 0
*/
