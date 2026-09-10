// Flooring removed by tgstation #97723 (https://github.com/tgstation/tgstation/pull/97723), re-added modularly from
// #97241, plus "(alt)" variants that restore the #97241 artwork for floors #97723 resprited rather than removed.
//

#define FLOORS_AND_WALLS_FLOORS 'modular_nova/modules/floors_and_walls/icons/floors.dmi'
#define FLOORS_AND_WALLS_TILES 'modular_nova/modules/floors_and_walls/icons/tiles.dmi'

/*
 * Carpets
 */


/turf/open/floor/carpet/bear/alt
	name = "bear fur carpet (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/carpet_bear.dmi'
	floor_tile = /obj/item/stack/tile/carpet/bear/alt

/obj/item/stack/tile/carpet/bear/alt
	name = "bear fur carpet (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile-carpet-bear"
	turf_type = /turf/open/floor/carpet/bear/alt
	merge_type = /obj/item/stack/tile/carpet/bear/alt
	tile_reskin_types = null

/turf/open/floor/carpet/polar_bear/alt
	name = "polar bear fur carpet (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/carpet_bearpolar.dmi'
	floor_tile = /obj/item/stack/tile/carpet/polar_bear/alt

/obj/item/stack/tile/carpet/polar_bear/alt
	name = "polar fur carpet (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile-carpet-bear-polar"
	turf_type = /turf/open/floor/carpet/polar_bear/alt
	merge_type = /obj/item/stack/tile/carpet/polar_bear/alt
	tile_reskin_types = null

/turf/open/floor/carpet/moth/alt
	name = "moth carpet (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/carpet_moth.dmi'
	floor_tile = /obj/item/stack/tile/carpet/moth/alt

/obj/item/stack/tile/carpet/moth/alt
	name = "moth fur carpet (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile-carpet-moth"
	turf_type = /turf/open/floor/carpet/moth/alt
	merge_type = /obj/item/stack/tile/carpet/moth/alt
	tile_reskin_types = null

/turf/open/floor/carpet/goliath/alt
	name = "goliath hide carpet (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/carpet_goliath.dmi'
	floor_tile = /obj/item/stack/tile/carpet/goliath/alt

/obj/item/stack/tile/carpet/goliath/alt
	name = "goliath hide carpet (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile-carpet-goliath"
	turf_type = /turf/open/floor/carpet/goliath/alt
	merge_type = /obj/item/stack/tile/carpet/goliath/alt
	tile_reskin_types = null

/turf/open/floor/carpet/carp/alt
	name = "carp scales carpet (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/carpet_carp.dmi'
	floor_tile = /obj/item/stack/tile/carpet/carp/alt

/obj/item/stack/tile/carpet/carp/alt
	name = "carp scales carpet (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile-carpet-carp"
	turf_type = /turf/open/floor/carpet/carp/alt
	merge_type = /obj/item/stack/tile/carpet/carp/alt
	tile_reskin_types = null

/turf/open/floor/carpet/lizard/alt
	name = "lizard scales (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/carpet_lizard.dmi'
	floor_tile = /obj/item/stack/tile/carpet/lizard/alt

/obj/item/stack/tile/carpet/lizard/alt
	name = "lizard scales carpet (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile-carpet-lizard"
	turf_type = /turf/open/floor/carpet/lizard/alt
	merge_type = /obj/item/stack/tile/carpet/lizard/alt
	tile_reskin_types = null

/*
 * Wood
 */

/turf/open/floor/wood/dark
	desc = "Stylish dark wood."
	icon = 'modular_nova/modules/floors_and_walls/icons/floors.dmi'
	icon_state = "darkwood"
	floor_tile = /obj/item/stack/tile/wood/dark

/obj/item/stack/tile/wood/dark
	name = "dark wood floor tile"
	singular_name = "dark wood floor tile"
	desc = "An easy to fit dark wood floor tile. Use while in your hand to change what pattern you want."
	icon = 'modular_nova/modules/floors_and_walls/icons/tiles.dmi'
	icon_state = "tile-darkwood"
	turf_type = /turf/open/floor/wood/dark
	merge_type = /obj/item/stack/tile/wood/dark

/turf/open/floor/wood/dark/tile
	icon_state = "darkwood_tile"
	floor_tile = /obj/item/stack/tile/wood/dark/tile

/obj/item/stack/tile/wood/dark/tile
	name = "tiled dark wood floor tile"
	singular_name = "tiled dark wood floor tile"
	icon_state = "tile-darkwood_tile"
	turf_type = /turf/open/floor/wood/dark/tile
	merge_type = /obj/item/stack/tile/wood/dark/tile

/turf/open/floor/wood/dark/parquet
	icon_state = "darkwood_parquet"
	floor_tile = /obj/item/stack/tile/wood/dark/parquet

/obj/item/stack/tile/wood/dark/parquet
	name = "parquet dark wood floor tile"
	singular_name = "parquet dark wood floor tile"
	icon_state = "tile-darkwood_parquet"
	turf_type = /turf/open/floor/wood/dark/parquet
	merge_type = /obj/item/stack/tile/wood/dark/parquet

/turf/open/floor/wood/dark/large
	icon_state = "darkwood_large"
	floor_tile = /obj/item/stack/tile/wood/dark/large

/obj/item/stack/tile/wood/dark/large
	name = "large dark wood floor tile"
	singular_name = "large dark wood floor tile"
	icon_state = "tile-darkwood_large"
	turf_type = /turf/open/floor/wood/dark/large
	merge_type = /obj/item/stack/tile/wood/dark/large

