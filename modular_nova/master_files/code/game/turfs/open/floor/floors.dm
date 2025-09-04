/// Add atmos tiles here for planetside safety

/turf/open/misc/beach/sand/safe_planet
	/// Initial gas mix should always be the specific planet's atmos ID
	initial_gas_mix = SAFE_PLANET_ATMOS
	/// Planetary atmos specifically makes it so incorrect gasses are deleted overtime, such as plasma, carbon, etc. This prevents planets from suddenly having too much plasma from a turbine or SM waste.
	planetary_atmos = TRUE

/turf/open/misc/beach/coast/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/beach/coast/corner/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/grass/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/wood/large/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/wood/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/iron/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/stone/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE

/turf/open/openspace/safe_planet
	initial_gas_mix = SAFE_PLANET_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/openspace/safe_planet

/turf/open/floor/iron/brick
	icon_state = "brick"
	base_icon_state = "brick"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick

/obj/item/stack/tile/iron/brick
	name = "brick floor tile"
	singular_name = "brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick"
	turf_type = /turf/open/floor/iron/brick
	merge_type = /obj/item/stack/tile/iron/brick
	tile_rotate_dirs = list(SOUTH, NORTH)

/turf/open/floor/iron/brick_half
	icon_state = "brick_half"
	base_icon_state = "brick_half"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_half

/obj/item/stack/tile/iron/brick_half
	name = "half brick floor tile"
	singular_name = "brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_half"
	turf_type = /turf/open/floor/iron/brick_half
	merge_type = /obj/item/stack/tile/iron/brick_half
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_half_vertical
	icon_state = "brick_half_vertical"
	base_icon_state = "brick_half_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_half_vertical

/obj/item/stack/tile/iron/brick_half_vertical
	name = "half brick vertical floor tile"
	singular_name = "brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_half_vertical"
	turf_type = /turf/open/floor/iron/brick_half_vertical
	merge_type = /obj/item/stack/tile/iron/brick_half_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_corner
	icon_state = "brick_corner"
	base_icon_state = "brick_corner"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_corner

/obj/item/stack/tile/iron/brick_corner
	name = "brick floor corner tile"
	singular_name = "brick floor corner tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_corner"
	turf_type = /turf/open/floor/iron/brick_corner
	merge_type = /obj/item/stack/tile/iron/brick_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_corner_inverse
	icon_state = "brick_corner_inverse"
	base_icon_state = "brick_corner_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_corner_inverse

/obj/item/stack/tile/iron/brick_corner_inverse
	name = "brick floor inverse corner tile"
	singular_name = "brick floor inverse corner tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_corner_inverse"
	turf_type = /turf/open/floor/iron/brick_corner_inverse
	merge_type = /obj/item/stack/tile/iron/brick_corner_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_corner_vertical
	icon_state = "brick_corner_vertical"
	base_icon_state = "brick_corner_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_corner_vertical

/obj/item/stack/tile/iron/brick_corner_vertical
	name = "brick floor vertical corner tile"
	singular_name = "brick floor vertical corner tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_corner_vertical"
	turf_type = /turf/open/floor/iron/brick_corner_vertical
	merge_type = /obj/item/stack/tile/iron/brick_corner_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_corner_vertical_inverse
	icon_state = "brick_corner_vertical_inverse"
	base_icon_state = "brick_corner_vertical_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_corner_vertical_inverse

/obj/item/stack/tile/iron/brick_corner_vertical_inverse
	name = "brick floor vertical inverse corner tile"
	singular_name = "brick floor vertical inverse corner tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_corner_vertical_inverse"
	turf_type = /turf/open/floor/iron/brick_corner_vertical_inverse
	merge_type = /obj/item/stack/tile/iron/brick_corner_vertical_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_aligned
	icon_state = "brick_aligned"
	base_icon_state = "brick_aligned"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_aligned

/obj/item/stack/tile/iron/brick_aligned
	name = "aligned brick floor tile"
	singular_name = "aligned brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_aligned"
	turf_type = /turf/open/floor/iron/brick_aligned
	merge_type = /obj/item/stack/tile/iron/brick_aligned
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_aligned_half
	icon_state = "brick_aligned_half"
	base_icon_state = "brick_aligned_half"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_aligned_half

