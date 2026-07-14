/obj/structure/shuttle_decoration
	abstract_type = /obj/structure/shuttle_decoration
	icon = 'modular_nova/modules/shipbreaking/icons/exterior.dmi'
	obj_flags = CAN_BE_HIT | IGNORE_DENSITY
	density = FALSE
	anchored = TRUE
	pass_flags_self = LETPASSTHROW|PASSSTRUCTURE
	armor_type = /datum/armor/structure_railing
	max_integrity = 75
	layer = LOW_ITEM_LAYER
	/// How long to either unwrench or unweld
	var/unfasten_time = 1 SECONDS
	/// Does this need to be welded off the wall, instead of using a wrench
	var/requires_welder = FALSE
	/// If this shuttle piece is large and pixel shifted and shouldn't be destroyed by shuttlerotate
	var/shuttles_wont_pixelshift = FALSE
	/// Will this reset its pixel shifting when unanchored
	var/resets_pixelshifting = TRUE

/obj/structure/shuttle_decoration/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_RECYCLE_LIKE_ITEM, TRAIT_GENERIC)
	AddElement(/datum/element/simple_rotation, ROTATION_NEEDS_ROOM)
	find_and_mount_on_atom()
	register_context()

/obj/structure/shuttle_decoration/shuttleRotate(rotation, params)
	if(shuttles_wont_pixelshift)
		params &= ~ROTATE_OFFSET
	return ..()

/obj/structure/shuttle_decoration/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		return NONE
	if(requires_welder)
		if(held_item.tool_behaviour == TOOL_WELDER)
			context[SCREENTIP_CONTEXT_LMB] = anchored ? "Unsecure" : "Secure"
			return CONTEXTUAL_SCREENTIP_SET
	else
		if(held_item.tool_behaviour == TOOL_WRENCH)
			context[SCREENTIP_CONTEXT_LMB] = anchored ? "Unsecure" : "Secure"
			return CONTEXTUAL_SCREENTIP_SET

/obj/structure/shuttle_decoration/examine(mob/user)
	. = ..()
	if(requires_welder)
		. += span_notice("Can be removed by cutting it off.")
	else
		. += span_notice("Can be removed by unfastening it.")

/obj/structure/shuttle_decoration/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(requires_welder)
		return NONE
	default_unfasten_wrench(user, tool, time = unfasten_time)
	if(resets_pixelshifting)
		SET_BASE_PIXEL(0, 0)
	return ITEM_INTERACT_SUCCESS

/obj/structure/shuttle_decoration/welder_act(mob/living/user, obj/item/tool)
	if(!requires_welder)
		return NONE
	balloon_alert(user, anchored ? "cutting..." : "securing...")
	if(!tool.use_tool(src, user, unfasten_time, amount = 1, volume=50))
		return ITEM_INTERACT_BLOCKING
	set_anchored(!anchored)
	if(anchored)
		find_and_mount_on_atom()
		if(resets_pixelshifting)
			SET_BASE_PIXEL(initial(base_pixel_x), initial(base_pixel_y))
	else if(resets_pixelshifting)
		SET_BASE_PIXEL(0, 0)
	return ITEM_INTERACT_SUCCESS