/turf/open/floor/wood/light
	desc = "Stylish light wood."
	icon = 'modular_nova/modules/floors_and_walls/icons/floors.dmi'
	icon_state = "lightwood"
	floor_tile = /obj/item/stack/tile/wood/light

/obj/item/stack/tile/wood/light
	name = "light wood floor tile"
	singular_name = "light wood floor tile"
	desc = "An easy to fit light wood floor tile. Use while in your hand to change what pattern you want."
	icon = 'modular_nova/modules/floors_and_walls/icons/tiles.dmi'
	icon_state = "tile-lightwood"
	turf_type = /turf/open/floor/wood/light
	merge_type = /obj/item/stack/tile/wood/light

/turf/open/floor/wood/light/tile
	icon_state = "lightwood_tile"
	floor_tile = /obj/item/stack/tile/wood/light/tile

/obj/item/stack/tile/wood/light/tile
	name = "tiled light wood floor tile"
	singular_name = "tiled light wood floor tile"
	icon_state = "tile-lightwood_tile"
	turf_type = /turf/open/floor/wood/light/tile
	merge_type = /obj/item/stack/tile/wood/light/tile

/turf/open/floor/wood/light/parquet
	icon_state = "lightwood_parquet"
	floor_tile = /obj/item/stack/tile/wood/light/parquet

/obj/item/stack/tile/wood/light/parquet
	name = "parquet light wood floor tile"
	singular_name = "parquet light wood floor tile"
	icon_state = "tile-lightwood_parquet"
	turf_type = /turf/open/floor/wood/light/parquet
	merge_type = /obj/item/stack/tile/wood/light/parquet

/turf/open/floor/wood/light/large
	icon_state = "lightwood_large"
	floor_tile = /obj/item/stack/tile/wood/light/large

/obj/item/stack/tile/wood/light/large
	name = "large light wood floor tile"
	singular_name = "large light wood floor tile"
	icon_state = "tile-lightwood_large"
	turf_type = /turf/open/floor/wood/light/large
	merge_type = /obj/item/stack/tile/wood/light/large

/*
 * Plasteel
 */

/turf/open/floor/mineral/plasteel
	name = "plasteel floor"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "plasteel"
	floor_tile = /obj/item/stack/tile/plasteel
	custom_materials = list(/datum/material/alloy/plasteel = SMALL_MATERIAL_AMOUNT * 5)
	rust_resistance = RUST_RESISTANCE_TITANIUM

/turf/open/floor/mineral/plasteel/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/obj/item/stack/tile/plasteel
	name = "plasteel tile"
	singular_name = "plasteel floor tile"
	desc = "Industrial plasteel tiles, tough and reinforced."
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "plasteel"
	inhand_icon_state = "tile-shuttle"
	turf_type = /turf/open/floor/mineral/plasteel
	mats_per_unit = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 0.25)
	merge_type = /obj/item/stack/tile/plasteel
	tile_reskin_types = list(
		/obj/item/stack/tile/plasteel,
		/obj/item/stack/tile/plasteel/straight,
		/obj/item/stack/tile/plasteel/corner,
		/obj/item/stack/tile/plasteel/block,
		/obj/item/stack/tile/plasteel/lock,
		/obj/item/stack/tile/plasteel/tiled,
	)

/turf/open/floor/mineral/plasteel/straight
	name = "straight plasteel floor"
	icon_state = "plasteel_straight"
	floor_tile = /obj/item/stack/tile/plasteel/straight

/obj/item/stack/tile/plasteel/straight
	name = "straight plasteel tile"
	singular_name = "straight plasteel floor tile"
	desc = "Industrial straight plasteel tiles, tough and reinforced."
	icon_state = "plasteel_straight"
	turf_type = /turf/open/floor/mineral/plasteel/straight
	merge_type = /obj/item/stack/tile/plasteel/straight

/turf/open/floor/mineral/plasteel/corner
	name = "corner plasteel floor"
	icon_state = "plasteel_corner"
	floor_tile = /obj/item/stack/tile/plasteel/corner

/obj/item/stack/tile/plasteel/corner
	name = "corner plasteel tile"
	singular_name = "corner plasteel floor tile"
	desc = "Industrial corner plasteel tiles, tough and reinforced."
	icon_state = "plasteel_corner"
	turf_type = /turf/open/floor/mineral/plasteel/corner
	merge_type = /obj/item/stack/tile/plasteel/corner

/turf/open/floor/mineral/plasteel/block
	name = "blocky plasteel floor"
	icon_state = "block"
	floor_tile = /obj/item/stack/tile/plasteel/block

/obj/item/stack/tile/plasteel/block
	name = "blocky plasteel tile"
	singular_name = "blocky plasteel floor tile"
	desc = "Blocky plasteel tiles, quite futuristic."
	icon_state = "block"
	turf_type = /turf/open/floor/mineral/plasteel/block
	merge_type = /obj/item/stack/tile/plasteel/block

/turf/open/floor/mineral/plasteel/lock
	name = "locked plasteel floor"
	icon_state = "lock"
	floor_tile = /obj/item/stack/tile/plasteel/lock

/obj/item/stack/tile/plasteel/lock
	name = "locked plasteel tile"
	singular_name = "locked plasteel floor tile"
	desc = "Locked plasteel tiles, with a keyhole symbol in the middle. Could be a pawn, though?"
	icon_state = "lock"
	turf_type = /turf/open/floor/mineral/plasteel/lock
	merge_type = /obj/item/stack/tile/plasteel/lock

/turf/open/floor/mineral/plasteel/tiled
	name = "tiled plasteel floor"
	icon_state = "alienvault"
	floor_tile = /obj/item/stack/tile/plasteel/tiled