/obj/item/stack/tile/iron/brick_aligned_half
	name = "half aligned brick floor tile"
	singular_name = "half aligned brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_aligned_half"
	turf_type = /turf/open/floor/iron/brick_aligned_half
	merge_type = /obj/item/stack/tile/iron/brick_aligned_half
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_aligned_half_vertical
	icon_state = "brick_aligned_half_vertical"
	base_icon_state = "brick_aligned_half_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_aligned_half_vertical

/obj/item/stack/tile/iron/brick_aligned_half_vertical
	name = "half aligned brick floor vertical tile"
	singular_name = "half aligned brick floor vertical tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_aligned_half_vertical"
	turf_type = /turf/open/floor/iron/brick_aligned_half_vertical
	merge_type = /obj/item/stack/tile/iron/brick_aligned_half_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_aligned_corner
	icon_state = "brick_aligned_corner"
	base_icon_state = "brick_aligned_corner"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_aligned_corner

/obj/item/stack/tile/iron/brick_aligned_corner
	name = "aligned brick corner"
	singular_name = "aligned brick corner"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_aligned_corner"
	turf_type = /turf/open/floor/iron/brick_aligned_corner
	merge_type = /obj/item/stack/tile/iron/brick_aligned_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_aligned_corner_inverse
	icon_state = "brick_aligned_corner_inverse"
	base_icon_state = "brick_aligned_corner_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_aligned_corner_inverse

/obj/item/stack/tile/iron/brick_aligned_corner_inverse
	name = "aligned brick inverse corner inverse"
	singular_name = "aligned brick inverse corner inverse"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_aligned_corner_inverse"
	turf_type = /turf/open/floor/iron/brick_aligned_corner_inverse
	merge_type = /obj/item/stack/tile/iron/brick_aligned_corner_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_aligned_corner_vertical
	icon_state = "brick_aligned_corner_vertical"
	base_icon_state = "brick_aligned_corner_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_aligned_corner_vertical

/obj/item/stack/tile/iron/brick_aligned_corner_vertical
	name = "aligned vertical brick corner"
	singular_name = "aligned vertical brick corner"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_aligned_corner_vertical"
	turf_type = /turf/open/floor/iron/brick_aligned_corner_vertical
	merge_type = /obj/item/stack/tile/iron/brick_aligned_corner_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_aligned_corner_vertical_inverse
	icon_state = "brick_aligned_corner_vertical_inverse"
	base_icon_state = "brick_aligned_corner_vertical_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/brick_aligned_corner_vertical_inverse

/obj/item/stack/tile/iron/brick_aligned_corner_vertical_inverse
	name = "aligned vertical brick inverse corner"
	singular_name = "aligned vertical brick inverse corner"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "brick_aligned_corner_vertical_inverse"
	turf_type = /turf/open/floor/iron/brick_aligned_corner_vertical_inverse
	merge_type = /obj/item/stack/tile/iron/brick_aligned_corner_vertical_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)


/*
* DARK TILES
*/

/turf/open/floor/iron/dark/brick
	icon_state = "dark_brick"
	base_icon_state = "dark_brick"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick

/obj/item/stack/tile/iron/dark/brick
	name = "dark brick floor tile"
	singular_name = "dark brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick"
	turf_type = /turf/open/floor/iron/dark/brick
	merge_type = /obj/item/stack/tile/iron/dark/brick
	tile_rotate_dirs = list(SOUTH, NORTH)

/turf/open/floor/iron/dark/brick_half
	icon_state = "dark_brick_half"
	base_icon_state = "dark_brick_half"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_half

/obj/item/stack/tile/iron/dark/brick_half
	name = "dark half brick floor tile"
	singular_name = "dark half brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_half"
	turf_type = /turf/open/floor/iron/dark/brick_half
	merge_type = /obj/item/stack/tile/iron/dark/brick_half
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_half_vertical
	icon_state = "dark_brick_half_vertical"
	base_icon_state = "dark_brick_half_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_half_vertical

/obj/item/stack/tile/iron/dark/brick_half_vertical
	name = "dark half brick vertical floor tile"
	singular_name = "dark brick vertical floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_half_vertical"
	turf_type = /turf/open/floor/iron/dark/brick_half_vertical
	merge_type = /obj/item/stack/tile/iron/dark/brick_half_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_corner
	icon_state = "dark_brick_corner"
	base_icon_state = "dark_brick_corner"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_corner

