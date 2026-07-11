/obj/machinery/inspector_mainframe
	name = "Inspector Mainframe"
	desc = "A sophisticated machine capable of locking down cargo shuttles and controlling ship alert status. Its functions are accessible through a secure interface."
	icon = 'icons/obj/machines/dominator.dmi'
	icon_state = "dominator"
	base_icon_state = "dominator"
	density = TRUE
	interaction_flags_machine = INTERACT_MACHINE_REQUIRES_LITERACY
	/// Is the cargo disruption active right now?
	var/cargo_disruption_active = FALSE
	/// Are we being tracked by the GPS signals?
	var/tracked = FALSE
	/// Current alert level of the ship
	var/current_alert_level = "Status Marble"
	/// Radio for sending guild messages
	var/obj/item/radio/radio
	/// Is the SOS beacon active
	var/sos_active = FALSE
	/// Timer ID for SOS signals
	var/sos_timer_id
	/// Options for the radial menu
	var/static/list/radial_options = list(
		"Cargo Disruption" = radial_toggle,
		"Ship Alert Status" = radial_alert,
		"SOS Beacon" = radial_sos,
	)
	/// Alert level options
	var/static/list/alert_options = list(
		"Status Marble" = alert_zero,
		"Status Silver" = alert_one,
		"Status Cobalt" = alert_two,
		"Status Pearl" = alert_three,
		"Status Onyx" = alert_four,
		"Status Obsidian" = alert_five,
	)
	/// Radial menu icons
	var/static/radial_toggle = image(icon = 'icons/obj/machines/dominator.dmi', icon_state = "dominator-Blue")
	var/static/radial_alert = image(icon = 'icons/obj/machines/status_display.dmi', icon_state = "frame")
	var/static/radial_sos = image(icon = 'icons/obj/machines/status_display.dmi', icon_state = "lockdown")
	/// Alert level icons
	var/static/alert_zero = image(icon = 'icons/obj/machines/status_display.dmi', icon_state = "outline")
	var/static/alert_one = image(icon = 'icons/obj/machines/status_display.dmi', icon_state = "greenalert")
	var/static/alert_two = image(icon = 'icons/obj/machines/status_display.dmi', icon_state = "bluealert")
	var/static/alert_three = image(icon = 'icons/obj/machines/status_display.dmi', icon_state = "redalert")
	var/static/alert_four = image(icon = 'icons/obj/machines/status_display.dmi', icon_state = "deltaalert")
	var/static/alert_five = image(icon = 'icons/obj/machines/status_display.dmi', icon_state = "lockdown")

/obj/machinery/inspector_mainframe/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new /obj/item/encryptionkey/headset_syndicate/guild()
	radio.set_listening(FALSE)
	radio.recalculateChannels()
	update_appearance()

/obj/machinery/inspector_mainframe/attack_ghost(mob/user)
	examine(user)

/obj/machinery/inspector_mainframe/ui_interact(mob/user)
	. = ..()
	open_options_menu(user)

/// Opens the radial menu with available options for the inspector mainframe
/obj/machinery/inspector_mainframe/proc/open_options_menu(mob/user)
	if(machine_stat & (NOPOWER|BROKEN))
		return

	var/list/available_options = radial_options.Copy()
	if(sos_active)
		available_options = list("SOS Beacon" = radial_sos)

	var/choice = show_radial_menu(user, src, available_options, require_near = TRUE, tooltips = TRUE)

	switch(choice)
		if("Cargo Disruption")
			if(cargo_disruption_active)
				toggle_off(user)
			else
				toggle_on(user)
		if("Ship Alert Status")
			select_alert_level(user)
		if("SOS Beacon")
			toggle_sos_beacon(user)

/// Activates the cargo disruption system and thus blocks Cargo; on first activation makes us visible on GPS.
/obj/machinery/inspector_mainframe/proc/toggle_on(mob/user)
	SSshuttle.registerTradeBlockade(src)
	cargo_disruption_active = TRUE
	to_chat(user,span_notice("You toggle [src] [cargo_disruption_active ? "on":"off"]."))
	if(!tracked)
		AddComponent(/datum/component/gps, "HC Starship")
		to_chat(user,span_warning("The scrambling signal can now be tracked by GPS."))
	if(!sos_active)
		START_PROCESSING(SSobj,src)
	update_appearance()
	send_notification()

