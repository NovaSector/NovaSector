GLOBAL_VAR_INIT(SUOOC_COLOR, "#b88646")
GLOBAL_VAR_INIT(suooc_allowed, TRUE)	// used with admin verbs to disable suooc - not a config option
GLOBAL_LIST_EMPTY(ckey_to_suooc_name)

#define SUOOC_LISTEN_PLAYER 1
#define SUOOC_LISTEN_ADMIN 2

/client/verb/suooc(msg as text)
	set name = "SUOOC"
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_QUARTERMASTER=TRUE, JOB_CARGO_TECHNICIAN=TRUE, JOB_CARGO_GORILLA=TRUE, JOB_SHAFT_MINER=TRUE, JOB_BITRUNNER=TRUE, JOB_CUSTOMS_AGENT=TRUE)
	if(!holder)
		var/job = mob?.mind.assigned_role.title
		if(!job || !job_lookup[job])
			to_chat(src, span_danger("You're not a member of Supply!"))
			return
		if(!GLOB.suooc_allowed)
			to_chat(src, span_danger("SUOOC is globally muted."))
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

	mob.log_talk(raw_msg, LOG_OOC, tag="SUOOC")

	var/keyname = key
	var/anon = FALSE

	//Anonimity for players and deadminned admins
	if(!holder || holder.deadmined)
		if(!GLOB.ckey_to_suooc_name[key])
			GLOB.ckey_to_suooc_name[key] = "Cratepusher [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"
		keyname = GLOB.ckey_to_suooc_name[key]
		anon = TRUE

	var/list/listeners = list()

	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		//Admins with muted OOC do not get to listen to SUOOC, but normal players do, as it could be admins talking important stuff to them
		if(iterated_mob.client?.holder && !iterated_mob.client?.holder?.deadmined && iterated_mob.client?.prefs?.chat_toggles & CHAT_OOC)
			listeners[iterated_mob.client] = SUOOC_LISTEN_ADMIN
		else
			if(iterated_mob.mind)
				var/datum/mind/mob_mind = iterated_mob.mind
				if(job_lookup[mob_mind.assigned_role?.title])
					listeners[iterated_mob.client] = SUOOC_LISTEN_PLAYER

	for(var/client/iterated_client as anything in listeners)
		var/mode = listeners[iterated_client]
		var/color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color)) ? iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color) : GLOB.SUOOC_COLOR
		var/name = (mode == SUOOC_LISTEN_ADMIN && anon) ? "([key])[keyname]" : keyname
		to_chat(iterated_client, span_oocplain("<font color='[color]'><b><span class='prefix'>SUOOC:</span> <EM>[name]:</EM> <span class='message linkify'>[msg]</span></b></font>"), avoid_highlighting = (iterated_client == src))

#undef SUOOC_LISTEN_PLAYER
#undef SUOOC_LISTEN_ADMIN

/proc/toggle_suooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling suooc
		if(toggle != GLOB.suooc_allowed)
			GLOB.suooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.suooc_allowed = !GLOB.suooc_allowed
	var/list/listeners = list()
	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_QUARTERMASTER=TRUE, JOB_CARGO_TECHNICIAN=TRUE, JOB_CARGO_GORILLA=TRUE, JOB_SHAFT_MINER=TRUE, JOB_BITRUNNER=TRUE, JOB_CUSTOMS_AGENT=TRUE)
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
		to_chat(iterated_client, span_oocplain("<b>The SUOOC channel has been globally [GLOB.suooc_allowed ? "enabled" : "disabled"].</b>"))

ADMIN_VERB(togglesuooc, R_ADMIN, "Toggle Supply OOC", "Toggles Supply OOC.", ADMIN_CATEGORY_SERVER)
	toggle_suooc()
	log_admin("[key_name(usr)] toggled Supply OOC.")
	message_admins("[key_name_admin(usr)] toggled Supply OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.suooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
