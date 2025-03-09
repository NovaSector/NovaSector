/obj/effect/landmark/awaystart/heretic
	name = "Heretic"
	id = AWAYSTART_HERETIC

/proc/generateMapList(filename)
	. = list()
	filename = "[global.config.directory]/[SANITIZE_FILENAME(filename)]"
	var/list/Lines = world.file2list(filename)

	if(!Lines.len)
		return
	for (var/t in Lines)
		if (!t)
			continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (t[1] == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null

		if (pos)
			name = LOWER_TEXT(copytext(t, 1, pos))

		else
			name = LOWER_TEXT(t)

		if (!name)
			continue

		. += t

/// Returns a list of all maps to be found in the directory that is passed in.
/proc/generate_map_list_from_directory(directory)
	var/list/config_maps = list()
	var/list/maps = flist(directory)
	for(var/map_file in maps)
		if(!findtext(map_file, ".dmm"))
			continue
		config_maps += (directory + map_file)
	return config_maps
