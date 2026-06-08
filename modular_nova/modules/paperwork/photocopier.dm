#define NOVA_BLANKS_FILE_NAME "config/nova/blanks.json"

// This is a copy of the original init_paper_blanks() function, but it loads from the NOVA_BLANKS_FILE_NAME instead of the TG one. If the file doesn't exist or is invalid, it falls back to the TG blanks instead of returning null.
/proc/init_paper_blanks_nova()
	if(!fexists(NOVA_BLANKS_FILE_NAME))
		return null

	var/list/blanks_json = json_decode(file2text(NOVA_BLANKS_FILE_NAME))
	if(!length(blanks_json))
		return null

	var/list/parsed_blanks = init_paper_blanks() || list() // start with the TG blanks if they exist
	for(var/list/paper_blank in blanks_json)
		if(!islist(paper_blank) || !paper_blank["code"])
			continue

		// Check if the code already exists in the TG blanks. If it does, skip it to avoid showing the same form multiples.
		parsed_blanks["[paper_blank["code"]]"] = paper_blank


	return parsed_blanks

#undef NOVA_BLANKS_FILE_NAME
