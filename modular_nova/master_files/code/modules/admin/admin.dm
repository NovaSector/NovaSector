GLOBAL_VAR_INIT(dchat_allowed, TRUE)

ADMIN_VERB(toggledchat, R_ADMIN, "Toggle Dead Chat", "Toggle dis bitch.", ADMIN_CATEGORY_SERVER)
	toggle_dchat()
	log_admin("[key_name(usr)] toggled dead chat.")
	message_admins("[key_name_admin(usr)] toggled dead chat.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle DCHAT", "[GLOB.dchat_allowed ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/proc/toggle_dchat(toggle = null)
	if(toggle != null) // if we're specifically en/disabling dead chat
		if(toggle != GLOB.dchat_allowed)
			GLOB.dchat_allowed = toggle
		else
			return
	else // otherwise just toggle it
		GLOB.dchat_allowed = !GLOB.dchat_allowed
	to_chat(world, span_oocplain("<B>The dead chat channel has been globally [GLOB.dchat_allowed ? "enabled" : "disabled"].</B>"))

/datum/admin_help
	/// Have we requested this ticket to stop being part of the Ticket Ping subsystem?
	var/ticket_ping_stop = FALSE
	/// Are we added to the ticket ping subsystem in the first place
	var/ticket_ping = FALSE
	/// Who is handling this admin help?
	var/handler
	/// All sanitized text
	var/full_text

/datum/admin_help/ClosureLinks(ref_src)
	. = ..()
	. += " (<A href='byond://?_src_=holder;[HrefToken(forceGlobal = TRUE)];ahelp=[ref_src];ahelp_action=handle_issue'>HANDLE</A>)" //NOVA EDIT ADDITION
	. += " (<A href='byond://?_src_=holder;[HrefToken(forceGlobal = TRUE)];ahelp=[ref_src];ahelp_action=pingmute'>PING MUTE</A>)" //NOVA EDIT ADDITION
	. += " (<A href='byond://?_src_=holder;[HrefToken(forceGlobal = TRUE)];ahelp=[ref_src];ahelp_action=convert'>MHELP</A>)"

//Let the initiator know their ahelp is being handled
/datum/admin_help/proc/handle_issue(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return FALSE

	if(handler && handler == usr.ckey) // No need to handle it twice as the same person ;)
		return TRUE

	if(handler && handler != usr.ckey)
		var/response = tgui_alert(usr, "This ticket is already being handled by [handler]. Do you want to continue?", "Ticket already assigned", list("Yes", "No"))
		if(!response || response == "No")
			return FALSE

	var/msg = span_adminhelp("Your ticket is now being handled by [usr?.client?.holder?.fakekey ? usr?.client?.holder?.fakekey : "an administrator"]! Please wait while they type their response and/or gather relevant information.")

	if(initiator)
		to_chat(initiator, msg)

	SSblackbox.record_feedback("tally", "ahelp_stats", 1, "handling")
	msg = "Ticket [TicketHref("#[id]")] is being handled by [key_name]"
	message_admins(msg)
	log_admin_private(msg)
	AddInteraction("Being handled by [key_name]", "Being handled by [key_name_admin(usr, FALSE)]")

	handler = "[usr.ckey]"
	return TRUE

///Proc which converts an admin_help ticket to a mentorhelp
/datum/admin_help/proc/convert_to_mentorhelp(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return FALSE

	if(handler && handler != usr.ckey)
		var/response = tgui_alert(usr, "This ticket is already being handled by [handler]. Do you want to continue?", "Ticket already assigned", list("Yes", "No"))
		if(!response || response == "No")
			return FALSE

	add_verb(initiator, /client/verb/mentorhelp) // Way to override mentorhelp cooldown.

	to_chat(initiator, span_adminhelp("Your ticket was converted to Mentorhelp"))
	initiator.mentorhelp(full_text)
	initiator.giveadminhelpverb()

	message_admins("[key_name] converted Ticket #[id] from [initiator_key_name] into Mentorhelp")
	log_admin("[usr.client] converted Ticket #[id] from [initiator_ckey] into Mentorhelp")

	Close(key_name, TRUE)

#define INSTANCES 1
#define LIST_COUNT 2
#define LIST_COUNT_NESTED 3
#define EMPTY_LISTS 4
#define BIGGEST_LIST 5
#define BIG_LIST_NAME 6
#define NESTED_LENGTH 7
#define MAX_DEPTH 8
#define CONTENTS_LEN 9

ADMIN_VERB(list_usage, R_ADMIN, "Measure list usage", "Generate a log file of list usage by type path", ADMIN_CATEGORY_DEBUG)
	var/list/data = list()
	if(tgui_alert(user, "Are you sure you want to log every instance of anything in the game and how many lists its using? This will cause the server to be unresponsive for several minutes.", "Think twice", list("Yes", "No")) != "Yes")
		return
	var/start_time = world.timeofday
	for(var/datum/thingy)
		log_thing(thingy, data)
	for(var/atom/thingy in world)
		log_thing(thingy, data)
	var/process_time = world.timeofday - start_time
	var/filename = file("[GLOB.log_directory]/list_usage.csv")
	start_time = world.timeofday
	WRITE_FILE(filename, "Path,Instances,List Count,Nested list count,Empty Lists,Biggest List,Name of biggest list,Recursive length,Max Depth,Contents len total")
	for(var/path, usage in data)
		var/list/list_data = usage
		WRITE_FILE(filename, "[path]," + list_data.Join(","))
	var/log_time = world.timeofday - start_time
	start_time = world.timeofday
	var/msg = "List analysis complete. Scan took [process_time/10]s, writing took [log_time/10]s."
	log_world(msg)
	message_admins(msg)

/proc/log_thing(datum/thingy, list/data)
	var/static/list/builtin_lists = list(
		"overlays" = 1,
		"underlays" = 1,
		"verbs" = 1,
		"vars" = 1,
		"contents" = 1,
		"filters" = 1,
		"group" = 1,
		"locs" = 1,
		"vis_contents" = 1,
		"vis_locs" = 1,

		"limb_icon_cache" = 1, // Not builtin, but static so not particularly relevant
		"turfs_by_zlevel" = 1,
	)
	var/list/type_list = data[thingy.type]
	if(isnull(type_list))
		type_list = new /list(9)
		for(var/i in 1 to length(type_list))
			type_list[i] = 0
		type_list[BIG_LIST_NAME] = null
		data[thingy.type] = type_list
	type_list[INSTANCES]++
	if(isatom(thingy))
		var/atom/atom_thing = thingy
		type_list[CONTENTS_LEN] += length(atom_thing.contents)

	for(var/varname, value in thingy.vars)
		if(!islist(value) || builtin_lists[varname])
			continue
		recursive_traverse_list(value, type_list)
		type_list[LIST_COUNT]++
		var/listlen = length(value)
		if(listlen == 0)
			type_list[EMPTY_LISTS]++
		else if(listlen > type_list[BIGGEST_LIST])
			type_list[BIGGEST_LIST] = listlen
			type_list[BIG_LIST_NAME] = varname

/proc/recursive_traverse_list(list/check_list, list/data, depth = 0)
	if(depth > data[MAX_DEPTH])
		data[MAX_DEPTH] = depth
	data[NESTED_LENGTH] += length(check_list)
	data[LIST_COUNT_NESTED]++
	for(var/key, value in check_list)
		var/list/list = islist(key) ? key : value
		if(!islist(list))
			continue
		recursive_traverse_list(list, data, depth + 1)

#undef INSTANCES
#undef LIST_COUNT
#undef LIST_COUNT_NESTED
#undef EMPTY_LISTS
#undef BIGGEST_LIST
#undef BIG_LIST_NAME
#undef NESTED_LENGTH
#undef MAX_DEPTH
#undef CONTENTS_LEN
