/obj/item/circuitboard/machine/artifact_analyser
	name = "Artifact Scanner"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/artifact_analyser
	req_components = list(
		/datum/stock_part/scanning_module = 2,
		/obj/item/stack/sheet/glass = 1,
	)

/obj/machinery/artifact_analyser
	name = "Anomaly Analyser"
	desc = "Studies the emissions of anomalous materials to discover their uses."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/machinery.dmi'
	icon_state = "xenoarch_console"
	anchored = TRUE
	density = TRUE

	circuit = /obj/item/circuitboard/machine/artifact_analyser

	/// Are we scanning
	var/scan_in_progress = FALSE
	/// Our scanpad
	var/obj/machinery/artifact_scanpad/owned_scanner = null
	/// How long have we been scanning
	var/scan_completion_time = 0
	/// How long do we need to scan
	var/scan_duration = 100
	/// What do we scan
	var/obj/scanned_object
	/// We can count scan nums to insert them into report
	var/report_num = 0

/obj/machinery/artifact_analyser/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/artifact_analyser/attackby(obj/item/used, mob/user, params)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, used))
		update_appearance()
		return
	if(default_pry_open(used))
		return
	if(default_deconstruction_crowbar(used))
		return
	return ..()

/**
 * Tries to reconnect nearby scanpad to itself
 */
/obj/machinery/artifact_analyser/proc/reconnect_scanner()
	//connect to a nearby scanner pad
	owned_scanner = locate(/obj/machinery/artifact_scanpad) in get_step(src, dir)
	if(!owned_scanner)
		owned_scanner = locate(/obj/machinery/artifact_scanpad) in orange(1, src)

/obj/machinery/artifact_analyser/ui_interact(mob/user)
	if(machine_stat & (NOPOWER|BROKEN) || !Adjacent(user) && !issilicon(user) && !isobserver(user))
		return
	var/dat = "<B>Anomalous material analyser</B><BR>"
	dat += "<HR>"
	if(!owned_scanner)
		owned_scanner = locate() in orange(1, src)

	if(!owned_scanner)
		dat += "<b><font color=red>Unable to locate analysis pad.</font></b><br>"
	else if(scan_in_progress)
		dat += "Please wait. Analysis in progress.<br>"
		dat += "<a href='byond://?src=[REF(src)];halt_scan=1'>Halt scanning</a><br>"
	else
		dat += "Scanner is ready.<br>"
		dat += "<a href='byond://?src=[REF(src)];begin_scan=1'>Begin scanning</a><br>"

	dat += "<br>"
	dat += "<hr>"

	var/datum/browser/popup = new(user, "artanalyser", name, 450, 500, nref = src)
	popup.set_content(dat)
	popup.open()

// Special paper for the science tool
/obj/item/paper/artifact_info
	var/artifact_type
	var/artifact_first_effect
	var/artifact_second_effect

/obj/machinery/artifact_analyser/process(seconds_per_tick, times_fired)
	if(scan_in_progress && world.time > scan_completion_time)
		// finish scanning
		scan_in_progress = FALSE
		if(usr)
			ui_interact(usr)

		// print results
		var/results = ""
		if(!owned_scanner)
			reconnect_scanner()
		if(!owned_scanner)
			results = "Error communicating with scanner."
			playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 25, FALSE)
		else if(!scanned_object || get_turf(scanned_object) != get_turf(owned_scanner))
			results = "Unable to locate scanned object. Ensure it was not moved in the process."
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 25, FALSE)
		else
			results = get_scan_info(scanned_object)
		owned_scanner.icon_state = "xenoarch_scanner"
		say("Scanning complete.")
		var/obj/item/paper/artifact_info/artifact_report = new(get_turf(src))
		artifact_report.name = "[src] report #[++report_num]"
		artifact_report.add_raw_text("<b>[src] analysis report #[report_num]</b><br>")
		artifact_report.add_raw_text("<br>")
		artifact_report.add_raw_text("[scanned_object] [results]")
		artifact_report.update_icon()

		var/obj/item/stamp/our_stamp = new
		var/stamp_data = our_stamp.get_writing_implement_details()
		artifact_report.add_stamp(stamp_data["stamp_class"], rand(0, 300), rand(0, 400), rand(0, 360), stamp_data["stamp_icon_state"])
		playsound(src, 'sound/machines/printer.ogg', 25, FALSE)

		if(scanned_object && istype(scanned_object, /obj/machinery/artifact))
			var/obj/machinery/artifact/scanned_artifact = scanned_object
			artifact_report.artifact_type = scanned_artifact.name
			if(scanned_artifact.first_effect)
				artifact_report.artifact_first_effect = scanned_artifact.first_effect.log_name
			if(scanned_artifact.secondary_effect)
				artifact_report.artifact_second_effect = scanned_artifact.secondary_effect.log_name
			scanned_artifact.being_used = 0