/obj/item/stack/tile/plasteel/tiled
	name = "plasteel tiled"
	singular_name = "tiled plasteel"
	desc = "Plasteel, tiled."
	icon_state = "plasteel_tiled"
	turf_type = /turf/open/floor/mineral/plasteel/tiled
	merge_type = /obj/item/stack/tile/plasteel/tiled

/*
 * Bluespace
 */

/turf/open/floor/mineral/bluespace/n
	name = "N-marked bluespace floor"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "bluespacecrystal_n"
	floor_tile = /obj/item/stack/tile/mineral/bluespace/n

/obj/item/stack/tile/mineral/bluespace/n
	name = "N-marked bluespace tile"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "bluespace_c_n"
	turf_type = /turf/open/floor/mineral/bluespace/n
	merge_type = /obj/item/stack/tile/mineral/bluespace/n

/turf/open/floor/mineral/bluespace/alt
	name = "bluespace floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/bluespace/alt

/obj/item/stack/tile/mineral/bluespace/alt
	name = "bluespace tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_bluespace_c"
	turf_type = /turf/open/floor/mineral/bluespace/alt
	merge_type = /obj/item/stack/tile/mineral/bluespace/alt

/turf/open/floor/mineral/bluespace/tiled/alt
	name = "tiled bluespace floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/bluespace/tiled/alt

/obj/item/stack/tile/mineral/bluespace/tiled/alt
	name = "tiled bluespace tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "bluespace_c_tiled"
	turf_type = /turf/open/floor/mineral/bluespace/tiled/alt
	merge_type = /obj/item/stack/tile/mineral/bluespace/tiled/alt

/*
 * Telecrystal
 */

/turf/open/floor/mineral/telecrystal/s
	name = "S-marked telecrystal floor"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "telecrystal_s"
	floor_tile = /obj/item/stack/tile/mineral/telecrystal/s

/obj/item/stack/tile/mineral/telecrystal/s
	name = "S-marked telecrystal tile"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "telecrystal_s"
	turf_type = /turf/open/floor/mineral/telecrystal/s
	merge_type = /obj/item/stack/tile/mineral/telecrystal/s

/turf/open/floor/mineral/telecrystal/alt
	name = "telecrystal floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/telecrystal/alt

/obj/item/stack/tile/mineral/telecrystal/alt
	name = "telecrystal tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/mineral/telecrystal/alt
	merge_type = /obj/item/stack/tile/mineral/telecrystal/alt

/turf/open/floor/mineral/telecrystal/tiled/alt
	name = "tiled telecrystal floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/telecrystal/tiled/alt

/obj/item/stack/tile/mineral/telecrystal/tiled/alt
	name = "tiled telecrystal tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "telecrystal_tiled"
	turf_type = /turf/open/floor/mineral/telecrystal/tiled/alt
	merge_type = /obj/item/stack/tile/mineral/telecrystal/tiled/alt

/*
 * Adamantine
 */

/turf/open/floor/mineral/adamantine/plating
	name = "adamantine plating"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "adamantium_alt"
	floor_tile = /obj/item/stack/tile/mineral/adamantine/plating

/obj/item/stack/tile/mineral/adamantine/plating
	name = "adamantine plating tile"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "adamantine_alt"
	turf_type = /turf/open/floor/mineral/adamantine/plating
	merge_type = /obj/item/stack/tile/mineral/adamantine/plating

/turf/open/floor/mineral/adamantine/alt
	name = "adamantine floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "adamantium"
	floor_tile = /obj/item/stack/tile/mineral/adamantine/alt

/obj/item/stack/tile/mineral/adamantine/alt
	name = "adamantine tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/mineral/adamantine/alt
	merge_type = /obj/item/stack/tile/mineral/adamantine/alt

/*
 * Bananium
 */

/turf/open/floor/mineral/bananium/alt
	name = "bananium floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/bananium/alt

/obj/item/stack/tile/mineral/bananium/alt
	name = "bananium tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_bananium"
	turf_type = /turf/open/floor/mineral/bananium/alt
	merge_type = /obj/item/stack/tile/mineral/bananium/alt

/turf/open/floor/mineral/bananium/tiled/alt
	name = "tiled bananium floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/bananium/tiled/alt

/obj/item/stack/tile/mineral/bananium/tiled/alt
	name = "tiled bananium tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "bananium_tiled"
	turf_type = /turf/open/floor/mineral/bananium/tiled/alt
	merge_type = /obj/item/stack/tile/mineral/bananium/tiled/alt

/*
 * Metal hydrogen for atmos nerds.
 */

/turf/open/floor/mineral/metal_hydrogen/alt
	name = "metal hydrogen floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/metal_hydrogen/alt

/obj/item/stack/tile/mineral/metal_hydrogen/alt
	name = "metal hydrogen tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/mineral/metal_hydrogen/alt
	merge_type = /obj/item/stack/tile/mineral/metal_hydrogen/alt

/turf/open/floor/mineral/metal_hydrogen/tiled/alt
	name = "tiled metalhydrogen floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/metal_hydrogen/tiled/alt

/obj/item/stack/tile/mineral/metal_hydrogen/tiled/alt
	name = "tiled metal hydrogen tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "metal_hydrogen_tiled"
	turf_type = /turf/open/floor/mineral/metal_hydrogen/tiled/alt
	merge_type = /obj/item/stack/tile/mineral/metal_hydrogen/tiled/alt

/*
 * Runite - upstream has no reskin radial for runite, so we do it here.
 */

/obj/item/stack/tile/mineral/runite
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/runite,
		/obj/item/stack/tile/mineral/runite/tiled,
		/obj/item/stack/tile/mineral/runite/alt,
	)

