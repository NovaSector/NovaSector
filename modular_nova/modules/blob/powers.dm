/mob/eye/blob/expand_blob(turf/tile)
	if(world.time < last_attack)
		return FALSE

	if(blobs_legit.len >= 400)
		to_chat(src, span_warning("You have reached your maximum size! You cannot expand any further."))
		return FALSE

	return ..()
