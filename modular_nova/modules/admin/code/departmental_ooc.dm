// All channels constructed together in one atomic list literal, so there's no cross-file init-order dependency - by the time any /client/verb below can run, this is guaranteed fully populated.
// me when i glob *lewdmoan
// antag_channel check just opens the channel up if you have ANY antagonist datum whatsoever. if you want to repurpose this, refactor that to something like is_antag_type and then check for none / any / specific type
// anon_prefix sets up the special naming for the anonymization layer in the different channels.
// "name_of_channel" = new /datum/department_ooc_channel(
GLOBAL_LIST_INIT(department_ooc_channels, list(
	"security" = new /datum/department_ooc_channel("SOOC", "#ff5454", list(JOB_CAPTAIN=TRUE, JOB_HEAD_OF_SECURITY=TRUE, JOB_WARDEN=TRUE, JOB_DETECTIVE=TRUE, JOB_SECURITY_OFFICER=TRUE, JOB_CORRECTIONS_OFFICER=TRUE, JOB_LAWYER=TRUE), anon_prefix = "Deputy"),
	"medical" = new /datum/department_ooc_channel("MOOC", "#57b8f0", list(JOB_CAPTAIN=TRUE, JOB_CHIEF_MEDICAL_OFFICER=TRUE, JOB_CORONER=TRUE, JOB_MEDICAL_DOCTOR=TRUE, JOB_PARAMEDIC=TRUE, JOB_CHEMIST=TRUE, JOB_VIROLOGIST=TRUE, JOB_ORDERLY=TRUE, JOB_PSYCHOLOGIST=TRUE), anon_prefix = "Doctor"),
	"engineering" = new /datum/department_ooc_channel("EOOC", "#f37746", list(JOB_CAPTAIN=TRUE, JOB_CHIEF_ENGINEER=TRUE, JOB_STATION_ENGINEER=TRUE, JOB_ATMOSPHERIC_TECHNICIAN=TRUE, JOB_TELECOMMS_SPECIALIST=TRUE, JOB_ENGINEERING_GUARD=TRUE), anon_prefix = "Engineer"),
	"research" = new /datum/department_ooc_channel("ROOC", "#c68cfa", list(JOB_CAPTAIN=TRUE, JOB_RESEARCH_DIRECTOR=TRUE, JOB_SCIENTIST=TRUE, JOB_ROBOTICIST=TRUE, JOB_GENETICIST=TRUE, JOB_SCIENCE_GUARD=TRUE, JOB_AI=TRUE, JOB_CYBORG=TRUE, JOB_HUMAN_AI=TRUE), anon_prefix = "Researcher"),
	"service" = new /datum/department_ooc_channel("SROOC", "#6ca729", list(JOB_CAPTAIN=TRUE, JOB_HEAD_OF_PERSONNEL=TRUE, JOB_BARTENDER=TRUE, JOB_BOTANIST=TRUE, JOB_COOK=TRUE, JOB_CHEF=TRUE, JOB_JANITOR=TRUE, JOB_CLOWN=TRUE, JOB_MIME=TRUE, JOB_CURATOR=TRUE, JOB_LAWYER=TRUE, JOB_CHAPLAIN=TRUE, JOB_PSYCHOLOGIST=TRUE, JOB_PUN_PUN=TRUE, JOB_BARBER=TRUE, JOB_BOUNCER=TRUE), anon_prefix = "Civil Servant"),
	"command" = new /datum/department_ooc_channel("COOC", "#fcdf03", list(JOB_CAPTAIN=TRUE, JOB_HEAD_OF_PERSONNEL=TRUE, JOB_HEAD_OF_SECURITY=TRUE, JOB_RESEARCH_DIRECTOR=TRUE, JOB_CHIEF_ENGINEER=TRUE, JOB_CHIEF_MEDICAL_OFFICER=TRUE, JOB_QUARTERMASTER=TRUE, JOB_BRIDGE_ASSISTANT=TRUE, JOB_VETERAN_ADVISOR=TRUE, JOB_BLUESHIELD=TRUE, JOB_NT_REP=TRUE), anon_prefix = "Commander"),
	"supply" = new /datum/department_ooc_channel("SUOOC", "#b88646", list(JOB_CAPTAIN=TRUE, JOB_QUARTERMASTER=TRUE, JOB_CARGO_TECHNICIAN=TRUE, JOB_CARGO_GORILLA=TRUE, JOB_SHAFT_MINER=TRUE, JOB_BITRUNNER=TRUE, JOB_CUSTOMS_AGENT=TRUE), anon_prefix = "Cratepusher"),
	"silicon" = new /datum/department_ooc_channel("SLOOC", "#20c20e", list(JOB_AI=TRUE, JOB_CYBORG=TRUE, JOB_HUMAN_AI=TRUE), anon_prefix = "Intelligence"),
	"antagonist" = new /datum/department_ooc_channel("AOOC", "#de3c8c", null, is_antag_channel = TRUE, anon_prefix = "Operator"),
))

