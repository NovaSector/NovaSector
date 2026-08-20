/obj/item/circuitboard/machine/rbmk2
	name = "RB-MK2 reactor"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/power/rbmk2
	req_components = list(
		/obj/item/stack/cable_coil = 4,
		/obj/item/stack/sheet/plasteel = 5,
		/datum/stock_part/capacitor = 4,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/servo = 4,
	)
	needs_anchored = TRUE
	custom_materials = list(/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
