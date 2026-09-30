/obj/structure/window/fulltile/salvage_shuttle
	name = "shuttle window"
	desc = "A high-strength shuttle window to allow visibility outside of every ship too cheap for cameras."
	icon = 'modular_nova/modules/shipbreaking/icons/smooth/shuttle_window.dmi'
	icon_state = "shuttle_window-0"
	base_icon_state = "shuttle_window"
	fulltile = TRUE
	smoothing_groups = SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_TITANIUM_WALLS
	canSmoothWith = SMOOTH_GROUP_AIRLOCK+ SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_CLOSED_TURFS
	max_integrity = 200
	glass_type = /obj/structure/hull_plating/window
	glass_amount = 1

/obj/structure/window/fulltile/salvage_shuttle/Initialize(mapload, direct)
	. = ..()
	var/static/list/tool_behaviors = list(
		TOOL_WELDER = list(
			SCREENTIP_CONTEXT_RMB = "Cut Window",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/obj/structure/window/fulltile/salvage_shuttle/examine(mob/user)
	. = ..()
	. += span_notice("It can be cut out of its frame by [EXAMINE_HINT("Right-Clicking")] with a welding tool of some kind.")

/obj/structure/window/fulltile/salvage_shuttle/welder_act_secondary(mob/living/user, obj/item/tool)
	if(!tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return ITEM_INTERACT_FAILURE
	balloon_alert(user, "cutting...")
	if(!tool.use_tool(src, user, 4 SECONDS, amount = 1, volume=50))
		return ITEM_INTERACT_BLOCKING
	new glass_type(get_turf(src))
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/structure/hull_plating/window
	name = "cut shuttle window"
	desc = "The glass of a shuttle window, cut out of its frame."
	icon = 'modular_nova/modules/shipbreaking/icons/smooth/smooth_misc.dmi'
	icon_state = "window"
	armor_type = /datum/armor/structure_window
	custom_materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
	)
