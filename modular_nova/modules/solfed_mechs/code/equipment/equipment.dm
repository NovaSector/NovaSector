// Mech equipped Kinetic Dampener

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener
	name = "Projectile Dampener Module"
	desc = "An advanced electromagnetic field generator adapted from peaceborg technology. It weakens incoming projectiles within a short radius, reducing their kinetic impact."
	icon = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "projectile_dampener"
	equipment_slot = MECHA_UTILITY
	detachable = FALSE
	active = FALSE
	can_be_toggled = TRUE
	/// Radius of the dampening field.
	var/field_radius = 4
	/// Damage multiplier on projectiles.
	var/damage_multiplier = 0.5
	/// Debuff multiplier on projectiles.
	var/debuff_multiplier = 0.5
	/// Speed multiplier on projectiles, higher means slower.
	var/speed_multiplier = 0.65
	/// List of all tracked projectiles.
	var/list/tracked_projectiles = list()
	/// Effect image on projectiles.
	var/image/projectile_effect
	/// The dampening field
	var/datum/proximity_monitor/advanced/bubble/projectile_dampener/dampening_field

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right)
	. = ..()
	new_mecha.initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/kinetic_dampener, VEHICLE_CONTROL_EQUIPMENT)

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/detach(atom/moveto)
	. = ..()
	chassis.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/kinetic_dampener, VEHICLE_CONTROL_EQUIPMENT)

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/Destroy()
	. = ..()
	chassis.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/kinetic_dampener, VEHICLE_CONTROL_EQUIPMENT)

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/Initialize(mapload)
	. = ..()
	projectile_effect = image('icons/effects/fields.dmi', "projectile_dampen_effect")

/datum/action/vehicle/sealed/mecha/kinetic_dampener
	name = "Projectile Dampener Module"
	desc = "An advanced electromagnetic field generator adapted from peaceborg technology. It weakens incoming projectiles within a short radius, reducing their kinetic impact."
	button_icon_state = "mech_defense_mode_off"

/datum/action/vehicle/sealed/mecha/kinetic_dampener/Trigger(mob/clicker, trigger_flags)
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/dampener = locate(/obj/item/mecha_parts/mecha_equipment/kinetic_dampener) in chassis.contents
	dampener.active = !dampener.active
	dampener.set_active(dampener.active)

	button_icon_state = dampener.active ? "mech_defense_mode_on" : "mech_defense_mode_off"
	build_all_button_icons()
	to_chat(clicker, span_notice("You toggle the projectile dampener [dampener.active ? "on" : "off"]."))
	return TRUE

/obj/item/mecha_parts/mecha_equipment/kinetic_dampener/set_active(active)
	. = ..()
	if(active)
		if(istype(dampening_field))
			QDEL_NULL(dampening_field)
		dampening_field = new(src, field_radius, TRUE, src)
	else
		QDEL_NULL(dampening_field)

// Mech equipped swarm micro rocket

//base one is setup to IFF on NT & centcom trims for future proofing.
/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod
	name = "Swarm Rocket Pod"
	desc = "A sealed multi-launch rocket pod mounted to the mecha's chassis. Fires a precision barrage of micro-rockets at nearby targets when activated. Targets lacking Nanotrasen or CentCom ID clearance will be marked for impact."
	icon_state = "mecha_missilerack_six"
	equipment_slot = MECHA_UTILITY
	detachable = FALSE
	equip_cooldown = 30
	///List of id_trim that the rocket pod shouldn't fire at.
	var/list/friendly_trims = list(/datum/id_trim/job, /datum/id_trim/centcom)

//IFF'ed on Solfed trims.
/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/solfed
	desc = "A sealed multi-launch rocket pod mounted to the mecha's chassis. Fires a precision barrage of micro-rockets at nearby targets when activated. Targets without SolFed ID clearance will be marked for impact."
	friendly_trims = list(/datum/id_trim/solfed)

/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right)
	. = ..()
	new_mecha.initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/swarm_rocket_pod, VEHICLE_CONTROL_EQUIPMENT)

/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/detach(atom/moveto)
	. = ..()
	chassis.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/swarm_rocket_pod, VEHICLE_CONTROL_EQUIPMENT)

