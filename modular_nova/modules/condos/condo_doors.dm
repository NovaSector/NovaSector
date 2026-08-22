// Subtype that mimics more traditional airlocks.
/turf/closed/indestructible/hoteldoor/fakedoor
	name = "Condo Door"
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	icon_state = "fake_door"
	leave_message = "Are you ready to leave the Condo? If all occupants vacate; it'll be reset and anything you leave behind'll be lost!"
	/// What kind of turf should be visually represented under this door?
	var/turf/floor_to_copy = /turf/open/floor/plating

/turf/closed/indestructible/hoteldoor/fakedoor/Initialize(mapload)
	. = ..()
	underlays += mutable_appearance(initial(floor_to_copy.icon), initial(floor_to_copy.icon_state), initial(floor_to_copy.layer), offset_spokesman = src, plane = FLOOR_PLANE)

/turf/closed/indestructible/hoteldoor/fakedoor/public
	icon = /obj/machinery/door/airlock/public::icon
	icon_state = "closed"
	opacity = FALSE
	floor_to_copy = /turf/open/floor/iron

/turf/closed/indestructible/hoteldoor/fakedoor/travel_tile
	name = "Travel Tile"
	icon = 'icons/effects/effects.dmi'
	icon_state = "target_tile"
	floor_to_copy = /turf/open/misc/dirt/jungle

// ============================================================================
//  Room management panel - the owner Ctrl-clicks their door to open it.
// ============================================================================
/turf/closed/indestructible/hoteldoor
	/// The room this door belongs to (set by link_condo_turfs).
	var/datum/condo_room/condo_room
	// Ctrl-click works while lying down, and never falls through to a pull attempt on this turf
	// (turfs have no can_be_pulled(), which runtimed).
	interaction_flags_click = ALLOW_RESTING

/turf/closed/indestructible/hoteldoor/click_ctrl(mob/user)
	if(condo_room?.is_owner(user))
		ui_interact(user)
		return CLICK_ACTION_SUCCESS
	// block instead of falling through to the (turf-invalid) pull path
	return CLICK_ACTION_BLOCKING

/turf/closed/indestructible/hoteldoor/ui_state(mob/user)
	return GLOB.physical_state

/turf/closed/indestructible/hoteldoor/ui_interact(mob/user, datum/tgui/ui)
	if(!condo_room?.is_owner(user))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CondoManage", "Room Management")
		ui.open()

/turf/closed/indestructible/hoteldoor/ui_static_data(mob/user)
	var/list/data = list()
	var/list/ambience_names = list()
	for(var/ambience_name in GLOB.condo_ambiences)
		ambience_names += ambience_name
	data["ambiences"] = ambience_names
	return data

/turf/closed/indestructible/hoteldoor/ui_data(mob/user)
	var/list/data = list()
	if(!condo_room)
		return data
	data["name"] = condo_room.display_name
	data["private"] = condo_room.private
	data["has_password"] = !!condo_room.password
	data["brightness"] = condo_room.brightness
	data["lamp_color"] = condo_room.lamp_color
	data["ambience"] = condo_room.ambience
	var/list/invited = list()
	for(var/inv_ckey in condo_room.invited)
		invited += list(list("ckey" = inv_ckey, "name" = condo_room.invited[inv_ckey]))
	data["invited"] = invited
	return data

/turf/closed/indestructible/hoteldoor/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	if(!condo_room?.is_owner(ui.user))
		return TRUE
	switch(action)
		if("set_brightness")
			condo_room.brightness = clamp(round(text2num(params["value"])), 0, 3)
			condo_room.apply_lights()
			return TRUE
		if("set_color")
			condo_room.lamp_color = condo_sanitize_lamp_color(params["value"])
			condo_room.apply_lights()
			return TRUE
		if("pick_color")
			var/picked = input(ui.user, "Pick a lamp color", "Lamp Color", condo_room.lamp_color || "#ffffff") as color|null
			if(picked)
				condo_room.lamp_color = picked
				condo_room.apply_lights()
			return TRUE
		if("set_ambience")
			condo_room.ambience = params["value"]
			condo_room.apply_ambience()
			return TRUE
		if("set_private")
			condo_room.private = params["value"]
			return TRUE
		if("set_password")
			condo_room.password = params["value"] // raw - only ever compared, never shown
			return TRUE
		if("rename")
			var/new_name = sanitize(params["value"])
			if(new_name)
				condo_room.display_name = new_name
				var/area/misc/condo/room_area = get_area(src)
				if(istype(room_area))
					room_area.name = new_name
			return TRUE
		if("invite")
			var/who = condo_room.invite_by_name(params["name"])
			if(who)
				to_chat(ui.user, span_notice("Invited [who]."))
			else
				to_chat(ui.user, span_warning("No online player is playing '[params["name"]]'."))
			return TRUE
		if("uninvite")
			condo_room.uninvite(params["ckey"])
			return TRUE
