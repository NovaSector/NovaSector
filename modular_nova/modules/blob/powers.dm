/** Expands to nearby tiles */
/mob/eye/blob/expand_blob(turf/tile)
	if(world.time < last_attack)
		return FALSE

	// 1. Check the cap first
	if(blobs_legit.len >= 400)
		to_chat(src, span_warning("You have reached your maximum size! You cannot expand any further."))
		return FALSE

	// 2. If we are under 400, run the original expansion logic
	return ..()
