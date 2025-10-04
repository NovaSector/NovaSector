/obj/machinery/ammo_workbench
	name = "ammunition workbench"
	desc = "A machine specifically made for manufacturing ammunition. Fits anything ammo-related, from magazines and stripper clips to boxes."
	icon = 'modular_nova/modules/ammo_workbench/icons/ammo_workbench.dmi'
	icon_state = "ammobench"
	density = TRUE
	use_power = IDLE_POWER_USE
	// active power usage taken from autolathes
	active_power_usage = 0.025 * STANDARD_CELL_RATE
	circuit = /obj/item/circuitboard/machine/ammo_workbench
	var/busy = FALSE
	var/error_message = ""
	var/error_type = ""
	var/disk_error = ""
	var/disk_error_type = ""
	var/timer_id
	var/turbo_boost = FALSE
	var/obj/item/ammo_box/loaded_magazine = null
	var/obj/item/ammo_workbench_module/loaded_module = null
	/// A list of all possible ammo types.
	var/list/possible_ammo_types = list()
	// hello future codediver. open to suggestions on how to do the following without it sucking so badly
	/// what casings we're able to use
	var/list/valid_casings = list()
	/// the material requirement strings for these casings (for the tooltip)
	var/list/casing_mat_strings = list()
	/// bitflags for allowed ammo types (see modular_nova/modules/ammo_workbench/code/ammo_bench_defines.dm)
	var/ammo_categories = NONE
	/// current multiplier for material cost per round
	var/creation_efficiency = 1.4
	/// current amount of time in deciseconds it takes to assemble a round
	var/time_per_round = 1.8 SECONDS
	/// multiplier for material cost per round (when turbo isn't enabled)
	var/base_efficiency = 1.4
	/// deciseconds per round (when turbo isn't enabled)
	var/base_time_per_round = 1.8 SECONDS
	/// deciseconds per round (when turbo is enabled)
	var/turbo_time_per_round = 0.225 SECONDS
	/// multiplier for material cost per round (when turbo is enabled)
	var/turbo_efficiency = 2.8
	/// can this print any round of any caliber given a correct ammo_box? (you varedit this at your own risk, especially if used in a player-facing context.)
	/// does not force ammo to load in. just makes it able to print wacky ammotypes e.g. lionhunter 7.62, techshells
	var/adminbus = FALSE

/obj/machinery/ammo_workbench/unlocked
	ammo_categories = AMMO_ALL_TYPES

/obj/item/circuitboard/machine/ammo_workbench
	name = "Ammunition Workbench"
	icon_state = "circuit_map"
	build_path = /obj/machinery/ammo_workbench
	req_components = list(
		/datum/stock_part/servo = 2,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2
	)

/obj/machinery/ammo_workbench/Initialize(mapload)
	AddComponent( \
		/datum/component/material_container, \
		SSmaterials.materials_by_category[MAT_CATEGORY_ITEM_MATERIAL], \
		200000, \
		MATCONTAINER_EXAMINE, \
		allowed_items = /obj/item/stack, \
	)
	. = ..()

/obj/machinery/ammo_workbench/examine(mob/user)
	. += ..()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Storing up to <b>[materials.max_amount]</b> material units.<br>\
			Material consumption at <b>[creation_efficiency*100]%</b>.")

/obj/machinery/ammo_workbench/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AmmoWorkbench")
		ui.open()

/obj/machinery/ammo_workbench/proc/update_ammotypes()
	LAZYCLEARLIST(valid_casings)
	LAZYCLEARLIST(casing_mat_strings)
	if(!loaded_magazine)
		return
	var/obj/item/ammo_casing/ammo_type = loaded_magazine.ammo_type
	var/ammo_caliber = initial(ammo_type.caliber)
	var/obj/item/ammo_casing/ammo_parent_type = type2parent(ammo_type)

	if(ammo_caliber == initial(ammo_parent_type.caliber) && ammo_caliber != null)
		ammo_type = ammo_parent_type
	possible_ammo_types = typesof(ammo_type)

	for(var/obj/item/ammo_casing/our_casing as anything in possible_ammo_types) // this is a list of TYPES, not INSTANCES
		if(!adminbus)
			if(!(initial(our_casing.can_be_printed))) // if we're not supposed to be printed (looking at you, smartgun rails)
				continue // go home
			if(!((initial(our_casing.ammo_categories) & ammo_categories) == our_casing.ammo_categories)) // categorical mismatch?
				continue // nuh uh
		if(initial(our_casing.projectile_type) == null) // spent casing subtypes >:(
			continue
		// i'm very sorry for this, but literally every other thing i tried to get the material composition didn't copy at all
		var/obj/item/ammo_casing/casing_actual = new our_casing
		var/list/raw_casing_mats = casing_actual.get_material_composition()
		var/list/efficient_casing_mats = list()
		qdel(casing_actual)
		for(var/material in raw_casing_mats)
			efficient_casing_mats[material] = raw_casing_mats[material] * creation_efficiency
		var/mat_string = ""

		for(var/i in 1 to length(efficient_casing_mats))
			var/datum/material/our_material = efficient_casing_mats[i]
			mat_string += "[efficient_casing_mats[our_material]] cm³ [our_material.name]"
			if(i == length(efficient_casing_mats))
				mat_string += " per cartridge"
			else
				mat_string += ", "

		valid_casings += our_casing // adding the valid typepath
		valid_casings[our_casing] = initial(our_casing.name)
		casing_mat_strings += mat_string // adding the casing material cost string
		// we pray to god these indexes stay consistent.