/turf/open/floor/mineral/runite/alt
	name = "runite floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/runite/alt

/obj/item/stack/tile/mineral/runite/alt
	name = "runite tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/mineral/runite/alt
	merge_type = /obj/item/stack/tile/mineral/runite/alt

/*
 * Mythril - likewise no upstream reskin radial.
 */

/obj/item/stack/tile/mineral/mythril
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/mythril,
		/obj/item/stack/tile/mineral/mythril/tiled,
		/obj/item/stack/tile/mineral/mythril/alt,
	)

/turf/open/floor/mineral/mythril/alt
	name = "mythril floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/mythril/alt

/obj/item/stack/tile/mineral/mythril/alt
	name = "mythril tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/mineral/mythril/alt
	merge_type = /obj/item/stack/tile/mineral/mythril/alt


/*
 * Ash forge circuit flooring
 */

/turf/open/floor/circuit/ash
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "ash"
	base_icon_state = "ash"
	light_color = LIGHT_COLOR_INTENSE_RED
	floor_tile = /obj/item/stack/tile/circuit/ash

/turf/open/floor/circuit/ash/off
	icon_state = "ash_off"
	always_off = TRUE

/turf/open/floor/circuit/ash/alt
	icon_state = "ash_alt"
	base_icon_state = "ash_alt"
	floor_tile = /obj/item/stack/tile/circuit/ash/alt

/turf/open/floor/circuit/ash/alt/off
	icon_state = "ash_alt_off"
	always_off = TRUE

/obj/item/stack/tile/circuit/ash
	name = "ornate ash forge tile"
	singular_name = "ornate ash forge tile"
	desc = "An ashen, ornate forge tile. Normaly seen in photos of ethereal homeworld's industrial areas."
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_ash"
	inhand_icon_state = "tile-rcircuit"
	turf_type = /turf/open/floor/circuit/ash
	merge_type = /obj/item/stack/tile/circuit/ash
	mats_per_unit = list(/datum/material/alloy/plastitanium = HALF_SHEET_MATERIAL_AMOUNT / 3)
	tile_reskin_types = list(
		/obj/item/stack/tile/circuit/ash,
		/obj/item/stack/tile/circuit/ash/alt,
	)

/obj/item/stack/tile/circuit/ash/alt
	name = "ash forge tile"
	singular_name = "ash forge tile"
	desc = "An ashen forge tile. Normaly seen in photos of ethereal homeworld's industrial areas."
	icon_state = "tile_ash_alt"
	turf_type = /turf/open/floor/circuit/ash/alt
	merge_type = /obj/item/stack/tile/circuit/ash/alt

/*
 * Bone
 */

/turf/open/floor/bone
	name = "bone floor"
	desc = "Those bones were once creatures with individidual hopes and dreams. Just a thing to think about as you walk on them."
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "bone_tile"
	custom_materials = list(/datum/material/bone = SMALL_MATERIAL_AMOUNT * 5)
	floor_tile = /obj/item/stack/tile/bone

/turf/open/floor/bone/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/obj/item/stack/tile/bone
	name = "bone tile"
	singular_name = "bone floor tile"
	desc = "Don't question where the dirt around it came from."
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_bone"
	inhand_icon_state = "tile-sepia"
	mats_per_unit = list(/datum/material/bone = HALF_SHEET_MATERIAL_AMOUNT / 2)
	turf_type = /turf/open/floor/bone
	merge_type = /obj/item/stack/tile/bone
	tile_reskin_types = list(
		/obj/item/stack/tile/bone,
		/obj/item/stack/tile/bone/corner,
		/obj/item/stack/tile/bone/straight,
		/obj/item/stack/tile/bone/spine,
		/obj/item/stack/tile/bone/meaty,
		/obj/item/stack/tile/bone/meaty/corner,
		/obj/item/stack/tile/bone/meaty/straight,
		/obj/item/stack/tile/bone/meaty/spine,
	)

/turf/open/floor/bone/corner
	name = "bone corner floor"
	icon_state = "bone_corner"
	floor_tile = /obj/item/stack/tile/bone/corner

/obj/item/stack/tile/bone/corner
	name = "bone corner tile"
	singular_name = "bone corner floor tile"
	icon_state = "bone_corner"
	turf_type = /turf/open/floor/bone/corner
	merge_type = /obj/item/stack/tile/bone/corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/bone/straight
	name = "bone straight floor"
	icon_state = "bone_straight"
	floor_tile = /obj/item/stack/tile/bone/straight

/obj/item/stack/tile/bone/straight
	name = "bone straight tile"
	singular_name = "bone straight floor tile"
	icon_state = "bone_straight"
	turf_type = /turf/open/floor/bone/straight
	merge_type = /obj/item/stack/tile/bone/straight
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/bone/spine
	name = "spine floor"
	icon_state = "bone_spine"
	floor_tile = /obj/item/stack/tile/bone/spine

/obj/item/stack/tile/bone/spine
	name = "bone spine tile"
	singular_name = "bone spine floor tile"
	icon_state = "bone_spine"
	turf_type = /turf/open/floor/bone/spine
	merge_type = /obj/item/stack/tile/bone/spine
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/bone/meaty
	name = "meaty bone floor"
	desc = "Spine-crawling, made literal."
	icon_state = "meatbone_tile"
	floor_tile = /obj/item/stack/tile/bone/meaty

