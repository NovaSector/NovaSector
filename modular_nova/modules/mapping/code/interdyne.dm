// Upgraded Interdyne machines

/obj/machinery/processor/slime/fullupgrade
	circuit = /obj/item/circuitboard/machine/processor/slime/fullupgrade

/obj/item/circuitboard/machine/processor/slime/fullupgrade
	name = "\improper Slime Processor"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/processor/slime/fullupgrade
	req_components = list(
		/datum/stock_part/servo/tier4  = 1,
		/datum/stock_part/matter_bin/tier4 = 1,
	)

/obj/machinery/processor/slime/fullupgrade/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/processor/slime/fullupgrade/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/processor/slime/fullupgrade/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/machinery/monkey_recycler/fullupgrade
	circuit = /obj/item/circuitboard/machine/monkey_recycler/fullupgrade

// formerly NO_DECONSTRUCTION
/obj/machinery/monkey_recycler/fullupgrade/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/monkey_recycler/fullupgrade/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/monkey_recycler/fullupgrade/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/item/circuitboard/machine/monkey_recycler/fullupgrade
	name = "\improper Monkey Recycler"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/monkey_recycler/fullupgrade
	req_components = list(
		/datum/stock_part/servo/tier4  = 1,
		/datum/stock_part/matter_bin/tier4 = 1,
	)

/obj/machinery/chem_master/fullupgrade
	name = "\improper ChemMaster 4000"
	circuit = /obj/item/circuitboard/machine/chem_master/fullupgrade

/obj/item/circuitboard/machine/chem_master/fullupgrade
	name = "\improper ChemMaster 4000"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/chem_master/fullupgrade
	desc = "You can turn the \"mode selection\" dial using a screwdriver, but you might not be able to turn it back."
	req_components = list(
		/obj/item/reagent_containers/cup/beaker/bluespace = 2,
		/datum/stock_part/servo/tier4 = 1,
		/obj/item/stack/sheet/glass = 1,
	)
	needs_anchored = FALSE

/obj/machinery/biogenerator/fullupgrade
	circuit = /obj/item/circuitboard/machine/biogenerator/fullupgrade

/obj/machinery/biogenerator/fullupgrade/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/biogenerator/fullupgrade/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/biogenerator/fullupgrade/default_pry_open(obj/item/crowbar, close_after_pry, open_density, closed_density)
	return NONE

/obj/item/circuitboard/machine/biogenerator/fullupgrade
	name = "\improper Biogenerator"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/biogenerator/fullupgrade
	req_components = list(
		/datum/stock_part/matter_bin/tier4 = 1,
		/datum/stock_part/servo/tier4 = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1,
	)
