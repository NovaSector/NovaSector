// Mineral walls, false walls and wall fillings removed by tgstation #97723, re-added modularly.

/*
 * Sandstone variants
 */

/turf/closed/wall/mineral/sandstone/wall_fill
	sheet_type = /obj/item/stack/wall_filling/sandstone/basic
	sheet_amount = 1

/turf/closed/wall/mineral/sandstone/ornate
	name = "ornate sandstone wall"
	desc = "A wall with ornate sandstone plating. Smooth."
	icon = 'modular_nova/modules/floors_and_walls/icons/sandstone_ornate_wall.dmi'
	icon_state = "sandstone_ornate_wall-0"
	base_icon_state = "sandstone_ornate_wall"
	sheet_type = /obj/item/stack/wall_filling/sandstone/ornate
	sheet_amount = 1

/turf/closed/wall/mineral/sandstone/basalt
	name = "basalt wall"
	desc = "A wall with basalt plating. The orange is from other colours of sand that make up for it."
	icon = 'modular_nova/modules/floors_and_walls/icons/sandbasalt_wall.dmi'
	icon_state = "sandbasalt_wall-0"
	base_icon_state = "sandbasalt_wall"
	sheet_type = /obj/item/stack/wall_filling/sandstone/basalt
	sheet_amount = 1

/obj/structure/falsewall/sandstone/wall_fill
	mineral = /obj/item/stack/wall_filling/sandstone/basic
	mineral_amount = 1
	walltype = /turf/closed/wall/mineral/sandstone/wall_fill

/obj/structure/falsewall/sandstone/ornate
	name = "sandstone wall"
	desc = "A wall with sandstone plating. Rough."
	icon = 'modular_nova/modules/floors_and_walls/icons/false_walls.dmi'
	fake_icon = 'modular_nova/modules/floors_and_walls/icons/sandstone_ornate_wall.dmi'
	icon_state = "sandstone_ornate_wall-open"
	base_icon_state = "sandstone_ornate_wall"
	mineral = /obj/item/stack/wall_filling/sandstone/ornate
	mineral_amount = 1
	walltype = /turf/closed/wall/mineral/sandstone/ornate

/obj/structure/falsewall/sandstone/basalt
	name = "basalt wall"
	desc = "A wall with basalt plating. The orange is from other colours of sand that make up for it."
	icon = 'modular_nova/modules/floors_and_walls/icons/false_walls.dmi'
	fake_icon = 'modular_nova/modules/floors_and_walls/icons/sandbasalt_wall.dmi'
	icon_state = "sandbasalt_wall-open"
	base_icon_state = "sandbasalt_wall"
	mineral = /obj/item/stack/wall_filling/sandstone/basalt
	mineral_amount = 1
	walltype = /turf/closed/wall/mineral/sandstone/basalt

/obj/item/stack/wall_filling/sandstone
	name = "sandstone wall filling"
	singular_name = "sandstone wall filler"
	desc = "A filling for a standard sandstone wall."
	icon = 'modular_nova/modules/floors_and_walls/icons/stack_objects.dmi'
	icon_state = "sandbrick-wall-fill"
	inhand_icon_state = null
	mats_per_unit = list(/datum/material/sandstone = SHEET_MATERIAL_AMOUNT * 2)
	merge_type = /obj/item/stack/wall_filling/sandstone
	made_from = /obj/item/stack/sheet/mineral/sandstone
	wall_reskin_types = list(
		/obj/item/stack/wall_filling/sandstone/basic,
		/obj/item/stack/wall_filling/sandstone/ornate,
		/obj/item/stack/wall_filling/sandstone/basalt,
	)

/obj/item/stack/wall_filling/sandstone/basic
	merge_type = /obj/item/stack/wall_filling/sandstone/basic

/obj/item/stack/wall_filling/sandstone/ornate
	name = "ornate sandstone wall filling"
	singular_name = "ornate sandstone wall filler"
	desc = "A filling for a ornate sandstone wall. Is someone here building a pyramid or something?"
	icon_state = "sandornate-wall-fill"
	merge_type = /obj/item/stack/wall_filling/sandstone/ornate

