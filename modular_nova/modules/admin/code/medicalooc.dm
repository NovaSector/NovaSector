GLOBAL_VAR_INIT(MOOC_COLOR, "#57b8f0")
GLOBAL_VAR_INIT(mooc_allowed, TRUE)	// used with admin verbs to disable mooc - not a config option
GLOBAL_LIST_EMPTY(ckey_to_mooc_name)

#define MOOC_LISTEN_PLAYER 1
#define MOOC_LISTEN_ADMIN 2

/client/verb/mooc(msg as text)
	set name = "MOOC"
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_CHIEF_MEDICAL_OFFICER=TRUE, JOB_CORONER=TRUE, JOB_MEDICAL_DOCTOR=TRUE, JOB_PARAMEDIC=TRUE, JOB_CHEMIST=TRUE, JOB_VIROLOGIST=TRUE, JOB_ORDERLY=TRUE, JOB_PSYCHOLOGIST=TRUE)
	if(!holder)
		var/job = mob?.mind.assigned_role.title
		if(!job || !job_lookup[job])
			to_chat(src, span_danger("You're not a member of Medical!"))
			return
		if(!GLOB.mooc_allowed)
			to_chat(src, span_danger("MOOC is globally muted."))
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

	mob.log_talk(raw_msg, LOG_OOC, tag="MOOC")

	var/keyname = key
	var/anon = FALSE

	//Anonimity for players and deadminned admins
	if(!holder || holder.deadmined)
		if(!GLOB.ckey_to_mooc_name[key])
			GLOB.ckey_to_mooc_name[key] = "Doctor [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"
		keyname = GLOB.ckey_to_mooc_name[key]
		anon = TRUE

	var/list/listeners = list()

	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		//Admins with muted OOC do not get to listen to MOOC, but normal players do, as it could be admins talking important stuff to them
		if(iterated_mob.client?.holder && !iterated_mob.client?.holder?.deadmined && iterated_mob.client?.prefs?.chat_toggles & CHAT_OOC)
			listeners[iterated_mob.client] = MOOC_LISTEN_ADMIN
		else
			if(iterated_mob.mind)
				var/datum/mind/mob_mind = iterated_mob.mind
				if(job_lookup[mob_mind.assigned_role?.title])
					listeners[iterated_mob.client] = MOOC_LISTEN_PLAYER

	for(var/client/iterated_client as anything in listeners)
		var/mode = listeners[iterated_client]
		var/color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color)) ? iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color) : GLOB.MOOC_COLOR
		var/name = (mode == MOOC_LISTEN_ADMIN && anon) ? "([key])[keyname]" : keyname
		to_chat(iterated_client, span_oocplain("<font color='[color]'><b><span class='prefix'>MOOC:</span> <EM>[name]:</EM> <span class='message linkify'>[msg]</span></b></font>"), avoid_highlighting = (iterated_client == src))

#undef MOOC_LISTEN_PLAYER
#undef MOOC_LISTEN_ADMIN

/proc/toggle_mooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling mooc
		if(toggle != GLOB.mooc_allowed)
			GLOB.mooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.mooc_allowed = !GLOB.mooc_allowed
	var/list/listeners = list()
	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_CHIEF_MEDICAL_OFFICER=TRUE, JOB_CORONER=TRUE, JOB_MEDICAL_DOCTOR=TRUE, JOB_PARAMEDIC=TRUE, JOB_CHEMIST=TRUE, JOB_VIROLOGIST=TRUE, JOB_ORDERLY=TRUE, JOB_PSYCHOLOGIST=TRUE)
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
		to_chat(iterated_client, span_oocplain("<b>The MOOC channel has been globally [GLOB.mooc_allowed ? "enabled" : "disabled"].</b>"))

ADMIN_VERB(togglemooc, R_ADMIN, "Toggle Medical OOC", "Toggles Medical OOC.", ADMIN_CATEGORY_SERVER)
	toggle_mooc()
	log_admin("[key_name(usr)] toggled Medical OOC.")
	message_admins("[key_name_admin(usr)] toggled Medical OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.mooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
