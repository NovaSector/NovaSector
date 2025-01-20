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

/obj/machinery/artifact_harvester/attackby(obj/I, mob/user)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		update_appearance()
		return
	if(default_pry_open(I))
		return
	if(default_deconstruction_crowbar(I))
		return
	if(istype(I, /obj/item/xenoarch/particles_battery))
		if(!inserted_battery && user.transferItemToLoc(I, src))
			user.visible_message(
				span_notice("[user] inserts [I] into [src]."),
				span_notice("You insert [I] into [src]."),
				blind_message = span_hear("You hear click."),
			)
			playsound(src, 'sound/machines/crate/crate_open.ogg', 30, 10)
			src.inserted_battery = I
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
	if(!usr)
		return
	if(.)
		return
	if(href_list["harvest"])
		playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)

		if(!inserted_battery)
			say("Cannot harvest. No battery inserted.")
			return
		if(inserted_battery.stored_charge == inserted_battery.capacity)
			say("Cannot harvest. battery is full.")
			return

		// locate artifact on analysis pad
		current_artifact = null
		var/obj/machinery/artifact/analysed
		for(var/obj/machinery/artifact/Artifact in get_turf(owned_scanner))
			analysed = Artifact
			if(analysed.being_used)
				say("Cannot harvest. Source already being harvested.")
				playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, 10)
				return
		current_artifact = analysed
		if(!current_artifact)
			var/message = "Cannot harvest. No noteworthy energy signature isolated."
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, 10)
			say(message)
			return

		// if both effects arent active, we cant harvest anything
		if(current_artifact.first_effect && !current_artifact.first_effect.activated  && !current_artifact?.secondary_effect?.activated)
			say("Cannot harvest. No energy emitting from source.")
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, 10)
			return

		// if both effects are active, we cant harvest anything
		if(current_artifact.first_effect && current_artifact.first_effect.activated && current_artifact.secondary_effect && current_artifact.secondary_effect.activated)
			say("Cannot harvest. Source is emitting conflicting energy signatures.")
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50, 10)
			return

		var/datum/artifact_effect/harvested_effect
		if(current_artifact.first_effect.activated)
			harvested_effect = current_artifact.first_effect
		else
			if(current_artifact.secondary_effect && current_artifact.secondary_effect.activated)
				harvested_effect = current_artifact.secondary_effect

		// if we already have charge in the battery, we can only recharge it from the source artifact
		if(inserted_battery.stored_charge)
			if(inserted_battery.battery_effect != harvested_effect)
				say("Cannot harvest. Battery is charged with a different energy signature.")
				return

		harvesting = TRUE
		update_use_power(ACTIVE_POWER_USE)
		current_artifact.anchored = TRUE
		current_artifact.being_used = TRUE
		icon_state = "harvester_on"
		owned_scanner.icon_state = "xenoarch_scanner_scanning"
		say("Beginning energy harvesting")

		inserted_battery.battery_effect = null
		// duplicate the artifact's effect datum
		if(!inserted_battery.battery_effect)
			var/new_effect_type = harvested_effect.type
			var/datum/artifact_effect/new_battery_effect = new new_effect_type(inserted_battery)
			for(var/varname in list("maximum_charges", "release_method", "range", "trigger", "activation_aura_cost", "activation_pulse_cost", "activation_touch_cost", "log_name"))
				new_battery_effect.vars[varname] = harvested_effect.vars[varname]
			inserted_battery.battery_effect = new_battery_effect

	if(href_list["stopharvest"])
		playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)
		if(draining)
			return
		if(!harvesting)
			return
		if(inserted_battery.battery_effect && inserted_battery.battery_effect.activated)
			inserted_battery.battery_effect.ToggleActivate()
		harvesting = FALSE
		current_artifact.anchored = FALSE
		current_artifact.being_used = FALSE
		current_artifact = null
		say("Energy harvesting interrupted.")
		icon_state = "harvester_battery"
		owned_scanner.icon_state = "xenoarch_scanner"
		update_use_power(IDLE_POWER_USE)
		ui_interact(usr)

	if(href_list["ejectbattery"])
		if(harvesting || draining)
			say("Battery is busy.")
			return
		playsound(src, 'sound/machines/crate/crate_open.ogg', 30, 10)
		src.inserted_battery.loc = src.loc
		inserted_battery.update_icon()
		src.inserted_battery = null
		icon_state = "harvester"
		owned_scanner.icon_state = "xenoarch_scanner"
		ui_interact(usr)

	if(href_list["drainbattery"])
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
		owned_scanner.icon_state = "xenoarch_scanner"
		say("Warning, battery charge dump commencing.")

	ui_interact(usr)
