/// Interdyne Autodoc — automated surgical pod that inserts organs and implants.
/// Requires ACCESS_SYNDICATE to operate controls; anyone can be a patient.

/obj/machinery/autodoc
	name = "Interdyne autodoc"
	desc = "An Interdyne Pharmaceuticals automated surgical pod. \
		Capable of performing organ transplants and implant insertions without a surgeon. \
		Requires authorization from an Interdyne representative to operate."
	icon = 'modular_nova/modules/company_imports/icons/interdyne_autodoc.dmi'
	icon_state = "autodoc"
	base_icon_state = "autodoc"
	density = TRUE
	obj_flags = BLOCKS_CONSTRUCTION
	circuit = /obj/item/circuitboard/machine/autodoc
	state_open = TRUE
	interaction_flags_mouse_drop = NEED_HANDS | NEED_DEXTERITY
	req_access = list(ACCESS_SYNDICATE)
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 2
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 2.5
	/// Items loaded into the machine for procedures (organs and implants)
	var/list/stored_items = list()
	/// Procedure queue — list of refs to items to process
	var/list/procedure_queue = list()
	/// Parallel list to procedure_queue — "insert" or "remove" for each entry
	var/list/queue_actions = list()
	/// Whether the machine is currently performing procedures
	var/operating = FALSE
	/// Current procedure index
	var/current_procedure = 0
	/// Time per procedure in deciseconds
	var/procedure_time = 60 SECONDS
	/// Maximum number of items that can be stored
	var/max_storage = 5
	COOLDOWN_DECLARE(message_cooldown)

/obj/machinery/autodoc/Initialize(mapload)
	. = ..()
	occupant_typecache = typecacheof(/mob/living/carbon/human)

/obj/machinery/autodoc/RefreshParts()
	. = ..()
	var/servo_rating = 0
	for(var/datum/stock_part/servo/servo in component_parts)
		servo_rating += servo.tier
	// Base 60s with two T1 servos (rating 2). Each upgrade step reduces by 5s. Min 30s at two T4 servos (rating 8).
	procedure_time = initial(procedure_time) - (servo_rating - 2) * (5 SECONDS)

	for(var/datum/stock_part/matter_bin/matter_bin in component_parts)
		max_storage = matter_bin.tier * 5

/obj/machinery/autodoc/on_set_is_operational(old_value)
	if(!is_operational && operating)
		abort_procedures()

/obj/machinery/autodoc/Destroy()
	for(var/atom/movable/item in stored_items)
		if(isorgan(item))
			var/obj/item/organ/organ = item
			organ.organ_flags &= ~ORGAN_FROZEN
		item.forceMove(get_turf(src))
	stored_items.Cut()
	procedure_queue.Cut()
	queue_actions.Cut()
	return ..()

/obj/machinery/autodoc/examine(mob/user)
	. = ..()
	if(occupant)
		. += span_notice("[occupant.name] is inside the surgical pod.")
	else
		. += span_notice("The surgical pod is empty.")
	if(length(stored_items))
		. += span_notice("[length(stored_items)] item\s loaded for procedures.")
	. += span_notice("Alt-click to [state_open ? "close" : "open"] the pod.")

/obj/machinery/autodoc/update_icon_state()
	if(machine_stat & (NOPOWER | BROKEN))
		icon_state = "[base_icon_state]_off"
		return ..()
	if(panel_open)
		icon_state = "[base_icon_state]_panel"
		return ..()
	if(operating)
		icon_state = "[base_icon_state]_on"
		return ..()
	icon_state = "[base_icon_state][state_open ? "_open" : ""]"
	return ..()

// --- Occupant management ---

/obj/machinery/autodoc/close_machine(atom/movable/target, density_to_set = TRUE)
	. = ..()
	update_appearance()

/obj/machinery/autodoc/open_machine(drop = TRUE, density_to_set = TRUE)
	if(operating)
		return
	. = ..()
	update_appearance()