/obj/item/stack/tile/bone/meaty
	name = "meaty bone tile"
	singular_name = "meaty bone floor tile"
	desc = "Don't question where the meat around it came from."
	icon_state = "tile_meatbone"
	inhand_icon_state = "tile-meat"
	lefthand_file = 'modular_nova/modules/floors_and_walls/icons/tiles_lefthand.dmi'
	righthand_file = 'modular_nova/modules/floors_and_walls/icons/tiles_righthand.dmi'
	turf_type = /turf/open/floor/bone/meaty
	merge_type = /obj/item/stack/tile/bone/meaty

/turf/open/floor/bone/meaty/corner
	name = "meaty bone corner floor"
	icon_state = "meatbone_corner"
	floor_tile = /obj/item/stack/tile/bone/meaty/corner

/obj/item/stack/tile/bone/meaty/corner
	name = "meaty bone corner tile"
	singular_name = "meaty bone corner floor tile"
	icon_state = "meatbone_corner"
	turf_type = /turf/open/floor/bone/meaty/corner
	merge_type = /obj/item/stack/tile/bone/meaty/corner
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/bone/meaty/straight
	name = "meaty bone straight floor"
	icon_state = "meatbone_straight"
	floor_tile = /obj/item/stack/tile/bone/meaty/straight

/obj/item/stack/tile/bone/meaty/straight
	name = "meaty bone straight tile"
	singular_name = "meaty bone straight floor tile"
	icon_state = "meatbone_straight"
	turf_type = /turf/open/floor/bone/meaty/straight
	merge_type = /obj/item/stack/tile/bone/meaty/straight
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/turf/open/floor/bone/meaty/spine
	name = "meaty spine floor"
	icon_state = "meatbone_spine"
	floor_tile = /obj/item/stack/tile/bone/meaty/spine

/obj/item/stack/tile/bone/meaty/spine
	name = "meaty bone spine tile"
	singular_name = "meaty bone spine floor tile"
	icon_state = "meatbone_spine"
	turf_type = /turf/open/floor/bone/meaty/spine
	merge_type = /obj/item/stack/tile/bone/meaty/spine
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST)

/*
 * MEAT
 */

/turf/open/floor/meat
	name = "meat floor"
	desc = "Floor is meat!"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "meat"
	custom_materials = list(/datum/material/meat = SMALL_MATERIAL_AMOUNT * 5)
	floor_tile = /obj/item/stack/tile/meat

/turf/open/floor/meat/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/obj/item/stack/tile/meat
	name = "meat tile"
	singular_name = "meat floor tile"
	desc = "From big Barry's builders best barbecue. This one looks a little stale."
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_meat"
	inhand_icon_state = "tile-meat"
	lefthand_file = 'modular_nova/modules/floors_and_walls/icons/tiles_lefthand.dmi'
	righthand_file = 'modular_nova/modules/floors_and_walls/icons/tiles_righthand.dmi'
	mats_per_unit = list(/datum/material/meat = HALF_SHEET_MATERIAL_AMOUNT / 2)
	turf_type = /turf/open/floor/meat
	merge_type = /obj/item/stack/tile/meat
	tile_reskin_types = list(
		/obj/item/stack/tile/meat,
		/obj/item/stack/tile/meat/fresh,
	)

/turf/open/floor/meat/fresh
	name = "fresh meat floor"
	icon_state = "meat_fresh"
	floor_tile = /obj/item/stack/tile/meat/fresh

/obj/item/stack/tile/meat/fresh
	name = "fresh meat tile"
	singular_name = "fresh meat floor tile"
	desc = "Fresh from big Barry's builders best barbecue."
	icon_state = "tile_meat_fresh"
	turf_type = /turf/open/floor/meat/fresh
	merge_type = /obj/item/stack/tile/meat/fresh

/*
 * Neo
 */

/turf/open/floor/neo
	name = "neo tile"
	desc = "It's pink and black because it shouldn't exist!"
	icon = FLOORS_AND_WALLS_FLOORS
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5)
	floor_tile = /obj/item/stack/tile/neo

/turf/open/floor/neo/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/obj/item/stack/tile/neo
	name = "neo tile"
	singular_name = "neo floor tile"
	icon = FLOORS_AND_WALLS_TILES
	inhand_icon_state = "tile-neon"
	mats_per_unit = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT / 2)
	turf_type = /turf/open/floor/neo
	merge_type = /obj/item/stack/tile/neo
	tile_reskin_types = list(
		/obj/item/stack/tile/neo/red,
		/obj/item/stack/tile/neo/purple,
		/obj/item/stack/tile/neo/orange,
		/obj/item/stack/tile/neo/cyan,
	)

/turf/open/floor/neo/red
	name = "red neo tile"
	desc = "A neo tile. Radiates with the power of ketchup."
	icon_state = "neo_red"
	floor_tile = /obj/item/stack/tile/neo/red

/obj/item/stack/tile/neo/red
	name = "red neo tile"
	singular_name = "red neo floor tile"
	desc = "A neo tile. Radiates with the power of ketchup."
	icon_state = "neo_red"
	turf_type = /turf/open/floor/neo/red
	merge_type = /obj/item/stack/tile/neo/red

/turf/open/floor/neo/purple
	name = "purple neo tile"
	desc = "A neo tile. Radiates with the power of neo. Duh."
	icon_state = "neo_purple"
	floor_tile = /obj/item/stack/tile/neo/purple

/obj/item/stack/tile/neo/purple
	name = "purple neo tile"
	singular_name = "purple neo floor tile"
	desc = "A neo tile. Radiates with the power of neo. Duh."
	icon_state = "neo_purple"
	turf_type = /turf/open/floor/neo/purple
	merge_type = /obj/item/stack/tile/neo/purple

/turf/open/floor/neo/orange
	name = "orange neo tile"
	desc = "A neo tile. Radiates with the power of 80s stylized sunset and tequilla."
	icon_state = "neo_orange"
	floor_tile = /obj/item/stack/tile/neo/orange