/obj/item/stack/tile/iron/dark/brick_corner
	name = "dark brick corner floor tile"
	singular_name = "dark brick corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_corner"
	turf_type = /turf/open/floor/iron/dark/brick_corner
	merge_type = /obj/item/stack/tile/iron/dark/brick_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_corner_inverse
	icon_state = "dark_brick_corner_inverse"
	base_icon_state = "dark_brick_corner_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_corner_inverse

/obj/item/stack/tile/iron/dark/brick_corner_inverse
	name = "dark brick inverse corner floor tile"
	singular_name = "dark brick inverse corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_corner_inverse"
	turf_type = /turf/open/floor/iron/dark/brick_corner_inverse
	merge_type = /obj/item/stack/tile/iron/dark/brick_corner_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_corner_vertical
	icon_state = "dark_brick_corner_vertical"
	base_icon_state = "dark_brick_corner_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_corner_vertical

/obj/item/stack/tile/iron/dark/brick_corner_vertical
	name = "dark brick vertical corner floor tile"
	singular_name = "dark brick vertical corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_corner_vertical"
	turf_type = /turf/open/floor/iron/dark/brick_corner_vertical
	merge_type = /obj/item/stack/tile/iron/dark/brick_corner_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_corner_vertical_inverse
	icon_state = "dark_brick_corner_vertical_inverse"
	base_icon_state = "dark_brick_corner_vertical_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_corner_vertical_inverse

/obj/item/stack/tile/iron/dark/brick_corner_vertical_inverse
	name = "dark brick vertical corner invserse floor tile"
	singular_name = "dark brick vertical corner invserse floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_corner_vertical_inverse"
	turf_type = /turf/open/floor/iron/dark/brick_corner_vertical_inverse
	merge_type = /obj/item/stack/tile/iron/dark/brick_corner_vertical_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_aligned
	icon_state = "dark_brick_aligned"
	base_icon_state = "dark_brick_aligned"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_aligned

/obj/item/stack/tile/iron/dark/brick_aligned
	name = "dark aligned brick floor tile"
	singular_name = "dark aligned floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_aligned"
	turf_type = /turf/open/floor/iron/dark/brick_aligned
	merge_type = /obj/item/stack/tile/iron/dark/brick_aligned
	tile_rotate_dirs = list(SOUTH, NORTH)

/turf/open/floor/iron/dark/brick_aligned_half
	icon_state = "dark_brick_aligned_half"
	base_icon_state = "dark_brick_aligned_half"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_aligned_half

/obj/item/stack/tile/iron/dark/brick_aligned_half
	name = "dark aligned half brick floor tile"
	singular_name = "dark aligned half brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_aligned_half"
	turf_type = /turf/open/floor/iron/dark/brick_aligned_half
	merge_type = /obj/item/stack/tile/iron/dark/brick_aligned_half
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_aligned_half_vertical
	icon_state = "dark_brick_aligned_half_vertical"
	base_icon_state = "dark_brick_aligned_half_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_aligned_half_vertical

/obj/item/stack/tile/iron/dark/brick_aligned_half_vertical
	name = "dark aligned half brick vertical floor tile"
	singular_name = "dark aligned half brick vertical floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_aligned_half_vertical"
	turf_type = /turf/open/floor/iron/dark/brick_aligned_half_vertical
	merge_type = /obj/item/stack/tile/iron/dark/brick_aligned_half_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_aligned_corner_vertical
	icon_state = "dark_brick_aligned_corner_vertical"
	base_icon_state = "dark_brick_aligned_corner_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_aligned_corner_vertical

/obj/item/stack/tile/iron/dark/brick_aligned_corner_vertical
	name = "dark aligned vertical corner floor tile"
	singular_name = "dark aligned vertical corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_aligned_corner_vertical"
	turf_type = /turf/open/floor/iron/dark/brick_aligned_corner_vertical
	merge_type = /obj/item/stack/tile/iron/dark/brick_aligned_corner_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_aligned_corner_vertical_inverse
	icon_state = "dark_brick_aligned_corner_vertical_inverse"
	base_icon_state = "dark_brick_aligned_corner_vertical_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_aligned_corner_vertical_inverse

