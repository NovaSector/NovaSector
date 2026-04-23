/mob/eye/blob/victory()
	var/datum/antagonist/blob/B = mind.has_antag_datum(/datum/antagonist/blob)
	if(B)
		var/datum/objective/blob_takeover/main_objective = locate() in B.objectives
		if(main_objective)
			main_objective.completed = TRUE

/mob/eye/blob/process()
	if(!blob_core)
		if(!placed)
			if(manualplace_min_time && world.time >= manualplace_min_time)
				to_chat(src, span_boldnotice("You may now place your blob core."))
				to_chat(src, span_bolddanger("You will automatically place your blob core in [DisplayTimeText(autoplace_max_time - world.time)]."))
				manualplace_min_time = 0
			if(autoplace_max_time && world.time >= autoplace_max_time)
				place_blob_core(BLOB_RANDOM_PLACEMENT)
		else
			// If we get here, it means yes: the blob is kill
			SSticker.news_report = BLOB_DESTROYED

			// Clear the biohazard emergency display when blob is defeated - async to avoid blocking
			INVOKE_ASYNC(src, PROC_REF(clear_biohazard_display))

			qdel(src)
	else if(!victory_in_progress && (blobs_legit.len >= blobwincount))
		on_critical_mass()
	else if(!free_strain_rerolls && (last_reroll_time + BLOB_POWER_REROLL_FREE_TIME<world.time))
		to_chat(src, span_boldnotice("You have gained another free strain re-roll."))
		free_strain_rerolls = 1

	if(!victory_in_progress && max_count < blobs_legit.len)
/mob/eye/blob/on_critical_mass()
	return
