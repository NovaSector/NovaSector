/// How long admins have to respond before a request is approved automatically.
#define EMERGENCY_NODE_APPROVAL_TIME (2 MINUTES)
/// How long new requests are blocked after an admin denies one.
#define EMERGENCY_NODE_DENIAL_COOLDOWN (10 MINUTES)
/// Requests are refused when more than this many living, non-AFK humans are in the round.
#define EMERGENCY_NODE_MAX_ACTIVE_PLAYERS 10
/// How long the landing marker shows before the pod falls, so ghosts have time to get there.
#define EMERGENCY_NODE_POD_TRANSIT_TIME (15 SECONDS)

#define EMERGENCY_NODE_STATE_IDLE "idle"
#define EMERGENCY_NODE_STATE_PENDING "pending"
#define EMERGENCY_NODE_STATE_DEPLOYED "deployed"

/// Deadpop power generator, no setup needed. A little self indulgent? Maybe.
/obj/machinery/power/rtg/emergency_node
	name = "emergency energy node"
	desc = "The Station Quick-deploy Unattended Emergency Energy Node, or SQUEEN for short. \
		Dropped in when a skeleton crew has nobody to run the engine."
	circuit = null
	can_buckle = FALSE
	affected_by_parts = FALSE
	power_gen = 2 MEGA WATTS
	cable_layer = CABLE_LAYER_ALL
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/power/rtg/emergency_node/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, /obj/item/flatpacked_machine/emergency_node, 2 SECONDS)
	AddElement(/datum/element/tool_blocker, TOOL_SCREWDRIVER)
	AddElement(/datum/element/tool_blocker, TOOL_CROWBAR)

/obj/machinery/power/rtg/emergency_node/process()
	// Also covers the pod landing and cables being cut and relaid.
	if(isnull(powernet))
		connect_to_network()
	return ..()

/obj/machinery/power/rtg/emergency_node/should_have_node()
	return TRUE

/obj/machinery/power/rtg/emergency_node/examine(mob/user)
	. = ..()
	if(powernet)
		. += span_notice("It is connected to the power grid.")
	else
		. += span_warning("It has no cable to feed. Lay a cable beneath it to restore output.")

/// The carryable form of the node, made by repacking it.
/obj/item/flatpacked_machine/emergency_node
	name = "flat-packed emergency energy node"
	desc = /obj/machinery/power/rtg/emergency_node::desc
	icon_state = "rtg_packed"
	type_to_deploy = /obj/machinery/power/rtg/emergency_node
	custom_materials = null
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/flatpacked_machine/emergency_node/give_manufacturer_examine()
	return

/**
 * Where the node lands on each map, keyed by the map_name in _maps/map_jsons.
 *
 * Format: "Map Name" = list(x, y, z)
 * A map left as null cannot request a node.
 *
 * Use the z shown in-game, not the z-level index from a map editor. Usually the map editor z+1 since CC loads on Z 1.
 * The tile must be on the station, must not be a wall, and must have a cable on the station's main grid.
 * The node is dense, so avoid tiles that would block a door or a narrow hallway.
 */
GLOBAL_LIST_INIT(emergency_node_drop_sites, list(
	"Blueshift" = list(123, 53, 2),
	"Delta Station" = list(91, 116, 2),
	"Ice Box Station" = list(113, 72, 4),
	"Kilo Station" = list(144, 77, 2),
	"MetaStation" = list(160, 154, 2),
	"MetaStation (Event Mode)" = list(160, 154, 2),
	"NebulaStation" = list(115, 104, 2),
	"NorthStar" = list(174, 122, 2),
	"Ouroboros" = list(128, 170, 2),
	"Pubby Station" = list(122, 95, 2),
	"SerenityStation" = list(153, 92, 3),
	"Snowglobe Station" = list(131, 89, 4),
	"Tramstation" = list(112, 97, 2),
	"Void Raptor" = list(142, 58, 2),
))

GLOBAL_DATUM_INIT(emergency_node_dispatch, /datum/emergency_node_dispatch, new)

GAME_VERB_DESC(/mob/living, request_emergency_power, "Request Emergency Power", "Ask for an emergency energy node when nobody is available to run the engine.", "IC")
	GLOB.emergency_node_dispatch.submit_request(src)

