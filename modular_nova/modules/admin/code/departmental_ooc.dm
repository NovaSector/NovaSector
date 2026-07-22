// All channels constructed together in one atomic list literal, so there's no cross-file init-order dependency - by the time any /client/verb below can run, this is guaranteed fully populated.
// me when i glob *lewdmoan
// antag_channel check just opens the channel up if you have ANY antagonist datum whatsoever. if you want to repurpose this, refactor that to something like is_antag_type and then check for none / any / specific type
// anon_prefix sets up the special naming for the anonymization layer in the different channels.
GLOBAL_LIST_INIT(department_ooc_channels, list(
	"security" = new /datum/department_ooc_channel("SEC-OOC", "#ff5454", DEPARTMENT_BITFLAG_SECURITY, anon_prefix = "Deputy"),
	"medical" = new /datum/department_ooc_channel("MED-OOC", "#57b8f0", DEPARTMENT_BITFLAG_MEDICAL, anon_prefix = "Doctor"),
	"engineering" = new /datum/department_ooc_channel("ENG-OOC", "#f37746", DEPARTMENT_BITFLAG_ENGINEERING, anon_prefix = "Engineer"),
	"research" = new /datum/department_ooc_channel("SCI-OOC", "#c68cfa", DEPARTMENT_BITFLAG_SCIENCE, anon_prefix = "Researcher"),
	"service" = new /datum/department_ooc_channel("SRV-OOC", "#6ca729", DEPARTMENT_BITFLAG_SERVICE, anon_prefix = "Civil Servant"),
	"command" = new /datum/department_ooc_channel("CMD-OOC", "#fcdf03", DEPARTMENT_BITFLAG_COMMAND | DEPARTMENT_BITFLAG_CAPTAIN, anon_prefix = "Commander"),
	"supply" = new /datum/department_ooc_channel("CAR-OOC", "#b88646", DEPARTMENT_BITFLAG_CARGO, anon_prefix = "Cratepusher"),
	"silicon" = new /datum/department_ooc_channel("AI-OOC", "#20c20e", DEPARTMENT_BITFLAG_SILICON, anon_prefix = "Intelligence"),
	"antagonist" = new /datum/department_ooc_channel("ANTAG-OOC", "#de3c8c", NONE, is_antag_channel = TRUE, anon_prefix = "Operator"),
	"central_command" = new /datum/department_ooc_channel("CC-OOC", "#00bfff", DEPARTMENT_BITFLAG_CENTRAL_COMMAND, anon_prefix = "Agent"),
	"backstage" = new /datum/department_ooc_channel("Backstage", "#ff0080", DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_COMMAND | DEPARTMENT_BITFLAG_CAPTAIN, is_antag_channel = TRUE, anon_prefix = "Actor"),
))

/// Channel key -> /datum/department_ooc_channel config, registered by each department file.
// Setup the datum for all of this
/datum/department_ooc_channel
	/// Short id used in chat prefix, e.g. "SOOC"
	var/id
	/// Display color for the chat
	var/color
	/// Bitflags for the departments allowed to use this channel.
	var/department_flags = NONE
	/// Whether the channel is currently globally enabled.
	var/allowed = TRUE
	/// ckey -> anon name, just a spot to put the data
	var/list/ckey_to_anon_name
	/// If TRUE, eligibility/listeners are based on having an antag datum in addition to department_flags.
	var/is_antag_channel = FALSE
	/// Special naming prefix for the anonymization layer in this channel.
	var/anon_prefix

// Sets us up
/datum/department_ooc_channel/New(id, color, department_flags, is_antag_channel, anon_prefix)
	. = ..()
	src.id = id
	src.color = color
	src.department_flags = department_flags
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
		var/allowed = FALSE// in proc binary flag for later
		if(channel.is_antag_channel && sender.mob.mind && length(sender.mob.mind.antag_datums))// if this is an antag channel being used and we have a mind and in our mind is anything under antag datums
			allowed = TRUE// stamp their paw approved

		if(!allowed && channel.department_flags)// if we arent approved from above but we have bitflags in the channel listing
			var/datum/job/job = sender.mob?.mind?.assigned_role// please dont crucify me for this check
			if(job && (job.departments_bitflags & channel.department_flags))// if the job has both matching bitflags to depflag
				allowed = TRUE// allow them

		if(!allowed)// if they didnt pass either of the two doors above
			if(channel.is_antag_channel)// and theyre speaking into an antag channel
				to_chat(sender, span_danger("You're not an antagonist or authorized role!"))// tell them they arent cool yet
			else// otherwise
				to_chat(sender, span_danger("You're not a [channel.id] role!"))// tell them to get a job
			return// get out

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

	// malding. populate listeners
	// Add admins first
	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		if(iterated_mob.client?.holder && !iterated_mob.client?.holder?.deadmined && (iterated_mob.client?.prefs?.chat_toggles & CHAT_OOC))
			listeners[iterated_mob.client] = DEPT_OOC_LISTEN_ADMIN

	// Add antags if applicable
	if(channel.is_antag_channel)
		for(var/mind in get_antag_minds(/datum/antagonist))
			var/datum/mind/antag_mind = mind
			if(!antag_mind.current || !antag_mind.current.client || isnewplayer(antag_mind.current))
				continue
			if(listeners[antag_mind.current.client]) // Skip if already added as admin
				continue
			listeners[antag_mind.current.client] = DEPT_OOC_LISTEN_PLAYER

	// Add department members if applicable
	if(channel.department_flags)
		for(var/iterated_player in GLOB.player_list)
			var/mob/iterated_mob = iterated_player
			if(listeners[iterated_mob.client]) // Skip if already added
				continue
			if(iterated_mob.mind)
				var/datum/job/job = iterated_mob.mind.assigned_role
				if(job && (job.departments_bitflags & channel.department_flags))
					listeners[iterated_mob.client] = DEPT_OOC_LISTEN_PLAYER

	for(var/client/iterated_client as anything in listeners)// now we iterate our clients
		var/mode = listeners[iterated_client]// its like an onion it hurts
		var/msg_color = (!anon && CONFIG_GET(flag/allow_admin_ooccolor) && iterated_client?.prefs?.read_preference(/datum/preference/color/ooc_color)) ? iterated_client.prefs.read_preference(/datum/preference/color/ooc_color) : channel.color// Im not going to bother, this staircase is upsetting
		var/display_name = (mode == DEPT_OOC_LISTEN_ADMIN && anon) ? "([sender.key])[keyname]" : keyname// fully compile our display name from above
		to_chat(iterated_client, span_oocplain("<font color='[msg_color]'><b><span class='prefix'>[channel.id]:</span> <EM>[display_name]:</EM> <span class='message linkify'>[msg]</span></b></font>"), avoid_highlighting = (iterated_client == sender))// disgusting results of the above proc go to chat