/obj/machinery/autodoc/mouse_drop_receive(atom/target, mob/user, params)
	if(!iscarbon(target))
		return
	if(operating)
		return
	close_machine(target)

/obj/machinery/autodoc/click_alt(mob/user)
	if(operating)
		balloon_alert(user, "operating!")
		return CLICK_ACTION_BLOCKING
	if(state_open)
		close_machine()
	else
		open_machine()
	return CLICK_ACTION_SUCCESS

/obj/machinery/autodoc/relaymove(mob/living/user, direction)
	if(operating)
		if(COOLDOWN_FINISHED(src, message_cooldown))
			COOLDOWN_START(src, message_cooldown, 4 SECONDS)
			to_chat(user, span_danger("The surgical pod is locked during the procedure!"))
		return
	open_machine()

/obj/machinery/autodoc/container_resist_act(mob/living/user)
	if(operating)
		if(COOLDOWN_FINISHED(src, message_cooldown))
			COOLDOWN_START(src, message_cooldown, 4 SECONDS)
			to_chat(user, span_danger("The surgical pod is locked during the procedure!"))
		return
	open_machine()

// --- Item loading ---

/obj/machinery/autodoc/attackby(obj/item/used, mob/user, list/modifiers, list/attack_modifiers)
	if(operating)
		return
	if(isorgan(used) || istype(used, /obj/item/implant))
		if(length(stored_items) >= max_storage)
			balloon_alert(user, "storage full!")
			return
		if(!user.transferItemToLoc(used, src))
			balloon_alert(user, "can't let go!")
			return
		stored_items += used
		if(isorgan(used))
			var/obj/item/organ/organ = used
			organ.organ_flags |= ORGAN_FROZEN
		balloon_alert(user, "loaded [used.name]")
		return
	if(!occupant && default_deconstruction_screwdriver(user, icon_state, icon_state, used))
		update_appearance()
		return
	if(default_pry_open(used))
		return
	if(default_deconstruction_crowbar(used))
		return
	return ..()

// --- TGUI ---

/obj/machinery/autodoc/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InterdyneAutodoc", name)
		ui.open()

/obj/machinery/autodoc/ui_data(mob/user)
	var/list/data = list()
	data["open"] = state_open
	data["operating"] = operating
	data["hasAccess"] = allowed(user)
	data["maxStorage"] = max_storage
	data["procedureTime"] = procedure_time / 10 // deciseconds to seconds

	// Occupant data
	data["occupant"] = null
	if(occupant)
		var/mob/living/mob_occupant = occupant
		data["occupant"] = list(
			"name" = mob_occupant.name,
			"health" = mob_occupant.health,
			"maxHealth" = mob_occupant.maxHealth,
			"bruteLoss" = mob_occupant.get_brute_loss(),
			"fireLoss" = mob_occupant.get_fire_loss(),
			"toxLoss" = mob_occupant.get_tox_loss(),
			"oxyLoss" = mob_occupant.get_oxy_loss(),
			"stat" = mob_occupant.stat,
		)

	// Stored items
	data["storedItems"] = list()
	for(var/obj/item/stored_item in stored_items)
		data["storedItems"] += list(list(
			"name" = stored_item.name,
			"ref" = REF(stored_item),
			"isOrgan" = isorgan(stored_item),
		))

	// Patient organs and implants (for removal)
	data["patientOrgans"] = list()
	data["patientImplants"] = list()
	if(occupant)
		var/mob/living/carbon/patient = occupant
		for(var/obj/item/organ/organ in patient.organs)
			data["patientOrgans"] += list(list(
				"name" = organ.name,
				"ref" = REF(organ),
				"zone" = organ.zone,
			))
		for(var/obj/item/implant/implant in patient.implants)
			data["patientImplants"] += list(list(
				"name" = implant.name,
				"ref" = REF(implant),
			))

	// Procedure queue
	data["queue"] = list()
	for(var/i in 1 to length(procedure_queue))
		var/obj/item/queued_item = procedure_queue[i]
		if(!queued_item || QDELETED(queued_item))
			continue
		data["queue"] += list(list(
			"name" = queued_item.name,
			"ref" = REF(queued_item),
			"isOrgan" = isorgan(queued_item),
			"action" = queue_actions[i],
		))

	return data