/obj/item/stack/wall_filling/sandstone/basalt
	name = "basalt sandstone wall filling"
	singular_name = "basalt sandstone wall filler"
	desc = "A filling for a basalt wall, made out of sandstone. Not sure how it works, not the weirdest thing you've seen."
	icon_state = "basaltbrick-wall-fill"
	merge_type = /obj/item/stack/wall_filling/sandstone/basalt

/*
 * Bone
 */

/turf/closed/wall/mineral/bone
	name = "bone wall"
	desc = "A bone wall. That's a lot of calcium."
	icon = 'modular_nova/modules/floors_and_walls/icons/bone_wall.dmi'
	icon_state = "bone_wall-0"
	base_icon_state = "bone_wall"
	sheet_type = /obj/item/stack/sheet/bone
	hardness = 30
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_BONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_BONE_WALLS
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)
	rust_resistance = RUST_RESISTANCE_ORGANIC

/obj/structure/falsewall/bone
	name = "bone wall"
	desc = "A bone wall. That's a lot of calcium."
	icon = 'modular_nova/modules/floors_and_walls/icons/false_walls.dmi'
	fake_icon = 'modular_nova/modules/floors_and_walls/icons/bone_wall.dmi'
	icon_state = "bone_wall-open"
	base_icon_state = "bone_wall"
	mineral = /obj/item/stack/sheet/bone
	walltype = /turf/closed/wall/mineral/bone
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_BONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_BONE_WALLS

/*
 * Runite
 */

/turf/closed/wall/mineral/runite
	name = "runite wall"
	desc = "A runite wall. How... magical."
	icon = 'modular_nova/modules/floors_and_walls/icons/runite_wall.dmi'
	icon_state = "runite_wall-0"
	base_icon_state = "runite_wall"
	sheet_type = /obj/item/stack/sheet/mineral/runite
	hardness = 40
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_RUNITE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_RUNITE_WALLS
	custom_materials = list(/datum/material/runite = SHEET_MATERIAL_AMOUNT * 2)
	rust_resistance = RUST_RESISTANCE_REINFORCED

/obj/structure/falsewall/runite
	name = "runite wall"
	desc = "A runite wall. How... magical."
	icon = 'modular_nova/modules/floors_and_walls/icons/false_walls.dmi'
	fake_icon = 'modular_nova/modules/floors_and_walls/icons/runite_wall.dmi'
	icon_state = "runite_wall-open"
	base_icon_state = "runite_wall"
	mineral = /obj/item/stack/sheet/mineral/runite
	walltype = /turf/closed/wall/mineral/runite
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_RUNITE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_RUNITE_WALLS

/*
 * Adamantine
 */

/turf/closed/wall/mineral/adamantine
	name = "adamantine wall"
	desc = "A adamantine wall. Quite industrial."
	icon = 'modular_nova/modules/floors_and_walls/icons/adamantine_wall.dmi'
	icon_state = "adamantine_wall-0"
	base_icon_state = "adamantine_wall"
	sheet_type = /obj/item/stack/sheet/mineral/adamantine
	hardness = 30
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_ADAMANTINE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_ADAMANTINE_WALLS
	custom_materials = list(/datum/material/adamantine = SHEET_MATERIAL_AMOUNT * 2)
	rust_resistance = RUST_RESISTANCE_REINFORCED

/obj/structure/falsewall/adamantine
	name = "adamantine wall"
	desc = "A adamantine wall. Quite industrial."
	icon = 'modular_nova/modules/floors_and_walls/icons/false_walls.dmi'
	fake_icon = 'modular_nova/modules/floors_and_walls/icons/adamantine_wall.dmi'
	icon_state = "adamantine_wall-open"
	base_icon_state = "adamantine_wall"
	mineral = /obj/item/stack/sheet/mineral/adamantine
	walltype = /turf/closed/wall/mineral/adamantine
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_ADAMANTINE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_ADAMANTINE_WALLS

