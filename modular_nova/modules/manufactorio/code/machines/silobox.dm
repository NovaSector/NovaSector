/obj/machinery/power/manufacturing/silobox
	name = "Silo resource retrieval machine"
	desc = "Pulls materials from a connected ore silo, one type at a time."
	icon = 'modular_nova/modules/manufactorio/icons/manufactorio.dmi'
	icon_state = "silobox"

	circuit = /obj/item/circuitboard/machine/silobox
	var/datum/component/remote_materials/rmat
	var/datum/material/selected_material = null // The material type selected for retrieval
	var/processing_speed = 6 SECONDS
	var/activated = FALSE

	COOLDOWN_DECLARE(process_speed)


/obj/machinery/power/manufacturing/silobox/Initialize(mapload)
	. = ..()
	rmat = AddComponent(/datum/component/remote_materials, mapload)


/obj/machinery/power/manufacturing/silobox/attack_hand(mob/user, list/modifiers)
	if(modifiers && modifiers.Find(RIGHT_CLICK)) // Right-click to select material
		var/list/materials = rmat?.mat_container?.materials
		if (!materials || !length(materials))
			to_chat(user, "<span class='warning'>No materials available in the connected silo.</span>")
			return

		var/list/material_choices = list()
		var/list/name_to_type = list()
		for(var/mat_type in materials)
			var/datum/material/M = GET_MATERIAL_REF(mat_type)
			if(!M) continue
			var/obj/item/stack/sheet/display = initial(M.sheet_type)
			material_choices[M.name] = image(icon = initial(display.icon), icon_state = initial(display.icon_state))
			name_to_type[M.name] = M

		var/new_material_name = show_radial_menu(user, src, material_choices, require_near = TRUE)
		if(new_material_name)
			selected_material = name_to_type[new_material_name]
			to_chat(user, "<span class='notice'>Selected [selected_material.name] for retrieval.</span>")
		return

	// Left-click activate/deactivate

	if (!selected_material)
		to_chat(user, "<span class='notice'>No material selected.</span>")
		return
	activated = !activated
	if(activated)
		to_chat(user, "<span class='notice'>Silo retrieval activated.</span>")
	else
		to_chat(user, "<span class='notice'>Silo retrieval deactivated.</span>")




/obj/machinery/power/manufacturing/silobox/process()
	if(!check_factors())
		return

	rmat.eject_sheets(selected_material, 5, src.loc, SILICON_OVERRIDE)




/obj/machinery/power/manufacturing/silobox/proc/check_factors()


	if(!COOLDOWN_FINISHED(src, process_speed))
		return FALSE

	COOLDOWN_START(src, process_speed, processing_speed)

	// Left-click to retrieve material
	if (!selected_material)
		return FALSE

	if (!activated)
		return FALSE

	//we are ready to go
	return TRUE



/obj/item/circuitboard/machine/silobox
	name = "Silo box"
	desc = "The bluespace miner is a machine that, when provided the correct temperature and pressure, will produce materials."
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/power/manufacturing/silobox
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/ore/bluespace_crystal/refined = 1,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/servo = 2,
	)
	needs_anchored = TRUE


/datum/design/board/silobox
	name = "Silo box Board"
	desc = "A machine that pulls materials from a connected ore silo, one type at a time."
	id = "silo_box"
	build_path = /obj/item/circuitboard/machine/silobox
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_SERVICE
