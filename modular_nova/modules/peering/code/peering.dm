// Alt + right-click a distant tile to lean and peer that way, sliding your view
// in that direction for a wider sightline.
//
// Binded to Alt+right click by default

/// Furthest, in tiles, the view can be shifted when peering into the distance.
#define PEER_MAX_OFFSET 8
/// The clicked turf must be at least this many tiles away for us to peer toward it.
#define PEER_MIN_DISTANCE 3

/mob/living
	/// TRUE while our view is shifted from peering into the distance.
	var/peering = FALSE

/mob/living/AltClickSecondaryOn(atom/target)
	if(peer_into_distance(get_turf(target)))
		return
	return ..()

/mob/living/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(peering)
		stop_peering()

/**
 * Lean and peer toward a distant turf, sliding the view that way for some extra sightline.
 * Announces to onlookers. Returns TRUE if we actually started peering, so the caller can
 * fall back to the normal click chain for nearby or invalid targets. Cancelled by moving.
 */
/mob/living/proc/peer_into_distance(turf/target)
	if(!client || !istype(target))
		return FALSE
	if(stat != CONSCIOUS || is_blind())
		return FALSE
	// Don't fight the vertical look (look up/down) system or any non-standard perspective.
	if(client.perspective != MOB_PERSPECTIVE || looking_vertically)
		return FALSE
	if(!can_look_up()) // shared incapacitation + cooldown gate with look up/down
		return FALSE
	// No peering while hefting a weapon that needs two hands: wielded two-handers, plus
	// heavy guns (e.g. the M64 shotgun) that require both hands to fire without carrying
	// TRAIT_WIELDED. Scoped guns fall in here too, so they use their own scope zoom instead.
	for(var/obj/item/held in held_items)
		var/obj/item/gun/held_gun = held
		if(HAS_TRAIT(held, TRAIT_WIELDED) || (istype(held_gun) && held_gun.weapon_weight >= WEAPON_HEAVY))
			to_chat(src, span_warning("You can't peer into the distance while handling [held]."))
			return FALSE
	var/turf/our_turf = get_turf(src)
	if(!our_turf || target.z != our_turf.z)
		return FALSE
	if(get_dist(our_turf, target) < PEER_MIN_DISTANCE)
		return FALSE // too close to bother; let the normal click chain handle it
	changeNext_move(CLICK_CD_LOOK_UP)
	face_atom(target) // turn to look where we're peering
	var/offset_x = clamp(target.x - our_turf.x, -PEER_MAX_OFFSET, PEER_MAX_OFFSET)
	var/offset_y = clamp(target.y - our_turf.y, -PEER_MAX_OFFSET, PEER_MAX_OFFSET)
	// The offset lives on the client, not us, so anything that repoints the view or takes us
	// out of commission without moving us (death and camera/mech/AI/ghost perspective swaps
	// via reset_perspective, or dropping into soft/hard crit via set_stat) would otherwise
	// leave it stuck crooked. Listen for those while peering so we can snap it back.
	if(!peering)
		RegisterSignals(src, list(COMSIG_MOB_RESET_PERSPECTIVE, COMSIG_MOB_LOGOUT, COMSIG_MOB_STATCHANGE), PROC_REF(cancel_peering))
	peering = TRUE
	visible_message(
		span_notice("[src] easily peers into the distance."),
		span_notice("You peer into the distance."),
	)
	animate(client, pixel_x = ICON_SIZE_X * offset_x, pixel_y = ICON_SIZE_Y * offset_y, time = 1.1 SECONDS, easing = SINE_EASING)
	return TRUE

/mob/living/proc/cancel_peering(datum/source)
	SIGNAL_HANDLER
	stop_peering()

/// Smoothly slides the view back onto the mob and clears the peering state.
/mob/living/proc/stop_peering()
	if(!peering)
		return
	peering = FALSE
	UnregisterSignal(src, list(COMSIG_MOB_RESET_PERSPECTIVE, COMSIG_MOB_LOGOUT, COMSIG_MOB_STATCHANGE))
	if(!client)
		return
	animate(client, pixel_x = 0, pixel_y = 0, time = 0.2 SECONDS, easing = SINE_EASING)

#undef PEER_MAX_OFFSET
#undef PEER_MIN_DISTANCE
