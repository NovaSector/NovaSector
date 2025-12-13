/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer
	name = "FOBricator Module"
	desc = "A deployable structure printer for SolFed field mechs. Allows fabrication of tactical infrastructure."
	icon = 'icons/obj/machines/lathes.dmi'
	icon_state = "autolathe"
	equipment_slot = MECHA_UTILITY
	detachable = FALSE
	///are we laying a cable?
	var/cablelay_mode = FALSE
	///List of printables items
	var/list/printables = list(
		/obj/structure/deployable_barricade/metal/plasteel = list(
			name = "Plasteel Barricade",
			energy = 100,
			time = 2.5 SECONDS
		),
		/obj/structure/deployable_barricade/metal = list(
			name = "Metal Barricade",
			energy = 75,
			time = 2 SECONDS
		),
		/obj/structure/barricade/sandbags = list(
			name = "Sandbags",
			energy = 50,
			time = 1.5 SECONDS
		),
		/turf/closed/wall/r_wall = list(
			name = "Reinforced Wall",
			energy = 120,
			time = 3 SECONDS
		),
		/turf/closed/wall = list(
			name = "Wall",
			energy = 90,
			time = 2.5 SECONDS
		),
		/obj/machinery/power/smes/battery_pack = list(
			name = "Stationary Battery",
			energy = 200,
			time = 4 SECONDS
		),
		/obj/machinery/power/rtg/portable = list(
			name = "RTG Generator",
			energy = 250,
			time = 5 SECONDS
		),
		/obj/machinery/power/floodlight = list(
			name = "Floodlight",
			energy = 80,
			time = 2 SECONDS
		),
		/turf/open/floor/plating = list(
			name = "Plating",
			energy = 30,
			time = 1 SECONDS
		),
		/obj/machinery/mech_bay_recharge_port = list(
			name = "Mech Bay Power Port",
			energy = 150,
			time = 3.5 SECONDS
		),
		/obj/machinery/computer/mech_bay_power_console = list(
			name = "Mech Bay Console",
			energy = 100,
			time = 3 SECONDS
		)
	)

/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right)
	. = ..()
	new_mecha.initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu, VEHICLE_CONTROL_EQUIPMENT)
	new_mecha.initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/toggle_cablelay, VEHICLE_CONTROL_EQUIPMENT)

/obj/item/mecha_parts/mecha_equipment/solfed_3d_printer/detach(atom/moveto)
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu, VEHICLE_CONTROL_EQUIPMENT)
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/toggle_cablelay, VEHICLE_CONTROL_EQUIPMENT)
	return ..()

/obj/item/mecha_parts/mecha_equipment/solfed_3d_printer/Destroy()
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu, VEHICLE_CONTROL_EQUIPMENT)
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/toggle_cablelay, VEHICLE_CONTROL_EQUIPMENT)
	return ..()

/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu
	name = "Deployable Structures"
	button_icon = 'modular_nova/modules/solfed_mechs/icons/action_mecha.dmi'
	button_icon_state = "rcd"
	desc = "Deploy SolFed field structures."

/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu/Trigger(mob/user, trigger_flags)
	var/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer/printer = locate(/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer) in chassis.equip_by_category[MECHA_UTILITY]
	if (!printer)
		to_chat(user, "No printer module detected.")
		return

	var/list/choices = list()
	for (var/typepath in printer.printables)
		var/name = printer.printables[typepath]["name"]
		choices[name] = typepath

	var/choice = input(user, "Select a structure to deploy:", "FOBricator") in choices
	if (!choice)
		return

	printer.deploy_structure(user, choices[choice])

/datum/action/vehicle/sealed/mecha/toggle_cablelay
	name = "Toggle Cable-Laying Mode"
	button_icon = 'modular_nova/modules/solfed_mechs/icons/action_mecha.dmi'
	button_icon_state = "rcl_off"
	desc = "Automatically lays cable while moving across valid tiles."

