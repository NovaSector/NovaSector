/obj/machinery/rnd/production/interdyne_fabricator
	name = "Interdyne pharmaceutical fabricator"
	desc = "A proprietary Interdyne Pharmaceuticals fabricator, pre-loaded with a comprehensive medical design library. \
		Unlike standard Nanotrasen techfabs, this machine operates independently of any research network, \
		drawing from Interdyne's own extensive pharmaceutical database."
	icon = 'modular_nova/modules/interdyne/icons/interdyne_fabricator.dmi'
	icon_state = "protolathe"
	production_animation = "protolathe_n"
	circuit = /obj/item/circuitboard/machine/interdyne_fabricator
	allowed_buildtypes = PROTOLATHE | IMPRINTER | MECHFAB
	allowed_department_flags = DEPARTMENT_BITFLAG_MEDICAL
	// Null here so the parent doesn't add a stripe from the wrong icon file
	stripe_color = null
	payment_department = ACCOUNT_INT
	req_access = list(ACCESS_INTERDYNE)
	/// The actual stripe color, applied in our own update_overlays
	var/interdyne_stripe_color = "#4CBB17"

/obj/machinery/rnd/production/interdyne_fabricator/Initialize(mapload)
	. = ..()
	// Use the admin techweb so all designs are considered "researched" - we filter by department flag instead
	stored_research = locate(/datum/techweb/admin) in SSresearch.techwebs

/obj/machinery/rnd/production/interdyne_fabricator/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InterdyneFabricator", name)
		ui.open()

/obj/machinery/rnd/production/interdyne_fabricator/ui_data(mob/user)
	. = ..()
	.["hasAccess"] = allowed(user)

/obj/machinery/rnd/production/interdyne_fabricator/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	if(!allowed(ui.user))
		to_chat(ui.user, span_warning("Access denied."))
		return TRUE
	return ..()

/obj/machinery/rnd/production/interdyne_fabricator/update_overlays()
	. = ..()
	if(!interdyne_stripe_color)
		return
	var/mutable_appearance/stripe = mutable_appearance(icon, "protolathe_stripe[panel_open ? "_t" : ""]")
	stripe.color = interdyne_stripe_color
	. += stripe

/obj/machinery/rnd/production/interdyne_fabricator/build_efficiency()
	return 1

// Pull designs from the global design list directly, filtered by medical department and allowed buildtypes
// Excludes alien technology, includes all implant and non-engineering cyborg module designs
/obj/machinery/rnd/production/interdyne_fabricator/update_designs()
	var/previous_design_count = cached_designs.len

	cached_designs.Cut()

	for(var/design_id, design in SSresearch.techweb_designs)
		var/datum/design/current_design = design

		if(!(current_design.build_type & allowed_buildtypes))
			continue

		// Skip alien technology - Interdyne doesn't have access to xenobiological blueprints
		if(findtext(design_id, "alien_"))
			continue

		// Include cyborg modules except engineering ones
		if(current_design.build_type & MECHFAB)
			var/is_borg_module = FALSE
			var/is_engineering = FALSE
			for(var/cat in current_design.category)
				if(findtext(cat, RND_CATEGORY_MECHFAB_CYBORG_MODULES))
					is_borg_module = TRUE
				if(findtext(cat, RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING))
					is_engineering = TRUE
			if(is_borg_module && !is_engineering)
				cached_designs |= current_design
			continue

		// Skip generic designs not intended for any specific department (filters away-mission and catch-all items)
		if(current_design.departmental_flags == ALL)
			continue

		// Include PKA modkits — Interdyne miners need them
		var/is_pka_mod = FALSE
		for(var/cat in current_design.category)
			if(findtext(cat, RND_SUBCATEGORY_TOOLS_PKA_MODS))
				is_pka_mod = TRUE
				break

		// Include all implant designs (even security-flagged ones), standard medical designs, and PKA mods
		if((current_design.departmental_flags & allowed_department_flags) || findtext(design_id, "implant") || is_pka_mod)
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
