/obj/structure/engine_covers
	abstract_type = /obj/structure/engine_covers
	icon = 'modular_nova/modules/shipbreaking/icons/exterior.dmi'
	icon_state = null
	flags_1 = ON_BORDER_1
	obj_flags = CAN_BE_HIT | IGNORE_DENSITY
	density = FALSE
	anchored = TRUE
	pass_flags_self = LETPASSTHROW|PASSSTRUCTURE
	armor_type = /datum/armor/nanocarbon_anything
	max_integrity = 150
	layer = ABOVE_OBJ_LAYER
	inertia_force_weight = 2
	/// How long to unweld
	var/unfasten_time = 1 SECONDS

/obj/structure/engine_covers/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_RECYCLE_LIKE_ITEM, TRAIT_GENERIC)
	AddElement(/datum/element/simple_rotation, ROTATION_NEEDS_ROOM)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_exit),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	register_context()

/obj/structure/engine_covers/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		return NONE
	if(held_item.tool_behaviour == TOOL_WELDER)
		context[SCREENTIP_CONTEXT_LMB] = anchored ? "Unsecure" : "Secure"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/engine_covers/examine(mob/user)
	. = ..()
	. += span_notice("You can [anchored ? "unsecure" : "secure"] it with a welding tool.")

/obj/structure/engine_covers/welder_act(mob/living/user, obj/item/tool)
	if(!tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return ITEM_INTERACT_FAILURE
	balloon_alert(user, anchored ? "cutting..." : "securing...")
	if(!tool.use_tool(src, user, unfasten_time, amount = 1, volume=50))
		return ITEM_INTERACT_BLOCKING
	set_anchored(!anchored)
	return ITEM_INTERACT_SUCCESS

/// Determines what to do when something is leaving our turf
/obj/structure/engine_covers/proc/on_exit(datum/source, atom/movable/leaving, direction)
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

/obj/structure/engine_covers/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir != dir)
		return TRUE

/obj/structure/engine_covers/CanPass(atom/movable/mover, border_dir)
	return (border_dir & dir) ? ..() : TRUE

/obj/structure/engine_covers/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	return !density || (dir != to_dir)

/obj/structure/engine_covers/can_atmos_pass(turf/the_turf, vertical = FALSE)
	if(get_dir(loc, the_turf) == dir)
		return !density
	else
		return TRUE

/obj/structure/engine_covers/thruster_nozzle
	name = "thruster nozzle"
	desc = "A protective nozzle for shuttle engines, to keep debris from getting inside the combustion chamber."
	icon_state = "nozzle"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
	)

/obj/structure/engine_covers/heater_cover
	name = "engine cover"
	desc = "A protective cover for engine components, as well as a barrier to prevent atmosphere escape."
	icon_state = "engine_plate"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
	)

/obj/structure/engine_covers/ion_plate
	name = "ion plate"
	desc = "An orbital engine using extremely high voltages and a bit of lead for good luck to propel ships without \
		needing to use expensive chemical fuels."
	icon_state = "ion_plate"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT,
	)
