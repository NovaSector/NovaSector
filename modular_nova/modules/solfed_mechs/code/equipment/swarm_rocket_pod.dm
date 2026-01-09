//base one is setup to IFF on NT & centcom trims for future proofing.
/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod
	name = "Swarm Rocket Pod"
	desc = "A sealed multi-launch rocket pod mounted to the mecha's chassis. Fires a precision barrage of micro-rockets at nearby targets when activated. Targets lacking Nanotrasen or CentCom ID clearance will be marked for impact."
	icon_state = "mecha_missilerack_six"
	equipment_slot = MECHA_UTILITY
	detachable = FALSE
	equip_cooldown = 30 SECONDS
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
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/swarm_rocket_pod, VEHICLE_CONTROL_EQUIPMENT)
	return ..()

/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/Destroy()
	chassis?.destroy_controller_action_type(/datum/action/vehicle/sealed/mecha/swarm_rocket_pod, VEHICLE_CONTROL_EQUIPMENT)
	return ..()

///Main proc for the rocket pod, uses the pod IFF to determinate a pool of potential target in range and view. Then calls the fire_rocket proc on an amount of targets, randomly picked in the pool.
/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/proc/trigger_swarm_rocket(mob/living/source)
	if(!action_checks(chassis))
		return FALSE
	var/turf/launch_origin = get_turf(chassis)
	if (!launch_origin)
		return FALSE

	var/list/valid_targets = list()

	for (var/atom/movable/thing in oview(7, chassis.loc))
		if(istype(thing, /mob/living))
			if(!is_friendly_mob(thing) && thing:health > 0)
				valid_targets += thing
		else if(istype(thing, /obj/vehicle))
			if(!is_friendly_vehicle(thing))
				valid_targets += thing

	if (!length(valid_targets))
		to_chat(source, span_warning("No valid targets in range."))
		return FALSE

	var/rocket_count = 12
	for (var/rocket_index in 1 to rocket_count)
		var/atom/movable/random_target = pick(valid_targets)
		if (random_target)
			//Delay from 0.2 to 2.4 seconds for staggered launch.
			var/launch_delay = rocket_index * 2
			addtimer(CALLBACK(src, PROC_REF(fire_rocket), random_target, source), launch_delay)

	TIMER_COOLDOWN_START(chassis, COOLDOWN_MECHA_EQUIPMENT(type), equip_cooldown)
	SEND_SIGNAL(source, COMSIG_MOB_USED_MECH_EQUIPMENT, chassis)
	chassis.use_energy(energy_drain)
	return TRUE

/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/proc/is_friendly_mob(mob/living/living_mob)
	var/obj/item/card/id/advanced/id_card = living_mob.get_idcard()
	if(id_card && locate(id_card.trim) in friendly_trims)
		return TRUE

	if(living_mob.has_buckled_mobs())
		for(var/mob/living/rider in living_mob.buckled_mobs)
			var/obj/item/card/id/advanced/rider_card = rider.get_idcard()
			if(rider_card && locate(rider_card.trim) in friendly_trims)
				return TRUE
	return FALSE

/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/proc/is_friendly_vehicle(obj/vehicle/target_vehicle)
	var/list/drivers = target_vehicle.return_drivers()
	if(drivers && drivers.len)
		var/mob/living/driver = drivers[1]
		var/obj/item/card/id/advanced/driver_card = driver.get_idcard()
		if(driver_card && locate(driver_card.trim) in friendly_trims)
			return TRUE
		return FALSE
	// No driver → treat as friendly, skip targeting
	return TRUE

/datum/action/vehicle/sealed/mecha/swarm_rocket_pod
	name = "Rocket Pod Barrage"
	desc = "Launches a spread of micro-rockets at all nearby hostiles. Targets without SolFed ID clearance will be marked for impact."
	button_icon_state = "mech_ivanov"

/datum/action/vehicle/sealed/mecha/swarm_rocket_pod/Trigger(mob/clicker, trigger_flags)
	var/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/pod = locate(/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod) in chassis.equip_by_category[MECHA_UTILITY]
	if (pod.trigger_swarm_rocket(clicker))
		button_icon_state = "mech_ivanov_cooldown"
		build_all_button_icons()
		addtimer(CALLBACK(src, PROC_REF(reset_icon)), pod.equip_cooldown, TIMER_STOPPABLE | TIMER_DELETE_ME)
		return TRUE
	return FALSE

