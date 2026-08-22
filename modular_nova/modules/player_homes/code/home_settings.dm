/*
 * Player-facing room settings: lighting and gravity, set from the console and kept in the sidecar.
 *
 * MERGE NOTE - NovaSector/NovaSector#7784
 * That PR gives condos the same two controls, as /datum/condo_room/apply_lights() and a gravity
 * toggle. Everything below deliberately works off "the reservation's turfs plus its area" rather
 * than off anything home-shaped, so when 7784 lands one implementation can simply call the other
 * instead of both being maintained. Nothing here depends on 7784 in the meantime.
 */

/// A valid "#rrggbb" bulb colour, or "" to leave every fixture on its own default. Never trusts a
/// raw string from a client.
/proc/sanitize_home_lamp_color(color)
	var/static/regex/hex_color = regex(@"^#[0-9a-fA-F]{6}$")
	return (color && hex_color.Find(color)) ? color : ""

/// Pushes the stored brightness and bulb colour onto every light fixture in the home.
/datum/home_instance/proc/apply_lights()
	if(isnull(reservation))
		return
	var/color = sanitize_home_lamp_color(lamp_color)
	var/level = clamp(round(brightness), HOME_BRIGHTNESS_MIN, HOME_BRIGHTNESS_MAX)
	var/lights_out = (level <= HOME_BRIGHTNESS_MIN)
	/// bulb_power multiplier for brightness 1 through 3
	var/static/list/power_steps = list(0.5, 1, 1.7)

	// Line the area switch up with the choice first, so the fixtures aren't fighting their own
	// power state on the way through.
	var/area/home_area = get_area(reservation.bottom_left_turfs[1])
	if(!isnull(home_area))
		home_area.lightswitch = !lights_out
		home_area.power_change()

	for(var/turf/reserved as anything in reservation.reserved_turfs)
		for(var/obj/machinery/light/fixture in reserved)
			if(lights_out)
				fixture.set_on(FALSE) // straight at the fixture; don't trust the power signal alone
				continue
			fixture.bulb_power = power_steps[level]
			fixture.bulb_colour = color || initial(fixture.bulb_colour)
			fixture.set_on(TRUE)
			// set_on() no-ops when the fixture was already lit, and we have just changed its colour
			// and power out from under it. No trigger or sound: this runs across a whole room.
			fixture.update(trigger = FALSE, play_sound = FALSE)
		CHECK_TICK

/**
 * Turns the home's gravity on or off.
 *
 * The area flag is the only lever that works here. has_gravity() reads
 * SSmapping.gravity_by_z_level[z] first and short-circuits straight past area.default_gravity, so
 * on a reservation z-level that has gravity, clearing default_gravity would do nothing at all -
 * NO_GRAVITY on the area is what actually bites.
 */
/datum/home_instance/proc/apply_gravity()
	if(isnull(reservation))
		return
	var/area/home_area = get_area(reservation.bottom_left_turfs[1])
	if(isnull(home_area))
		return
	if(gravity)
		home_area.area_flags &= ~NO_GRAVITY
	else
		home_area.area_flags |= NO_GRAVITY
	// Mobs cache their gravity state, so they have to be told. Objects re-check on every move.
	for(var/mob/living/occupant as anything in home_area.get_all_contents_type(/mob/living))
		occupant.refresh_gravity()

/// Re-applies everything the sidecar remembers. Called once on load, and again on every change.
/datum/home_instance/proc/apply_settings()
	apply_lights()
	apply_gravity()