/*
 * Metal hydrogen
 */

/turf/closed/wall/mineral/metalhydrogen
	name = "metal hydrogen wall"
	desc = "A metal hydrogen wall. Long live atmosia!"
	icon = 'modular_nova/modules/floors_and_walls/icons/metal_hydrogen_wall.dmi'
	icon_state = "metal_hydrogen_wall-0"
	base_icon_state = "metal_hydrogen_wall"
	sheet_type = /obj/item/stack/sheet/mineral/metal_hydrogen
	hardness = 30
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_METALHYDROGEN_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_METALHYDROGEN_WALLS
	custom_materials = list(/datum/material/metalhydrogen = SHEET_MATERIAL_AMOUNT * 2)
	rust_resistance = RUST_RESISTANCE_REINFORCED

/obj/structure/falsewall/metalhydrogen
	name = "metal hydrogen wall"
	desc = "A metal hydrogen wall. Long live atmosia!"
	icon = 'modular_nova/modules/floors_and_walls/icons/false_walls.dmi'
	fake_icon = 'modular_nova/modules/floors_and_walls/icons/metal_hydrogen_wall.dmi'
	icon_state = "metal_hydrogen_wall-open"
	base_icon_state = "metal_hydrogen_wall"
	mineral = /obj/item/stack/sheet/mineral/metal_hydrogen
	walltype = /turf/closed/wall/mineral/metalhydrogen
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_METALHYDROGEN_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_METALHYDROGEN_WALLS

/*
 * Hauntium
 */

/turf/closed/wall/mineral/hauntium
	name = "hauntium wall"
	desc = "A hauntium wall. Are you spooked yet?"
	icon = 'modular_nova/modules/floors_and_walls/icons/hauntium_wall.dmi'
	icon_state = "hauntium_wall-0"
	base_icon_state = "hauntium_wall"
	sheet_type = /obj/item/stack/sheet/hauntium
	hardness = 20
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_HAUNTIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_HAUNTIUM_WALLS
	custom_materials = list(/datum/material/hauntium = SHEET_MATERIAL_AMOUNT * 2)
	rust_resistance = RUST_RESISTANCE_ORGANIC

/obj/structure/falsewall/hauntium
	name = "hauntium wall"
	desc = "A hauntium wall. Are you spooked yet?"
	icon = 'modular_nova/modules/floors_and_walls/icons/false_walls.dmi'
	fake_icon = 'modular_nova/modules/floors_and_walls/icons/hauntium_wall.dmi'
	icon_state = "hauntium_wall-open"
	base_icon_state = "hauntium_wall"
	mineral = /obj/item/stack/sheet/hauntium
	walltype = /turf/closed/wall/mineral/hauntium
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_HAUNTIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_HAUNTIUM_WALLS

/*
 * Mythril
 */

/turf/closed/wall/mineral/mythril
	name = "mythril wall"
	desc = "A mythril wall. You are in the deep end, huh?"
	icon = 'modular_nova/modules/floors_and_walls/icons/mythril_wall.dmi'
	icon_state = "mythril_wall-0"
	base_icon_state = "mythril_wall"
	sheet_type = /obj/item/stack/sheet/mineral/mythril
	hardness = 1
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_MYTHRIL_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_MYTHRIL_WALLS
	custom_materials = list(/datum/material/mythril = SHEET_MATERIAL_AMOUNT * 2)
	rust_resistance = RUST_RESISTANCE_REINFORCED

/obj/structure/falsewall/mythril
	name = "mythril wall"
	desc = "A fake mythril wall. You can tell it's fake because it's not perfect like the rest."
	icon = 'modular_nova/modules/floors_and_walls/icons/false_walls.dmi'
	fake_icon = 'modular_nova/modules/floors_and_walls/icons/mythril_wall.dmi'
	icon_state = "mythril_wall-open"
	base_icon_state = "mythril_wall"
	mineral = /obj/item/stack/sheet/mineral/mythril
	walltype = /turf/closed/wall/mineral/mythril
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_MYTHRIL_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_MYTHRIL_WALLS