/obj/machinery/artifact_analyser/Topic(href, href_list)
	. = ..()
	if(!usr)
		return
	if(.)
		return
	if(href_list["close"])
		playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)
		return FALSE
	if(href_list["begin_scan"])
		playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)
		if(!owned_scanner)
			reconnect_scanner()
		if(owned_scanner)
			var/artifact_in_use = 0
			for(var/obj/being_scanned in owned_scanner.loc)
				if(being_scanned == owned_scanner)
					continue
				if(being_scanned.invisibility)
					continue
				if(istype(scanned_object, /obj/machinery/artifact))
					var/obj/machinery/artifact/scanned_artifact = scanned_object
					if(scanned_artifact.being_used)
						artifact_in_use = 1
					else
						scanned_artifact.being_used = 1

				if(artifact_in_use)
					say("Cannot scan. Too much interference.")
					playsound(src, 'sound/machines/buzz/buzz-two.ogg', 25, FALSE)
				else
					scanned_object = being_scanned
					scan_in_progress = 1
					scan_completion_time = world.time + scan_duration
					say("Scanning begun.")
					owned_scanner.icon_state = "xenoarch_scanner_scanning"
					flick("xenoarch_console_working", src)
				break
			if(!scanned_object)
				say("Unable to isolate scan target.")
	if(href_list["halt_scan"])
		playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)
		owned_scanner.icon_state = "xenoarch_scanner"
		scan_in_progress = 0
		say("Scanning halted.")

	ui_interact(usr)

/**
 * Returns fluff info about artifacts
 *
 * Arguments:
 * * scanned_obj - object to get info about
 */
/obj/machinery/artifact_analyser/proc/get_scan_info(obj/scanned_obj)
	switch(scanned_obj.type)
		if(/obj/machinery/auto_cloner)
			return "Automated cloning pod - appears to rely on organic nanomachines with a self perpetuating \
			ecosystem involving self cannibalism and a symbiotic relationship with the contained liquid.<br><br>\
			Structure is composed of a carbo-titanium alloy with interlaced reinforcing energy fields, and the contained liquid \
			resembles proto-plasmic residue supportive of single cellular developmental conditions."
		if(/obj/structure/constructshell)
			return "Tribal idol - Item resembles statues/emblems built by superstitious pre-warp civilisations to honour their gods. Material appears to be a \
			rock/plastcrete composite."
		if(/obj/machinery/replicator)
			return "Automated construction unit - Item appears to be able to synthesize synthetic items, some with simple internal circuitry. Method unknown, \
			phasing suggested?"
		if(/obj/machinery/power/crystal)
			return "Crystal formation - Pseudo organic crystalline matrix, unlikely to have formed naturally. No known technology exists to synthesize this exact composition. \
			Attention: energetic excitement is noticed. The appearance of current is possible. Connect the crystal to the network, using wrench and wires on it. Make sure there is a cable underneath."
		if(/obj/machinery/artifact/bluespace_crystal)
			return "Crystal formation - An extraordinary big example of bluespace crystal. Deep scan indicates presence of anomalous fluctuations inside. Secondary scan indicates unusual \
			activity around moving objects."
		if (/obj/vehicle/sealed/mecha/reticence/artifact)
			return "Mechanical exosuit - Age scan reveals data incompatibility. Object seems to be very old, yet modernly fitted with weapons and unknown constant cloaking field generator. \
			Also, sensors detect traces of ectoplasm inside the cockpit. The only possible way this exosuit got here is a timewarp or a sensor malfunction."
		if (/obj/vehicle/sealed/mecha/odysseus/artifact)
			return "Mechanical exosuit - Age scan reveals data incompatibility. Object seems to be very old, but design is almost identitcal to odysseus mech. \
			The only possible way this exosuit got here is a timewarp or a sensor malfunction."
		if (/obj/vehicle/sealed/mecha/savannah_ivanov/artifact)
			return "Mechanical exosuit - Age scan reveals data incompatibility. Object seems to be very old, but yet belongs to the Third Sovient Union era, which is \
			not that old in global terms. Mechanical drives of this example are hopelessly rusted and repair in unlikely. Internal structure is almost identical to \
			Savannah Ivanov exosuit, which implies this is a prototype. Designers seem to be focused on making the mech tough, since the deep scan indicates heavy armor layers both \
			in the outer shell and internal components. Comparing to the standard Savannah Ivanov, this example is 25% tougher, but twice as slow. \
			The only possible way this exosuit got here is a timewarp or a sensor malfunction."
		if (/obj/vehicle/sealed/mecha/durand/artifact)
			return "Mechanical exosuit - Age scan reveals data incompatibility. Object seems to be very old, but it is a Durand-like exosuit with 93% of internal components \
			being identical to the Nanotrasen Durand exosuit. The only real difference is slightly better placement of servomotors. Deep scan indicates, that due to the time it \
			spent in the rock, its armor layers deteriorated. The only possible way this exosuit got here is a timewarp or a sensor malfunction."
		if(/obj/machinery/artifact) // a fun one
			var/obj/machinery/artifact/scanned_artifact = scanned_obj
			var/out = "Anomalous alien device - composed of an unknown alloy.<br><br>"

			if(scanned_artifact.first_effect)
				out += scanned_artifact.first_effect.get_description()

			if(scanned_artifact.secondary_effect)
				out += "<br><br>Internal scans indicate ongoing secondary activity<br><br>"
				out += scanned_artifact.secondary_effect.get_description()

			return out
		else
			// it was an ordinary item
			return "[scanned_obj.name] - Mundane application."
