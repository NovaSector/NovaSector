/obj/machinery/exoscanner/shuttle_part
	abstract_type = /obj/machinery/exoscanner/shuttle_part
	icon = 'modular_nova/modules/shipbreaking/icons/exterior.dmi'
	icon_state = null
	circuit = null
	layer = LOW_ITEM_LAYER

/obj/machinery/exoscanner/shuttle_part/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_RECYCLE_LIKE_ITEM, TRAIT_GENERIC)
	find_and_mount_on_atom()

/obj/machinery/exoscanner/shuttle_part/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(. != ITEM_INTERACT_SUCCESS)
		return
	if(anchored)
		SET_BASE_PIXEL(initial(base_pixel_x), initial(base_pixel_y))
	else
		SET_BASE_PIXEL(0, 0)

/obj/machinery/exoscanner/shuttle_part/screwdriver_act(mob/user, obj/item/tool)
	return

/obj/machinery/exoscanner/shuttle_part/update_icon_state()
	. = ..()
	icon_state = base_icon_state

/obj/machinery/exoscanner/shuttle_part/radar_panel
	name = "radar panel"
	desc = "A radar panel, made to be mounted flat to the walls of ships for directional scanning."
	icon_state = "radar_panel"
	base_icon_state = "radar_panel"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/exoscanner/shuttle_part/radar_panel, 3)

/obj/machinery/exoscanner/shuttle_part/sensors_blister
	name = "sensors blister"
	desc = "A tightly-packed sensors blister holding all manner of receiving and transmitting equipment in a protective \
		housing. This one was left closed."
	icon_state = "blister_closed"
	base_icon_state = "blister_closed"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/exoscanner/shuttle_part/sensors_blister, 18)

// The north facing one has to be special due to the antennae
/obj/machinery/exoscanner/shuttle_part/sensors_blister/directional/north
	SET_BASE_PIXEL(0, 26)

/obj/machinery/exoscanner/shuttle_part/open_sensors_blister
	name = "sensors blister"
	desc = "A tightly-packed sensors blister holding all manner of receiving and transmitting equipment in a protective \
		housing. This one was left open."
	icon_state = "blister_open"
	base_icon_state = "blister_open"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/exoscanner/shuttle_part/open_sensors_blister, 18)

// The north facing one has to be special due to the antennae
/obj/machinery/exoscanner/shuttle_part/open_sensors_blister/directional/north
	SET_BASE_PIXEL(0, 26)

/obj/machinery/exoscanner/shuttle_part/radio_dish
	name = "radio dish"
	desc = "A directional radio dish, for extremely long range communication and sensing."
	icon_state = "dish"
	base_icon_state = "dish"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/exoscanner/shuttle_part/radio_dish, 12)
