///Time taken to spawn a boulder, also the cooldown applied before the next manual teleportation
#define LRM_TELEPORTATION_TIME (1.5 SECONDS)
///Cooldown for automatic teleportation after processing boulders_processing_max number of boulders
#define LRM_BATCH_COOLDOWN (3 SECONDS)
///Special case when we are trying to teleport a boulder but there is already another boulder in our loc
#define LRM_TURF_BLOCKED_BY_BOULDER -1
///Failure to have boulders to pull from. To prevent the damned thing from bricking itself.
#define LRM_NO_BOULDER -2
///So they cant take boulders the BRM can.
#define LRM_UNSTABLE_BOULDER -3

/obj/machinery/lrm
	name = "Linked Retrieval Matrix"
	desc = "A teleportation matrix used to retrieve boulders from linked Boulder Storage Collector boxes."
	icon = 'modular_nova/modules/ghost_mining/icons/lrm.dmi'
	icon_state = "lrm"
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.5
	circuit = /obj/item/circuitboard/machine/lrm
	processing_flags = START_PROCESSING_MANUALLY
	anchored = TRUE
	density = TRUE

	/// How many boulders can we process maximum per loop?
	var/boulders_processing_max = 1
	/// Are we trying to actively collect boulders automatically?
	var/toggled_on = FALSE
	///Have we finished processing a full batch of boulders
	var/batch_processing = FALSE
	///Linked BSC's to collect from
	var/list/linked_bscs = list()

	/// Cooldown used for left click teleportation.
	COOLDOWN_DECLARE(manual_teleport_cooldown)
	/// Cooldown used for automatic teleportation after processing boulders_processing_max number of boulders.
	COOLDOWN_DECLARE(batch_start_cooldown)

/obj/machinery/lrm/Initialize(mapload)
	. = ..()
	register_context()

/obj/machinery/lrm/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE

	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "Teleport single boulder"
		context[SCREENTIP_CONTEXT_RMB] = "Toggle [toggled_on ? "Off" : "On"] automatic boulder retrieval"
		return CONTEXTUAL_SCREENTIP_SET

	if(!isnull(held_item))
		if(held_item.tool_behaviour == TOOL_WRENCH)
			context[SCREENTIP_CONTEXT_LMB] = "[anchored ? "Un" : ""]Anchor"
			return CONTEXTUAL_SCREENTIP_SET
		if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
			context[SCREENTIP_CONTEXT_LMB] = "[panel_open ? "Close" : "Open"] panel"
			return CONTEXTUAL_SCREENTIP_SET
		if(held_item.tool_behaviour == TOOL_MULTITOOL)
			context[SCREENTIP_CONTEXT_LMB] = "Link From Buffer"
			return CONTEXTUAL_SCREENTIP_SET
		else if(panel_open && held_item.tool_behaviour == TOOL_CROWBAR)
			context[SCREENTIP_CONTEXT_LMB] = "Deconstruct"
			return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/lrm/examine(mob/user)
	. = ..()
	var/rock_count = 0
	for(var/datum/weakref/num_collector in linked_bscs)
		var/obj/structure/ore_box/boulder_collector/collector = num_collector?.resolve()
		if(isnull(collector))
			continue
		rock_count += LAZYLEN(collector.available_boulders)

	var/link_count = length(linked_bscs)

	. += span_notice("The small screen reads there are [span_boldnotice("[rock_count] boulders")] available to teleport.")
	. += span_notice("The small screen reads there are [span_boldnotice("[link_count] collectors")] available to extract from.")
	. += span_notice("Can collect up to <b>[boulders_processing_max] boulders</b> at a time.")
	. += span_notice("Automatic boulder retrieval can be toggled [EXAMINE_HINT("[toggled_on ? "Off" : "On"]")] with [EXAMINE_HINT("Right Click")].")

	if(anchored)
		. += span_notice("It's [EXAMINE_HINT("anchored")] in place.")
	else
		. += span_warning("It needs to be [EXAMINE_HINT("anchored")] to start operations.")

	. += span_notice("Its maintenance panel can be [EXAMINE_HINT("screwed")] [panel_open ? "closed" : "open"].")

	if(panel_open)
		. += span_notice("The whole machine can be [EXAMINE_HINT("pried")] apart.")

/obj/machinery/lrm/update_icon_state()
	icon_state = initial(icon_state)

	if(!anchored || !is_operational || machine_stat & (BROKEN | NOPOWER) || panel_open)
		icon_state = "[icon_state]-off"
		return

	if(toggled_on)
		icon_state = "[icon_state]-toggled"
		return

	return ..()

/obj/machinery/lrm/wrench_act(mob/living/user, obj/item/tool)
	. = NONE
	if(default_unfasten_wrench(user, tool, time = 1.5 SECONDS) == SUCCESSFUL_UNFASTEN)
		return ITEM_INTERACT_SUCCESS