/obj/item/stack/tile/neo/orange
	name = "orange neo tile"
	singular_name = "orange neo floor tile"
	desc = "A neo tile. Radiates with the power of 80s stylized sunset and tequilla."
	icon_state = "neo_orange"
	turf_type = /turf/open/floor/neo/orange
	merge_type = /obj/item/stack/tile/neo/orange

/turf/open/floor/neo/cyan
	name = "cyan neo tile"
	desc = "A neo tile. Radiates with the power of being pedantic about colour names."
	icon_state = "neo_cyan"
	floor_tile = /obj/item/stack/tile/neo/cyan

/obj/item/stack/tile/neo/cyan
	name = "cyan neo tile"
	singular_name = "cyan neo floor tile"
	desc = "A neo tile. Radiates with the power of being pedantic about colour names."
	icon_state = "neo_cyan"
	turf_type = /turf/open/floor/neo/cyan
	merge_type = /obj/item/stack/tile/neo/cyan

/*
 * Silver and gold, not the Burt Ives kind.
 */

/turf/open/floor/silvergold
	name = "silver and gold floor"
	desc = "Floor made from silver and gold, in scaly pattern. As if just one or the other wasn't lavish enough."
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "blade"
	custom_materials = list(/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT / 4, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT / 4)
	floor_tile = /obj/item/stack/tile/silvergold

/obj/item/stack/tile/silvergold
	name = "silver and gold floor"
	singular_name = "silver and gold tile"
	desc = "Floor made from silver and gold, in scaly pattern. As if just one or the other wasn't lavish enough."
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "blade"
	inhand_icon_state = "tile-silvergold"
	lefthand_file = 'modular_nova/modules/floors_and_walls/icons/tiles_lefthand.dmi'
	righthand_file = 'modular_nova/modules/floors_and_walls/icons/tiles_righthand.dmi'
	mats_per_unit = list(/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT / 4, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT / 4)
	turf_type = /turf/open/floor/silvergold
	merge_type = /obj/item/stack/tile/silvergold
	tile_reskin_types = list(
		/obj/item/stack/tile/silvergold,
		/obj/item/stack/tile/silvergold/sword,
		/obj/item/stack/tile/silvergold/void,
		/obj/item/stack/tile/silvergold/flow,
	)

/turf/open/floor/silvergold/sword
	name = "sword floor"
	desc = "Floor made from silver and gold, in scaly pattern, with a sword in the middle."
	icon_state = "blade_sword"
	floor_tile = /obj/item/stack/tile/silvergold/sword

/obj/item/stack/tile/silvergold/sword
	name = "sword tile"
	singular_name = "sword tile"
	desc = "Floor made from silver and gold, in scaly pattern, with a sword in the middle."
	icon_state = "blade_sword"
	turf_type = /turf/open/floor/silvergold/sword
	merge_type = /obj/item/stack/tile/silvergold/sword

/turf/open/floor/silvergold/void
	name = "stars tile"
	desc = "Floor made from silver and gold, picturing stars. As opposed to the actual stars you are surrounded by."
	icon_state = "void"
	floor_tile = /obj/item/stack/tile/silvergold/void

/obj/item/stack/tile/silvergold/void
	name = "stars tile"
	singular_name = "stars tile"
	desc = "Floor made from silver and gold, picturing stars. As opposed to the actual stars you are surrounded by."
	icon_state = "void"
	turf_type = /turf/open/floor/silvergold/void
	merge_type = /obj/item/stack/tile/silvergold/void

/turf/open/floor/silvergold/flow
	name = "flowing tile"
	desc = "Floor made from silver and gold, with a flowing pattern. Silver and gold in balance."
	icon_state = "flow"
	floor_tile = /obj/item/stack/tile/silvergold/flow

/obj/item/stack/tile/silvergold/flow
	name = "flowing tile"
	singular_name = "flowing tile"
	desc = "Floor made from silver and gold, with a flowing pattern. Silver and gold in balance."
	icon_state = "flow"
	turf_type = /turf/open/floor/silvergold/flow
	merge_type = /obj/item/stack/tile/silvergold/flow

/*
 * Hauntium
 */

/turf/open/floor/hauntium/ghostbricked
	name = "ghostbricked hauntium floor"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "hauntium_ghostbricked"
	floor_tile = /obj/item/stack/tile/hauntium/ghostbricked

/obj/item/stack/tile/hauntium/ghostbricked
	name = "ghostbricked hauntium tile"
	singular_name = "ghostbricked hauntium floor tile"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_hauntium_ghostbricked"
	turf_type = /turf/open/floor/hauntium/ghostbricked
	merge_type = /obj/item/stack/tile/hauntium/ghostbricked


/*
 * Aesthetic sand
 */

/turf/open/floor/fakesand
	name = "aesthetic sand flooring"
	desc = "Safely recreated turf for your desertplanet-scaping."
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "asteroid"
	floor_tile = /obj/item/stack/tile/basalt/sand
	flags_1 = NONE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_turf = FALSE
	/// Icon state prefix used for the randomised look and the raked variant.
	var/base_icon = "asteroid"

/turf/open/floor/fakesand/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/diggable, /obj/item/stack/ore/glass, 2, worm_chance = 0)
	if(prob(15))
		icon_state = "[base_icon][rand(0, 12)]"

/turf/open/floor/fakesand/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/cultivator/rake))
		return NONE
	icon_state = "[base_icon]_raked"
	dir = turn(dir, 45)

	user.visible_message(
		span_notice("[user] rakes the [name]."),
		span_notice("You rake the [name]."),
	)

	playsound(src, 'sound/effects/shovel_dig.ogg', 50, TRUE)

	return ITEM_INTERACT_SUCCESS

