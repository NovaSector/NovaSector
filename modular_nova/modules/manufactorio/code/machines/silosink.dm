/obj/machinery/power/manufacturing/silolink
	name = "Silo resource retrieval machine"
	desc = "Pulls materials from a connected ore silo, one type at a time."
	icon = 'modular_nova/modules/manufactorio/icons/manufactorio.dmi'
	icon_state = "silolink"


	var/datum/component/remote_materials/rmat
	var/datum/material/selected_material = null // The material type selected for retrieval




/obj/machinery/power/manufacturing/silolink/Initialize(mapload)
	. = ..()
	rmat = AddComponent(/datum/component/remote_materials, mapload)


/obj/machinery/power/manufacturing/silolink/attack_hand(mob/user, list/modifiers)
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

	// Left-click to retrieve material
	if (!selected_material)
		to_chat(user, "<span class='warning'>No material selected. Right-click to select a material to retrieve.</span>")
		return

	if(!istype(selected_material, /datum/material))
		to_chat(user, "<span class='warning'>Invalid material selected. Please select again.</span>")
		selected_material = null
		return

	var/amt = rmat.eject_sheets(selected_material, 5, user.loc, ID_DATA(user))
	if (amt)
		to_chat(user, "<span class='notice'>Retrieved [amt] sheets of [selected_material.name].</span>")
	else
		to_chat(user, "<span class='warning'>Failed to retrieve [selected_material]. The silo might be empty.</span>")


/obj/machinery/power/manufacturing/silolink/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