/obj/machinery/lrm/screwdriver_act(mob/living/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/lrm/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/lrm/multitool_act(mob/living/user, obj/item/multitool/buffer_holder)
	. = ..()
	if(!buffer_holder.buffer)
		balloon_alert_to_viewers("no connectable device detected!")
		return ITEM_INTERACT_SUCCESS
	if(!istype(buffer_holder.buffer, /obj/structure/ore_box/boulder_collector))
		balloon_alert_to_viewers("detected device is not connectable!")
		return ITEM_INTERACT_SUCCESS
	if(buffer_holder.buffer in linked_bscs)
		balloon_alert_to_viewers("machine already linked!")
		return ITEM_INTERACT_SUCCESS

	if(istype(buffer_holder.buffer, /obj/structure/ore_box/boulder_collector))
		linked_bscs += WEAKREF(buffer_holder.buffer)
		balloon_alert_to_viewers("collector connected to matrix!")
		return ITEM_INTERACT_SUCCESS


///To allow boulders on a conveyor belt to move unobstructed if multiple machines are made on a single line
/obj/machinery/lrm/CanAllowThrough(atom/movable/mover, border_dir)
	if(!anchored)
		return FALSE
	if(istype(mover, /obj/item/boulder/ghost_mining))
		return TRUE
	return ..()

/obj/machinery/lrm/RefreshParts()
	. = ..()

	boulders_processing_max = 0
	for(var/datum/stock_part/part in component_parts)
		boulders_processing_max += part.tier

	boulders_processing_max = ROUND_UP((boulders_processing_max / 12) * 7)

/obj/machinery/lrm/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(. || panel_open)
		return
	if(!handle_teleport_conditions(user))
		return

	var/result = pre_collect_boulder()
	if(result == LRM_TURF_BLOCKED_BY_BOULDER)
		balloon_alert(user, "no space!")
	else if(result == LRM_NO_BOULDER)
		balloon_alert(user, "no boulders!")
	else if(result)
		balloon_alert(user, "teleporting...")
	COOLDOWN_START(src, manual_teleport_cooldown, LRM_TELEPORTATION_TIME)

	return TRUE

/**
 * Handles qualifiers for enabling teleportation of boulders.
 * Returns TRUE if the teleportation can proceed, FALSE otherwise.
 * Arguments
 *
 * * mob/user - the mob to inform if conditions aren't met
 */

/obj/machinery/lrm/proc/handle_teleport_conditions(mob/user)
	if(!COOLDOWN_FINISHED(src, manual_teleport_cooldown))
		return FALSE
	if(panel_open)
		balloon_alert(user, "close panel first!")
		return FALSE
	if(batch_processing)
		balloon_alert(user, "batch still processing!")
		return FALSE
	playsound(src, 'sound/machines/mining/manual_teleport.ogg', 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	return TRUE

/obj/machinery/lrm/attack_ai(mob/user)
	. = ..()
	if(. || panel_open)
		return
	if(!handle_teleport_conditions(user))
		return

	var/result = pre_collect_boulder()
	if(result == LRM_TURF_BLOCKED_BY_BOULDER)
		balloon_alert(user, "no space!")
	else if(result == LRM_NO_BOULDER)
		balloon_alert(user, "no boulders!")
	else if(result == LRM_UNSTABLE_BOULDER)
		balloon_alert(user, "chosen boulder too unstable!")
	else if(result)
		balloon_alert(user, "teleporting...")

	COOLDOWN_START(src, manual_teleport_cooldown, LRM_TELEPORTATION_TIME)

	return TRUE

/obj/machinery/lrm/attack_robot(mob/user)
	. = ..()
	if(. || panel_open)
		return
	if(!handle_teleport_conditions(user))
		return

	var/result = pre_collect_boulder()
	if(result == LRM_TURF_BLOCKED_BY_BOULDER)
		balloon_alert(user, "no space!")
	else if(result == LRM_NO_BOULDER)
		balloon_alert(user, "no boulders!")
	else if(result == LRM_UNSTABLE_BOULDER)
		balloon_alert(user, "chosen boulder too unstable!")
	else if(result)
		balloon_alert(user, "teleporting...")

	COOLDOWN_START(src, manual_teleport_cooldown, LRM_TELEPORTATION_TIME)

	return TRUE

/obj/machinery/lrm/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN || panel_open)
		return
	if(!anchored)
		balloon_alert(user, "anchor it first!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	toggle_auto_on(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/**
 * Toggles automatic boulder retrieval on.
 * Adjusts the teleportation sound, icon state, and begins processing.
 * Arguments
 *
 * * mob/user - the player who has toggled us
 */
/obj/machinery/lrm/proc/toggle_auto_on(mob/user)
	if(panel_open)
		balloon_alert(user, "close panel first!")
		return
	if(!anchored)
		balloon_alert(user, "anchor it first!")
		return
	if(!is_operational || machine_stat & (BROKEN | NOPOWER))
		return

	toggled_on = ! toggled_on
	if(toggled_on)
		begin_processing()
	else
		end_processing()
	update_appearance(UPDATE_ICON_STATE)

/obj/machinery/lrm/attack_ai_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN || panel_open)
		return
	if(!anchored)
		balloon_alert(user, "unanchored!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	toggle_auto_on(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/lrm/attack_robot_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN || panel_open)
		return
	if(!user.can_perform_action(src, ALLOW_SILICON_REACH | FORBID_TELEKINESIS_REACH))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!anchored)
		balloon_alert(user, "unanchored!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	toggle_auto_on(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/lrm/process()
	if(!toggled_on)
		return PROCESS_KILL

	//have some cooldown after processing the previous batch of boulders
	if(batch_processing || !COOLDOWN_FINISHED(src, batch_start_cooldown))
		return

	pre_collect_boulder(FALSE, boulders_processing_max)

/**
 * Begins to collect a boulder from the available boulders list in SSore_generation.
 * Boulders must be in the available boulders list.
 * A selected boulder is picked randomly.
 * Arguments
 *
 * * feedback - should we play sound and display allert if now boulders are available
 * * boulders_remaining - how many boulders we want to try & collect spawning a boulder every LRM_TELEPORTATION_TIME seconds
 */

/obj/machinery/lrm/proc/pre_collect_boulder(feedback = TRUE, boulders_remaining = 1)
	batch_processing = TRUE

	//not within operation parameters
	if(!anchored || panel_open || !is_operational || machine_stat & (BROKEN | NOPOWER))
		batch_processing = FALSE
		return FALSE

	//There is an boulder in our loc. it has be removed so we don't clog up our loc with even more boulders
	if(locate(/obj/item/boulder/ghost_mining) in loc)
		batch_processing = FALSE
		return LRM_TURF_BLOCKED_BY_BOULDER

	//check boxes for boulders
	var/list/holding_boxes = list()
	for(var/datum/weakref/possible_collector_ref in linked_bscs) //Search list for candidates
		var/obj/structure/ore_box/boulder_collector/possible_collector = possible_collector_ref?.resolve() //resolve for actual item
		if(isnull(possible_collector)) //pruning dead ends
			linked_bscs -= possible_collector_ref
			continue
		if(LAZYLEN(possible_collector.available_boulders) >= 1)
			holding_boxes += possible_collector_ref

	//no boulders in boxes
	if(!length(holding_boxes))
		batch_processing = FALSE
		return LRM_NO_BOULDER

	//pick & spawn the boulder
	flick("lrm-flash", src)
	playsound(src, toggled_on ? 'sound/machines/mining/auto_teleport.ogg' : 'sound/machines/mining/manual_teleport.ogg', 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

	var/datum/weakref/collector_ref = pick(holding_boxes)
	var/obj/structure/ore_box/boulder_collector/collector = collector_ref?.resolve()
	var/datum/weakref/chosen_rock_ref = pick(collector.available_boulders)
	var/obj/item/boulder/chosen_rock = chosen_rock_ref?.resolve()

	//If boulder is BRM'able, refuse.
	if(isnull(chosen_rock) || chosen_rock.brm_stable)

		batch_processing = FALSE
		balloon_alert_to_viewers("Boulder outside parameters!")
		return LRM_UNSTABLE_BOULDER

	chosen_rock.forceMove(drop_location())
	chosen_rock.pixel_x = rand(-2, 2)
	chosen_rock.pixel_y = rand(-2, 2)
	LAZYREMOVE(collector.available_boulders, chosen_rock_ref)
	balloon_alert_to_viewers("boulder appears!")
	use_energy(active_power_usage)

	//try again if we have more boulders to work with
	boulders_remaining -= 1
	if(boulders_remaining <= 0)
		COOLDOWN_START(src, batch_start_cooldown, LRM_BATCH_COOLDOWN)
		batch_processing = FALSE
		return TRUE
	else
		addtimer(CALLBACK(src, PROC_REF(pre_collect_boulder), feedback, boulders_remaining), LRM_TELEPORTATION_TIME, TIMER_STOPPABLE | TIMER_DELETE_ME)

// Circuit Board

/obj/item/circuitboard/machine/lrm
	name = "Linked Retrieval Matrix"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/lrm
	req_components = list(
		/datum/stock_part/capacitor = 1,
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/micro_laser = 1,
	)

///Beacon to launch a new mining setup when activated. For testing and speed!
/obj/item/boulder_beacon/lrm
	name = "\improper T.I. boulder beacon"
	desc = "Tarkon Industries brand mining beacon. Used for local mining operations and colony startups."

/obj/item/boulder_beacon/lrm/launch_payload()
	playsound(src, SFX_SPARKS, 80, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	switch(uses)
		if(3)
			new /obj/machinery/lrm(drop_location())
		if(2)
			new /obj/machinery/bouldertech/refinery(drop_location())
		if(1)
			new /obj/machinery/bouldertech/refinery/smelter(drop_location())
			qdel(src)
	uses--

#undef LRM_TELEPORTATION_TIME
#undef LRM_BATCH_COOLDOWN
#undef LRM_TURF_BLOCKED_BY_BOULDER
#undef LRM_NO_BOULDER
#undef LRM_UNSTABLE_BOULDER