/turf/open/floor/fakesand/red
	name = "aesthetic red sand flooring"
	desc = "Safely recreated turf for your mars-scaping."
	icon_state = "ironsand"
	base_icon = "ironsand"
	floor_tile = /obj/item/stack/tile/basalt/redsand

/turf/open/floor/fakesand/moon
	name = "aesthetic moon sand flooring"
	desc = "Safely recreated turf for your moon-scaping."
	icon_state = "moon"
	base_icon = "moon"
	floor_tile = /obj/item/stack/tile/basalt/moonsand

/obj/item/stack/tile/basalt
	tile_reskin_types = list(
		/obj/item/stack/tile/basalt,
		/obj/item/stack/tile/basalt/sand,
		/obj/item/stack/tile/basalt/redsand,
		/obj/item/stack/tile/basalt/moonsand,
	)

/obj/item/stack/tile/basalt/sand
	name = "sand tile"
	singular_name = "sand floor tile"
	desc = "Artificially made sand tile."
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_sand"
	inhand_icon_state = "tile-hay"
	turf_type = /turf/open/floor/fakesand
	merge_type = /obj/item/stack/tile/basalt/sand

/obj/item/stack/tile/basalt/redsand
	name = "red sand tile"
	singular_name = "red sand floor tile"
	desc = "Artificially made red sand tile."
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_redsand"
	inhand_icon_state = "tile-meat"
	lefthand_file = 'modular_nova/modules/floors_and_walls/icons/tiles_lefthand.dmi'
	righthand_file = 'modular_nova/modules/floors_and_walls/icons/tiles_righthand.dmi'
	turf_type = /turf/open/floor/fakesand/red
	merge_type = /obj/item/stack/tile/basalt/redsand

/obj/item/stack/tile/basalt/moonsand
	name = "moon sand tile"
	singular_name = "moon sand floor tile"
	desc = "Artificially made moon sand tile."
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_moonsand"
	inhand_icon_state = "tile-silver"
	turf_type = /turf/open/floor/fakesand/moon
	merge_type = /obj/item/stack/tile/basalt/moonsand

/*
 * Sandstone
 */

/obj/item/stack/tile/mineral/sandstone
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/sandstone,
		/obj/item/stack/tile/mineral/sandstone/cobbled,
		/obj/item/stack/tile/mineral/sandstone/tiled,
		/obj/item/stack/tile/mineral/sandstone/basalt,
		/obj/item/stack/tile/mineral/sandstone/alt,
	)

/turf/open/floor/sandstone/cobbled
	name = "cobbled sandstone floor"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "sandstone_cobbled"
	floor_tile = /obj/item/stack/tile/mineral/sandstone/cobbled

/obj/item/stack/tile/mineral/sandstone/cobbled
	name = "cobbled sandstone tile"
	singular_name = "sandstone cobbled floor tile"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "sandstone_cobbled"
	turf_type = /turf/open/floor/sandstone/cobbled
	merge_type = /obj/item/stack/tile/mineral/sandstone/cobbled

/turf/open/floor/sandstone/tiled
	name = "sandstone tile"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "sandstonevault"
	floor_tile = /obj/item/stack/tile/mineral/sandstone/tiled

/obj/item/stack/tile/mineral/sandstone/tiled
	name = "sandstone brick tile"
	singular_name = "sandstone brick floor tile"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "sandstone_tiled"
	turf_type = /turf/open/floor/sandstone/tiled
	merge_type = /obj/item/stack/tile/mineral/sandstone/tiled

/turf/open/floor/sandstone/basalt
	name = "basalt brick tile"
	icon = FLOORS_AND_WALLS_FLOORS
	icon_state = "basaltbrick_floor"
	floor_tile = /obj/item/stack/tile/mineral/sandstone/basalt

/obj/item/stack/tile/mineral/sandstone/basalt
	name = "basalt brick tile"
	singular_name = "basalt brick floor tile"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_basaltbrick"
	turf_type = /turf/open/floor/sandstone/basalt
	merge_type = /obj/item/stack/tile/mineral/sandstone/basalt


/*
 * Misc
 */

/turf/open/floor/hauntium/alt
	name = "hauntium floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/hauntium/alt

/obj/item/stack/tile/hauntium/alt
	name = "hauntium tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/hauntium/alt
	merge_type = /obj/item/stack/tile/hauntium/alt

/turf/open/floor/sandstone/alt
	name = "sandstone brick floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/mineral/sandstone/alt

/obj/item/stack/tile/mineral/sandstone/alt
	name = "sandstone brick tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "tile_sandstone"
	turf_type = /turf/open/floor/sandstone/alt
	merge_type = /obj/item/stack/tile/mineral/sandstone/alt

/turf/open/floor/bamboo/planks/alt
	name = "bamboo planks floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/bamboo/planks/alt

/obj/item/stack/tile/bamboo/planks/alt
	name = "bamboo planks tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/bamboo/planks/alt
	merge_type = /obj/item/stack/tile/bamboo/planks/alt

/turf/open/floor/plastic/puzzle/alt
	name = "plastic puzzle floor (alt)"
	icon = FLOORS_AND_WALLS_FLOORS
	floor_tile = /obj/item/stack/tile/plastic/puzzle/alt

/obj/item/stack/tile/plastic/puzzle/alt
	name = "puzzle tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	icon_state = "plastic_puzzle"
	turf_type = /turf/open/floor/plastic/puzzle/alt
	merge_type = /obj/item/stack/tile/plastic/puzzle/alt

