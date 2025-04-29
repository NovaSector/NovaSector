/obj/machinery/meter/monitored
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/machinery/meter"
	post_init_icon_state = "meter"
	/// The unique string that represents which atmos chamber to associate with.
	var/chamber_id

/obj/machinery/meter/monitored/Initialize(mapload, new_piping_layer)
	id_tag = assign_random_name()
	if(mapload)
		GLOB.map_loaded_sensors[chamber_id] = id_tag
	. = ..()

/obj/machinery/meter/monitored/layer2
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/machinery/meter"
	post_init_icon_state = "meter"
	target_layer = 2

/obj/machinery/meter/monitored/layer4
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/machinery/meter"
	post_init_icon_state = "meter"
	target_layer = 4

/obj/machinery/meter/monitored/waste_loop
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/machinery/meter"
	post_init_icon_state = "meter"
	name = "waste loop gas flow meter"
	chamber_id = ATMOS_GAS_MONITOR_WASTE

/obj/machinery/meter/monitored/distro_loop
	icon = 'icons/map_icons/items.dmi'
	icon_state = "/obj/machinery/meter"
	post_init_icon_state = "meter"
	name = "distribution loop gas flow meter"
	chamber_id = ATMOS_GAS_MONITOR_DISTRO