/// Tracks the round's node request from the player verb through admin review to the drop.
/datum/emergency_node_dispatch
	/// Where the current request is in its lifecycle.
	var/state = EMERGENCY_NODE_STATE_IDLE
	/// Increments per request, so an old admin link cannot resolve a newer request.
	var/request_id = 0
	/// Timer that approves the pending request.
	var/approval_timer
	/// key_name of whoever made the pending request, for logs.
	var/requester_name
	/// ckey of whoever made the pending request, so they can be told the outcome.
	var/requester_ckey
	COOLDOWN_DECLARE(denial_cooldown)

/// Returns the drop turf for the current map, or null if it is unset or unusable.
/datum/emergency_node_dispatch/proc/get_drop_turf()
	var/list/coords = GLOB.emergency_node_drop_sites[SSmapping.current_map.map_name]
	if(length(coords) != 3)
		return null
	var/turf/drop_turf = locate(coords[1], coords[2], coords[3])
	if(isnull(drop_turf) || !is_station_level(drop_turf.z) || isclosedturf(drop_turf))
		return null
	if(isnull(drop_turf.get_cable_node(CABLE_LAYER_ALL)))
		return null
	return drop_turf

/// Returns why this user cannot make a request right now, or null if they can.
/datum/emergency_node_dispatch/proc/get_refusal(mob/living/user)
	if(!SSticker.HasRoundStarted())
		return "The shift hasn't started yet."
	if(user.stat != STABLE)
		return "You can't do that right now."
	if(state == EMERGENCY_NODE_STATE_PENDING)
		return "An emergency power request is already awaiting a response."
	if(state == EMERGENCY_NODE_STATE_DEPLOYED)
		return "An emergency energy node has already been sent this shift."
	if(!COOLDOWN_FINISHED(src, denial_cooldown))
		return "The last request was denied. Try again in [DisplayTimeText(COOLDOWN_TIMELEFT(src, denial_cooldown))]."
	if(get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE) > EMERGENCY_NODE_MAX_ACTIVE_PLAYERS)
		return "There's enough crew aboard to run the engine."
	if(isnull(get_drop_turf()))
		return "No usable emergency power drop site is available on this station."
	return null

/// Handles the player verb: confirms, then opens the admin review window.
/datum/emergency_node_dispatch/proc/submit_request(mob/living/user)
	var/refusal = get_refusal(user)
	if(refusal)
		to_chat(user, span_warning(refusal))
		return

	var/choice = tgui_alert(user, "Request an emergency energy node? Only do this if nobody can run the engine. \
		It lands automatically in [DisplayTimeText(EMERGENCY_NODE_APPROVAL_TIME)] unless an admin denies it.", "Request Emergency Power", list("Request", "Cancel"))
	if(choice != "Request" || QDELETED(user))
		return

	// The prompt can stay open for a while, so check everything again.
	refusal = get_refusal(user)
	if(refusal)
		to_chat(user, span_warning(refusal))
		return

	state = EMERGENCY_NODE_STATE_PENDING
	request_id++
	requester_name = key_name(user)
	requester_ckey = user.ckey
	approval_timer = addtimer(CALLBACK(src, PROC_REF(on_approval_timeout)), EMERGENCY_NODE_APPROVAL_TIME, TIMER_STOPPABLE)

	to_chat(user, span_notice("Your request has been sent. The node will launch in [DisplayTimeText(EMERGENCY_NODE_APPROVAL_TIME)] unless it is denied."))
	user.log_message("requested an emergency energy node.", LOG_GAME)
	notify_admins(user)

/// Sends admins the request with its approve and deny links.
/datum/emergency_node_dispatch/proc/notify_admins(mob/living/user)
	var/turf/drop_turf = get_drop_turf()
	var/link_base = "byond://?src=[REF(src)];[HrefToken(forceGlobal = TRUE)];emergency_node_request=[request_id];emergency_node_action"
	to_chat(GLOB.admins,
		span_adminnotice("<b><font color=orange>EMERGENCY POWER REQUEST:</font></b> [ADMIN_LOOKUPFLW(user)] requested an emergency energy node, \
			landing at [ADMIN_COORDJMP(drop_turf)]. It will launch automatically in [DisplayTimeText(EMERGENCY_NODE_APPROVAL_TIME)]. \
			(<a href='[link_base]=approve'>APPROVE</a>) (<a href='[link_base]=deny'>DENY</a>)"),
		type = MESSAGE_TYPE_PRAYER)
	for(var/client/admin_client as anything in GLOB.admins)
		if(admin_client.prefs.toggles & SOUND_ADMINHELP)
			window_flash(admin_client, ignorepref = TRUE)
			SEND_SOUND(admin_client, sound('sound/effects/gong.ogg'))

