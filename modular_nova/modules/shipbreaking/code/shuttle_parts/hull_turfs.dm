/turf/closed/wall/mineral/nanocarbon
	name = "nanocarbon hull"
	desc = "A durable nanocarbon-metal alloy hull used commonly in high endurance ships."
	icon = 'modular_nova/modules/shipbreaking/icons/turfs/nanocarbon_wall.dmi'
	icon_state = "nanocarbon_wall-0"
	base_icon_state = "nanocarbon_wall"
	explosive_resistance = 3
	flags_ricochet = RICOCHET_SHINY | RICOCHET_HARD
	sheet_type = /obj/item/stack/sheet/nanocarbon
	hardness = 20
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS | SMOOTH_OBJ
	smoothing_groups = SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_SHUTTLE_PARTS + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_PLASTITANIUM_WALLS
	custom_materials = list(
		/datum/material/nanocarbon = SHEET_MATERIAL_AMOUNT * 3,
	)
	rust_resistance = RUST_RESISTANCE_TITANIUM
	baseturfs = /turf/baseturf_bottom
	girder_type = /obj/structure/titanium_structure
	/// How many shards of nanocarbon the wall will make when exploded, maximum
	var/number_of_shards = 6

/turf/closed/wall/mineral/nanocarbon/break_wall()
	var/obj/new_plating = new /obj/structure/hull_plating/nanocarbon(src)
	new_plating.color = color
	if(girder_type)
		return new girder_type(src)

/turf/closed/wall/mineral/nanocarbon/devastate_wall()
	var/random_shards = rand(2, number_of_shards)
	for(var/iteration in 1 to random_shards)
		var/obj/item/shard = new /obj/item/nanocarbon_shard(src)
		shard.pixel_x = rand(-6, 6)
		shard.pixel_y = rand(-6, 6)
		shard.color = color
		var/atom/throw_target = get_edge_target_turf(shard, pick(GLOB.alldirs))
		shard.throw_at(throw_target, 6, 6)
	if(girder_type && prob(40))
		new girder_type(src)

/turf/closed/wall/mineral/nanocarbon/nodiagonal
	icon = MAP_SWITCH('modular_nova/modules/shipbreaking/icons/turfs/nanocarbon_wall.dmi', 'modular_nova/modules/shipbreaking/icons/turfs/walls_misc.dmi')
	icon_state = MAP_SWITCH("nanocarbon_wall-0", "nanocarbon_nd")
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/mineral/nanocarbon/primary_colour
	color = COLOR_SILVER

/turf/closed/wall/mineral/nanocarbon/primary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_PRIMARY_COLOUR, TRAIT_GENERIC)

/turf/closed/wall/mineral/nanocarbon/nodiagonal/primary_colour
	color = COLOR_SILVER

/turf/closed/wall/mineral/nanocarbon/nodiagonal/primary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_PRIMARY_COLOUR, TRAIT_GENERIC)

/turf/closed/wall/mineral/nanocarbon/secondary_colour
	color = COLOR_BROWN

/turf/closed/wall/mineral/nanocarbon/secondary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_SECONDARY_COLOUR, TRAIT_GENERIC)

/turf/closed/wall/mineral/nanocarbon/nodiagonal/secondary_colour
	color = COLOR_BROWN

/turf/closed/wall/mineral/nanocarbon/nodiagonal/secondary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_SECONDARY_COLOUR, TRAIT_GENERIC)

/turf/closed/wall/mineral/nanocarbon/black
	color = COLOR_DARK

/turf/closed/wall/mineral/nanocarbon/nodiagonal/black
	color = COLOR_DARK

/turf/closed/wall/mineral/nanocarbon/standard
	color = COLOR_SILVER

/turf/closed/wall/mineral/nanocarbon/nodiagonal/standard
	color = COLOR_SILVER

/turf/closed/wall/mineral/nanocarbon/red
	color = COLOR_BUBBLEGUM_RED

/turf/closed/wall/mineral/nanocarbon/nodiagonal/red
	color = COLOR_BUBBLEGUM_RED

/turf/closed/wall/mineral/nanocarbon/green
	color = COLOR_IRISH_GREEN

/turf/closed/wall/mineral/nanocarbon/nodiagonal/green
	color = COLOR_IRISH_GREEN

/turf/closed/wall/mineral/nanocarbon/blue
	color = COLOR_COMMAND_BLUE

/turf/closed/wall/mineral/nanocarbon/nodiagonal/blue
	color = COLOR_COMMAND_BLUE

/turf/closed/wall/mineral/nanocarbon/yellow
	color = COLOR_GOLD

/turf/closed/wall/mineral/nanocarbon/nodiagonal/yellow
	color = COLOR_GOLD

/turf/closed/wall/mineral/nanocarbon/tiziran_bronze
	name = "bronze hull"
	color = "#a6836a"

/turf/closed/wall/mineral/nanocarbon/nodiagonal/tiziran_bronze
	name = "bronze hull"
	color = "#a6836a"

