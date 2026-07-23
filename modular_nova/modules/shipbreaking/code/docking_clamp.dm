/obj/effect/temp_visual/telegraphing/long_duration
	duration = 15 SECONDS

// Circuit and RND

/obj/item/circuitboard/machine/docking_clamp
	name = "Salvage Clamp"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/docking_clamp

/datum/design/board/salvage_docking_clamp
	name = "Salvage Clamp"
	desc = "A large clamp for holding shuttles in place without using their own power."
	id = "salvage_docking_clamp"
	build_path = /obj/item/circuitboard/machine/docking_clamp
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/mining/New()
	design_ids += list(
		"salvage_docking_clamp",
	)
	return ..()

// Everything else

/obj/machinery/docking_clamp
	name = "salvage clamp"
	desc = "A large clamp for holding shuttles in place without using their own power."
	icon = 'icons/obj/machines/floor.dmi'
	icon_state = "mass_driver"
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/docking_clamp
	/// The docking port we use to connect ships with
	var/obj/docking_port/stationary/salvage_dock/docking_port
	/// The computer the clamp is linked to
	var/datum/weakref/controller_ref

/obj/machinery/docking_clamp/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_rotation)
	var/static/list/tool_behaviors = list(
		TOOL_MULTITOOL = list(
			SCREENTIP_CONTEXT_LMB = "Get Link",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/obj/machinery/docking_clamp/Destroy(force)
	var/obj/machinery/computer/salvage_bay_controller/control_console = controller_ref?.resolve()
	if(control_console)
		control_console.delink_clamp()
		controller_ref = null
	if(docking_port)
		SSshuttle.stationary_docking_ports -= docking_port
		QDEL_NULL(docking_port)
	return ..()

/obj/machinery/docking_clamp/examine(mob/user)
	. = ..()
	if(!controller_ref?.resolve())
		. += span_notice("Use a [EXAMINE_HINT("multitool")] to connect this to a [EXAMINE_HINT("salvage bay control console")] before use.")
	if(!docking_port)
		. += span_notice("Interact with the clamp to set it up for docking, otherwise it will not function.")
		. += span_notice("The clamp requires a large space in front of it, indicated by holograms on setup.")
		. += span_notice("This space is [EXAMINE_HINT("[floor(/obj/docking_port/stationary/salvage_dock::width / 2)]")] tiles to either side of the clamp, and [EXAMINE_HINT("[/obj/docking_port/stationary/salvage_dock::height]")] tiles straight out.")

/obj/machinery/docking_clamp/multitool_act(mob/living/user, obj/item/multitool/the_tool)
	if(!panel_open)
		balloon_alert(user, "panel closed!")
		return ITEM_INTERACT_BLOCKING
	the_tool.set_buffer(src)
	balloon_alert(user, "saved to multitool buffer")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/docking_clamp/wrench_act(mob/living/user, obj/item/tool)
	if(!panel_open)
		balloon_alert(user, "panel closed!")
		return ITEM_INTERACT_BLOCKING
	if(!default_unfasten_wrench(user, tool, 4 SECONDS))
		return ITEM_INTERACT_BLOCKING
	if(!anchored)
		SSshuttle.stationary_docking_ports -= docking_port
		QDEL_NULL(docking_port)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/docking_clamp/screwdriver_act(mob/living/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/docking_clamp/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/docking_clamp/interact(mob/user)
	. = ..()
	if(!anchored)
		balloon_alert(user, "not secured!")
		return
	if(docking_port)
		balloon_alert(user, "unsetting...")
		if(!do_after(user, 3 SECONDS, src))
			return
		SSshuttle.stationary_docking_ports -= docking_port
		QDEL_NULL(docking_port)
		return
	balloon_alert(user, "setting clamp...")
	if(!do_after(user, 2 SECONDS, src))
		return
	var/turf/dock_location = get_step(src, dir)
	var/obj/docking_port/stationary/salvage_dock/temp_docking_port = new(dock_location, dir)
	var/list/docking_turfs = temp_docking_port.return_turfs()
	var/list/dock_bounds = temp_docking_port.return_coords()
	var/list/overlappers = SSshuttle.get_dock_overlap(dock_bounds[1], dock_bounds[2], dock_bounds[3], dock_bounds[4], z)
	if(length(overlappers)) // Overlappers list contains ourself as well
		for(var/obj/docksearch as anything in overlappers)
			if(docksearch == temp_docking_port)
				continue
			balloon_alert(user, "intersecting nearby dock!")
			temp_docking_port.Destroy(TRUE)
			return
	for(var/turf/checked_turf as anything in docking_turfs)
		if(checked_turf.x <= 10 || checked_turf.y <= 10 || checked_turf.x >= world.maxx - 10 || checked_turf.y >= world.maxy - 10)
			balloon_alert(user, "cannot place here!")
			new /obj/effect/temp_visual/telegraphing/long_duration(checked_turf)
			temp_docking_port.Destroy(TRUE)
			return
		var/area/turf_area = get_area(checked_turf)
		if(checked_turf.is_blocked_turf(TRUE) || !(turf_area.outdoors))
			balloon_alert(user, "dock not clear!")
			new /obj/effect/temp_visual/telegraphing/long_duration(checked_turf)
			temp_docking_port.Destroy(TRUE)
			return
		new /obj/effect/temp_visual/medical_holosign(checked_turf)
	docking_port = temp_docking_port

/// Scans the docking port area for if living mobs are present inside, TRUE means a mob is in the way (or we have no port?)
/obj/machinery/docking_clamp/proc/check_for_clear_bay()
	if(!docking_port)
		return TRUE // what ?? No
	var/list/docking_turfs = docking_port.return_turfs()
	for(var/turf/checked_turf as anything in docking_turfs)
		for(var/mob/living/living_mob in checked_turf.contents)
			return TRUE
	return FALSE

/obj/docking_port/stationary/salvage_dock
	name = "Salvage Dock"
	width = 31
	height = 19
	dwidth = 15

/obj/docking_port/stationary/salvage_dock/Initialize(mapload, dock_direction)
	setDir(dock_direction)
	. = ..()
