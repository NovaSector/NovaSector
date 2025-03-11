/datum/fish_source/New() //This is an override so anything in fishing that doesnt have a regeneration time but its limited will regenerate in 30 minutes.
	..()

	if (!fish_count_regen)
		fish_count_regen = list()

	for(var/path in fish_counts)
		if (!(path in fish_count_regen))
			fish_count_regen[path] = 30 MINUTES