/turf/closed/wall/mineral/aluminum
	name = "aluminum wall"
	desc = "A thin aluminum wall, commonly used to plate the interior of ships."
	icon = 'modular_nova/modules/shipbreaking/icons/turfs/aluminum_wall.dmi'
	icon_state = "aluminum_wall-0"
	base_icon_state = "aluminum_wall"
	sheet_type = /obj/item/stack/sheet/aluminum
	hardness = 50
	explosive_resistance = 0
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_OBJ
	smoothing_groups = SMOOTH_GROUP_TITANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_TITANIUM_WALLS
	custom_materials = list(
		/datum/material/aluminum = SHEET_MATERIAL_AMOUNT * 2,
	)
	rust_resistance = RUST_RESISTANCE_TITANIUM
	baseturfs = /turf/open/floor/plating/nanocarbon

/turf/closed/wall/mineral/aluminum/break_wall()
	var/obj/new_plating = new /obj/structure/hull_plating/aluminum(src)
	new_plating.color = color
	if(girder_type)
		return new girder_type(src)

/turf/open/floor/plating/nanocarbon
	name = "nanocarbon hull"
	desc = "A durable nanocarbon-metal alloy hull used commonly in high endurance ships."
	icon = 'modular_nova/modules/shipbreaking/icons/turfs/floors.dmi'
	icon_state = "nanocarbon"
	base_icon_state = "nanocarbon"
	attachment_holes = FALSE
	upgradable = FALSE
	rust_resistance = RUST_RESISTANCE_TITANIUM
	/// What kind of plating we make when cut apart
	var/obj/cut_plating = /obj/structure/hull_plating/nanocarbon/floor

/turf/open/floor/plating/nanocarbon/Initialize(mapload)
	. = ..()
	var/static/list/tool_behaviors = list(
		TOOL_WELDER = list(
			SCREENTIP_CONTEXT_LMB = "Cut Hull",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/turf/open/floor/plating/nanocarbon/welder_act(mob/living/user, obj/item/tool)
	if(!tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return ITEM_INTERACT_FAILURE
	balloon_alert(user, "cutting...")
	if(!tool.use_tool(src, user, 4 SECONDS, amount = 1, volume=50))
		return ITEM_INTERACT_BLOCKING
	new cut_plating(get_turf(src))
	ScrapeAway()
	return ITEM_INTERACT_SUCCESS

/turf/open/floor/plating/nanocarbon/ex_act(severity, target)
	if(severity >= EXPLODE_HEAVY)
		nanocarbon_nuke()
	return ..()

/// Makes shards of nanocarbon
/turf/open/floor/plating/nanocarbon/proc/nanocarbon_nuke()
	for(var/iteration in 1 to 2)
		var/obj/item/shard = new /obj/item/nanocarbon_shard(src)
		shard.pixel_x = rand(-6, 6)
		shard.pixel_y = rand(-6, 6)
		shard.color = color
		var/atom/throw_target = get_edge_target_turf(shard, pick(GLOB.alldirs))
		shard.throw_at(throw_target, 6, 6)

/turf/open/floor/plating/nanocarbon/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/nanocarbon/exterior
	icon_state = "nanocarbon_outside"
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/nanocarbon/exterior/primary_colour
	color = COLOR_SILVER

/turf/open/floor/plating/nanocarbon/exterior/primary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_PRIMARY_COLOUR, TRAIT_GENERIC)

/turf/open/floor/plating/nanocarbon/exterior/secondary_colour
	color = COLOR_BROWN

/turf/open/floor/plating/nanocarbon/exterior/secondary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_SECONDARY_COLOUR, TRAIT_GENERIC)

/turf/open/floor/plating/nanocarbon/exterior/black
	color = COLOR_DARK

/turf/open/floor/plating/nanocarbon/exterior/standard
	color = COLOR_SILVER

/turf/open/floor/plating/nanocarbon/exterior/red
	color = COLOR_BUBBLEGUM_RED

/turf/open/floor/plating/nanocarbon/exterior/green
	color = COLOR_IRISH_GREEN

/turf/open/floor/plating/nanocarbon/exterior/blue
	color = COLOR_COMMAND_BLUE

/turf/open/floor/plating/nanocarbon/exterior/yellow
	color = COLOR_GOLD

/turf/open/floor/plating/aluminum
	name = "aluminum hull"
	desc = "Thin aluminum hull, commonly used to plate the cargo bays of ships."
	icon = 'modular_nova/modules/shipbreaking/icons/turfs/aluminum.dmi'
	icon_state = "aluminum-0"
	base_icon_state = "aluminum"
	attachment_holes = FALSE
	upgradable = FALSE
	rust_resistance = RUST_RESISTANCE_TITANIUM
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_CHASM
	canSmoothWith = SMOOTH_GROUP_TURF_CHASM
	/// What kind of plating we make when cut apart
	var/obj/cut_plating = /obj/structure/hull_plating/aluminum/floor

/turf/open/floor/plating/aluminum/Initialize(mapload)
	. = ..()
	var/static/list/tool_behaviors = list(
		TOOL_WELDER = list(
			SCREENTIP_CONTEXT_LMB = "Cut Plating",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/turf/open/floor/plating/aluminum/welder_act(mob/living/user, obj/item/tool)
	if(!tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return ITEM_INTERACT_FAILURE
	balloon_alert(user, "cutting...")
	if(!tool.use_tool(src, user, 4 SECONDS, amount = 1, volume=50))
		return ITEM_INTERACT_BLOCKING
	new cut_plating(get_turf(src))
	ScrapeAway()
	return ITEM_INTERACT_SUCCESS

/turf/open/floor/plating/aluminum/airless
	initial_gas_mix = AIRLESS_ATMOS
