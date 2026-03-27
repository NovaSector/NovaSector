/obj/machinery/chem_master/interdyne
	name = "Interdyne ChemMaster"
	desc = "An Interdyne Pharmaceuticals chemical processor. Used to separate chemicals and distribute them in a variety of forms. \
		Features integrated Interdyne autoinjector fabrication capabilities."
	icon = 'modular_nova/modules/company_imports/icons/interdyne_chemmaster.dmi'
	circuit = /obj/item/circuitboard/machine/chem_master/interdyne

/obj/machinery/chem_master/interdyne/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InterdyneChemMaster", name)
		ui.open()

/obj/machinery/chem_master/interdyne/load_printable_containers()
	var/static/list/containers
	if(!length(containers))
		containers = list(
			CAT_INTERDYNE_INJECTORS = GLOB.reagent_containers[CAT_INTERDYNE_INJECTORS],
			CAT_TUBES = GLOB.reagent_containers[CAT_TUBES],
			CAT_PILLS = GLOB.reagent_containers[CAT_PILLS],
			CAT_PATCHES = GLOB.reagent_containers[CAT_PATCHES],
			CAT_HYPOS = GLOB.reagent_containers[CAT_HYPOS],
			CAT_DARTS = GLOB.reagent_containers[CAT_DARTS],
			CAT_PEN_INJECTORS = GLOB.reagent_containers[CAT_PEN_INJECTORS],
		)
	return containers

/obj/item/circuitboard/machine/chem_master/interdyne
	name = "\improper Interdyne ChemMaster"
	build_path = /obj/machinery/chem_master/interdyne
