/// GPS tracking module for proteans - allows crew to track them when in suit form
/obj/item/mod/module/gps/protean
	name = "MOD integrated positioning system"
	desc = "This module uses common galactic positioning technology to calculate the user's position anywhere in space, showing their position to crew monitors and tracking consoles."
	icon_state = "gps"
	module_type = MODULE_TOGGLE
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/gps)
	cooldown_time = 0 SECONDS
	/// Whether the GPS is broadcasting to crew monitors
	var/crew_monitor_mode = TRUE
	/// Internal GPS component
	var/obj/item/gps/internal_gps

/obj/item/mod/module/gps/protean/Initialize(mapload)
	. = ..()
	internal_gps = new /obj/item/gps(src)
	internal_gps.gpstag = "Protean"

/obj/item/mod/module/gps/protean/on_activation()
	. = ..()
	if(!.)
		return
	START_PROCESSING(SSobj, src)
	to_chat(mod.wearer, span_notice("GPS tracking enabled. Your location is now visible[crew_monitor_mode ? " on crew monitors" : " to tracking devices"]."))

/obj/item/mod/module/gps/protean/on_deactivation(display_message, deleting = FALSE)
	. = ..()
	if(!.)
		return
	STOP_PROCESSING(SSobj, src)
	to_chat(mod.wearer, span_notice("GPS tracking disabled."))

/obj/item/mod/module/gps/protean/process(seconds_per_tick)
	if(!active || !mod.wearer)
		return PROCESS_KILL

	// Broadcast to crew monitor if enabled
	if(crew_monitor_mode)
		broadcast_to_crew_monitor()

/obj/item/mod/module/gps/protean/proc/broadcast_to_crew_monitor()
	var/mob/living/carbon/human/protean = mod.wearer
	if(!istype(protean))
		return

	// Just keep the GPS active for crew tracking
	// The GPS system handles the positioning

/obj/item/mod/module/gps/protean/ui_action_click()
	if(!mod.wearer)
		return

	var/choice = tgui_alert(mod.wearer, "GPS Configuration", "Protean GPS", list("Toggle Crew Monitor", "Toggle GPS", "Cancel"))

	switch(choice)
		if("Toggle Crew Monitor")
			crew_monitor_mode = !crew_monitor_mode
			to_chat(mod.wearer, span_notice("Crew monitor broadcasting [crew_monitor_mode ? "enabled" : "disabled"]."))
		if("Toggle GPS")
			. = ..()

/obj/item/mod/module/gps/protean/get_configuration()
	. = ..()
	.["crew_monitor"] = add_ui_configuration("Crew Monitor", "bool", crew_monitor_mode)

/obj/item/mod/module/gps/protean/configure_edit(key, value)
	switch(key)
		if("crew_monitor")
			crew_monitor_mode = text2num(value)

// GPS module installation moved to protean_species.dm outfit_handling proc

