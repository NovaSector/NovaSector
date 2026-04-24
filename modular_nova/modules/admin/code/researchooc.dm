GLOBAL_VAR_INIT(ROOC_COLOR, "#c68cfa")
GLOBAL_VAR_INIT(rooc_allowed, TRUE)	// used with admin verbs to disable rooc - not a config option
GLOBAL_LIST_EMPTY(ckey_to_rooc_name)

#define ROOC_LISTEN_PLAYER 1
#define ROOC_LISTEN_ADMIN 2

/client/verb/rooc(msg as text)
	set name = "ROOC"
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_RESEARCH_DIRECTOR=TRUE, JOB_SCIENTIST=TRUE, JOB_ROBOTICIST=TRUE, JOB_GENETICIST=TRUE, JOB_SCIENCE_GUARD=TRUE, JOB_AI=TRUE, JOB_CYBORG=TRUE, JOB_HUMAN_AI=TRUE)
	if(!holder)
		var/job = mob?.mind.assigned_role.title
		if(!job || !job_lookup[job])
			to_chat(src, span_danger("You're not a member of Research!"))
			return
		if(!GLOB.rooc_allowed)
			to_chat(src, span_danger("ROOC is globally muted."))
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

	mob.log_talk(raw_msg, LOG_OOC, tag="ROOC")

	var/keyname = key
	var/anon = FALSE

	//Anonimity for players and deadminned admins
	if(!holder || holder.deadmined)
		if(!GLOB.ckey_to_rooc_name[key])
			GLOB.ckey_to_rooc_name[key] = "Researcher [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"
		keyname = GLOB.ckey_to_rooc_name[key]
		anon = TRUE

	var/list/listeners = list()

	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		//Admins with muted OOC do not get to listen to ROOC, but normal players do, as it could be admins talking important stuff to them
		if(iterated_mob.client?.holder && !iterated_mob.client?.holder?.deadmined && iterated_mob.client?.prefs?.chat_toggles & CHAT_OOC)
			listeners[iterated_mob.client] = ROOC_LISTEN_ADMIN
		else
			if(iterated_mob.mind)
				var/datum/mind/mob_mind = iterated_mob.mind
				if(job_lookup[mob_mind.assigned_role?.title])
					listeners[iterated_mob.client] = ROOC_LISTEN_PLAYER

	for(var/client/iterated_client as anything in listeners)
		var/mode = listeners[iterated_client]
		var/color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color)) ? iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color) : GLOB.ROOC_COLOR
		var/name = (mode == ROOC_LISTEN_ADMIN && anon) ? "([key])[keyname]" : keyname
		to_chat(iterated_client, span_oocplain("<font color='[color]'><b><span class='prefix'>ROOC:</span> <EM>[name]:</EM> <span class='message linkify'>[msg]</span></b></font>"), avoid_highlighting = (iterated_client == src))

#undef ROOC_LISTEN_PLAYER
#undef ROOC_LISTEN_ADMIN

/proc/toggle_rooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling rooc
		if(toggle != GLOB.rooc_allowed)
			GLOB.rooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.rooc_allowed = !GLOB.rooc_allowed
	var/list/listeners = list()
	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_RESEARCH_DIRECTOR=TRUE, JOB_SCIENTIST=TRUE, JOB_ROBOTICIST=TRUE, JOB_GENETICIST=TRUE, JOB_SCIENCE_GUARD=TRUE, JOB_AI=TRUE, JOB_CYBORG=TRUE, JOB_HUMAN_AI=TRUE)
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
		to_chat(iterated_client, span_oocplain("<b>The ROOC channel has been globally [GLOB.rooc_allowed ? "enabled" : "disabled"].</b>"))

ADMIN_VERB(togglerooc, R_ADMIN, "Toggle Research OOC", "Toggles Research OOC.", ADMIN_CATEGORY_SERVER)
	toggle_rooc()
	log_admin("[key_name(usr)] toggled Research OOC.")
	message_admins("[key_name_admin(usr)] toggled Research OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.rooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