/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/Destroy()
	. = ..()
	chassis.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/swarm_rocket_pod, VEHICLE_CONTROL_EQUIPMENT)

///Main proc for the rocket pod, uses the pod IFF to determinate a pool of potential target in range and view. Then calls the fire_rocket proc on an amount of targets, randomly picked in the pool.
/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/proc/trigger_swarm_rocket(mob/living/source)
	if(!action_checks(chassis))
		return FALSE
	var/turf/launch_origin = get_turf(chassis)
	if (!launch_origin)
		return FALSE

	var/list/valid_targets = list()
	var/is_friendly = FALSE

	// Scan for living mobs
	for (var/mob/living/living_mob in view(7, chassis.loc))
		is_friendly = FALSE

		var/obj/item/card/id/advanced/mob_id_card = living_mob.get_idcard()
		if(locate(mob_id_card.trim) in friendly_trims)
			is_friendly = TRUE

		// Check if this mob is being ridden by someone friendly
		if (!is_friendly && living_mob.has_buckled_mobs())
			for (var/mob/living/rider_mob in living_mob.buckled_mobs)
				var/obj/item/card/id/advanced/rider_id_card = rider_mob.get_idcard()
				if(locate(rider_id_card.trim) in friendly_trims)
					is_friendly = TRUE
				if (is_friendly)
					break

		if (!is_friendly && living_mob.health > 0)
			valid_targets += living_mob

	// Scan for sealed vehicles
	for (var/obj/vehicle/target_vehicle in view(7, chassis.loc))
		is_friendly = FALSE
		var/mob/living/vehicle_driver = chassis.return_drivers()

		if (vehicle_driver)
			var/obj/item/card/id/advanced/driver_id_card = vehicle_driver[1].get_idcard()
			if(locate(driver_id_card.trim) in friendly_trims)
				is_friendly = TRUE
		else
			is_friendly = TRUE

		if (!is_friendly)
			valid_targets += target_vehicle

	if (!valid_targets.len)
		to_chat(source, span_warning("No valid targets in range."))
		return FALSE

	var/rocket_count = 12
	var/list/selected_targets = list()

	for (var/rocket_index in 1 to rocket_count)
		var/atom/movable/random_target = pick(valid_targets)
		if (random_target)
			selected_targets += random_target

	for (var/launch_index in 1 to selected_targets.len)
		var/target = selected_targets[launch_index]
		var/launch_delay = launch_index * 2
		addtimer(CALLBACK(src, PROC_REF(fire_rocket), target), launch_delay)

	TIMER_COOLDOWN_START(chassis, COOLDOWN_MECHA_EQUIPMENT(type), equip_cooldown)
	SEND_SIGNAL(source, COMSIG_MOB_USED_MECH_EQUIPMENT, chassis)
	chassis.use_energy(energy_drain)
	return TRUE

/datum/action/vehicle/sealed/mecha/swarm_rocket_pod
	name = "Rocket Pod Barrage"
	desc = "Launches a spread of micro-rockets at all nearby hostiles. Targets without SolFed ID clearance will be marked for impact."
	button_icon_state = "mech_ivanov"

/datum/action/vehicle/sealed/mecha/swarm_rocket_pod/Trigger(mob/clicker, trigger_flags)
	var/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/pod = locate(/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod) in chassis.equip_by_category[MECHA_UTILITY]
	if (pod.trigger_swarm_rocket(clicker))
		return TRUE

	to_chat(clicker, span_warning("Rocket pod not found or failed to fire."))
	return FALSE

/obj/effect/swarm_rocket_tracker
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "sniper_zoom"
	layer = ABOVE_MOB_LAYER
	///The actual target the tracker is trying to get to.
	var/atom/movable/target
	///Is it still tracking or not.
	var/tracking = TRUE
	///Delay between tracker movement
	var/move_delay = 5
	///How many time is the tracker allowed to move before having to stop and fire the rocket regardless of location.
	var/max_moves = 7
	///How many moves has the tracker made until now.
	var/move_count = 0

/obj/effect/swarm_rocket_tracker/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(step_or_drop)), move_delay)