/// Resets the datum button icon after the cooldown is up.
/datum/action/vehicle/sealed/mecha/swarm_rocket_pod/proc/reset_icon()
	button_icon_state = "mech_ivanov"
	build_all_button_icons()

/obj/effect/swarm_rocket_tracker
	icon = 'icons/mob/actions/actions_items.dmi'
	icon_state = "sniper_zoom"
	layer = ABOVE_MOB_LAYER
	///What is the tracked target
	var/atom/movable/target
	///Is the tracker still tracking
	var/tracking = TRUE
	///How long should the tracker wait between moves
	var/move_delay = 5
	///How many moves is the tracker allowed to do.
	var/max_moves = 7
	///How many moves has the tracke done
	var/move_count = 0
	///Who spawned the tracker.
	var/mob/firer
	///Tracking timer id for cleanup
	var/list/timer_ids = list()

/obj/effect/swarm_rocket_tracker/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(step_or_drop)), move_delay)

/obj/effect/swarm_rocket_tracker/Destroy()
	// cancel all outstanding timers before deletion
	for(var/id in timer_ids)
		deltimer(id)
	return ..()

/obj/effect/swarm_rocket_tracker/proc/step_or_drop()
	if (!target || !target.loc)
		qdel(src)
		return

	if (!tracking)
		var/turf/fall_location = get_turf(src)
		var/obj/effect/temp_visual/swarm_rocket_fall/rocket = new(fall_location)
		rocket.fingerprintslast = firer  // attribution
		qdel(src)
		return

	var/turf/current_tile = get_turf(src)
	var/turf/target_tile = get_turf(target)

	if (current_tile == target_tile || ++move_count >= max_moves)
		tracking = FALSE
		timer_ids += addtimer(CALLBACK(src, PROC_REF(step_or_drop)), move_delay, TIMER_STOPPABLE | TIMER_DELETE_ME)
		return

	var/angle_to_target = get_angle(src, target)
	var/direction_to_target = angle2dir(angle_to_target)
	var/turf/next_tile = get_step(current_tile, direction_to_target)

	if (!next_tile || next_tile.density || istype(next_tile, /turf/closed))
		timer_ids += addtimer(CALLBACK(src, PROC_REF(step_or_drop)), move_delay, TIMER_STOPPABLE | TIMER_DELETE_ME)
		return

	src.Move(next_tile, glide_size_override = DELAY_TO_GLIDE_SIZE(move_delay))
	timer_ids += addtimer(CALLBACK(src, PROC_REF(step_or_drop)), move_delay, TIMER_STOPPABLE | TIMER_DELETE_ME)

/obj/effect/swarm_rocket_tracker/proc/commit_step(turf/new_loc)
	forceMove(new_loc)
	pixel_x = 0
	pixel_y = 0
	timer_ids += addtimer(CALLBACK(src, PROC_REF(step_or_drop)), move_delay, TIMER_STOPPABLE | TIMER_DELETE_ME)

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
	var/explosion_radius = 1
	pixel_y = 120
	var/start_scale = 1.0
	var/end_scale = 0.4

/obj/effect/temp_visual/swarm_rocket_fall/Initialize(mapload)
	. = ..()
	transform = matrix(start_scale, MATRIX_SCALE).Turn(180)
	animate(src,
		transform = matrix(end_scale, MATRIX_SCALE),
		pixel_y = 0,
		time = duration,
		easing = EASE_IN)

/obj/effect/temp_visual/swarm_rocket_fall/Destroy()
	// Explosion payload occurs exactly when the temp_visual is being cleaned up by duration
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
	return ..()

///Animates rockets firing up from the mech and create the tracking circles before initialising their tracking loop.
/obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/proc/fire_rocket(atom/movable/target, mob/living/source)
	if (!target)
		return
	var/turf/chassis_turf = get_turf(chassis)
	if (!chassis_turf)
		return

	var/obj/effect/temp_visual/swarm_rocket_rise/rocket = new(chassis_turf)
	rocket.pixel_x = rand(-12, 12)

	var/obj/effect/swarm_rocket_tracker/tracker = new(chassis_turf)
	tracker.firer = source
	tracker.target = target

	var/drop_delay = 2 SECONDS
	addtimer(CALLBACK(tracker, /obj/effect/swarm_rocket_tracker/proc/step_or_drop), drop_delay, TIMER_STOPPABLE | TIMER_DELETE_ME)
