/obj/item/circuitboard/machine/artifact_harvester
	name = "Exotic Particle Harvester"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/artifact_harvester
	req_components = list(
		/datum/stock_part/scanning_module = 2,
		/datum/stock_part/capacitor = 4,
		/datum/stock_part/servo = 2,
		/datum/stock_part/amplifier = 1,
		/datum/stock_part/filter = 1, // Exotic particles, exotic(for machinery) stock parts
	)

/obj/machinery/artifact_harvester
	name = "Exotic Particle Harvester"
	desc = "It is used to drain the energy out of the artifacts."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/machinery.dmi'
	icon_state = "harvester"
	anchored = TRUE
	density = TRUE
	idle_power_usage = 50
	active_power_usage = 750
	use_power = IDLE_POWER_USE
	// Is it harvesting right now?
	var/harvesting = FALSE
	// Is it draining battery right now?
	var/draining = FALSE
	var/obj/item/xenoarch/particles_battery/inserted_battery
	var/obj/machinery/artifact/current_artifact
	var/obj/machinery/artifact_scanpad/owned_scanner = null

/obj/machinery/artifact_harvester/Initialize(mapload)
	. = ..()
	owned_scanner = locate(/obj/machinery/artifact_scanpad) in get_step(src, dir)
	if(!owned_scanner)
		owned_scanner = locate(/obj/machinery/artifact_scanpad) in orange(1, src)
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/artifact_harvester/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, attacking_item))
		update_appearance()
		return
	if(default_pry_open(attacking_item))
		return
	if(default_deconstruction_crowbar(attacking_item))
		return
	if(istype(attacking_item, /obj/item/xenoarch/particles_battery))
		if(!inserted_battery && user.transferItemToLoc(attacking_item, src))
			user.visible_message(
				span_notice("[user] inserts [attacking_item] into [src]."),
				span_notice("You insert [attacking_item] into [src]."),
				blind_message = span_hear("You hear click."),
			)
			playsound(src, 'sound/machines/crate/crate_open.ogg', 30, 10)
			src.inserted_battery = attacking_item
			icon_state = "harvester_battery"
			ui_interact(user)
		else
			to_chat(user, span_warning("There is already a battery in [src]."))
	else
		return..()

/obj/machinery/artifact_harvester/ui_interact(mob/user)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	var/dat = "<B>Artifact Power Harvester</B><BR>"
	dat += "<HR><BR>"
	//
	if(owned_scanner)
		if(harvesting || draining)
			if(harvesting)
				dat += "Please wait. Harvesting in progress ([round((inserted_battery.stored_charge/inserted_battery.capacity)*100)]%).<br>"
				dat += "<A href='byond://?src=[REF(src)];stopharvest=1'>Halt early</A><BR>"
			if(draining)
				dat += "Please wait. Energy dump in progress ([round((inserted_battery.stored_charge/inserted_battery.capacity)*100)]%).<br>"
		else if(inserted_battery)
			dat += "<b>[inserted_battery.name]</b> inserted, charge level: [round(inserted_battery.stored_charge,1)]/[inserted_battery.capacity] ([round((inserted_battery.stored_charge/inserted_battery.capacity)*100)]%)<BR>"
			dat += "<A href='byond://?src=[REF(src)];ejectbattery=1'>Eject battery</a><BR>"
			dat += "<A href='byond://?src=[REF(src)];drainbattery=1'>Drain battery of all charge</a><BR>"
			dat += "<A href='byond://?src=[REF(src)];harvest=1'>Begin harvesting</a><BR>"

		else
			dat += "No battery inserted.<BR>"
	else
		dat += "<B><font color=red>Unable to locate analysis pad.</font><BR></b>"

	dat += "<HR>"
	dat += "<A href='byond://?src=[REF(src)];refresh=1'>Refresh</A>"

	var/datum/browser/popup = new(user, "artharvester", name, 450, 500)
	popup.set_content(dat)
	popup.open()

