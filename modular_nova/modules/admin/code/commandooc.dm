GLOBAL_VAR_INIT(COOC_COLOR, "#fcdf03")
GLOBAL_VAR_INIT(cooc_allowed, TRUE)	// used with admin verbs to disable cooc - not a config option
GLOBAL_LIST_EMPTY(ckey_to_cooc_name)

#define COOC_LISTEN_PLAYER 1
#define COOC_LISTEN_ADMIN 2

/client/verb/cooc(msg as text)
	set name = "COOC"
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_HEAD_OF_PERSONNEL=TRUE, JOB_HEAD_OF_SECURITY=TRUE, JOB_RESEARCH_DIRECTOR=TRUE, JOB_CHIEF_ENGINEER=TRUE, JOB_CHIEF_MEDICAL_OFFICER=TRUE, JOB_QUARTERMASTER=TRUE, JOB_BRIDGE_ASSISTANT=TRUE, JOB_VETERAN_ADVISOR=TRUE, JOB_BLUESHIELD=TRUE, JOB_NT_REP=TRUE)
	if(!holder)
		var/job = mob?.mind.assigned_role.title
		if(!job || !job_lookup[job])
			to_chat(src, span_danger("You're not a member of Command!"))
			return
		if(!GLOB.cooc_allowed)
			to_chat(src, span_danger("COOC is globally muted."))
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, span_danger("You cannot use OOC (muted)."))
			return
	if(is_banned_from(ckey, "OOC"))
		to_chat(src, span_danger("You have been banned from OOC."))
		return
	if(QDELETED(src))
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	var/raw_msg = msg

	if(!msg)
		return

	msg = emoji_parse(msg)

	if(!(prefs.chat_toggles & CHAT_OOC))
		to_chat(src, span_danger("You have OOC muted."))
		return

	mob.log_talk(raw_msg, LOG_OOC, tag="COOC")

	var/keyname = key
	var/anon = FALSE

	//Anonimity for players and deadminned admins
	if(!holder || holder.deadmined)
		if(!GLOB.ckey_to_cooc_name[key])
			GLOB.ckey_to_cooc_name[key] = "Commander [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"
		keyname = GLOB.ckey_to_cooc_name[key]
		anon = TRUE

	var/list/listeners = list()

	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		//Admins with muted OOC do not get to listen to COOC, but normal players do, as it could be admins talking important stuff to them
		if(iterated_mob.client?.holder && !iterated_mob.client?.holder?.deadmined && iterated_mob.client?.prefs?.chat_toggles & CHAT_OOC)
			listeners[iterated_mob.client] = COOC_LISTEN_ADMIN
		else
			if(iterated_mob.mind)
				var/datum/mind/mob_mind = iterated_mob.mind
				if(job_lookup[mob_mind.assigned_role?.title])
					listeners[iterated_mob.client] = COOC_LISTEN_PLAYER

	for(var/client/iterated_client as anything in listeners)
		var/mode = listeners[iterated_client]
		var/color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color)) ? iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color) : GLOB.COOC_COLOR
		var/name = (mode == COOC_LISTEN_ADMIN && anon) ? "([key])[keyname]" : keyname
		to_chat(iterated_client, span_oocplain("<font color='[color]'><b><span class='prefix'>COOC:</span> <EM>[name]:</EM> <span class='message linkify'>[msg]</span></b></font>"), avoid_highlighting = (iterated_client == src))

#undef COOC_LISTEN_PLAYER
#undef COOC_LISTEN_ADMIN

/proc/toggle_cooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling cooc
		if(toggle != GLOB.cooc_allowed)
			GLOB.cooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.cooc_allowed = !GLOB.cooc_allowed
	var/list/listeners = list()
	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_HEAD_OF_PERSONNEL=TRUE, JOB_HEAD_OF_SECURITY=TRUE, JOB_RESEARCH_DIRECTOR=TRUE, JOB_CHIEF_ENGINEER=TRUE, JOB_CHIEF_MEDICAL_OFFICER=TRUE, JOB_BRIDGE_ASSISTANT=TRUE, JOB_VETERAN_ADVISOR=TRUE, JOB_BLUESHIELD=TRUE, JOB_NT_REP=TRUE)
	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		if(!iterated_mob.client?.holder?.deadmined)
			listeners[iterated_mob.client] = TRUE
		else
			if(iterated_mob.mind)
				var/datum/mind/mob_mind = iterated_mob.mind
				if(job_lookup[mob_mind.assigned_role])
					listeners[iterated_mob.client] = TRUE
	for(var/iterated_listener in listeners)
		var/client/iterated_client = iterated_listener
		to_chat(iterated_client, span_oocplain("<b>The COOC channel has been globally [GLOB.cooc_allowed ? "enabled" : "disabled"].</b>"))

ADMIN_VERB(togglecooc, R_ADMIN, "Toggle Command OOC", "Toggles Command OOC.", ADMIN_CATEGORY_SERVER)
	toggle_cooc()
	log_admin("[key_name(usr)] toggled Command OOC.")
	message_admins("[key_name_admin(usr)] toggled Command OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.cooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
