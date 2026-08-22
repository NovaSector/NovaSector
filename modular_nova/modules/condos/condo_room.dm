/// Access check results for entering a room - local, #undef'd at the bottom of this file.
#define CONDO_ACCESS_OK "ok"
#define CONDO_ACCESS_PASSWORD "password" // private, has a password you can try
#define CONDO_ACCESS_DENIED "denied" // private invite-only and you're not on the list

/// One active condo room: its loaded reservation, who owns it, who can get in, and its settings.
/// Players never see the id - rooms are picked from a list, not by number.
/datum/condo_room
	/// Hidden unique key.
	var/id
	/// Display label, e.g. "Furboy's room". Doesn't have to be unique.
	var/display_name
	var/owner_ckey
	var/owner_name
	/// FALSE = anyone can enter. TRUE = owner + invited ckeys + (password if one is set).
	var/private = FALSE
	/// Optional password for private rooms.
	var/password
	/// Invited players: ckey -> their character name (so the panel can show who's invited).
	var/list/invited = list()
	var/datum/map_template/condo/template
	var/datum/turf_reservation/condo/reservation
	/// Lighting/ambience choices, re-appliable and editable from the door panel.
	var/brightness = 2
	var/lamp_color
	var/ambience

/datum/condo_room/Destroy()
	template = null
	reservation = null
	invited = null
	return ..()

/// How this mob may enter: OK / needs PASSWORD / DENIED.
/datum/condo_room/proc/access_for(mob/user)
	if(!private)
		return CONDO_ACCESS_OK
	var/user_ckey = user?.ckey
	if(user_ckey && ((user_ckey == owner_ckey) || (user_ckey in invited)))
		return CONDO_ACCESS_OK
	if(password)
		return CONDO_ACCESS_PASSWORD
	return CONDO_ACCESS_DENIED

/// Tries to warp a mob in, prompting for the password if the room is locked. Returns TRUE if
/// they got in (so the teleporter UI can close). Keeps all CONDO_ACCESS_* use in this file.
/datum/condo_room/proc/try_enter(mob/user)
	switch(access_for(user))
		if(CONDO_ACCESS_OK)
			SScondos.warp_into_room(src, user)
			return TRUE
		if(CONDO_ACCESS_PASSWORD)
			var/tried = tgui_input_text(user, "This room is locked. Enter the password:", "Password", encode = FALSE, max_length = 42)
			if(isnull(tried))
				return FALSE
			if(tried == password)
				SScondos.warp_into_room(src, user)
				return TRUE
			to_chat(user, span_warning("Wrong password."))
			return FALSE
		if(CONDO_ACCESS_DENIED)
			to_chat(user, span_warning("\The [display_name] is invite-only."))
	return FALSE

/// TRUE if this mob owns the room (used to gate the door management panel).
/datum/condo_room/proc/is_owner(mob/user)
	return user?.ckey && (user.ckey == owner_ckey)

/// Adds an online player (found by character name) to the invite list. Returns their name or null.
/datum/condo_room/proc/invite_by_name(char_name)
	if(!char_name)
		return null
	for(var/client/connected as anything in GLOB.clients)
		var/mob/their_mob = connected.mob
		if(their_mob?.real_name == char_name && connected.ckey)
			invited[connected.ckey] = their_mob.real_name
			return their_mob.real_name
	return null

/datum/condo_room/proc/uninvite(invited_ckey)
	invited -= invited_ckey

/// A valid "#rrggbb" lamp color or "" (default) - never trusts a raw client string.
/proc/condo_sanitize_lamp_color(color)
	var/static/regex/hex_color = regex(@"^#[0-9a-fA-F]{6}$")
	return (color && hex_color.Find(color)) ? color : ""

/// Applies the stored brightness (0 = off, 1..3 = dim->bright) + lamp color to every light.
/datum/condo_room/proc/apply_lights()
	if(!reservation)
		return
	var/color = condo_sanitize_lamp_color(lamp_color)
	var/level = clamp(round(brightness), 0, 3)
	var/lights_off = (level <= 0)
	var/static/list/power_steps = list(0.5, 1, 1.7) // bulb_power multiplier for brightness 1..3
	// match the area switches to the choice - off at brightness 0, on otherwise
	var/list/seen_areas = list()
	for(var/turf/room_turf as anything in reservation.reserved_turfs)
		var/area/room_area = room_turf.loc
		if(seen_areas[room_area])
			continue
		seen_areas[room_area] = TRUE
		room_area.lightswitch = !lights_off
		room_area.power_change()
	for(var/turf/room_turf as anything in reservation.reserved_turfs)
		for(var/obj/machinery/light/lamp in room_turf)
			if(lights_off)
				lamp.set_on(FALSE) // turn each lamp off directly, don't trust the power signal alone
				continue
			lamp.set_on(TRUE)
			if(color)
				lamp.bulb_colour = color
				// atom color wins over nightshift (which would otherwise reset the bulb on the next
				// update), so the choice actually sticks
				lamp.color = color
			// scale off the type default so re-applying doesn't compound
			lamp.bulb_power = initial(lamp.bulb_power) * power_steps[level]
			// instant = TRUE: template-loaded lamps have maploaded = FALSE, else the update is skipped
			lamp.update(trigger = FALSE, instant = TRUE, play_sound = FALSE)

/// Applies the stored area ambience preset across every room area.
/datum/condo_room/proc/apply_ambience()
	if(!reservation)
		return
	var/list/sound_list = (ambience && GLOB.condo_ambiences[ambience]) ? GLOB.ambience_assoc[GLOB.condo_ambiences[ambience]] : null
	var/list/seen_areas = list()
	for(var/turf/room_turf as anything in reservation.reserved_turfs)
		var/area/room_area = room_turf.loc
		if(seen_areas[room_area])
			continue
		seen_areas[room_area] = TRUE
		room_area.ambientsounds = sound_list

#undef CONDO_ACCESS_OK
#undef CONDO_ACCESS_PASSWORD
#undef CONDO_ACCESS_DENIED
