/obj/structure/shuttle_decoration/wall_plate
	abstract_type = /obj/structure/shuttle_decoration/wall_plate
	icon = 'modular_nova/modules/shipbreaking/icons/wall_platings.dmi'
	max_integrity = 125
	unfasten_time = 2 SECONDS
	requires_welder = TRUE
	pass_flags_self = NONE
	layer = ABOVE_MOB_LAYER
	flags_1 = ON_BORDER_1
	density = TRUE
	obj_flags = CAN_BE_HIT | IGNORE_DENSITY
	/// What type of hull plate object do we spawn when cut off the wall
	var/obj/structure/hull_plating/cut_plating = /obj/structure/hull_plating
	/// Do we transfer our color to the cut_plating
	var/keep_color = FALSE

/obj/structure/shuttle_decoration/wall_plate/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_exit),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/shuttle_decoration/wall_plate/welder_act(mob/living/user, obj/item/tool)
	if(!requires_welder)
		return NONE
	if(!tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return ITEM_INTERACT_FAILURE
	balloon_alert(user, "cutting...")
	if(!tool.use_tool(src, user, 4 SECONDS, amount = 1, volume=50))
		return ITEM_INTERACT_BLOCKING
	var/obj/new_plating = new cut_plating(get_turf(src))
	if(keep_color)
		new_plating.color = color
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/// Determines what to do when something is leaving our turf
/obj/structure/shuttle_decoration/wall_plate/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER
	if(leaving == src)
		return // Let's not block ourselves.
	if(!(direction & dir))
		return
	if (!density)
		return
	if (leaving.movement_type & (PHASING))
		return
	if (leaving.move_force >= MOVE_FORCE_EXTREMELY_STRONG)
		return
	leaving.Bump(src)
	return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/shuttle_decoration/wall_plate/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir != dir)
		return TRUE

/obj/structure/shuttle_decoration/wall_plate/CanPass(atom/movable/mover, border_dir)
	return (border_dir & dir) ? ..() : TRUE

/obj/structure/shuttle_decoration/wall_plate/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	return !density || (dir != to_dir)

/obj/structure/shuttle_decoration/wall_plate/gold_foil
	name = "gold foil wrapping"
	desc = "Gold foil insulation to keep the heat in (or out) of a ship or satellite."
	icon_state = "gold_foil"
	cut_plating = /obj/structure/hull_plating/gold_foil

/obj/structure/shuttle_decoration/wall_plate/gold_foil/diagonal
	icon_state = "gold_foil_diag"

/obj/structure/shuttle_decoration/wall_plate/silver_foil
	name = "silver foil wrapping"
	desc = "Silver foil insulation to keep the heat in (or out) of a ship or satellite."
	icon_state = "silver_foil"
	cut_plating = /obj/structure/hull_plating/silver_foil

/obj/structure/shuttle_decoration/wall_plate/silver_foil/diagonal
	icon_state = "silver_foil_diag"

/obj/structure/shuttle_decoration/wall_plate/nanocarbon
	name = "nanocarbon hull screen"
	desc = "A standoff screen of nanocarbon used typically for in atmosphere aerodynamics, or layered protection."
	icon_state = "nanocarbon"
	armor_type = /datum/armor/nanocarbon_anything
	max_integrity = 150
	cut_plating = /obj/structure/hull_plating/nanocarbon/floor
	keep_color = TRUE

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal
	icon_state = "nanocarbon_diag"

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/ex_act(severity, target)
	. = ..()
	if(severity >= EXPLODE_HEAVY)
		nanocarbon_nuke()
	return TRUE

/// Makes shards of nanocarbon
/obj/structure/shuttle_decoration/wall_plate/nanocarbon/proc/nanocarbon_nuke()
	var/random_shards = 2
	for(var/iteration in 1 to random_shards)
		var/obj/item/shard = new /obj/item/nanocarbon_shard(src)
		shard.pixel_x = rand(-6, 6)
		shard.pixel_y = rand(-6, 6)
		shard.color = color

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/primary_colour
	color = COLOR_SILVER

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/primary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_PRIMARY_COLOUR, TRAIT_GENERIC)

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/primary_colour
	color = COLOR_SILVER

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/primary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_PRIMARY_COLOUR, TRAIT_GENERIC)

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/secondary_colour
	color = COLOR_BROWN

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/secondary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_SECONDARY_COLOUR, TRAIT_GENERIC)

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/secondary_colour
	color = COLOR_BROWN

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/secondary_colour/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SHIP_SECONDARY_COLOUR, TRAIT_GENERIC)

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/black
	color = COLOR_DARK

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/black
	color = COLOR_DARK

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/standard
	color = COLOR_SILVER

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/standard
	color = COLOR_SILVER

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/red
	color = COLOR_BUBBLEGUM_RED

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/red
	color = COLOR_BUBBLEGUM_RED

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/green
	color = COLOR_IRISH_GREEN

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/green
	color = COLOR_IRISH_GREEN

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/blue
	color = COLOR_COMMAND_BLUE

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/blue
	color = COLOR_COMMAND_BLUE

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/yellow
	color = COLOR_GOLD

/obj/structure/shuttle_decoration/wall_plate/nanocarbon/diagonal/yellow
	color = COLOR_GOLD

/obj/structure/shuttle_decoration/wall_plate/armor
	name = "armor plating"
	desc = "Thick armor plating to protect ships from anything between asteroid impacts and weapons fire."
	icon_state = "armor"
	cut_plating = /obj/structure/hull_plating/armor_panels

/obj/structure/shuttle_decoration/wall_plate/armor/diagonal
	icon_state = "armor_diag"

/obj/structure/shuttle_decoration/wall_plate/plastamic
	name = "plastamic cladding"
	desc = "Polymer sheets used to cover a typically much uglier hull plate behind them."
	icon_state = "plastic"
	cut_plating = /obj/structure/hull_plating/plastamic_sheets
