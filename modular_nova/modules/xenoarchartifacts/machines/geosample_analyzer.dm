/obj/item/circuitboard/machine/radiocarbon_spectrometer
	name = "Radiocarbon spectrometer"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/radiocarbon_spectrometer
	req_components = list(
		/datum/stock_part/scanning_module = 4,
		/obj/item/reagent_containers/cup/beaker = 1,
		/obj/item/stack/sheet/glass = 1,
	)

/obj/machinery/radiocarbon_spectrometer
	name = "Radiocarbon spectrometer"
	desc = "A specialised, complex scanner for gleaning information on all manner of small things."
	anchored = TRUE
	density = TRUE
	icon = 'modular_nova/modules/xenoarchartifacts/icons/machinery.dmi'
	icon_state = "spectrometer"

	circuit = /obj/item/circuitboard/machine/radiocarbon_spectrometer

	use_power = IDLE_POWER_USE // 1 = idle, 2 = active
	idle_power_usage = 20
	active_power_usage = 3000
	// Are we scanning right now?
	var/scanning = FALSE
	// Sample of the rock we need to scan
	var/obj/item/xenoarch/core_sampler/current_sample

/obj/machinery/radiocarbon_spectrometer/attackby(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, attacking_item))
		update_appearance()
		return
	if(default_pry_open(attacking_item))
		return
	if(default_deconstruction_crowbar(attacking_item))
		return
	if(istype(attacking_item, /obj/item/xenoarch/core_sampler))
		var/obj/item/xenoarch/core_sampler/sampler = attacking_item
		if(!powered())
			return
		if(scanning)
			to_chat(user, span_notice("The machine is currently working."))
			return
		if(!sampler.sample)
			balloon_alert(user, "core sampler is empty!")
			return
		if(!user.transferItemToLoc(sampler, src))
			to_chat(user, span_warning("\The [sampler] is stuck to your hand, you cannot put it in the machine!"))
			return TRUE
		current_sample = sampler
		scanning = TRUE
		user.visible_message(
			span_notice("[user] inserts [sampler] into [src]."),
			span_notice("You insert [sampler] into [src]."),
			blind_message = span_notice("You hear click nearby."),
		)
		process_sample()
	else
		balloon_alert(user, "geosamples only!")
	return ..()

/**
 * Tries to process inserted geosample.
 * Takes 10 seconds.
 */
/obj/machinery/radiocarbon_spectrometer/proc/process_sample()
	var/data = ""
	if(powered())
		update_use_power(ACTIVE_POWER_USE)
		icon_state = "spectrometer_processing"
		var/obj/structure/boulder/current_boulder = current_sample.sample
		var/age = current_boulder.artifact_age
		data = "Mundane object (archaic xenos origins)<br>"
		data += "<B>Spectometric analysis on mineral sample has determined type of required field: [current_boulder.artifact_stabilizing_field]</B><BR>"
		data += "<HR>"
		if (age > 1000000000)
			data += " - Radiometric dating shows age of approximate [round(age/1000000000)] billion years<br>"
		else if (age > 1000000)
			data += " - Radiometric dating shows age of approximate [round(age/1000000)] million years<br>"
		else
			data += " - Radiometric dating shows age of approximate [round(age/1000)] thousand years<br>"
		data += " - Hyperspectral imaging reveals exotic energy wavelength detected with ID: [current_boulder.artifact_id]<br>"
		sleep(10 SECONDS)
	else
		fail_scan()
		return
	if(powered()) // Double check if still powered after sleep
		var/obj/item/paper/artifact_info/artifact_report = new(get_turf(src))
		artifact_report.name = "[src] report"
		artifact_report.add_raw_text(data)
		artifact_report.update_icon()
		var/obj/item/stamp/granted/our_stamp = new
		var/stamp_data = our_stamp.get_writing_implement_details()
		artifact_report.add_stamp(stamp_data["stamp_class"], rand(0, 300), rand(0, 400), rand(0, 360), stamp_data["stamp_icon_state"])
		playsound(src, 'sound/machines/printer.ogg', 25, FALSE)
		scanning = FALSE
		icon_state = "spectrometer"
		update_use_power(IDLE_POWER_USE)
	else
		fail_scan()

/**
 * Used in process() to fail the scan
 */
/obj/machinery/radiocarbon_spectrometer/proc/fail_scan()
	qdel(current_sample)
	current_sample = NONE
	scanning = FALSE
	icon_state = "spectrometer"
	update_use_power(IDLE_POWER_USE)
	visible_message(
		span_warning("[src] destroys core sampler due to internal error."),
		blind_message = span_warning("You hear machine whirling."),
	)