/datum/action/vehicle/sealed/mecha/toggle_cablelay/Trigger(mob/clicker, trigger_flags)
	var/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer/printer = locate(/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer) in chassis.equip_by_category[MECHA_UTILITY]
	if (!printer)
		to_chat(clicker, "No cable-laying module detected.")
		return

	printer.cablelay_mode = !printer.cablelay_mode
	button_icon_state = printer.cablelay_mode ? "rcl_on" : "rcl_off"
	build_all_button_icons()
	to_chat(clicker, "Cable-laying mode [printer.cablelay_mode ? "enabled" : "disabled"].")

/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer/Move(newloc, dir)
	. = ..()
	if(!cablelay_mode)
		return
	var/turf/current_tile = get_turf(src)
	var/mob/living/user = chassis.return_drivers()[1]
	if(isnull(user) || !isturf(current_tile))
		return

	if(current_tile.underfloor_accessibility < UNDERFLOOR_INTERACTABLE || !current_tile.can_have_cabling())
		return

	for(var/obj/structure/cable/existing_cable in current_tile)
		if(existing_cable.cable_layer & CABLE_LAYER_2)
			return // Already a cable here

	var/obj/structure/cable/new_cable = new /obj/structure/cable(current_tile)
	new_cable.cable_layer = CABLE_LAYER_2

	var/datum/powernet/net = new()
	net.add_cable(new_cable)

	for(var/dir_check in GLOB.cardinals)
		new_cable.mergeConnectedNetworks(dir_check)
	new_cable.mergeConnectedNetworksOnTurf()

	chassis.use_energy(25)

/datum/action/vehicle/sealed/mecha/open_fob_menu
	name = "Deployable Structures"
	button_icon_state = "build"
	desc = "Deploy SolFed field structures."

/datum/action/vehicle/sealed/mecha/open_fob_menu/Trigger(mob/user, trigger_flags)
	if(!chassis)
		return

	var/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer/printer = locate(/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer) in chassis.flat_equipment
	var/list/choices = list()
	for(var/typepath in printer.printables)
		var/name = printer.printables[typepath]["name"]
		choices[name] = typepath

	var/choice = input(user, "Select a structure to deploy:", "FOBricator") in choices
	if(!choice)
		return

	printer.deploy_structure(user, choices[choice])

///Check if the item the mech is trying to build fits at the location targetted.
/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer/proc/can_build_here(turf/target_turf, typepath, atom/movable/user = null)
	// Rule 1: Must be a valid turf and not a closed one
	if(!isturf(target_turf) || istype(target_turf, /turf/closed))
		return FALSE

	// Rule 2: Use RCD-style blocked turf check
	if(target_turf.is_blocked_turf(
		exclude_mobs = TRUE,
		source_atom = user,
		ignore_atoms = list(/obj/item, /obj/effect),
		type_list = TRUE))
		balloon_alert(user, "something is on the tile!")
		return FALSE

	// Rule 3: Plating can only be built on openspace
	if(typepath == /turf/open/floor/plating && !istype(target_turf, /turf/open/openspace))
		return FALSE

	return TRUE

///Provided there's space and the mecha has enough power, create a structure one step in front of the mech.
/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer/proc/deploy_structure(mob/user, typepath)
	var/data = printables[typepath]
	if(!data)
		return

	var/energy_cost = data["energy"]
	var/deploy_time = data["time"]
	var/turf/target = get_step(src, usr.dir)

	if(!can_build_here(target, typepath))
		to_chat(user, "Not a valid space to deploy.")
		return

	if(!chassis.use_energy(energy_cost))
		to_chat(user, "Insufficient energy to fabricate [data["name"]].")
		return

	to_chat(user, "Beginning deployment of [data["name"]]...")

	if (do_after(user, deploy_time, target))
		chassis.use_energy(energy_cost)
		var/obj/structure/item = new typepath(target)
		item.setDir(user.dir)
		to_chat(user, "[item] deployed successfully.")
