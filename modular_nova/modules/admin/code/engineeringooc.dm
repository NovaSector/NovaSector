GLOBAL_VAR_INIT(EOOC_COLOR, "#f37746")
GLOBAL_VAR_INIT(eooc_allowed, TRUE)	// used with admin verbs to disable eooc - not a config option
GLOBAL_LIST_EMPTY(ckey_to_eooc_name)

#define EOOC_LISTEN_PLAYER 1
#define EOOC_LISTEN_ADMIN 2

/client/verb/eooc(msg as text)
	set name = "EOOC"
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_CHIEF_ENGINEER=TRUE, JOB_STATION_ENGINEER=TRUE, JOB_ATMOSPHERIC_TECHNICIAN=TRUE, JOB_TELECOMMS_SPECIALIST=TRUE, JOB_ENGINEERING_GUARD=TRUE)
	if(!holder)
		var/job = mob?.mind.assigned_role.title
		if(!job || !job_lookup[job])
			to_chat(src, span_danger("You're not a member of Engineering!"))
			return
		if(!GLOB.eooc_allowed)
			to_chat(src, span_danger("EOOC is globally muted."))
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

	mob.log_talk(raw_msg, LOG_OOC, tag="EOOC")

	var/keyname = key
	var/anon = FALSE

	//Anonimity for players and deadminned admins
	if(!holder || holder.deadmined)
		if(!GLOB.ckey_to_eooc_name[key])
			GLOB.ckey_to_eooc_name[key] = "Engineer [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"
		keyname = GLOB.ckey_to_eooc_name[key]
		anon = TRUE

	var/list/listeners = list()

	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		//Admins with muted OOC do not get to listen to EOOC, but normal players do, as it could be admins talking important stuff to them
		if(iterated_mob.client?.holder && !iterated_mob.client?.holder?.deadmined && iterated_mob.client?.prefs?.chat_toggles & CHAT_OOC)
			listeners[iterated_mob.client] = EOOC_LISTEN_ADMIN
		else
			if(iterated_mob.mind)
				var/datum/mind/mob_mind = iterated_mob.mind
				if(job_lookup[mob_mind.assigned_role?.title])
					listeners[iterated_mob.client] = EOOC_LISTEN_PLAYER

	for(var/client/iterated_client as anything in listeners)
		var/mode = listeners[iterated_client]
		var/color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color)) ? iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color) : GLOB.EOOC_COLOR
		var/name = (mode == EOOC_LISTEN_ADMIN && anon) ? "([key])[keyname]" : keyname
		to_chat(iterated_client, span_oocplain("<font color='[color]'><b><span class='prefix'>EOOC:</span> <EM>[name]:</EM> <span class='message linkify'>[msg]</span></b></font>"), avoid_highlighting = (iterated_client == src))

#undef EOOC_LISTEN_PLAYER
#undef EOOC_LISTEN_ADMIN

/proc/toggle_eooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling eooc
		if(toggle != GLOB.eooc_allowed)
			GLOB.eooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.eooc_allowed = !GLOB.eooc_allowed
	var/list/listeners = list()
	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_CHIEF_ENGINEER=TRUE, JOB_STATION_ENGINEER=TRUE, JOB_ATMOSPHERIC_TECHNICIAN=TRUE, JOB_TELECOMMS_SPECIALIST=TRUE, JOB_ENGINEERING_GUARD=TRUE)
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
		to_chat(iterated_client, span_oocplain("<b>The EOOC channel has been globally [GLOB.eooc_allowed ? "enabled" : "disabled"].</b>"))

ADMIN_VERB(toggleeooc, R_ADMIN, "Toggle Engineering OOC", "Toggles Engineering OOC.", ADMIN_CATEGORY_SERVER)
	toggle_eooc()
	log_admin("[key_name(usr)] toggled Engineering OOC.")
	message_admins("[key_name_admin(usr)] toggled Engineering OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.eooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