#undef DEPT_OOC_LISTEN_PLAYER
#undef DEPT_OOC_LISTEN_ADMIN
// kill our defs
// Sets up the general purpose selector verb for departmental oocs, per vinylspiders request
/client/verb/department_ooc()// i cannot express how much this hurts my head for no reason
	set name = "Department OOC"// name our verb
	set category = "OOC"// categorize it

	var/list/available = list()// assemble a list for clients to speak into
	for(var/channel_key in GLOB.department_ooc_channels)// assigning our channel keys from our glob above
		var/datum/department_ooc_channel/channel = GLOB.department_ooc_channels[channel_key]// mapping our channels from key selection inside out glob lookup
		if(!holder)// if they are not a holder
			var/allowed = FALSE
			if(channel.is_antag_channel && mob?.mind && length(mob.mind.antag_datums))
				allowed = TRUE
			if(!allowed && channel.department_flags)
				var/datum/job/job = mob?.mind?.assigned_role
				if(job && (job.departments_bitflags & channel.department_flags))
					allowed = TRUE

			if(!allowed)
				continue

		available[channel.id] = channel_key// map selections to pick from through the filtering we just did

	if(!length(available))// if there isnt anything at all in our available channels
		to_chat(src, span_danger("You have no OOC channels available to you."))// laugh a bit
		return// get out

	var/picked_id = tgui_input_list(usr, "Select a channel", "Department OOC", available)// they have channels? ok buddy, tell me what you want to use then
	if(isnull(picked_id))// you didnt pick anything
		return// thank 4 waste my time

	var/msg = tgui_input_text(usr, "Message to send on [picked_id]", "Department OOC")// let them decide their message, tgui panel now that its not fighting a native prompt for the arg anymore
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

	// repurpose our code from earlier to save my brain
	// Add admins
	for(var/iterated_player in GLOB.player_list)
		var/mob/iterated_mob = iterated_player
		if(!iterated_mob.client?.holder?.deadmined)
			listeners[iterated_mob.client] = TRUE

	// Add antags
	if(channel.is_antag_channel)
		for(var/mind in get_antag_minds(/datum/antagonist))
			var/datum/mind/antag_mind = mind
			if(!antag_mind.current || !antag_mind.current.client || isnewplayer(antag_mind.current))
				continue
			listeners[antag_mind.current.client] = TRUE

	// Add department members
	if(channel.department_flags)
		for(var/iterated_player in GLOB.player_list)
			var/mob/iterated_mob = iterated_player
			if(iterated_mob.mind)
				var/datum/job/job = iterated_mob.mind.assigned_role
				if(job && (job.departments_bitflags & channel.department_flags))
					listeners[iterated_mob.client] = TRUE

	for(var/iterated_listener in listeners)// this is speaking to essentially everyone, you know, this is how we speak to everyone globally. or atleast how im trying to.
		var/client/iterated_client = iterated_listener// setup our clients to inform
		to_chat(iterated_client, span_oocplain("<b>The [channel.id] channel has been globally [channel.allowed ? "enabled" : "disabled"].</b>"))// inform those clients

// For the regulation of the dorks, runs the above proc using input created from a list selector populated through our glob
ADMIN_VERB(toggledeptooc, R_ADMIN, "Toggle Department OOC", "Toggles a department OOC channel.", ADMIN_CATEGORY_SERVER)// make our new verb
	var/list/options = list()// setup var for our selections
	for(var/channel_key in GLOB.department_ooc_channels)// prepare options from our glob
		var/datum/department_ooc_channel/channel = GLOB.department_ooc_channels[channel_key]// prepare our selection
		options["[channel.id] ([channel.allowed ? "Enabled" : "Disabled"])"] = channel_key// run those bits for data
	var/picked = tgui_input_list(usr, "Select a channel to toggle", "Toggle Department OOC", options)// post our sel
	if(picked)// If we picked something
		toggle_department_ooc(options[picked])// Run the toggle with our selection
		log_admin("[key_name(usr)] toggled [options[picked]] Department OOC.")// Admin log entry for doing so
		message_admins("[key_name_admin(usr)] toggled [options[picked]] Department OOC.")// Tell asay what we did