/// Channel key -> /datum/department_ooc_channel config, registered by each department file.
// Setup the datum for all of this
/datum/department_ooc_channel
	/// Short id used in chat prefix, e.g. "SOOC"
	var/id
	/// Display color for the chat
	var/color
	/// GLOBAL_VAR name string this channel's "allowed" toggle lives under, for admin verb messaging.
	var/list/job_lookup
	/// Whether the channel is currently globally enabled.
	var/allowed = TRUE
	/// ckey -> anon name, just a spot to put the data
	var/list/ckey_to_anon_name
	/// If TRUE, eligibility/listeners are based on having an antag datum instead of job_lookup.
	var/is_antag_channel = FALSE

// Sets us up
/datum/department_ooc_channel/New(id, color, list/job_lookup, is_antag_channel, anon_prefix)
	. = ..()
	src.id = id
	src.color = color
	src.job_lookup = job_lookup
	src.is_antag_channel = is_antag_channel
	src.anon_prefix = anon_prefix
	ckey_to_anon_name = list()

// Because numbers are illegible and are bad >:( we use defines
#define DEPT_OOC_LISTEN_PLAYER 1
#define DEPT_OOC_LISTEN_ADMIN 2

// Fresh proc lesgo, handles speech
// Handling our list manipulations inside proc instead of through login or mob initialize because I try to be considerate
/proc/send_department_ooc(client/sender, channel_key, msg)// who sent it, in what channel, with what message
	var/datum/department_ooc_channel/channel = GLOB.department_ooc_channels[channel_key]// make tappable var from results of selection through
	if(!channel)// if no selection
		return// go home
	if(GLOB.say_disabled)// check if speech is globally disabled for some godforsaken reason
		to_chat(sender, span_danger("Speech is currently admin-disabled."))// tell the nerd
		return// get out
	if(!sender.mob)// if were not a mob for some reason
		return// go home

	if(!sender.holder)// if we are not an admin holder
		if(channel.is_antag_channel)// and our channel selection is an antag centric channel
			if(!sender.mob.mind || !length(sender.mob.mind.antag_datums))// and if they are not an antag
				to_chat(sender, span_danger("You're not an antagonist!"))// tell the dork
				return// get out
		else// if its not an antag channel
			var/job = sender.mob?.mind?.assigned_role?.title // we setup job from a goofy list of operative breadcrumb checks
			if(!job || !channel.job_lookup[job])// if no job or and also if the job we have isnt in our lookup
				to_chat(sender, span_danger("You're not a [channel.id] role!"))// tell dork
				return// go away
		if(!channel.allowed)// if the channel isn't on the allowed to speak list rn
			to_chat(sender, span_danger("[channel.id] is globally muted."))// inform
			return// leave
		if(sender.prefs.muted & MUTE_OOC)// if they can speak but theyre muted,
			to_chat(sender, span_danger("You cannot use OOC (muted)."))// tell them
			return// go away
	if(is_banned_from(sender.ckey, "OOC"))// if youre banned and trying to use ooc itself
		to_chat(sender, span_danger("You have been banned from OOC."))// tell shut
		return// do not pass go
	if(QDELETED(sender))// if for whatever fucking reason we are qdel'd in this process
		return// into the trash

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)// sanity work on our message
	var/raw_msg = msg// convert our msg into a new var
	if(!msg)// if no message
		return// back out
	msg = emoji_parse(msg)// guys its late 2020's we post 🤰 now get with the times and dont break my unicode

	if(!(sender.prefs.chat_toggles & CHAT_OOC))// if they dont want to see ooc
		to_chat(sender, span_danger("You have OOC muted."))// shut the door in their face they arent a part of the party and shouldnt shout in the window
		return// go home dork

	sender.mob.log_talk(raw_msg, LOG_OOC, tag = channel.id)// if we got this far post a log

	var/keyname = sender.key// grab the key of our sender to use in bullshit
	var/anon = FALSE// Lil switcheroo on if we have done the anonymization for them yet
	if((!sender.holder || sender.holder.deadmined) && sender.prefs?.read_preference(/datum/preference/toggle/department_ooc_anon))// if we arent a holder or deadminned, and our prefs for anonymous d-ooc are disabled
		if(!channel.ckey_to_anon_name[sender.key])// and also if our name is not already generated into our list, checking by choice in list
			channel.ckey_to_anon_name[sender.key] = "[channel.anon_prefix] [pick(GLOB.phonetic_alphabet)] [rand(1, 99)]"// then update the list for that channel utilizing the anon prefix for that channel, with bonus numerals for identities
		keyname = channel.ckey_to_anon_name[sender.key]// sets our keyname to the result of selecting our sender from the list we just populated above, or if it was already populated, uses it
		anon = TRUE// sets our anony mode to true now that its been processed, so we dont ever re-assign their name accidentally

	var/list/listeners = list()// we love lists
	if(channel.is_antag_channel)// if the channel you picked was an antagonist channel
		for(var/mind in get_antag_minds(/datum/antagonist))// populate a mind var with the results spit out from a simple antag minds check, its so cool this proc exists
			var/datum/mind/antag_mind = mind// rebase the antag minds into the mind var
			if(!antag_mind.current || !antag_mind.current.client || isnewplayer(antag_mind.current))// imagine saying this outloud, semantically.
				continue// keep going if we got this far
			listeners[antag_mind.current.client] = DEPT_OOC_LISTEN_PLAYER// oh look that define showed up
	for(var/iterated_player in GLOB.player_list)// iterate our list from our glob into something we can poke
		var/mob/iterated_mob = iterated_player// copy that over to a new thing we can poke
		if(iterated_mob.client?.holder && !iterated_mob.client?.holder?.deadmined && iterated_mob.client?.prefs?.chat_toggles & CHAT_OOC)// if we are a holder and we arent deadminned and we have the relevant toggles alive
			listeners[iterated_mob.client] = DEPT_OOC_LISTEN_ADMIN// add them to the admeme list
		else if(!channel.is_antag_channel && iterated_mob.mind)// hnnnng they arent an antag channel and also we have their mind in our previously iterated var
			var/datum/mind/mob_mind = iterated_mob.mind// setup more shit by writing our mind into a datum
			if(channel.job_lookup[mob_mind.assigned_role?.title])// check our lookup against their job and if valid
				listeners[iterated_mob.client] = DEPT_OOC_LISTEN_PLAYER// PUT THEM ON THE LIST good god

	for(var/client/iterated_client as anything in listeners)// now we iterate our clients
		var/mode = listeners[iterated_client]// its like an onion it hurts
		var/msg_color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color)) ? iterated_client.prefs.read_preference(/datum/preference/color/ooc_color) : channel.color// Im not going to bother, this staircase is upsetting
		var/display_name = (mode == DEPT_OOC_LISTEN_ADMIN && anon) ? "([sender.key])[keyname]" : keyname// fully compile our display name from above
		to_chat(iterated_client, span_oocplain("<font color='[msg_color]'><b><span class='prefix'>[channel.id]:</span> <EM>[display_name]:</EM> <span class='message linkify'>[msg]</span></b></font>"), avoid_highlighting = (iterated_client == sender))// disgusting results of the above proc go to chat

