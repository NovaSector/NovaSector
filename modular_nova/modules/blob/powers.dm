/mob/eye/blob/proc/can_expand(turf/tile)
	. = ..()
	if(!.)
		return
	if(blobs_legit.len >= 400)
		to_chat(src, span_warning("You have reached your maximum size! You cannot expand any further."))
		return FALSE