/obj/machinery/autodoc/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		// Door toggle — anyone can open/close when not operating
		if("door")
			if(operating)
				return
			if(state_open)
				close_machine()
			else
				open_machine()
			return TRUE

		// All other actions require access
		if("queue_add")
			if(!allowed(usr))
				to_chat(usr, span_warning("Access denied."))
				return
			var/obj/item/target = locate(params["ref"]) in stored_items
			if(!target || (target in procedure_queue))
				return
			procedure_queue += target
			queue_actions += "insert"
			return TRUE

		if("queue_add_removal")
			if(!allowed(usr))
				to_chat(usr, span_warning("Access denied."))
				return
			if(!occupant)
				return
			var/mob/living/carbon/patient = occupant
			var/obj/item/target = locate(params["ref"]) in (patient.organs + patient.implants)
			if(!target || (target in procedure_queue))
				return
			procedure_queue += target
			queue_actions += "remove"
			return TRUE

		if("queue_remove")
			if(!allowed(usr))
				to_chat(usr, span_warning("Access denied."))
				return
			var/obj/item/target = locate(params["ref"]) in procedure_queue
			if(!target)
				return
			var/idx = procedure_queue.Find(target)
			procedure_queue.Cut(idx, idx + 1)
			queue_actions.Cut(idx, idx + 1)
			return TRUE

		if("eject_item")
			if(!allowed(usr))
				to_chat(usr, span_warning("Access denied."))
				return
			if(operating)
				return
			var/obj/item/target = locate(params["ref"]) in stored_items
			if(!target)
				return
			var/idx = procedure_queue.Find(target)
			if(idx)
				procedure_queue.Cut(idx, idx + 1)
				queue_actions.Cut(idx, idx + 1)
			stored_items -= target
			if(isorgan(target))
				var/obj/item/organ/organ = target
				organ.organ_flags &= ~ORGAN_FROZEN
			target.forceMove(get_turf(src))
			balloon_alert(usr, "ejected [target.name]")
			return TRUE

		if("start")
			if(!allowed(usr))
				to_chat(usr, span_warning("Access denied."))
				return
			if(operating || !occupant || !length(procedure_queue))
				return
			start_procedures()
			return TRUE

// --- Procedure execution ---

/obj/machinery/autodoc/proc/start_procedures()
	operating = TRUE
	current_procedure = 1
	use_power = ACTIVE_POWER_USE
	update_appearance()
	visible_message(span_notice("[src] hums to life and locks the surgical pod."))
	playsound(src, 'sound/machines/synth/synth_yes.ogg', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(perform_next_procedure)), 1 SECONDS)

/obj/machinery/autodoc/proc/perform_next_procedure()
	if(!operating || !occupant || current_procedure > length(procedure_queue))
		finish_procedures()
		return
	if(!is_operational)
		abort_procedures()
		return

	var/obj/item/current_item = procedure_queue[current_procedure]
	if(!current_item || QDELETED(current_item))
		current_procedure++
		addtimer(CALLBACK(src, PROC_REF(perform_next_procedure)), 0.5 SECONDS)
		return

	var/action = queue_actions[current_procedure]
	if(action == "remove")
		visible_message(span_notice("[src] begins removing [current_item.name]..."))
	else
		visible_message(span_notice("[src] begins inserting [current_item.name]..."))
	playsound(src, 'sound/items/weapons/circsawhit.ogg', 50, TRUE)

	addtimer(CALLBACK(src, PROC_REF(complete_procedure), current_procedure), procedure_time)

