/obj/item/circuitboard/machine/rbmk2_sniffer
	name = "RB-MK2 \"Boombox\" sniffer"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/rbmk2_sniffer
	req_components = list(
		/obj/item/stack/cable_coil = 4,
		/obj/item/stack/sheet/mineral/uranium = 1,
	)
	needs_anchored = TRUE

/obj/machinery/rbmk2_sniffer
	name = "\improper RB-MK2 \"Boombox\" reactor sniffer"
	desc = "A modified air alarm designed to detect stray ionization particles, AKA a meltdown. Can be linked to nearby RB-MK2 machines by interacting with the wires."
	icon = 'modular_nova/modules/RBMK2/icons/reactor_stuff.dmi'
	icon_state = "reactor_sniffer"
	base_icon_state = "reactor_sniffer"
	density = FALSE
	anchored = TRUE

	use_power = IDLE_POWER_USE

	max_integrity = 100

	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 0.05
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.02
	power_channel = AREA_USAGE_ENVIRON

	circuit = /obj/item/circuitboard/machine/rbmk2_sniffer

	/// The last meltdown state detected by the sniffer.
	var/last_meltdown = FALSE
	/// The last criticality value detected by the sniffer.
	var/last_criticality = 0
	/// The last integrity value detected by the sniffer.
	var/last_integrity = 100
	/// Has the sniffer alerted the emergency channel?
	var/alerted_emergency_channel = FALSE
	/// All the reactors the sniffer is linked to.
	var/list/obj/machinery/power/rbmk2/linked_reactors = list()

	resistance_flags = FIRE_PROOF

	// Vars for the wires.
	var/radio_enabled = TRUE
	var/link_confirm = FALSE
	var/unlink_confirm = FALSE
	var/test_wire_switch = FALSE
	/// Internal radio.
	var/obj/item/radio/stored_radio
	/// The key our internal radio uses
	var/radio_key = /obj/item/encryptionkey/headset_eng
	/// Need null to actually broadcast to common. Stolen from supermatter code.
	var/emergency_channel = null
	var/warning_channel = RADIO_CHANNEL_ENGINEERING

	COOLDOWN_DECLARE(radio_cooldown_integrity)
	COOLDOWN_DECLARE(radio_cooldown_criticality)

/obj/machinery/rbmk2_sniffer/Initialize(mapload, ndir, nbuild)
	. = ..()

	set_wires(new /datum/wires/rbmk2_sniffer(src))

	if(ndir)
		setDir(ndir)

	stored_radio = new(src)
	stored_radio.keyslot = new radio_key
	stored_radio.set_listening(FALSE)
	stored_radio.recalculateChannels()

	find_and_hang_on_wall()

	if(mapload)
		for(var/obj/machinery/power/rbmk2/reactor in range(10, src))
			link_reactor(null, reactor)

/obj/machinery/rbmk2_sniffer/update_icon()
	. = ..()

	if(machine_stat & (NOPOWER|BROKEN))
		icon_state = "reactor_sniffer"
	else
		if(last_meltdown)
			icon_state = "reactor_sniffer_bad"
		else
			icon_state = "reactor_sniffer_good"

/obj/machinery/rbmk2_sniffer/update_overlays()
	. = ..()
	if(panel_open)
		. += "reactor_sniffer_panel"

/obj/machinery/rbmk2_sniffer/Destroy()
	. = ..()

	for(var/obj/machinery/power/rbmk2/reactor as anything in linked_reactors)
		unlink_reactor(desired_reactor = reactor)

	QDEL_NULL(stored_radio)

/obj/machinery/rbmk2_sniffer/screwdriver_act(mob/living/user, obj/item/attack_item)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, attack_item))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/rbmk2_sniffer/crowbar_act(mob/living/user, obj/item/attack_item)
	if(default_deconstruction_crowbar(attack_item))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/rbmk2_sniffer/multitool_act(mob/living/user, obj/item/multitool/tool)
	if(panel_open)
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS

/obj/machinery/rbmk2_sniffer/wirecutter_act(mob/living/user, obj/item/tool)
	if(panel_open)
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS

/obj/machinery/rbmk2_sniffer/proc/link_reactor(mob/user, obj/machinery/power/rbmk2/desired_reactor)
	if(desired_reactor in linked_reactors)
		balloon_alert(user, "already linked!")
		return FALSE

	linked_reactors[desired_reactor] = TRUE
	desired_reactor.linked_sniffers[src] = TRUE

	return TRUE