#undef DEPT_OOC_LISTEN_PLAYER
#undef DEPT_OOC_LISTEN_ADMIN
// kill our defs
// Sets up the general purpose selector verb for departmental oocs, per vinylspiders request
/client/verb/department_ooc(msg as text)// i cannot express how much this hurts my head for no reason
	set name = "Department OOC"// name our verb
	set category = "OOC"// categorize it

	var/list/available = list()// assemble a list for clients to speak into
	for(var/channel_key in GLOB.department_ooc_channels)// assigning our channel keys from our glob above
		var/datum/department_ooc_channel/channel = GLOB.department_ooc_channels[channel_key]// mapping our channels from key selection inside out glob lookup
		if(!holder)// if they are not a holder
			if(channel.is_antag_channel)// and this is an antag channel
				if(!mob?.mind || !length(mob.mind.antag_datums))// see if they have a mind, if they do, look if they have antag datums
					continue// keep going if they passed that check
			else// otherwise
				var/job = mob?.mind?.assigned_role?.title// map a lookup to a variable
				if(!job || !channel.job_lookup[job])// check if the selection passes muster
					continue// if it does keep going
		available[channel.id] = channel_key// map selections to pick from through the filtering we just did

	if(!length(available))// if there isnt anything at all in our available channels
		to_chat(src, span_danger("You have no OOC channels available to you."))// laugh a bit
		return// get out

	var/picked_id = tgui_input_list(usr, "Select a channel", "Department OOC", available)// they have channels? ok buddy, tell me what you want to use then
	if(isnull(picked_id))// you didnt pick anything
		return// thank 4 waste my time

	if(isnull(msg))// no message, duh, but we check it to
		msg = tgui_input_text(usr, "Message to send on [picked_id]", "Department OOC")// let them decide their message
	if(isnull(msg))// still no message?
		return// kill, die even

	send_department_ooc(src, available[picked_id], msg)// oh wow we got this far? cool send that shit

