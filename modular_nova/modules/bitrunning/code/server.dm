/datum/aas_config_entry/bitrunning_ghost_mark
	name = "Bitrunning Alert: New Digital Message"
	announcement_lines_map = list(
		"Message" = "You have: a new message: from %NAME: %MESSAGE")
	vars_and_tooltips_map = list(
		"NAME" = "will be replaced with their username.",
		"MESSAGE" = "with the content of their message."
	)

/obj/machinery/quantum_server
	///List of ckeys containing players who have recently sent a message, players on this list are prohibited from sending a new one untill their ckey disappears.
	var/list/spam_queue = list()
	///Toggles whether the server accepts new messages or not.
	var/message_protected = FALSE
	///Maximum amount of connections that can be added via domain anchors. 1 for T1, 2 for T2, etc.
	var/max_anchors = -1
	///Current amount of used domain anchors.
	var/current_anchors = 0

/obj/machinery/quantum_server/post_machine_initialize()
	. = ..()

/obj/machinery/quantum_server/Destroy()
	spam_queue = null
	return ..()

/obj/machinery/quantum_server/examine(mob/user)
	. = ..()
	if(max_anchors >= 1)
		. += span_infoplain("- Its domain vulnerability scanners permit for up to [max_anchors] domain anchors to be used.")
	. += span_notice("Any preloaded SNPC patterns, 'ghastly Resonance apparitions', or connected bitrunners can leave a custom-written message on the quantum server, \
	causing a small, audible blip and sending a department message, indicating their activity to on-station bitrunners.")
	. += span_notice("Its <b>messaging protection</b> is currently: <b>[message_protected ? "enabled" : "disabled"]</b>")

/obj/machinery/quantum_server/RefreshParts()
	. = ..()
	var/datum/stock_part/scanning_module/scanner = locate() in component_parts
	if(scanner)
		max_anchors = scanner.tier

/obj/machinery/quantum_server/reset(fast = FALSE)
	. = ..()
	current_anchors = initial(current_anchors)

/obj/machinery/quantum_server/attack_ghost(mob/user)
	. = ..()
	if(!is_operational)
		return

	if(message_protected)
		balloon_alert(user, "message protected!")
		return

	for(var/player_key in spam_queue)
		if(player_key == user.ckey)
			balloon_alert(user, "spam protection active!")
			return
	ghost_mark(user)

/obj/machinery/quantum_server/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	message_protected = !message_protected
	balloon_alert(user, "message protection [message_protected ? "enabled" : "disabled"]!")

/// 'Marks' the server with the ghost's presence: their custom-written message, and the ckey added to the spam-prevention list.
/obj/machinery/quantum_server/proc/ghost_mark(mob/activator)
	var/message = tgui_input_text(activator, "Write your message", "Holonet Gaming Network", max_length = MAX_PLAQUE_LEN)
	if(!message)
		return
	var/messenger = tgui_input_text(activator, "Set your username", "Holonet Gaming Network", max_length = MAX_NAME_LEN)
	if(!messenger)
		messenger = pick(GLOB.hacker_aliases)
	if(message_protected)
		balloon_alert(activator, "message protected!")
		return
	playsound(loc, 'sound/machines/ectoscope_beep.ogg', 75)
	aas_config_announce(/datum/aas_config_entry/bitrunning_ghost_mark, list("NAME" = messenger, "MESSAGE" = message), src, list(RADIO_CHANNEL_FACTION))
	if(activator?.ckey)
		spam_queue += activator.ckey
		addtimer(CALLBACK(src, PROC_REF(clear_spam), activator.ckey), 30 SECONDS, TIMER_UNIQUE | TIMER_STOPPABLE | TIMER_DELETE_ME)
	activator.log_message("[activator] (as '[messenger]') sent the following quantum server message: '[message]'", LOG_TELECOMMS)

///Removes the ghost from the spam_queue list and lets them know they are free to message again.
/obj/machinery/quantum_server/proc/clear_spam(ghost_ckey)
	spam_queue -= ghost_ckey
	var/mob/ghost = get_mob_by_ckey(ghost_ckey)
	if(!ghost || isliving(ghost))
		return
	to_chat(ghost, "[FOLLOW_LINK(ghost, src)] <span class='nicegreen'>The spam protection of [src] has deactivated.</span>")