/obj/machinery/ammo_workbench/ui_data(mob/user)
	var/list/data = list()

	data["datadisk_loaded"] = FALSE
	data["datadisk_name"] = null
	data["datadisk_desc"] = null

	data["disk_error"] = disk_error
	data["disk_error_type"] = disk_error_type

	if(loaded_module)
		data["datadisk_loaded"] = TRUE
		data["datadisk_name"] = loaded_module.name
		data["datadisk_desc"] = loaded_module.desc

	data["mag_loaded"] = FALSE
	data["error"] = null
	data["error_type"] = null
	data["system_busy"] = busy

	data["efficiency"] = creation_efficiency
	data["time"] = time_per_round / 10
	data["turboBoost"] = turbo_boost

	data["materials"] = list()
	var/datum/component/material_container/mat_container = GetComponent(/datum/component/material_container)
	if (mat_container)
		for(var/mat in mat_container.materials)
			var/datum/material/material = mat
			var/amount = mat_container.materials[material]
			var/sheet_amount = amount / SHEET_MATERIAL_AMOUNT
			var/ref = REF(material)
			data["materials"] += list(list("name" = material.name, "id" = ref, "amount" = sheet_amount))

	if(error_message)
		data["error"] = error_message
		data["error_type"] = error_type
	else if(busy)
		data["error"] = "System is busy."
		data["error_type"] = ""

	if(!loaded_magazine)
		data["error"] = "No ammunition container detected."
		data["error_type"] = ""
		return data
	else
		data["mag_loaded"] = TRUE

	data["available_rounds"] = list()

	for(var/casings_to_relay = 1 to length(valid_casings))
		var/typepath = valid_casings[casings_to_relay]
		data["available_rounds"] += list(list(
			"name" = valid_casings[typepath],
			"typepath" = typepath,
			"mats_list" = casing_mat_strings[casings_to_relay]
		))

	data["mag_name"] = loaded_magazine.name
	data["current_rounds"] = length(loaded_magazine.stored_ammo)
	data["max_rounds"] = loaded_magazine.max_ammo

	return data

/obj/machinery/ammo_workbench/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!isliving(usr))
		return
	switch(action)
		if("EjectMag")
			eject_ammobox(usr)
			. = TRUE

		if("FillMagazine")
			var/type_to_pass = text2path(params["selected_type"])
			fill_magazine_start(type_to_pass)
			. = TRUE

		if("Release")

			var/datum/component/material_container/mat_container = GetComponent(/datum/component/material_container)

			if(!mat_container)
				return
			var/datum/material/mat = locate(params["id"])

			var/amount = mat_container.materials[mat]
			if(!amount)
				return

			var/stored_amount = CEILING(amount / SHEET_MATERIAL_AMOUNT, 0.1)

			if(!stored_amount)
				return

			var/desired = 0
			if (params["sheets"])
				desired = text2num(params["sheets"])

			var/sheets_to_remove = round(min(desired,50,stored_amount))

			mat_container.retrieve_stack(sheets_to_remove, mat, loc)
			. = TRUE

		if("ReadDisk")
			loadDisk()

		if("EjectDisk")
			eject_disk(usr)

		if("turboBoost")
			toggle_turbo_boost()

/**
 * Toggles this ammo bench's turbo setting.
 * If it's on, uses the turbo time-per-round/efficiency;
 * if off, resets to base time-per-round/efficiency.
 * `forced_off` forces turbo off.
 */
/obj/machinery/ammo_workbench/proc/toggle_turbo_boost(forced_off = FALSE)
	if(forced_off)
		turbo_boost = FALSE
	else
		turbo_boost = !turbo_boost

	if(turbo_boost)
		time_per_round = turbo_time_per_round
		creation_efficiency = turbo_efficiency
	else
		time_per_round = base_time_per_round
		creation_efficiency = base_efficiency
	update_ammotypes()

