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

/obj/machinery/status_display/syndie
	name = "syndicate status display"

/obj/machinery/status_display/syndie/post_machine_initialize()
	. = ..()
	set_picture("synd")

#undef NOVA_ALERTS_ICON_FILE