/obj/machinery/autodoc/proc/complete_procedure(procedure_index)
	if(!is_operational)
		abort_procedures()
		return
	if(!operating || !occupant)
		current_procedure++
		addtimer(CALLBACK(src, PROC_REF(perform_next_procedure)), 0.5 SECONDS)
		return

	var/obj/item/target = procedure_queue[procedure_index]
	var/action = queue_actions[procedure_index]

	if(QDELETED(target))
		current_procedure++
		addtimer(CALLBACK(src, PROC_REF(perform_next_procedure)), 0.5 SECONDS)
		return

	var/mob/living/carbon/patient = occupant
	var/success = FALSE

	switch(action)
		if("insert")
			if(isorgan(target))
				var/obj/item/organ/organ_item = target
				organ_item.organ_flags &= ~ORGAN_FROZEN
				if(try_find_empty_zone(organ_item, patient))
					success = organ_item.Insert(patient)
				if(success)
					stored_items -= target
			else if(istype(target, /obj/item/implant))
				var/obj/item/implant/implant_item = target
				success = implant_item.implant(patient, src)
				if(success)
					stored_items -= target
		if("remove")
			if(istype(target, /obj/item/implant))
				var/obj/item/implant/implant_item = target
				if(target in patient.implants)
					implant_item.removed(patient)
					target.forceMove(src)
					stored_items += target
					success = TRUE
			else if(isorgan(target))
				var/obj/item/organ/organ_item = target
				if(target in patient.organs)
					organ_item.Remove(patient)
					target.forceMove(src)
					stored_items += target
					organ_item.organ_flags |= ORGAN_FROZEN
					success = TRUE

	if(success)
		if(action == "insert")
			visible_message(span_notice("[src] successfully inserts [target.name]."))
		else
			visible_message(span_notice("[src] successfully removes [target.name]."))
		playsound(src, 'sound/machines/synth/synth_yes.ogg', 40, TRUE)
	else
		if(action == "insert")
			visible_message(span_warning("[src] fails to insert [target.name]!"))
		else
			visible_message(span_warning("[src] fails to remove [target.name]!"))
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 40, TRUE)

	current_procedure++
	addtimer(CALLBACK(src, PROC_REF(perform_next_procedure)), 1 SECONDS)

/// Checks if an organ can be inserted by finding an empty zone.
/// For organs with valid_zones (e.g. arm augments), tries each zone and swaps to an empty one.
/// Returns TRUE if a valid empty zone was found (or default slot is free), FALSE if all slots occupied.
/obj/machinery/autodoc/proc/try_find_empty_zone(obj/item/organ/organ, mob/living/carbon/patient)
	if(length(organ.valid_zones))
		for(var/zone in organ.valid_zones)
			var/check_slot = organ.valid_zones[zone]
			if(!patient.get_organ_slot(check_slot))
				organ.swap_zone(zone)
				return TRUE
		return FALSE
	return !patient.get_organ_slot(organ.slot)

/obj/machinery/autodoc/proc/finish_procedures()
	operating = FALSE
	current_procedure = 0
	use_power = IDLE_POWER_USE
	procedure_queue.Cut()
	queue_actions.Cut()
	update_appearance()
	visible_message(span_notice("[src] completes all procedures and unlocks the pod."))
	playsound(src, 'sound/machines/microwave/microwave-end.ogg', 50, TRUE)
	open_machine(drop = FALSE)
	dump_inventory_contents(stored_items + list(occupant))
	update_appearance()

/obj/machinery/autodoc/proc/abort_procedures()
	operating = FALSE
	current_procedure = 0
	use_power = IDLE_POWER_USE
	procedure_queue.Cut()
	queue_actions.Cut()
	update_appearance()
	visible_message(span_warning("[src] shuts down mid-procedure and unlocks the pod!"))
	playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 50, TRUE)
	open_machine(drop = FALSE)
	dump_inventory_contents(stored_items + list(occupant))
	update_appearance()

// --- Circuit board ---

/obj/item/circuitboard/machine/autodoc
	name = "Interdyne Autodoc"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/autodoc
	req_components = list(
		/datum/stock_part/matter_bin = 1,
		/datum/stock_part/servo = 2,
		/datum/stock_part/scanning_module = 1,
	)