/*
 * Stained glass
 */

/turf/open/floor/glass/stained_red/alt
	name = "red stained glass floor (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/glass_stained_red.dmi'
	floor_tile = /obj/item/stack/tile/stained_glass/red/alt

/obj/item/stack/tile/stained_glass/red
	tile_reskin_types = list(
		/obj/item/stack/tile/stained_glass/red,
		/obj/item/stack/tile/stained_glass/red/alt,
	)

/obj/item/stack/tile/stained_glass/red/alt
	name = "red stained glass floor (alt)"
	singular_name = "red stained glass floor tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/glass/stained_red/alt
	merge_type = /obj/item/stack/tile/stained_glass/red/alt

/turf/open/floor/glass/stained_orange/alt
	name = "orange stained glass floor (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/glass_stained_orange.dmi'
	floor_tile = /obj/item/stack/tile/stained_glass/orange/alt

/obj/item/stack/tile/stained_glass/orange
	tile_reskin_types = list(
		/obj/item/stack/tile/stained_glass/orange,
		/obj/item/stack/tile/stained_glass/orange/alt,
	)

/obj/item/stack/tile/stained_glass/orange/alt
	name = "orange stained glass floor (alt)"
	singular_name = "orange stained glass floor tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/glass/stained_orange/alt
	merge_type = /obj/item/stack/tile/stained_glass/orange/alt

/turf/open/floor/glass/stained_yellow/alt
	name = "yellow stained glass floor (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/glass_stained_yellow.dmi'
	floor_tile = /obj/item/stack/tile/stained_glass/yellow/alt

/obj/item/stack/tile/stained_glass/yellow
	tile_reskin_types = list(
		/obj/item/stack/tile/stained_glass/yellow,
		/obj/item/stack/tile/stained_glass/yellow/alt,
	)

/obj/item/stack/tile/stained_glass/yellow/alt
	name = "yellow stained glass floor (alt)"
	singular_name = "yellow stained glass floor tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/glass/stained_yellow/alt
	merge_type = /obj/item/stack/tile/stained_glass/yellow/alt

/turf/open/floor/glass/stained_green/alt
	name = "green stained glass floor (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/glass_stained_green.dmi'
	floor_tile = /obj/item/stack/tile/stained_glass/green/alt

/obj/item/stack/tile/stained_glass/green
	tile_reskin_types = list(
		/obj/item/stack/tile/stained_glass/green,
		/obj/item/stack/tile/stained_glass/green/alt,
	)

/obj/item/stack/tile/stained_glass/green/alt
	name = "green stained glass floor (alt)"
	singular_name = "green stained glass floor tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/glass/stained_green/alt
	merge_type = /obj/item/stack/tile/stained_glass/green/alt

/turf/open/floor/glass/stained_blue/alt
	name = "blue stained glass floor (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/glass_stained_blue.dmi'
	floor_tile = /obj/item/stack/tile/stained_glass/blue/alt

/obj/item/stack/tile/stained_glass/blue
	tile_reskin_types = list(
		/obj/item/stack/tile/stained_glass/blue,
		/obj/item/stack/tile/stained_glass/blue/alt,
	)

/obj/item/stack/tile/stained_glass/blue/alt
	name = "blue stained glass floor (alt)"
	singular_name = "blue stained glass floor tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/glass/stained_blue/alt
	merge_type = /obj/item/stack/tile/stained_glass/blue/alt

/turf/open/floor/glass/stained_purple/alt
	name = "purple stained glass floor (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/glass_stained_purple.dmi'
	floor_tile = /obj/item/stack/tile/stained_glass/purple/alt

/obj/item/stack/tile/stained_glass/purple
	tile_reskin_types = list(
		/obj/item/stack/tile/stained_glass/purple,
		/obj/item/stack/tile/stained_glass/purple/alt,
	)

/obj/item/stack/tile/stained_glass/purple/alt
	name = "purple stained glass floor (alt)"
	singular_name = "purple stained glass floor tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/glass/stained_purple/alt
	merge_type = /obj/item/stack/tile/stained_glass/purple/alt

/turf/open/floor/glass/stained_white/alt
	name = "white stained glass floor (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/glass_stained_white.dmi'
	floor_tile = /obj/item/stack/tile/stained_glass/white/alt

/obj/item/stack/tile/stained_glass/white
	tile_reskin_types = list(
		/obj/item/stack/tile/stained_glass/white,
		/obj/item/stack/tile/stained_glass/white/alt,
	)

/obj/item/stack/tile/stained_glass/white/alt
	name = "white stained glass floor (alt)"
	singular_name = "white stained glass floor tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/glass/stained_white/alt
	merge_type = /obj/item/stack/tile/stained_glass/white/alt

/turf/open/floor/glass/stained_black/alt
	name = "black stained glass floor (alt)"
	icon = 'modular_nova/modules/floors_and_walls/icons/glass_stained_black.dmi'
	floor_tile = /obj/item/stack/tile/stained_glass/black/alt

/obj/item/stack/tile/stained_glass/black
	tile_reskin_types = list(
		/obj/item/stack/tile/stained_glass/black,
		/obj/item/stack/tile/stained_glass/black/alt,
	)

/obj/item/stack/tile/stained_glass/black/alt
	name = "black stained glass floor (alt)"
	singular_name = "black stained glass floor tile (alt)"
	icon = FLOORS_AND_WALLS_TILES
	turf_type = /turf/open/floor/glass/stained_black/alt
	merge_type = /obj/item/stack/tile/stained_glass/black/alt



#undef FLOORS_AND_WALLS_FLOORS
#undef FLOORS_AND_WALLS_TILES