// For the admins to address infighting, like usual
/proc/toggle_department_ooc(channel_key, toggle = null)
	var/datum/department_ooc_channel/channel = GLOB.department_ooc_channels[channel_key]// Get channel to poke through glob lookup of choice provided
	if(!channel)// if none
		return// go away
	if(toggle != null)// if our toggle is not absent or dataless
		if(toggle == channel.allowed)// and if the toggle is already on the allowed list
			return// we have nothing else to do here
		channel.allowed = toggle// otherwise set it to enabled
	else// if it is already enabled
		channel.allowed = !channel.allowed// turn the coin over

	var/list/listeners = list()// empty list make
	if(channel.is_antag_channel)// look in channel list for things with our is antag channel bool
		for(var/mind in get_antag_minds(/datum/antagonist))// setup a new mind var of a lazy check of our antags
			var/datum/mind/antag_mind = mind// populate the datum of all antag minds into our var here
			if(!antag_mind.current || !antag_mind.current.client || isnewplayer(antag_mind.current))// *the sounds of hair tearing*
				continue// keep us going please were nearly done aaa
			listeners[antag_mind.current.client] = TRUE// update values
	for(var/iterated_player in GLOB.player_list)// iterate our players through the global player list
		var/mob/iterated_mob = iterated_player// iterate our mob list off our player list
		if(!iterated_mob.client?.holder?.deadmined)// if the iterated client of our mob to send is not a holder and is not deadminned
			listeners[iterated_mob.client] = TRUE// update values
		else if(!channel.is_antag_channel && iterated_mob.mind)// its not an antag channel and our mind is iterated
			var/datum/mind/mob_mind = iterated_mob.mind// populate our mob minds that arent antag minds by equating them
			if(channel.job_lookup[mob_mind.assigned_role])// check if our assigned role of our mob's mind is in our relevant job checks in our channels
				listeners[iterated_mob.client] = TRUE// last. value. updated

	for(var/iterated_listener in listeners)// this is speaking to essentially everyone, you know, this is how we speak to everyone globally. or atleast how im trying to.
		var/client/iterated_client = iterated_listener// setup our clients to inform
		to_chat(iterated_client, span_oocplain("<b>The [channel.id] channel has been globally [channel.allowed ? "enabled" : "disabled"].</b>"))// inform those clients

// For the regulation of the dorks, runs the above proc using input created from a list selector populated through our glob
ADMIN_VERB(toggledeptooc, R_ADMIN, "Toggle Department OOC", "Toggles a department OOC channel.", ADMIN_CATEGORY_SERVER)// make our new verb
	var/list/options = list()// setup var for our selections
	for(var/channel_key in GLOB.department_ooc_channels)// prepare options from our glob
		var/datum/department_ooc_channel/channel = GLOB.department_ooc_channels[channel_key]// prepare our selection
		options["[channel.id] ([channel.allowed ? "Enabled" : "Disabled"])"] = channel_key// run those bits for data

	var/picked = tgui_input_list(usr, "Select a channel to toggle", "Toggle Department OOC", options)// post our selector
	if(isnull(picked))// if they pick nothing,
		return// go home omg
	var/channel_key = options[picked]// they did pick something? map that back to our var
	var/datum/department_ooc_channel/channel = GLOB.department_ooc_channels[channel_key]// cross assosciate our moving pieces with our selection

	toggle_department_ooc(channel_key)// use our selection to do the thing we came here to do
	log_admin("[key_name(usr)] toggled [channel.id] OOC.")// admin.log
	message_admins("[key_name_admin(usr)] toggled [channel.id] OOC.")// inform asay
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle [channel.id] OOC", "[channel.allowed ? "Enabled" : "Disabled"]"))
