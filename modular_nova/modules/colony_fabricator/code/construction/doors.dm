// Shutters

/obj/machinery/door/poddoor/shutters/colony_fabricator
	name = "prefab shutters"
	icon = 'modular_nova/modules/colony_fabricator/icons/doors/shutter.dmi'

/obj/machinery/door/poddoor/shutters/colony_fabricator/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/shutters/colony_fabricator/open(forced = DEFAULT_DOOR_CHECKS)
	if(!density)
		return TRUE
	if(operating)
		return FALSE
	operating = TRUE
	use_power(active_power_usage)
	flick("opening", src)
	icon_state = "open"
	set_opacity(0)
	SLEEP_NOT_DEL(0.5 SECONDS)
	set_density(FALSE)
	flags_1 &= ~PREVENT_CLICK_UNDER_1
	SLEEP_NOT_DEL(0.5 SECONDS)
	layer = initial(layer)
	update_appearance()
	set_opacity(0)
	operating = FALSE
	air_update_turf(TRUE, FALSE)
	update_freelook_sight()
	if(autoclose)
		autoclose_in(DOOR_CLOSE_WAIT)
	return TRUE

/obj/machinery/door/poddoor/shutters/colony_fabricator/close(forced = DEFAULT_DOOR_CHECKS)
	if(density)
		return TRUE
	if(operating || welded)
		return FALSE
	if(safe)
		for(var/atom/movable/M in get_turf(src))
			if(M.density && M != src) //something is blocking the door
				if(autoclose)
					autoclose_in(DOOR_CLOSE_WAIT)
				return FALSE

	operating = TRUE

	flick("closing")
	icon_state = "closed"
	layer = closingLayer
	SLEEP_NOT_DEL(0.5 SECONDS)
	set_density(TRUE)
	flags_1 |= PREVENT_CLICK_UNDER_1
	SLEEP_NOT_DEL(0.5 SECONDS)
	update_appearance()
	if(visible && !glass)
		set_opacity(1)
	operating = FALSE
	air_update_turf(TRUE, TRUE)
	update_freelook_sight()

	if(!can_crush)
		return TRUE

	if(safe)
		CheckForMobs()
	else
		crush()
	return TRUE

/obj/item/flatpacked_machine/shutter_kit
	name = "prefab shutters parts kit"
	icon = 'modular_nova/modules/colony_fabricator/icons/doors/packed.dmi'
	icon_state = "shutters_parts"
	type_to_deploy = /obj/machinery/door/poddoor/shutters/colony_fabricator/preopen
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)

// Airlocks

/obj/machinery/door/airlock/colony_prefab
	name = "prefab airlock"
	icon = 'modular_nova/modules/colony_fabricator/icons/doors/airlock.dmi'
	overlays_file = 'modular_nova/modules/colony_fabricator/icons/doors/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_colony_prefab

/obj/structure/door_assembly/door_assembly_colony_prefab
	name = "prefab airlock assembly"
	icon = 'modular_nova/modules/colony_fabricator/icons/doors/airlock.dmi'
	base_name = "prefab airlock"
	airlock_type = /obj/machinery/door/airlock/colony_prefab
	noglass = TRUE

/obj/item/flatpacked_machine/airlock_kit
	name = "prefab airlock parts kit"
	icon = 'modular_nova/modules/colony_fabricator/icons/doors/packed.dmi'
	icon_state = "airlock_parts"
	type_to_deploy = /obj/machinery/door/airlock/colony_prefab
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)
