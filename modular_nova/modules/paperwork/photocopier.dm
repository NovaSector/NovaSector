#define NOVA_BLANKS_FILE_NAME "modular_nova/modules/paperwork/config/blanks.json"

GLOBAL_VAR_INIT(nova_blanks_loaded, FALSE)

// Hook into the vanilla ui_static_data() proc to load our custom photocopier templates from file
/obj/machinery/photocopier/ui_static_data(mob/user)
	if(!GLOB.nova_blanks_loaded)
		load_nova_paperwork_templates()

	// Hand back to the original ui_static_data() proc to ensure normal functionality continues
	return ..()

// Separate proc to load the photocopier templates from file and store them in a global list for use by the photocopier ui
/proc/load_nova_paperwork_templates()
	GLOB.nova_blanks_loaded = TRUE

	if(!fexists(NOVA_BLANKS_FILE_NAME))
		return

	var/list/blanks_json = json_decode(file2text(NOVA_BLANKS_FILE_NAME))
	if(!length(blanks_json))
		return
	if(!GLOB.paper_blanks)
		GLOB.paper_blanks = list()

	for(var/list/paper_blank in blanks_json)
		if(!islist(paper_blank) || !paper_blank["code"])
			continue

		// Store the paper blank in the global list, using its code as the key for easy retrieval later
		GLOB.paper_blanks["[paper_blank["code"]]"] = paper_blank

#undef NOVA_BLANKS_FILE_NAME
