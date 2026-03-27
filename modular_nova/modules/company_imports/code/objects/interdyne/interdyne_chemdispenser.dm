/obj/machinery/chem_dispenser/interdyne
	name = "Interdyne Chem Dispenser"
	desc = "An Interdyne Pharmaceuticals chemical dispenser. Creates and dispenses chemicals with a distinctly corporate flair. \
		Its safety protocols have been thoroughly 'revised' by Interdyne engineers."
	icon = 'modular_nova/modules/company_imports/icons/interdyne_chemdispenser.dmi'
	circuit = /obj/item/circuitboard/machine/chem_dispenser/interdyne
	/// No upgrades needed - all reagents available by default
	upgrade_reagents = null
	upgrade2_reagents = null
	upgrade3_reagents = null
	emagged_reagents = null

	/// Interdyne-exclusive reagents only available on this machine
	var/static/list/interdyne_reagents = list(
	)

/obj/machinery/chem_dispenser/interdyne/Initialize(mapload)
	dispensable_reagents = default_dispensable_reagents + default_upgrade_reagents + default_upgrade2_reagents + default_upgrade3_reagents + default_emagged_reagents + interdyne_reagents
	return ..()

/obj/machinery/chem_dispenser/interdyne/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InterdyneChemDispenser", name)
		ui.open()

	var/is_hallucinating = FALSE
	if(isliving(user))
		var/mob/living/living_user = user
		is_hallucinating = !!living_user.has_status_effect(/datum/status_effect/hallucination)
	ui.set_autoupdate(!is_hallucinating)

/obj/item/circuitboard/machine/chem_dispenser/interdyne
	name = "\improper Interdyne Chem Dispenser"
	build_path = /obj/machinery/chem_dispenser/interdyne
