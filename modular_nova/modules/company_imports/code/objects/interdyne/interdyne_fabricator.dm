/obj/machinery/rnd/production/interdyne_fabricator
	name = "Interdyne pharmaceutical fabricator"
	desc = "A proprietary Interdyne Pharmaceuticals fabricator, pre-loaded with a comprehensive medical design library. \
		Unlike standard Nanotrasen techfabs, this machine operates independently of any research network, \
		drawing from Interdyne's own extensive pharmaceutical database."
	icon_state = "protolathe"
	production_animation = "protolathe_n"
	circuit = /obj/item/circuitboard/machine/interdyne_fabricator
	allowed_buildtypes = PROTOLATHE | IMPRINTER
	allowed_department_flags = DEPARTMENT_BITFLAG_MEDICAL
	stripe_color = "#4CBB17"
	payment_department = ACCOUNT_INT

/obj/machinery/rnd/production/interdyne_fabricator/Initialize(mapload)
	. = ..()
	// Use the admin techweb so all designs are considered "researched" - we filter by department flag instead
	stored_research = locate(/datum/techweb/admin) in SSresearch.techwebs

/obj/machinery/rnd/production/interdyne_fabricator/build_efficiency()
	return 1

// Pull designs from the global design list directly, filtered by medical department and allowed buildtypes
/obj/machinery/rnd/production/interdyne_fabricator/update_designs()
	var/previous_design_count = cached_designs.len

	cached_designs.Cut()

	for(var/design_id, design in SSresearch.techweb_designs)
		var/datum/design/current_design = design

		if((current_design.departmental_flags & allowed_department_flags) && (current_design.build_type & allowed_buildtypes))
			cached_designs |= current_design

	var/design_delta = length(cached_designs) - previous_design_count

	if(design_delta > 0)
		say("Received [design_delta] new design[design_delta == 1 ? "" : "s"].")
		playsound(src, 'sound/machines/beep/twobeep_high.ogg', 50, TRUE)

	update_static_data_for_all_viewers()

/obj/item/circuitboard/machine/interdyne_fabricator
	name = "\improper Interdyne Pharmaceutical Fabricator"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/rnd/production/interdyne_fabricator
	req_components = list(
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/servo = 2,
	)
