/obj/machinery/posialert
	name = "automated positronic alert console"
	desc = "A console that will ping when a positronic personality is available for download."
	icon = 'modular_nova/modules/positronic_alert_console/icons/terminals.dmi'
	icon_state = "posialert"
	// to create a cooldown so if roboticists are tired of ghosts
	COOLDOWN_DECLARE(robotics_cooldown)
	/// the reason that the console is muted (player decided)
	var/mute_reason
	// to create a cooldown so ghosts cannot spam it
	COOLDOWN_DECLARE(ghost_cooldown)
	/// The radio channel used to send messages.
	var/announcement_channel = RADIO_CHANNEL_SCIENCE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/posialert, 28)

/obj/machinery/posialert/examine(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, robotics_cooldown))
		. += span_notice("Remaining time on mute is [COOLDOWN_TIMELEFT(src, robotics_cooldown) * 0.1] seconds.")
		. += span_notice("Mute reason: [mute_reason]")
	. += span_notice("Press the screen to mute or unmute the console.")

/obj/machinery/posialert/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, robotics_cooldown))
		COOLDOWN_RESET(src, robotics_cooldown)
		to_chat(user, span_notice("You have removed the mute on [src]."))
		return
	mute_reason = null
	mute_reason = stripped_input(user, "What would the reason for the mute be? (max characters is 20)", "Mute Reason", "", 20)
	if(!mute_reason)
		to_chat(user, span_warning("[src] requires a reason to mute!"))
		return
	COOLDOWN_START(src, robotics_cooldown, 5 MINUTES)
	to_chat(user, span_notice("You have muted [src] for five minutes."))

/obj/machinery/posialert/attack_ghost(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, robotics_cooldown))
		to_chat(user, span_warning("[src] has been muted! Remaining time on mute is [COOLDOWN_TIMELEFT(src, robotics_cooldown) * 0.1] seconds."))
		to_chat(user, span_warning("[src]'s mute reason: [mute_reason]"))
		return
	if(!COOLDOWN_FINISHED(src, ghost_cooldown))
		to_chat(user, span_warning("[src] is currently still on cooldown! Remaining time on cooldown is [COOLDOWN_TIMELEFT(src, ghost_cooldown) * 0.1] seconds."))
		return
	COOLDOWN_START(src, ghost_cooldown, 30 SECONDS)
	flick("posialertflash",src)
	say("There are positronic personalities available.")
	aas_config_announce(/datum/aas_config_entry/posibrain_alert, list(), src, list(announcement_channel))
	playsound(loc, 'sound/machines/ping.ogg', 50)

/datum/aas_config_entry/posibrain_alert
	name = "Science Alert: New Positronic Brain Available"
	announcement_lines_map = list(
		"Message" = "There are positronic personalities available.",
	)
	general_tooltip = "Broadcasted when a new personality is available for download in posibrain."

/datum/aas_config_entry/posibrain_alert/act_up()
	. = ..()
	if (.)
		return

	announcement_lines_map["Message"] = pick(
		"R/NT1M3 A= ANNOUN-*#nt_SY!?EM.dm, LI%£ 86: N=0DE NULL!",
		"New version of SyndieOS downloaded and ready for installation. Please proceed to robotics.",
		"ERR)#R - B*@ TEXT F*O(ND!")