/// Deactivates the cargo disruption system and clears the trade blockade
/obj/machinery/inspector_mainframe/proc/toggle_off(mob/user)
	SSshuttle.clearTradeBlockade(src)
	cargo_disruption_active = FALSE
	if(!sos_active)
		STOP_PROCESSING(SSobj,src)
	to_chat(user,span_notice("You toggle [src] [cargo_disruption_active ? "on":"off"]."))
	update_appearance()

/// Broadcasts an SOS signal through the radio and schedules the next broadcast
/obj/machinery/inspector_mainframe/proc/broadcast_sos_signal()
	// Only broadcast if SOS is still active
	if(!sos_active)
		return

	// Play alarm sound
	playsound(src, 'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_small_09.ogg', 75, TRUE)

	// Send special messages when special statuses are active
	if(current_alert_level == "Status Obsidian")
		radio.talk_into(src, "ENCRYPTED BURST: OBSIDIAN. Self-destruct and denial protocols initiated. All assets to be denied to enemy.", RADIO_CHANNEL_GUILD)
	else
		radio.talk_into(src, "DISTRESS SIGNAL REPEATING: Requesting immediate assistance. Patrol vessel under sustained combat operations. All available units respond.", RADIO_CHANNEL_GUILD)

	// Cancel any existing timer before creating a new one to prevent stacking
	if(sos_timer_id)
		deltimer(sos_timer_id)
		sos_timer_id = null

	// Create a new timer
	sos_timer_id = addtimer(CALLBACK(src, PROC_REF(broadcast_sos_signal)), 30 SECONDS, TIMER_STOPPABLE)

/// Sends a priority announcement about signal interference and cargo lockdown
/obj/machinery/inspector_mainframe/proc/send_notification()
	priority_announce("Signal interference detected; source registered on local GPS units. Cargo shuttle systems have been locked down.")

/// Shows a radial menu for selecting the ship's alert level
/obj/machinery/inspector_mainframe/proc/select_alert_level(mob/user)
	if(machine_stat & (NOPOWER|BROKEN))
		return

	var/choice = show_radial_menu(user, src, alert_options, require_near = TRUE, tooltips = TRUE)

	switch(choice)
		if("Status Marble")
			set_alert_level("Status Marble", "STANDBY/ADMINISTRATIVE. The patrol is in a secure, non-hostile environment. This includes being docked \
			at a Coalition-controlled starbase, in transit through fully secured Coalition space, or undergoing maintenance and resupply in a friendly port. \
			The threat of hostile action is assessed as negligible. All personal weapons are to be secured in the armory. \
			Ship-based defensive systems may be powered down to standby mode to conserve energy.", user)
		if("Status Silver")
			set_alert_level("Status Silver", "ROUTINE PATROL/STANDARD INSPECTION. The patrol is approaching or has begun initial interactions with a non-Coalition \
			facility under Standard Inspection Protocols. The facility is presumed compliant but not yet trusted. \
			All personal weapons are to be holstered but authorized for immediate draw. Weapon safeties may be disengaged at the individual officer's discretion \
			based on perceived threat. Ship defensive systems are active and scanning.", user)
		if("Status Cobalt")
			set_alert_level("Status Cobalt", "ELEVATED THREAT/VIOLATION OF PROTOCOL. One or more Standard Procedures have been violated, or anomalous but not yet \
			overtly hostile activity is detected. All personnel must draw weapons and hold them at low-ready. \
			Ship thrusters are to be kept spooled for immediate maneuver. Defensive shields are raised to tactical strength. High alert. Inspection may be \
			halted and teams recalled to the ship or ordered to hold position and fortify.", user)
		if("Status Pearl")
			set_alert_level("Status Pearl", "HOSTILE INTENT CONFIRMED. Direct, unambiguous evidence of hostile intent has been identified. This includes weapon discharge \
			towards patrol personnel, attempted boarding of the patrol vessel, active targeting by a Bluespace Artillery Cannon, or a declared threat against the \
			patrol. Weapons free. All defensive systems are at full power. The ship is to maneuver to a tactical advantage. \
			All personnel to battle stations. Preemptive self-defense protocols are authorized.", user)
		if("Status Onyx")
			set_alert_level("Status Onyx", "SUSTAINED COMBAT OPERATIONS. The patrol is engaged in a full-scale battle. Escape may not be immediately possible, \
			and the patrol must fight its way out. Total warfare. All weapons and systems are to be used to their maximum effectiveness. \
			Damage control teams are active. The focus is on neutralizing targets of opportunity and creating an opening for extraction. \
			The primary objective is to neutralize all threats to the patrol to allow for extraction.", user)
		if("Status Obsidian")
			set_alert_level("Status Obsidian", "BROKEN ARROW/DENIAL OF ASSETS. The patrol vessel is irrecoverably compromised, with capture or destruction \
			imminent. The primary mission has failed. The new objective is to ensure that no Coalition personnel, technology, intelligence, or the vessel \
			itself can be exploited by the enemy. All classified data, mission logs, and personnel records are to be purged from all systems. The crew \
			is expected to fight until the vessel is destroyed or all hands are lost.", user)

