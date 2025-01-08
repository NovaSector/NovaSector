/obj/machinery/quantum_server
	///List of ckeys containing players who have recently activated the device, players on this list are prohibited from activating the device untill their residue decays.
	var/list/spam_queue = list()

/obj/machinery/quantum_server/attack_ghost(mob/user)
	. = ..()
	if(!is_operational)
		return

	for(var/player_key in spam_queue)
		if(player_key == user.ckey)
			return
	ghost_mark(user)

/obj/machinery/quantum_server/proc/ghost_mark(mob/activator)
	if(!use_energy(active_power_usage, force = FALSE))
		return
	var/message = tgui_input_text(activator, "Send a play request", "Holonet Gaming Network", max_length = MAX_PLAQUE_LEN)
	if(!message)
		return
	var/messenger = tgui_input_text(activator, "Set your username", "Holonet Gaming Network", max_length = MAX_NAME_LEN)
	if(!messenger)
		messenger = pick(GLOB.hacker_aliases)
	playsound(loc, 'sound/machines/ectoscope_beep.ogg', 75)
	radio.talk_into(src, "You have a new message from [messenger]: [message]", RADIO_CHANNEL_SUPPLY)
	if(activator?.ckey)
		spam_queue += activator.ckey
		addtimer(CALLBACK(src, PROC_REF(clear_spam), activator.ckey), 15 SECONDS)

/obj/machinery/quantum_server/Destroy()
	spam_queue = null
	. = ..()

/obj/machinery/quantum_server/examine(mob/user)
	. = ..()
	. += span_notice("Any intercepted Resonance patterns, 'ghastly apparitions', or connected bitrunners can leave a custom-written play request on the quantum server, \
	causing a small, audible blip and sending message, indicating their activity to on-station bitrunners.")

///Removes the ghost from the ectoplasmic_residues list and lets them know they are free to activate the sniffer again.
/obj/machinery/quantum_server/proc/clear_spam(ghost_ckey)
	spam_queue -= ghost_ckey
	var/mob/ghost = get_mob_by_ckey(ghost_ckey)
	if(!ghost || isliving(ghost))
		return
	to_chat(ghost, "[FOLLOW_LINK(ghost, src)] <span class='nicegreen'>The spam protection of [src] has deactivated.</span>")