/obj/item/stack/tile/iron/dark/brick_aligned_corner_vertical_inverse
	name = "dark aligned vertical inverse corner floor tile"
	singular_name = "dark aligned vertical inverse corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_aligned_corner_vertical_inverse"
	turf_type = /turf/open/floor/iron/dark/brick_aligned_corner_vertical_inverse
	merge_type = /obj/item/stack/tile/iron/dark/brick_aligned_corner_vertical_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_aligned_corner
	icon_state = "dark_brick_aligned_corner"
	base_icon_state = "dark_brick_aligned_corner"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_aligned_corner

/obj/item/stack/tile/iron/dark/brick_aligned_corner
	name = "dark aligned corner floor tile"
	singular_name = "dark aligned corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_aligned_corner"
	turf_type = /turf/open/floor/iron/dark/brick_aligned_corner
	merge_type = /obj/item/stack/tile/iron/dark/brick_aligned_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/dark/brick_aligned_corner_inverse
	icon_state = "dark_brick_aligned_corner_inverse"
	base_icon_state = "dark_brick_aligned_corner_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/dark/brick_aligned_corner_inverse

/obj/item/stack/tile/iron/dark/brick_aligned_corner_inverse
	name = "dark aligned inverse corner floor tile"
	singular_name = "dark aligned inverse corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "dark_brick_aligned_corner_inverse"
	turf_type = /turf/open/floor/iron/dark/brick_aligned_corner_inverse
	merge_type = /obj/item/stack/tile/iron/dark/brick_aligned_corner_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/*
* WHITE TILES
*/
/turf/open/floor/iron/white/brick
	icon_state = "white_brick"
	base_icon_state = "white_brick"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick

/obj/item/stack/tile/iron/white/brick
	name = "white brick floor tile"
	singular_name = "white brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick"
	turf_type = /turf/open/floor/iron/white/brick
	merge_type = /obj/item/stack/tile/iron/white/brick
	tile_rotate_dirs = list(SOUTH, NORTH)

/turf/open/floor/iron/white/brick_half
	icon_state = "white_brick_half"
	base_icon_state = "white_brick_half"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_half

/obj/item/stack/tile/iron/white/brick_half
	name = "white half brick floor tile"
	singular_name = "white half brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_half"
	turf_type = /turf/open/floor/iron/white/brick_half
	merge_type = /obj/item/stack/tile/iron/white/brick_half
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_half_vertical
	icon_state = "white_brick_half_vertical"
	base_icon_state = "white_brick_half_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_half_vertical

/obj/item/stack/tile/iron/white/brick_half_vertical
	name = "white half brick vertical floor tile"
	singular_name = "white half brick vertical floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_half_vertical"
	turf_type = /turf/open/floor/iron/white/brick_half_vertical
	merge_type = /obj/item/stack/tile/iron/white/brick_half_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_corner
	icon_state = "white_brick_corner"
	base_icon_state = "white_brick_corner"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_corner

/obj/item/stack/tile/iron/white/brick_corner
	name = "white brick corner floor tile"
	singular_name = "white brick corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_corner"
	turf_type = /turf/open/floor/iron/white/brick_corner
	merge_type = /obj/item/stack/tile/iron/white/brick_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_corner_inverse
	icon_state = "white_brick_corner_inverse"
	base_icon_state = "white_brick_corner_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_corner_inverse

/obj/item/stack/tile/iron/white/brick_corner_inverse
	name = "white brick inverse corner floor tile"
	singular_name = "white brick inverse corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_corner_inverse"
	turf_type = /turf/open/floor/iron/white/brick_corner_inverse
	merge_type = /obj/item/stack/tile/iron/white/brick_corner_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_corner_vertical
	icon_state = "white_brick_corner_vertical"
	base_icon_state = "white_brick_corner_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_corner_vertical

/obj/item/stack/tile/iron/white/brick_corner_vertical
	name = "white vertical brick corner floor tile"
	singular_name = "white vertical brick corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_corner_vertical"
	turf_type = /turf/open/floor/iron/white/brick_corner_vertical
	merge_type = /obj/item/stack/tile/iron/white/brick_corner_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_corner_vertical_inverse
	icon_state = "white_brick_corner_vertical_inverse"
	base_icon_state = "white_brick_corner_vertical_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_corner_vertical_inverse