/// Sets the ship's alert level and notifies the crew via radio
/obj/machinery/inspector_mainframe/proc/set_alert_level(level_name, level_description, mob/user)
	if(current_alert_level == level_name)
		balloon_alert(user, "alert level unchanged!")
		return

	current_alert_level = level_name
	to_chat(user, span_notice("You set the ship alert status to [level_name]."))
	radio.talk_into(src, "ALERT LEVEL CHANGED: [level_name] - [level_description]", RADIO_CHANNEL_GUILD)
	balloon_alert(user, "alert level updated")
	playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, TRUE)
	update_appearance()

/// Toggles the SOS beacon on or off, can only be activated at Status Onyx or Status Obsidian
/obj/machinery/inspector_mainframe/proc/toggle_sos_beacon(mob/user)
	if(machine_stat & (NOPOWER|BROKEN))
		return

	if(current_alert_level != "Status Onyx" && current_alert_level != "Status Obsidian")
		balloon_alert(user, "requires status four or five!")
		to_chat(user, span_warning("The SOS beacon can only be activated when the ship is at Status Onyx or Status Obsidian."))
		return

	sos_active = !sos_active
	if(sos_active)
		if(!cargo_disruption_active)
			START_PROCESSING(SSobj, src)
		to_chat(user, span_notice("You activate the SOS beacon."))
		balloon_alert(user, "distress beacon activated!")
		playsound(src, 'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_small_09.ogg', 75, TRUE)
		if(current_alert_level == "Status Obsidian")
			radio.talk_into(src, "ENCRYPTED BURST: OBSIDIAN. Self-destruct and denial protocols initiated. All assets to be denied to the enemy.", RADIO_CHANNEL_GUILD)
		else
			radio.talk_into(src, "EMERGENCY DISTRESS SIGNAL ACTIVATED. Requesting immediate assistance. Patrol vessel under sustained combat operations. All available units respond.", RADIO_CHANNEL_GUILD)
		addtimer(CALLBACK(src, PROC_REF(broadcast_sos_signal)), 30 SECONDS, TIMER_STOPPABLE)
	else
		if(!cargo_disruption_active)
			STOP_PROCESSING(SSobj, src)
		// Cancel the SOS timer
		if(sos_timer_id)
			deltimer(sos_timer_id)
			sos_timer_id = null
		to_chat(user, span_notice("You deactivate the SOS beacon."))
		balloon_alert(user, "distress beacon deactivated!")
		playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, TRUE)
		radio.talk_into(src, "Distress signal deactivated.", RADIO_CHANNEL_GUILD)
	update_appearance()

/obj/machinery/inspector_mainframe/update_icon_state()
	icon_state = cargo_disruption_active ? "[base_icon_state]-Blue" : base_icon_state
	return ..()

/obj/machinery/inspector_mainframe/Destroy(force)
	toggle_off()
	// Cancel any pending SOS timer
	if(sos_timer_id)
		deltimer(sos_timer_id)
		sos_timer_id = null
	QDEL_NULL(radio)
	return ..()

/obj/machinery/inspector_mainframe/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: System is [cargo_disruption_active ? "ACTIVE" : "INACTIVE"]. Current alert level: [current_alert_level]. SOS beacon: [sos_active ? "ACTIVE" : "INACTIVE"].")
