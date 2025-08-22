/turf/open/floor
	icon = 'modular_nova/modules/aesthetics/floors/icons/floors.dmi'

/turf/open/floor/catwalk_floor
	icon = 'modular_nova/modules/aesthetics/floors/icons/catwalk_plating.dmi'

//Removes redundant textured stuff from this radial, as all of ours are textured by default
/obj/item/stack/tile/iron
	tile_reskin_types = list(
		/obj/item/stack/tile/iron,
		/obj/item/stack/tile/iron/edge,
		/obj/item/stack/tile/iron/half,
		/obj/item/stack/tile/iron/corner,
		/obj/item/stack/tile/iron/large,
		/obj/item/stack/tile/iron/small,
		/obj/item/stack/tile/iron/diagonal,
		/obj/item/stack/tile/iron/herringbone,
		/obj/item/stack/tile/iron/brick,
		/obj/item/stack/tile/iron/dark,
		/obj/item/stack/tile/iron/dark/smooth_edge,
		/obj/item/stack/tile/iron/dark/smooth_half,
		/obj/item/stack/tile/iron/dark/smooth_corner,
		/obj/item/stack/tile/iron/dark/smooth_large,
		/obj/item/stack/tile/iron/dark/small,
		/obj/item/stack/tile/iron/dark/diagonal,
		/obj/item/stack/tile/iron/dark/herringbone,
		/obj/item/stack/tile/iron/dark_side,
		/obj/item/stack/tile/iron/dark_corner,
		/obj/item/stack/tile/iron/checker,
		/obj/item/stack/tile/iron/white,
		/obj/item/stack/tile/iron/white/smooth_edge,
		/obj/item/stack/tile/iron/white/smooth_half,
		/obj/item/stack/tile/iron/white/smooth_corner,
		/obj/item/stack/tile/iron/white/smooth_large,
		/obj/item/stack/tile/iron/white/small,
		/obj/item/stack/tile/iron/white/diagonal,
		/obj/item/stack/tile/iron/white/herringbone,
		/obj/item/stack/tile/iron/white_side,
		/obj/item/stack/tile/iron/white_corner,
		/obj/item/stack/tile/iron/cafeteria,
		/obj/item/stack/tile/iron/recharge_floor,
		/obj/item/stack/tile/iron/smooth,
		/obj/item/stack/tile/iron/smooth_edge,
		/obj/item/stack/tile/iron/smooth_half,
		/obj/item/stack/tile/iron/smooth_corner,
		/obj/item/stack/tile/iron/smooth_large,
		/obj/item/stack/tile/iron/terracotta,
		/obj/item/stack/tile/iron/terracotta/small,
		/obj/item/stack/tile/iron/terracotta/diagonal,
		/obj/item/stack/tile/iron/terracotta/herringbone,
		/obj/item/stack/tile/iron/kitchen,
		/obj/item/stack/tile/iron/kitchen/small,
		/obj/item/stack/tile/iron/kitchen/diagonal,
		/obj/item/stack/tile/iron/kitchen/herringbone,
		/obj/item/stack/tile/iron/chapel,
		/obj/item/stack/tile/iron/showroomfloor,
		/obj/item/stack/tile/iron/solarpanel,
		/obj/item/stack/tile/iron/freezer,
		/obj/item/stack/tile/iron/grimy,
		/obj/item/stack/tile/iron/sepia,
	)

/turf/open/indestructible/cobble
	name = "cobblestone path"
	desc = "A simple but beautiful path made of various sized stones."
	icon = 'modular_nova/modules/aesthetics/floors/icons/floors.dmi'
	icon_state = "cobble"
	baseturfs = /turf/open/indestructible/cobble
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/indestructible/cobble/side
	icon_state = "cobble_side"

/turf/open/indestructible/cobble/corner
	icon_state = "cobble_corner"

/turf/open/floor/plating/reinforced
	icon = 'icons/turf/floors.dmi'

/turf/open/floor/greenscreen
	icon = 'icons/turf/floors.dmi'

/turf/open/floor/iron/white/textured_large/airless
	initial_gas_mix = AIRLESS_ATMOS

/*
* Standard Tiles
*/

/turf/open/floor/iron/brick
	icon_state = "brick"
	base_icon_state = "brick"
	floor_tile = /obj/item/stack/tile/iron/brick

/obj/item/stack/tile/iron/brick
	name = "brick floor tile"
	singular_name = "brick floor tile"
	icon_state = "tile_edge"
	turf_type = /turf/open/floor/iron/brick
	merge_type = /obj/item/stack/tile/iron/brick
	tile_rotate_dirs = list(SOUTH, NORTH)

/turf/open/floor/iron/brick_half
	icon_state = "brick_half"
	base_icon_state = "brick_half"
	floor_tile = /obj/item/stack/tile/iron/brick_half

/obj/item/stack/tile/iron/brick_half
	name = "half brick floor tile"
	singular_name = "brick floor tile"
	icon_state = "brick_half"
	turf_type = /turf/open/floor/iron/brick_half
	merge_type = /obj/item/stack/tile/iron/brick_half
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_corner
	icon_state = "brick_corner"
	base_icon_state = "brick_corner"
	floor_tile = /obj/item/stack/tile/iron/brick_corner

/obj/item/stack/tile/iron/brick_corner
	name = "brick corner floor tile"
	singular_name = "brick floor tile"
	icon_state = "brick_corner"
	turf_type = /turf/open/floor/iron/brick_corner
	merge_type = /obj/item/stack/tile/iron/brick_corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_corner_inverse
	icon_state = "brick_corner_inverse"
	base_icon_state = "brick_corner_inverse"
	floor_tile = /obj/item/stack/tile/iron/brick_corner_inverse

/obj/item/stack/tile/iron/brick_corner_inverse
	name = "brick inverse floor tile"
	singular_name = "brick floor tile"
	icon_state = "brick_corner_inverse"
	turf_type = /turf/open/floor/iron/brick_corner_inverse
	merge_type = /obj/item/stack/tile/iron/brick_corner_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_corner_vertical
	icon_state = "brick_corner_vertical"
	base_icon_state = "brick_corner_vertical"
	floor_tile = /obj/item/stack/tile/iron/brick_corner_vertical

/obj/item/stack/tile/iron/brick_corner_vertical
	name = "brick corner floor tile"
	singular_name = "brick floor tile"
	icon_state = "brick_corner_vertical"
	turf_type = /turf/open/floor/iron/brick_corner_vertical
	merge_type = /obj/item/stack/tile/iron/brick_corner_vertical
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/iron/brick_corner_vertical_inverse
	icon_state = "brick_corner_vertical_inverse"
	base_icon_state = "brick_corner_vertical_inverse"
	floor_tile = /obj/item/stack/tile/iron/brick_corner_vertical_inverse

/obj/item/stack/tile/iron/brick_corner_vertical_inverse
	name = "brick inverse floor tile"
	singular_name = "brick floor tile"
	icon_state = "brick_corner_vertical_inverse"
	turf_type = /turf/open/floor/iron/brick_corner_vertical_inverse
	merge_type = /obj/item/stack/tile/iron/brick_corner_vertical_inverse
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)



/*
* DARK TILES
*/

/*
* WHITE TILES
*/
