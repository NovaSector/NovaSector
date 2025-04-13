#define NOVA_ALERTS_ICON_FILE 'modular_nova/master_files/icons/obj/machines/status_display.dmi'

// Additional alert levels
GLOBAL_LIST_INIT(alert_picture_options_nova, list(
		"Violet Alert" = "violetalert",
		"Orange Alert" = "orangealert",
		"Amber Alert" = "amberalert",
		"Gamma Alert" = "gammaalert",
		"Epsilon Alert" = "epsilonalert",
		"Federal Alert" = "federalalert",
))

// Change the icon based on if we are using our alerts or TG's
/obj/machinery/status_display/set_picture(state)

	if(state == "default" || state == "synd" || state == "bluealert")
		icon = NOVA_ALERTS_ICON_FILE
		return ..(state)

	for(var/picture_key in GLOB.alert_picture_options_nova)
		if(GLOB.alert_picture_options_nova[picture_key] == state)
			icon = NOVA_ALERTS_ICON_FILE
			return ..(state)

	icon = initial(icon)
	return ..(state)

/obj/machinery/status_display/post_machine_initialize()
	. = ..()
	set_picture("default")

/obj/machinery/status_display/evac
	var/static/list/alert_list = list(
		"greenalert",
		"bluealert",
		"violetalert",
		"orangealert",
		"amberalert",
		"redalert",
		"deltaalert",
		"gammaalert",
		"epsilonalert",
		"federalalert",
	)

/obj/machinery/status_display/evac/Initialize(mapload, ndir, building)
	. = ..()
	RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, PROC_REF(on_sec_level_change))

/obj/machinery/status_display/evac/Destroy()
	. = ..()
	UnregisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED)

/obj/machinery/status_display/evac/proc/on_sec_level_change(datum/source, new_level)
	SIGNAL_HANDLER
	if(current_mode != SD_PICTURE)
		return
	if(!(current_picture in alert_list))
		return

	var/datum/security_level/alert_level = SSsecurity_level.available_levels[SSsecurity_level.number_level_to_text(new_level)]
	set_picture(alert_level.status_display_icon_state)

/obj/machinery/status_display/syndie
	name = "syndicate status display"

/obj/machinery/status_display/syndie/post_machine_initialize()
	. = ..()
	set_picture("synd")

#undef NOVA_ALERTS_ICON_FILE
