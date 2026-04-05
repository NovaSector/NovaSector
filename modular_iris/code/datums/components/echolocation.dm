/datum/component/echolocation
	/// Tracks which "from_when" values we've already scheduled fades for,
	var/list/scheduled_fades = list()
	/// Per-receiver stash for temporarily-removed images (keyed by receiver -> atom)
	var/list/stashed_images = list()

/datum/component/echolocation/proc/delete_single_image(params)
	var/mob/living/echolocate_receiver = params[1]
	var/image/previous_image = params[2]
	if(!echolocate_receiver || !echolocate_receiver.client)
		return
	if(previous_image in echolocate_receiver.client.images)
		echolocate_receiver.client.images -= previous_image
	// Clean up any stray receiver entries that still reference this image
	if(receivers[echolocate_receiver])
		for(var/atom/rendered_atom as anything in list(receivers[echolocate_receiver]))
			if(receivers[echolocate_receiver][rendered_atom]["image"] == previous_image)
				receivers[echolocate_receiver] -= rendered_atom
	// Also remove any stashed entries that reference this image
	if(stashed_images[echolocate_receiver])
		for(var/atom/stashed_atom as anything in list(stashed_images[echolocate_receiver]))
			if(stashed_images[echolocate_receiver][stashed_atom]["image"] == previous_image)
				stashed_images[echolocate_receiver] -= stashed_atom


/datum/component/echolocation/proc/try_stash_entry(mob/living/echolocate_receiver, atom/rendered_atom, list/entry, from_when)
	if(!echolocate_receiver)
		return FALSE
	if(isnull(stashed_images[echolocate_receiver]))
		stashed_images[echolocate_receiver] = list()
	var/stashed = list("image" = entry["image"], "time" = entry["time"], "z" = rendered_atom.z)
	stashed_images[echolocate_receiver][rendered_atom] = stashed
	// hide image from the client while it's stashed
	if(echolocate_receiver.client && (entry["image"] in echolocate_receiver.client.images))
		echolocate_receiver.client.images -= entry["image"]
	return TRUE

/datum/component/echolocation/proc/try_restore_from_stash(mob/living/echolocate_receiver, atom/input_atom)
	if(!echolocate_receiver || !echolocate_receiver.client)
		return FALSE
	if(!stashed_images[echolocate_receiver])
		return FALSE
	var/stashed = stashed_images[echolocate_receiver][input_atom]
	if(!stashed)
		return FALSE
	if(stashed["z"] != echolocate_receiver.z)
		return FALSE
	if(stashed["time"] <= "[world.time]")
		stashed_images[echolocate_receiver] -= input_atom
		if(!length(stashed_images[echolocate_receiver]))
			stashed_images -= echolocate_receiver
		return FALSE
	if(!(stashed["image"] in echolocate_receiver.client.images))
		echolocate_receiver.client.images += stashed["image"]
	if(!receivers[echolocate_receiver])
		receivers[echolocate_receiver] = list()
	receivers[echolocate_receiver][input_atom] = list("image" = stashed["image"], "time" = stashed["time"])
	stashed_images[echolocate_receiver] -= input_atom
	if(!length(stashed_images[echolocate_receiver]))
		stashed_images -= echolocate_receiver
	return TRUE

/datum/component/echolocation/proc/cleanup_stash(from_when)
	for(var/mob/living/receiver as anything in list(stashed_images))
		for(var/atom/atom_key as anything in list(stashed_images[receiver]))
			var/entry = stashed_images[receiver][atom_key]
			if(entry["time"] <= from_when)
				if(receiver && receiver.client && (entry["image"] in receiver.client.images))
					receiver.client.images -= entry["image"]
				stashed_images[receiver] -= atom_key
				if(!length(stashed_images[receiver]))
					stashed_images -= receiver
