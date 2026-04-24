GLOBAL_VAR_INIT(SROOC_COLOR, "#6ca729")
GLOBAL_VAR_INIT(srooc_allowed, TRUE)	// used with admin verbs to disable srooc - not a config option
GLOBAL_LIST_EMPTY(ckey_to_srooc_name)

#define SROOC_LISTEN_PLAYER 1
#define SROOC_LISTEN_ADMIN 2

/client/verb/srooc(msg as text)
	set name = "SROOC"
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_HEAD_OF_PERSONNEL=TRUE, JOB_BARTENDER=TRUE, JOB_BOTANIST=TRUE, JOB_COOK=TRUE, JOB_CHEF=TRUE, JOB_JANITOR=TRUE, JOB_CLOWN=TRUE, JOB_MIME=TRUE, JOB_CURATOR=TRUE, JOB_LAWYER=TRUE, JOB_CHAPLAIN=TRUE, JOB_PSYCHOLOGIST=TRUE, JOB_PUN_PUN=TRUE, JOB_BARBER=TRUE, JOB_BOUNCER=TRUE)
	if(!holder)
		var/job = mob?.mind.assigned_role.title
		if(!job || !job_lookup[job])
			to_chat(src, span_danger("You're not a member of Service!"))
			return
		if(!GLOB.srooc_allowed)
			to_chat(src, span_danger("SROOC is globally muted."))
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

	mob.log_talk(raw_msg, LOG_OOC, tag="SROOC")

	var/keyname = key
	var/anon = FALSE

	//Anonimity for players and deadminned admins
	if(!holder || holder.deadmined)
		if(!GLOB.ckey_to_srooc_name[key])
			GLOB.ckey_to_srooc_name[key] = "Civil Servant [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"
		keyname = GLOB.ckey_to_srooc_name[key]
		anon = TRUE

	var/list/listeners = list()

	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		//Admins with muted OOC do not get to listen to SROOC, but normal players do, as it could be admins talking important stuff to them
		if(iterated_mob.client?.holder && !iterated_mob.client?.holder?.deadmined && iterated_mob.client?.prefs?.chat_toggles & CHAT_OOC)
			listeners[iterated_mob.client] = SROOC_LISTEN_ADMIN
		else
			if(iterated_mob.mind)
				var/datum/mind/mob_mind = iterated_mob.mind
				if(job_lookup[mob_mind.assigned_role?.title])
					listeners[iterated_mob.client] = SROOC_LISTEN_PLAYER

	for(var/client/iterated_client as anything in listeners)
		var/mode = listeners[iterated_client]
		var/color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color)) ? iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color) : GLOB.SROOC_COLOR
		var/name = (mode == SROOC_LISTEN_ADMIN && anon) ? "([key])[keyname]" : keyname
		to_chat(iterated_client, span_oocplain("<font color='[color]'><b><span class='prefix'>SROOC:</span> <EM>[name]:</EM> <span class='message linkify'>[msg]</span></b></font>"), avoid_highlighting = (iterated_client == src))

#undef SROOC_LISTEN_PLAYER
#undef SROOC_LISTEN_ADMIN

/proc/toggle_srooc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling srooc
		if(toggle != GLOB.srooc_allowed)
			GLOB.srooc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.srooc_allowed = !GLOB.srooc_allowed
	var/list/listeners = list()
	var/static/list/job_lookup = list(JOB_CAPTAIN=TRUE, JOB_HEAD_OF_PERSONNEL=TRUE, JOB_BARTENDER=TRUE, JOB_BOTANIST=TRUE, JOB_COOK=TRUE, JOB_CHEF=TRUE, JOB_JANITOR=TRUE, JOB_CLOWN=TRUE, JOB_MIME=TRUE, JOB_CURATOR=TRUE, JOB_LAWYER=TRUE, JOB_CHAPLAIN=TRUE, JOB_PSYCHOLOGIST=TRUE, JOB_PUN_PUN=TRUE, JOB_BARBER=TRUE, JOB_BOUNCER=TRUE)
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
		to_chat(iterated_client, span_oocplain("<b>The SROOC channel has been globally [GLOB.srooc_allowed ? "enabled" : "disabled"].</b>"))

ADMIN_VERB(togglesrooc, R_ADMIN, "Toggle Service OOC", "Toggles Service OOC.", ADMIN_CATEGORY_SERVER)
	toggle_srooc()
	log_admin("[key_name(usr)] toggled Service OOC.")
	message_admins("[key_name_admin(usr)] toggled Service OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.srooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