///Check if the targetting icon has moves left and isn't on the target tile, if so, creep toward its target. If not, drops a rocket from the sky on the location. Also avoids walls.
/obj/effect/swarm_rocket_tracker/proc/step_or_drop()
	if (!target || !target.loc)
		qdel(src)
		return

	if (!tracking)
		var/turf/fall_location = get_turf(src)
		new /obj/effect/temp_visual/swarm_rocket_fall(fall_location)
		qdel(src)
		return

	var/turf/current_tile = get_turf(src)
	var/turf/target_tile = get_turf(target)

	if (current_tile == target_tile || ++move_count >= max_moves)
		tracking = FALSE
		addtimer(CALLBACK(src, PROC_REF(step_or_drop)), move_delay)
		return

	var/angle_to_target = get_angle(src, target)
	var/direction_to_target = angle2dir(angle_to_target)
	var/turf/next_tile = get_step(current_tile, direction_to_target)

	if (!next_tile || next_tile.density || istype(next_tile, /turf/closed))
		addtimer(CALLBACK(src, PROC_REF(step_or_drop)), move_delay)
		return

	// Animate from current to next tile
	var/pixel_offset_x = (next_tile.x - current_tile.x) * 32
	var/pixel_offset_y = (next_tile.y - current_tile.y) * 32
	animate(src, pixel_x = pixel_offset_x, pixel_y = pixel_offset_y, time = move_delay)

	// After animation, move and reset offset
	addtimer(CALLBACK(src, PROC_REF(commit_step), next_tile), move_delay)

///Actually moves the targetting tracker after the animation played.
/obj/effect/swarm_rocket_tracker/proc/commit_step(turf/new_loc)
	forceMove(new_loc)
	pixel_x = 0
	pixel_y = 0
	addtimer(CALLBACK(src, PROC_REF(step_or_drop)), move_delay)

/obj/effect/temp_visual/swarm_rocket_rise
	name = "Swarm Micro-Rocket"
	icon = 'icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "84mm-heap"
	duration = 20
	///max size for the rocket icon when animated
	var/max_scale = 1.0
	///size at which the rocket starts the animation.
	var/current_scale = 0.4

/obj/effect/temp_visual/swarm_rocket_rise/Initialize(mapload)
	. = ..()
	transform = matrix(current_scale, MATRIX_SCALE)
	animate(src,
		transform = matrix(max_scale, MATRIX_SCALE),
		pixel_y = base_pixel_y + 500,
		time = duration,
		easing = QUAD_EASING | EASE_IN)
	playsound(src, 'sound/items/weapons/minebot_rocket.ogg', 100, FALSE)

/obj/effect/temp_visual/swarm_rocket_fall
	name = "Swarm Micro-Rocket"
	icon = 'icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "84mm-heap"
	duration = 14
	///radius of the rocket's explosion
	var/explosion_radius = 1
	pixel_y = 120
	///size the rocket starts off at
	var/start_scale = 1.0
	///minumum size for the rocket icon when animated
	var/end_scale = 0.4

/obj/effect/temp_visual/swarm_rocket_fall/Initialize(mapload)
	. = ..()
	transform = matrix(start_scale, MATRIX_SCALE).Turn(180)
	animate(src,
		transform = matrix(end_scale, MATRIX_SCALE),
		pixel_y = 0,
		time = duration,
		easing = EASE_IN)
	addtimer(CALLBACK(src, PROC_REF(do_explosion)), duration)

///Create the explosion on the rocket drop location.
/obj/effect/temp_visual/swarm_rocket_fall/proc/do_explosion()
	playsound(src, 'sound/items/weapons/minebot_rocket.ogg', 100, FALSE)

	explosion(src,
		devastation_range = -1,
		heavy_impact_range = -1,
		light_impact_range = explosion_radius,
		flame_range = explosion_radius,
		flash_range = explosion_radius,
		adminlog = TRUE,
		smoke = TRUE,
		explosion_cause = src)