/datum/emergency_node_dispatch/Topic(href, href_list)
	. = ..()
	if(!href_list["emergency_node_action"] || !check_rights(R_ADMIN))
		return
	if(!usr.client.holder.CheckAdminHref(href, href_list))
		return
	if(state != EMERGENCY_NODE_STATE_PENDING || text2num(href_list["emergency_node_request"]) != request_id)
		to_chat(usr, span_warning("That emergency power request has already been resolved."))
		return

	switch(href_list["emergency_node_action"])
		if("approve")
			deltimer(approval_timer)
			log_admin("[key_name(usr)] approved the emergency power request from [requester_name].")
			message_admins("[key_name_admin(usr)] approved the emergency power request from [requester_name].")
			launch()
		if("deny")
			deny(usr)

/// Cancels the pending request and starts the denial cooldown.
/datum/emergency_node_dispatch/proc/deny(mob/admin)
	deltimer(approval_timer)
	approval_timer = null
	state = EMERGENCY_NODE_STATE_IDLE
	COOLDOWN_START(src, denial_cooldown, EMERGENCY_NODE_DENIAL_COOLDOWN)
	log_admin("[key_name(admin)] denied the emergency power request from [requester_name].")
	message_admins("[key_name_admin(admin)] denied the emergency power request from [requester_name].")
	notify_requester(span_warning("Your emergency power request was denied."))

/datum/emergency_node_dispatch/proc/on_approval_timeout()
	log_admin("The emergency power request from [requester_name] was approved automatically after no admin response.")
	message_admins("The emergency power request from [requester_name] was approved automatically after no admin response.")
	launch()

/// Sends the pod, or returns to idle if the drop site somehow stopped being usable during review. (This is what we call a bad day for engineering.)
/datum/emergency_node_dispatch/proc/launch()
	approval_timer = null
	var/turf/drop_turf = get_drop_turf()
	if(isnull(drop_turf))
		state = EMERGENCY_NODE_STATE_IDLE
		log_game("Emergency node launch aborted: the drop site on [SSmapping.current_map.map_name] is no longer usable.")
		message_admins("Emergency node launch aborted: the drop site on [SSmapping.current_map.map_name] is no longer usable.")
		notify_requester(span_warning("The emergency node launch was aborted because its landing site is damaged. Repair the wiring and try again."))
		return

	// Since we can repack it, we'll need to track some way to make sure we don't end up with duplicates.
	state = EMERGENCY_NODE_STATE_DEPLOYED
	podspawn(list(
		"target" = drop_turf,
		"path" = /obj/structure/closet/supplypod/centcompod,
		"spawn" = /obj/machinery/power/rtg/emergency_node,
		"delays" = list(POD_TRANSIT = EMERGENCY_NODE_POD_TRANSIT_TIME, POD_FALLING = 4, POD_OPENING = 30, POD_LEAVING = 30),
	))
	log_game("An emergency energy node was launched to [AREACOORD(drop_turf)].")
	priority_announce("An emergency energy node has been launched to [get_area_name(drop_turf, TRUE)] to support your reduced crew. ETA: 15 seconds. Please remember to adjust the station's SMES units accordingly.", "Emergency Power Dispatch")
	// Everyone likes watching drop pods.
	var/static/mutable_appearance/landing_marker = mutable_appearance('icons/obj/supplypods_32x32.dmi', "LZ")
	notify_ghosts(
		"An emergency energy node is dropping into [get_area_name(drop_turf, TRUE)]!",
		source = drop_turf,
		header = "Emergency Power Inbound",
		alert_overlay = landing_marker,
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
	)

/// Messages the requesting player if they are still connected and something bad has happened.
/datum/emergency_node_dispatch/proc/notify_requester(message)
	var/client/requester_client = GLOB.directory[requester_ckey]
	if(requester_client)
		to_chat(requester_client, message)


#undef EMERGENCY_NODE_APPROVAL_TIME
#undef EMERGENCY_NODE_DENIAL_COOLDOWN
#undef EMERGENCY_NODE_MAX_ACTIVE_PLAYERS
#undef EMERGENCY_NODE_POD_TRANSIT_TIME
#undef EMERGENCY_NODE_STATE_IDLE
#undef EMERGENCY_NODE_STATE_PENDING
#undef EMERGENCY_NODE_STATE_DEPLOYED
