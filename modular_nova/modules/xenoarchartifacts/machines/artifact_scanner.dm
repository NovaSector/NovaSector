/obj/item/circuitboard/machine/artifact_scanpad
	name = "Artifact Scanpad"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/artifact_scanpad
	req_components = list(
		/datum/stock_part/scanning_module = 4,
		/datum/stock_part/micro_laser = 2,
		/obj/item/stack/cable_coil = 2,
	)

/obj/machinery/artifact_scanpad
	name = "Anomaly Scanner Pad"
	desc = "Place things here for scanning."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/machinery.dmi'
	icon_state = "xenoarch_scanner"
	anchored = TRUE
	layer = 4.25
	density = FALSE
	circuit = /obj/item/circuitboard/machine/artifact_scanpad

/obj/machinery/artifact_scanpad/Initialize(mapload)
	. = ..()
	var/static/mutable_appearance/scanner_bottom_overlay
	if(!scanner_bottom_overlay)
		scanner_bottom_overlay = mutable_appearance(icon, "xenoarch_scanner_bottom", ABOVE_NORMAL_TURF_LAYER)
	add_overlay(scanner_bottom_overlay)

/obj/machinery/artifact_scanpad/crowbar_act(mob/living/user, obj/item/tool)
	return default_pry_open(user, tool, close_after_pry = FALSE, open_density = FALSE, closed_density = TRUE, deconstruct_on_fail = TRUE)

/obj/machinery/artifact_scanpad/screwdriver_act(mob/living/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, tool)
