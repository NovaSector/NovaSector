/obj/structure/titanium_structure
	name = "titanium framing"
	desc = "A large skeleton made of titanium steel that makes up the outer structure of most ships"
	icon = 'modular_nova/modules/shipbreaking/icons/smooth/girder_titan.dmi'
	icon_state = "girder_titan-0"
	base_icon_state = "girder_titan"
	anchored = TRUE
	density = TRUE
	max_integrity = 200
	rad_insulation = RAD_VERY_LIGHT_INSULATION
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_GIRDER
	canSmoothWith = SMOOTH_GROUP_GIRDER + SMOOTH_GROUP_WALLS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 1,
	)

/obj/structure/titanium_structure/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_RECYCLE_LIKE_ITEM, TRAIT_GENERIC)
	register_context()

/obj/structure/titanium_structure/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		return NONE
	if(held_item.tool_behaviour == TOOL_WELDER)
		context[SCREENTIP_CONTEXT_LMB] = anchored ? "Unsecure" : "Secure"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/titanium_structure/examine(mob/user)
	. = ..()
	. += span_notice("Can be removed by cutting it off.")

/obj/structure/titanium_structure/welder_act(mob/living/user, obj/item/tool)
	if(!tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return ITEM_INTERACT_FAILURE
	balloon_alert(user, anchored ? "cutting..." : "securing...")
	if(!tool.use_tool(src, user, 2 SECONDS, amount = 1, volume=50))
		return ITEM_INTERACT_BLOCKING
	set_anchored(!anchored)
	return ITEM_INTERACT_SUCCESS