/obj/item/stack/tile/iron/white/brick_corner_vertical_inverse
	name = "white brick corner inverse floor tile"
	singular_name = "white brick corner inverse floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_corner_vertical_inverse"
	turf_type = /turf/open/floor/iron/white/brick_corner_vertical_inverse
	merge_type = /obj/item/stack/tile/iron/white/brick_corner_vertical_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_aligned
	icon_state = "white_brick_aligned"
	base_icon_state = "white_brick_aligned"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_aligned

/obj/item/stack/tile/iron/white/brick_aligned
	name = "white aligned brick floor tile"
	singular_name = "white aligned brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_aligned"
	turf_type = /turf/open/floor/iron/white/brick_aligned
	merge_type = /obj/item/stack/tile/iron/white/brick_aligned
	tile_rotate_dirs = list(SOUTH, NORTH)

/turf/open/floor/iron/white/brick_aligned_half
	icon_state = "white_brick_aligned_half"
	base_icon_state = "white_brick_aligned_half"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_aligned_half

/obj/item/stack/tile/iron/white/brick_aligned_half
	name = "white aligned half brick floor tile"
	singular_name = "white aligned half brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_aligned_half"
	turf_type = /turf/open/floor/iron/white/brick_aligned_half
	merge_type = /obj/item/stack/tile/iron/white/brick_aligned_half
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_aligned_half_vertical
	icon_state = "white_brick_aligned_half_vertical"
	base_icon_state = "white_brick_aligned_half_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_aligned_half_vertical

/obj/item/stack/tile/iron/white/brick_aligned_half_vertical
	name = "white aligned half vertical brick floor tile"
	singular_name = "white aligned half vertical brick floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_aligned_half_vertical"
	turf_type = /turf/open/floor/iron/white/brick_aligned_half_vertical
	merge_type = /obj/item/stack/tile/iron/white/brick_aligned_half_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_aligned_corner_vertical
	icon_state = "white_brick_aligned_corner_vertical"
	base_icon_state = "white_brick_aligned_corner_vertical"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_aligned_corner_vertical

/obj/item/stack/tile/iron/white/brick_aligned_corner_vertical
	name = "white aligned vertical brick corner floor tile"
	singular_name = "white aligned vertical brick corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_aligned_corner_vertical"
	turf_type = /turf/open/floor/iron/white/brick_aligned_corner_vertical
	merge_type = /obj/item/stack/tile/iron/white/brick_aligned_corner_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_aligned_corner_vertical_inverse
	icon_state = "white_brick_aligned_corner_vertical_inverse"
	base_icon_state = "white_brick_aligned_corner_vertical_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_aligned_corner_vertical_inverse

/obj/item/stack/tile/iron/white/brick_aligned_corner_vertical_inverse
	name = "white aligned vertical brick inverse corner floor tile"
	singular_name = "white aligned vertical brick inverse corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_aligned_corner_vertical_inverse"
	turf_type = /turf/open/floor/iron/white/brick_aligned_corner_vertical_inverse
	merge_type = /obj/item/stack/tile/iron/white/brick_aligned_corner_vertical_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_aligned_corner
	icon_state = "white_brick_aligned_corner"
	base_icon_state = "white_brick_aligned_corner"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_aligned_corner

/obj/item/stack/tile/iron/white/brick_aligned_corner
	name = "white aligned brick corner floor tile"
	singular_name = "white aligned brick corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_aligned_corner"
	turf_type = /turf/open/floor/iron/white/brick_aligned_corner
	merge_type = /obj/item/stack/tile/iron/white/brick_aligned_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/white/brick_aligned_corner_inverse
	icon_state = "white_brick_aligned_corner_inverse"
	base_icon_state = "white_brick_aligned_corner_inverse"
	icon = 'modular_nova/master_files/icons/turf/floors/floor.dmi'
	floor_tile = /obj/item/stack/tile/iron/white/brick_aligned_corner_inverse

/obj/item/stack/tile/iron/white/brick_aligned_corner_inverse
	name = "white aligned brick inverse corner floor tile"
	singular_name = "white aligned brick inverse corner floor tile"
	icon = 'modular_nova/master_files/icons/obj/tiles.dmi'
	icon_state = "white_brick_aligned_corner_inverse"
	turf_type = /turf/open/floor/iron/white/brick_aligned_corner_inverse
	merge_type = /obj/item/stack/tile/iron/white/brick_aligned_corner_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)