/obj/machinery/rbmk2_sniffer/proc/unlink_reactor(mob/user, obj/machinery/power/rbmk2/desired_reactor)
	if(!(desired_reactor in linked_reactors))
		return FALSE

	linked_reactors.Remove(desired_reactor)
	desired_reactor.linked_sniffers.Remove(src)

	return TRUE

/obj/machinery/rbmk2_sniffer/examine(mob/user)
	. = ..()

	. += "It is linked to [length(linked_reactors)] reactor(s)."

	if(last_meltdown)
		. += span_danger("It is flashing red!")
	else
		. += span_notice("It is glowing a steady green.")

/obj/machinery/rbmk2_sniffer/proc/alert_radio(alert_text, bypass_cooldown = FALSE, alert_emergency_channel = FALSE, criticality = TRUE)
	if(!radio_enabled || !alert_text)
		return FALSE

	if(!bypass_cooldown) //This section of code handles cooldowns.
		if(criticality)
			if(!COOLDOWN_FINISHED(src, radio_cooldown_criticality))
				return FALSE
			COOLDOWN_START(src, radio_cooldown_criticality, (criticality >= 100 ? 10 SECONDS : 5 SECONDS))
		else
			if(!COOLDOWN_FINISHED(src, radio_cooldown_integrity))
				return FALSE
			COOLDOWN_START(src, radio_cooldown_integrity, 5 SECONDS)

	stored_radio.talk_into(src, alert_text, alert_emergency_channel ? emergency_channel : warning_channel)

	playsound(src, 'sound/effects/alert.ogg', 50, TRUE)

	return TRUE

/obj/machinery/rbmk2_sniffer/process(seconds_per_tick)
	if(machine_stat & (NOPOWER|BROKEN))
		return FALSE

	var/highest_criticality = 0
	var/lowest_integrity_percent = 1
	var/has_meltdown = FALSE

	for(var/obj/machinery/power/rbmk2/reactor as anything in linked_reactors)
		if(!reactor.active)
			continue
		var/integrity_percent = reactor.get_integrity()/reactor.max_integrity
		if(integrity_percent <= lowest_integrity_percent)
			lowest_integrity_percent = integrity_percent
			if(lowest_integrity_percent <= 0.8)
				has_meltdown = TRUE
		if(!reactor.meltdown)
			continue
		has_meltdown = TRUE
		if(reactor.criticality <= highest_criticality)
			continue
		highest_criticality = reactor.criticality

	var/alert_emergency_channel = highest_criticality >= 70 || lowest_integrity_percent <= 0.2

	if(alert_emergency_channel)
		alerted_emergency_channel = TRUE

	if(last_meltdown != has_meltdown)
		last_meltdown = has_meltdown
		if(last_meltdown)
			alert_radio(
				"Stray ionization detected! Reduce power output immediately!",
				bypass_cooldown = TRUE,
			)
		else
			alert_radio(
				"Stray ionization process halted. Returning to safe operating parameters.",
				bypass_cooldown = TRUE,
				alert_emergency_channel = alerted_emergency_channel,
			)
			alerted_emergency_channel = FALSE
	else if( highest_criticality >= 100 || abs(highest_criticality - last_criticality) >= 3 )
		last_criticality = highest_criticality
		if(highest_criticality >= 100)
			alert_radio(
				"CRITICALITY THRESHOLD MET! SEEK SHELTER IMMEDIATELY! CRITICALITY AT [round(last_criticality, 0.1)]%!",
				bypass_cooldown = TRUE,
				alert_emergency_channel = alert_emergency_channel,
			)
		else
			alert_radio(
				"Stray ionization detected! Criticality at [round(last_criticality, 0.1)]%!",
				alert_emergency_channel = alert_emergency_channel,
			)

	if(lowest_integrity_percent <= 0.8)
		last_integrity = lowest_integrity_percent
		if(abs(highest_criticality - last_criticality) >= 0.05 || lowest_integrity_percent <= 0.3)
			alert_radio(
				"[lowest_integrity_percent <= 0.3 ? "DANGER!" : "Warning!"] integrity at [round(lowest_integrity_percent*100, 0.1)]%! Perform repairs immediately!",
				alert_emergency_channel = alert_emergency_channel,
				criticality = FALSE,
				bypass_cooldown = lowest_integrity_percent <= 0.3,
			)

	update_appearance(UPDATE_ICON)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/rbmk2_sniffer, 24)