/obj/machinery/artifact_harvester/process(seconds_per_tick, times_fired)
	if(machine_stat & (NOPOWER|BROKEN))
		return

	if(harvesting)
		inserted_battery.stored_charge = min(inserted_battery.stored_charge + 5, inserted_battery.capacity)

		// check if we've finished
		if(inserted_battery.stored_charge >= inserted_battery.capacity)
			update_use_power(IDLE_POWER_USE)
			harvesting = FALSE
			current_artifact.anchored = FALSE
			current_artifact.being_used = FALSE
			current_artifact = null
			say("Battery is full.")
			playsound(src, 'sound/machines/beep/beep.ogg', 50, FALSE)
			icon_state = "harvester_battery"
			owned_scanner.icon_state = "xenoarch_scanner"

	else if(draining)
		// dump some charge
		inserted_battery.stored_charge = max(inserted_battery.stored_charge - 5, 0)
		// if the effect works by touch, activate it on anyone viewing the console
		if(inserted_battery.battery_effect.release_method == ARTIFACT_EFFECT_TOUCH)
			var/list/nearby = viewers(1, src)
			for(var/mob/mob_nearby in nearby)
				inserted_battery.battery_effect.do_effect_touch(mob_nearby)

		// if there's no charge left, finish
		if(inserted_battery.stored_charge <= 0)
			update_use_power(IDLE_POWER_USE)
			inserted_battery.stored_charge = 0
			draining = FALSE
			inserted_battery.battery_effect = null
			QDEL_NULL(inserted_battery.battery_effect)
			say("Battery dump completed.")
			icon_state = "harvester_battery"

