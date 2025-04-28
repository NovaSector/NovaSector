#define WIRE_UNLINK "Unlink"
#define WIRE_TEST "Test"
#define WIRE_LINK "Link"

/datum/wires/rbmk2_sniffer
	holder_type = /obj/machinery/rbmk2_sniffer
	proper_name = "RB-MK2 Sniffer"

/datum/wires/rbmk2_sniffer/New(atom/holder)
	wires = list(
		WIRE_SIGNAL,
		WIRE_PROCEED,
		WIRE_LINK,
		WIRE_UNLINK,
		WIRE_TEST,
	)
	. = ..()

/datum/wires/rbmk2_sniffer/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/rbmk2_sniffer/sniffer = holder
	return sniffer.panel_open

/datum/wires/rbmk2_sniffer/get_status()
	var/obj/machinery/rbmk2_sniffer/sniffer = holder
	. = list()
	. += "The radio light is [sniffer.radio_enabled ? "blinking red" : "off"]."
	if(sniffer.link_confirm)
		. += "The LED display is displaying \"LINK CONFIRM?\"."
	else if(sniffer.unlink_confirm)
		. += "The LED display is displaying \"UNLINK CONFIRM?\"."
	else
		. += "The LED display is displaying nothing."

/datum/wires/rbmk2_sniffer/on_pulse(wire, user)
	var/obj/machinery/rbmk2_sniffer/sniffer = holder
	switch(wire)
		if(WIRE_LINK)
			if(sniffer.unlink_confirm || sniffer.link_confirm)
				sniffer.unlink_confirm = FALSE
				sniffer.link_confirm = FALSE
			else
				sniffer.link_confirm = TRUE
		if(WIRE_UNLINK)
			if(sniffer.unlink_confirm || sniffer.link_confirm)
				sniffer.unlink_confirm = FALSE
				sniffer.link_confirm = FALSE
			else
				sniffer.unlink_confirm = TRUE
		if(WIRE_PROCEED)
			if(sniffer.unlink_confirm)
				var/unlink_amount = 0
				for(var/obj/machinery/power/rbmk2/reactor as anything in sniffer.linked_reactors)
					unlink_amount += sniffer.unlink_reactor(user, reactor)
			if(sniffer.link_confirm)
				var/link_amount = 0
				for(var/obj/machinery/power/rbmk2/reactor in range(10, sniffer))
					link_amount += sniffer.link_reactor(user, reactor)
			sniffer.link_confirm = FALSE
			sniffer.unlink_confirm = FALSE
		if(WIRE_TEST)
			sniffer.alert_radio("This is a test message. Do not panic.", alert_emergency_channel = sniffer.test_wire_switch, bypass_cooldown = TRUE)
			sniffer.test_wire_switch = !sniffer.test_wire_switch

/datum/wires/rbmk2_sniffer/on_cut(wire, mend, source)
	var/obj/machinery/rbmk2_sniffer/sniffer = holder
	switch(wire)
		if(WIRE_SIGNAL)
			sniffer.radio_enabled = mend
		if(WIRE_LINK)
			sniffer.link_confirm = FALSE
		if(WIRE_UNLINK)
			sniffer.unlink_confirm = FALSE
		if(WIRE_PROCEED)
			sniffer.link_confirm = FALSE
			sniffer.unlink_confirm = FALSE

/datum/wires/rbmk2_sniffer/can_reveal_wires(mob/user)
	if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		return TRUE
	return ..()

#undef WIRE_LINK
#undef WIRE_UNLINK
#undef WIRE_TEST