///Animates rockets firing up from the mech and create the tracking circles before initialising their tracking loop.
/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/proc/fire_rocket(atom/movable/target)
	if (!target)
		return

	var/obj/effect/temp_visual/swarm_rocket_rise/rocket = new(get_turf(chassis))
	rocket.pixel_x = rand(-12, 12)

	var/obj/effect/swarm_rocket_tracker/tracker = new(get_turf(chassis))
	tracker.target = target

	var/drop_delay = 2 SECONDS
	addtimer(CALLBACK(tracker, /obj/effect/swarm_rocket_tracker/proc/step_or_drop), drop_delay)


///FOBricator

/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer
	name = "FOBricator Module"
	desc = "A deployable structure printer for SolFed field mechs. Allows fabrication of tactical infrastructure."
	icon = 'icons/obj/machines/drone_dispenser.dmi'
	icon_state = "on"
	equipment_slot = MECHA_UTILITY
	icon_state = "3d_printer"
	detachable = FALSE
	equip_cooldown = 20
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

/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right)
	. = ..()
	new_mecha.initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu, VEHICLE_CONTROL_EQUIPMENT)
	new_mecha.initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/toggle_cablelay, VEHICLE_CONTROL_EQUIPMENT)

/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/detach(atom/moveto)
	. = ..()
	chassis.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu, VEHICLE_CONTROL_EQUIPMENT)
	chassis.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/toggle_cablelay, VEHICLE_CONTROL_EQUIPMENT)

/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/Destroy()
	. = ..()
	chassis.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu, VEHICLE_CONTROL_EQUIPMENT)
	chassis.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/toggle_cablelay, VEHICLE_CONTROL_EQUIPMENT)

/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu
	name = "Deployable Structures"
	button_icon = 'modular_nova/modules/solfed_mechs/icons/action_mecha.dmi'
	button_icon_state = "rcd"
	desc = "Deploy SolFed field structures."

/datum/action/vehicle/sealed/mecha/solfed_3d_printer_open_menu/Trigger(mob/user, trigger_flags)
	var/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer/printer = locate(/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer) in chassis.equip_by_category[MECHA_UTILITY]
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
	var/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer/printer = locate(/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer) in chassis.equip_by_category[MECHA_UTILITY]
	if (!printer)
		to_chat(clicker, "No cable-laying module detected.")
		return

	printer.cablelay_mode = !printer.cablelay_mode
	button_icon_state = printer.cablelay_mode ? "rcl_on" : "rcl_off"
	build_all_button_icons()
	to_chat(clicker, "Cable-laying mode [printer.cablelay_mode ? "enabled" : "disabled"].")

/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer/Move(newloc, dir)
	. = ..()
	if(!cablelay_mode)
		return
	var/turf/current_tile = get_turf(src)
	var/mob/living/user = chassis.return_drivers()[1]
	if(!user || !isturf(current_tile))
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

	var/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer/printer = locate(/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer) in chassis.equip_by_category[MECHA_UTILITY]
	var/list/choices = list()
	for(var/typepath in printer.printables)
		var/name = printer.printables[typepath]["name"]
		choices[name] = typepath

	var/choice = input(user, "Select a structure to deploy:", "FOBricator") in choices
	if(!choice)
		return

	printer.deploy_structure(user, choices[choice])

///Check if the item the mech is trying to build fits at the location targetted.
/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer/proc/can_build_here(turf/target_turf, typepath, atom/movable/user = null)
	// Rule 1: Must be a valid turf and not a closed one
	if(!isturf(target_turf) || istype(target_turf, /turf/closed))
		return FALSE

	// Rule 2: Use RCD-style blocked turf check
	if(target_turf.is_blocked_turf(
		exclude_mobs = TRUE,
		source_atom = user,
		ignore_atoms = list(/obj/item, /obj/effect),
		type_list = TRUE))
		balloon_alert(user, "Something is on the tile!")
		return FALSE

	// Rule 3: Plating can only be built on openspace
	if(typepath == /turf/open/floor/plating && !istype(target_turf, /turf/open/openspace))
		return FALSE

	return TRUE

///Provided there's space and the mecha has enough power, create a structure one step in front of the mech.
/obj/item/mecha_parts/mecha_equipment/utility/solfed_3d_printer/proc/deploy_structure(mob/user, typepath)
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