/obj/machinery/artifact_harvester/Topic(href, href_list)
	. = ..()
	if(.)
		return .
	if(!usr || get_dist(src, usr) > 1)
		return

	var/needs_refresh = FALSE
	if(href_list["refresh"])
		interact(usr)
		return
	// --- HARVEST ---
	else if(href_list["harvest"])
		playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)

		if(!inserted_battery)
			say("Cannot harvest. No battery inserted.")
			return
		if(inserted_battery.stored_charge >= inserted_battery.capacity)
			say("Cannot harvest. Battery is full.")
			return
		if(!owned_scanner)
			say("Cannot harvest. Scanner not connected.")
			return

		// Find artifact on scanner turf (prefer artifacts)
		var/turf/scanner_turf = get_turf(owned_scanner)
		var/obj/machinery/artifact/analysed = locate(/obj/machinery/artifact) in scanner_turf
		if(!analysed)
			for(var/obj/machinery/artifact/scanned_object in scanner_turf)
				if(scanned_object == owned_scanner)
					continue
				if(scanned_object.invisibility || HAS_TRAIT(scanned_object, TRAIT_UNDERFLOOR))
					continue
				analysed = scanned_object
				break

		current_artifact = analysed
		if(!current_artifact)
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, 10)
			say("Cannot harvest. No noteworthy energy signature isolated.")
			return

		// If it's actually an artifact, enforce usage gating
		var/obj/machinery/artifact/scanned_artifact = current_artifact
		// Effect state sanity
		var/datum/artifact_effect/first_effect = null
		var/datum/artifact_effect/second_effect = null
		if(istype(scanned_artifact))
			if(scanned_artifact.being_used)
				playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, 10)
				say("Cannot harvest. Source already being harvested.")
				return

			first_effect = scanned_artifact.first_effect
			second_effect = scanned_artifact.secondary_effect

		// Conflicting (both active) = fail
		if((first_effect && first_effect.activated) && (second_effect && second_effect.activated))
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, 10)
			say("Cannot harvest. Source is emitting conflicting energy signatures.")
			return

		// Choose the active one
		var/datum/artifact_effect/harvested_effect = null
		if(first_effect && first_effect.activated)
			harvested_effect = first_effect
		else if(second_effect && second_effect.activated)
			harvested_effect = second_effect

		if(!harvested_effect)
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, 10)
			say("Cannot harvest. No energy emitting from source.")
			return

		// Battery signature lock: if battery has charge, it must match the same effect instance
		if(inserted_battery.stored_charge && inserted_battery.battery_effect && inserted_battery.battery_effect != harvested_effect)
			say("Cannot harvest. Battery is charged with a different energy signature.")
			return

		// Begin harvesting
		harvesting = TRUE
		update_use_power(ACTIVE_POWER_USE)
		if(istype(scanned_artifact))
			scanned_artifact.anchored = TRUE
			scanned_artifact.being_used = TRUE

		icon_state = "harvester_on"
		if(owned_scanner)
			owned_scanner.icon_state = "xenoarch_scanner_scanning"
		say("Beginning energy harvesting")

		inserted_battery.battery_effect = null
		// Duplicate the battery's effect datum
		var/new_effect_type = harvested_effect.type
		var/datum/artifact_effect/new_effect = new new_effect_type(inserted_battery)
		new_effect.maximum_charges = harvested_effect.maximum_charges
		new_effect.release_method = harvested_effect.release_method
		new_effect.range = harvested_effect.range
		new_effect.trigger = harvested_effect.trigger
		new_effect.activation_aura_cost = harvested_effect.activation_aura_cost
		new_effect.activation_pulse_cost = harvested_effect.activation_pulse_cost
		new_effect.activation_touch_cost = harvested_effect.activation_touch_cost
		new_effect.log_name = harvested_effect.log_name
		inserted_battery.battery_effect = new_effect

		needs_refresh = TRUE

	// --- STOP HARVEST ---
	else if(href_list["stopharvest"])
		playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)

		if(draining || !harvesting)
			return

		if(inserted_battery && inserted_battery.battery_effect && inserted_battery.battery_effect.activated)
			inserted_battery.battery_effect.ToggleActivate()

		harvesting = FALSE

		if(current_artifact && istype(current_artifact, /obj/machinery/artifact))
			current_artifact.anchored = FALSE
			current_artifact.being_used = FALSE

		current_artifact = null
		say("Energy harvesting interrupted.")
		icon_state = "harvester_battery"
		if(owned_scanner)
			owned_scanner.icon_state = "xenoarch_scanner"
		update_use_power(IDLE_POWER_USE)

		needs_refresh = TRUE

	// --- EJECT BATTERY ---
	else if(href_list["ejectbattery"])
		if(harvesting || draining)
			say("Battery is busy.")
			return

		playsound(src, 'sound/machines/crate/crate_open.ogg', 30, 10)

		if(inserted_battery)
			inserted_battery.forceMove(get_turf(src))
			inserted_battery.update_icon()
			inserted_battery = null

		icon_state = "harvester"
		if(owned_scanner)
			owned_scanner.icon_state = "xenoarch_scanner"

		needs_refresh = TRUE

	// --- DRAIN BATTERY ---
	else if(href_list["drainbattery"])
		if(!inserted_battery)
			say("Cannot dump energy. No battery inserted.")
			return
		if(harvesting)
			say("Cannot dump energy. Energy harvesting is initiated.")
			return
		if(!inserted_battery.stored_charge)
			say("Cannot dump energy. Battery is drained of charge already.")
			return
		if(!inserted_battery.battery_effect)
			return
		if(tgui_alert(usr, "This action will dump all charge, safety gear is recommended before proceeding", "Warning", list("Continue", "Cancel")) != "Continue")
			return

		if(!inserted_battery.battery_effect.activated)
			inserted_battery.battery_effect.ToggleActivate(TRUE)

		draining = TRUE
		update_use_power(ACTIVE_POWER_USE)
		icon_state = "harvester_on"
		if(owned_scanner)
			owned_scanner.icon_state = "xenoarch_scanner"
		say("Warning, battery charge dump commencing.")

		needs_refresh = TRUE

	// --- default: nothing matched ---
	else
		// No action keys → just refresh
		needs_refresh = TRUE

	if(needs_refresh)
		ui_interact(usr)