/obj/machinery/ammo_workbench/proc/eject_ammobox(mob/living/user)
	if(loaded_magazine)
		loaded_magazine.forceMove(drop_location())

		if(user)
			try_put_in_hand(loaded_magazine, user)

		loaded_magazine = null
	busy = FALSE
	error_message = ""
	error_type = ""
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	update_ammotypes()
	update_appearance()

/obj/machinery/ammo_workbench/proc/fill_magazine_start(obj/item/ammo_casing/casing_type)
	if(machine_stat & (NOPOWER|BROKEN))
		busy = FALSE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return

	if(error_message)
		error_message = ""
		error_type = ""

	if(!(casing_type in possible_ammo_types))
		error_message = "Ammunition type mismatch!"
		error_type = "bad"
		ammo_fill_finish(FALSE)
		return

	if(loaded_magazine.stored_ammo.len >= loaded_magazine.max_ammo)
		error_message = "Ammunition container full."
		error_type = "good"
		ammo_fill_finish(TRUE)
		return

	if(busy)
		return

	busy = TRUE

	timer_id = addtimer(CALLBACK(src, PROC_REF(fill_round), casing_type), time_per_round, TIMER_STOPPABLE)

/obj/machinery/ammo_workbench/proc/fill_round(obj/item/ammo_casing/casing_type)
	if(machine_stat & (NOPOWER|BROKEN))
		busy = FALSE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return

	if(!loaded_magazine)
		return

	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)

	var/obj/item/ammo_casing/new_casing = new casing_type

	var/list/required_materials = new_casing.get_material_composition()
	var/list/efficient_materials = list()

	for(var/material in required_materials)
		efficient_materials[material] = required_materials[material] * creation_efficiency

	if(!materials.has_materials(efficient_materials))
		error_message = "Materials insufficient!"
		error_type = "bad"
		ammo_fill_finish(FALSE)
		qdel(new_casing)
		return

	if(new_casing.type in possible_ammo_types)
		if(!loaded_magazine.give_round(new_casing))
			error_message = "Unable to insert ammunition...?"
			error_type = "bad"
			ammo_fill_finish(FALSE)
			qdel(new_casing)
			return
		materials.use_materials(efficient_materials)
		new_casing.set_custom_materials(efficient_materials)
		loaded_magazine.update_appearance()
		flick("ammobench_process", src)
		use_energy(active_power_usage)
		playsound(loc, 'sound/machines/piston/piston_raise.ogg', 60, 1)
	else
		qdel(new_casing)
		ammo_fill_finish(FALSE)
		return

	if(loaded_magazine.stored_ammo.len >= loaded_magazine.max_ammo)
		ammo_fill_finish(TRUE)
		error_message = "Ammunition container full."
		error_type = "good"
		return

	SStgui.update_uis(src)

	timer_id = addtimer(CALLBACK(src, PROC_REF(fill_round), casing_type), time_per_round, TIMER_STOPPABLE)

/obj/machinery/ammo_workbench/proc/ammo_fill_finish(successfully = TRUE)
	SStgui.update_uis(src)
	if(successfully)
		playsound(loc, 'sound/machines/ping.ogg', 40, TRUE)
	else
		playsound(loc, 'sound/machines/buzz/buzz-sigh.ogg', 40, TRUE)
	update_appearance()
	busy = FALSE
	if(timer_id)
		deltimer(timer_id)
		timer_id = null

/obj/machinery/ammo_workbench/proc/loadDisk()
	disk_error = ""
	disk_error_type = ""
	if(!loaded_module)
		disk_error = "No disk detected!"
		disk_error_type = "bad"
		return FALSE

	disk_error = "Disk loaded successfully."
	disk_error_type = "good"
	return TRUE

/obj/machinery/ammo_workbench/proc/eject_disk(mob/user)
	if(loaded_module)
		try_put_in_hand(loaded_module, user)
		loaded_module = null
		ammo_categories = initial(ammo_categories)
		update_ammotypes()
		disk_error = ""
		disk_error_type = ""

