// Solar panels

/obj/machinery/power/solar/deployable
	icon = 'modular_nova/modules/colony_fabricator/icons/machines.dmi'
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar

/obj/machinery/power/solar/deployable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/power/solar/deployable/crowbar_act(mob/user, obj/item/I)
	return

/obj/machinery/power/solar/deployable/on_deconstruction(disassembled)
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// formerly NO_DECONSTRUCTION
/obj/machinery/power/solar/deployable/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/power/solar/deployable/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/power/solar/deployable/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

// Solar panel sub-types
/obj/machinery/power/solar/deployable/titaniumglass
	power_tier = 2
	material_type = /datum/material/alloy/titaniumglass
	repacked_type = /obj/item/flatpacked_machine/solar/titaniumglass

/obj/machinery/power/solar/deployable/plasmaglass
	power_tier = 3
	material_type = /datum/material/alloy/plasmaglass
	repacked_type = /obj/item/flatpacked_machine/solar/plasmaglass

/obj/machinery/power/solar/deployable/plastitaniumglass
	power_tier = 4
	material_type = /datum/material/alloy/plastitaniumglass
	repacked_type = /obj/item/flatpacked_machine/solar/plastitaniumglass

// Solar panel deployable item

/obj/item/flatpacked_machine/solar
	name = "flat-packed solar panel"
	desc = /obj/machinery/power/solar/deployable::desc
	icon_state = "solar_panel_packed"
	type_to_deploy = /obj/machinery/power/solar/deployable
	deploy_time = 2 SECONDS
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)

// Solar Panel Deployable Sub-types

/obj/item/flatpacked_machine/solar/titaniumglass
	name = "titanium flat-packed solar panel"
	type_to_deploy = /obj/machinery/power/solar/deployable/titaniumglass
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
	)

/obj/item/flatpacked_machine/solar/plasmaglass
	name = "plasma flat-packed solar panel"
	type_to_deploy = /obj/machinery/power/solar/deployable/plasmaglass
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
	)

/obj/item/flatpacked_machine/solar/plastitaniumglass
	name = "plastitanium flat-packed solar panel"
	type_to_deploy = /obj/machinery/power/solar/deployable/plastitaniumglass
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
	)

// Solar trackers

/obj/machinery/power/tracker/deployable
	icon = 'modular_nova/modules/colony_fabricator/icons/machines.dmi'
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar_tracker

/obj/machinery/power/tracker/deployable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/power/tracker/deployable/crowbar_act(mob/user, obj/item/item_acting)
	return NONE

// formerly NO_DECONSTRUCTION
/obj/machinery/power/tracker/deployable/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/power/tracker/deployable/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/power/tracker/deployable/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/machinery/power/tracker/deployable/on_deconstruction(disassembled)
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// Solar tracker deployable item

/obj/item/flatpacked_machine/solar_tracker
	name = "flat-packed solar tracker"
	desc = /obj/machinery/power/tracker/deployable::desc
	icon_state = "solar_tracker_packed"
	type_to_deploy = /obj/machinery/power/tracker/deployable
	deploy_time = 3 SECONDS
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3.5,
	)