/datum/design/board/ammo_workbench
	name = "Ammunition Workbench"
	desc = "A machine made specifically for manufacturing ammunition."
	id = "ammo_workbench"
	build_path = /obj/item/circuitboard/machine/ammo_workbench
	category = list(RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

//MISC MACHINE PROCS

/obj/machinery/ammo_workbench/RefreshParts()
	. = ..()
	toggle_turbo_boost(forced_off = TRUE) // forces turbo off
	var/time_efficiency = 1.8 SECONDS
	for(var/datum/stock_part/micro_laser/new_laser in component_parts)
		time_efficiency -= new_laser.tier * 2 // there's two lasers
		// time_eff prog with paired lasers is 1.4 -> 1.0 -> 0.6 -> 0.2 seconds per round
	time_per_round = clamp(time_efficiency, 1, 20)
	base_time_per_round = time_per_round
	turbo_time_per_round = time_efficiency / 8

	var/efficiency = 1.4
	for(var/datum/stock_part/servo/new_servo in component_parts)
		efficiency -= new_servo.tier * 0.1 // there's two servos

	creation_efficiency = max(0, efficiency) // with paired servos of appropriate tier, progression is 1.2 -> 1 -> 0.8 -> 0.6
	base_efficiency = creation_efficiency
	turbo_efficiency = creation_efficiency * 2

	var/mat_capacity = 0
	for(var/datum/stock_part/matter_bin/new_matter_bin in component_parts)
		mat_capacity += new_matter_bin.tier * (40 * SHEET_MATERIAL_AMOUNT)

	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.max_amount = mat_capacity
	update_ammotypes()

/obj/machinery/ammo_workbench/update_overlays()
	. = ..()
	if(loaded_magazine)
		. += "ammobench_loaded"

/obj/machinery/ammo_workbench/Destroy()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	if(loaded_magazine)
		loaded_magazine.forceMove(loc)
		loaded_magazine = null

	return ..()

/obj/machinery/ammo_workbench/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(default_deconstruction_screwdriver(user, "[initial(icon_state)]_t", initial(icon_state), attacking_item))
		return
	if(default_deconstruction_crowbar(attacking_item))
		return
	if(Insert_Item(attacking_item, user))
		return TRUE
	else
		return ..()

/obj/machinery/ammo_workbench/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()

	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src, ALLOW_SILICON_REACH | FORBID_TELEKINESIS_REACH))
		return

	eject_ammobox(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/ammo_workbench/attack_robot_secondary(mob/user, list/modifiers)
	return attack_hand_secondary(user, modifiers)

/obj/machinery/ammo_workbench/attack_ai_secondary(mob/user, list/modifiers)
	return attack_hand_secondary(user, modifiers)

/obj/machinery/ammo_workbench/proc/Insert_Item(obj/item/inserted, mob/living/user)
	if(user.combat_mode)
		return FALSE
	if(!is_insertion_ready(user, inserted))
		return FALSE
	if(istype(inserted, /obj/item/ammo_box))
		if(!user.transferItemToLoc(inserted, src))
			return FALSE
		if(loaded_magazine)
			loaded_magazine.forceMove(drop_location())
			user.put_in_hands(loaded_magazine)
			loaded_magazine = null
			busy = FALSE
			error_message = ""
			error_type = ""
			if(timer_id)
				deltimer(timer_id)
				timer_id = null
		loaded_magazine = inserted
		to_chat(user, span_notice("You insert [inserted] into [src]'s reciprocal."))
		flick("h_lathe_load", src)
		update_appearance()
		update_ammotypes()
		playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)
		return TRUE
	if(istype(inserted, /obj/item/ammo_workbench_module))
		if(!user.transferItemToLoc(inserted, src))
			return FALSE
		if(loaded_module)
			loaded_module.forceMove(drop_location())
			user.put_in_hands(loaded_module)
			loaded_module = null
			busy = FALSE
			error_message = ""
			error_type = ""
			if(timer_id)
				deltimer(timer_id)
				timer_id = null
		loaded_module = inserted
		ammo_categories = loaded_module.ammo_categories
		to_chat(user, span_notice("You insert [inserted] into [src]'s module port."))
		flick("h_lathe_load", src)
		update_appearance()
		update_ammotypes()
		playsound(loc, 'sound/machines/terminal/terminal_insert_disc.ogg', 35, 1)
		return TRUE
	return FALSE

/obj/machinery/ammo_workbench/proc/is_insertion_ready(mob/user, obj/item/inserted)
	if(panel_open)
		to_chat(user, span_warning("You can't load [src] while it's opened!"))
		return FALSE
	if(machine_stat & BROKEN)
		to_chat(user, span_warning("[src] is broken."))
		return FALSE
	if(machine_stat & NOPOWER)
		to_chat(user, span_warning("[src] has no power."))
		return FALSE
	return TRUE

/obj/item/flatpack/ammo_workbench
	name = "flatpacked ammunition workbench"
	board = /obj/item/circuitboard/machine/ammo_workbench
