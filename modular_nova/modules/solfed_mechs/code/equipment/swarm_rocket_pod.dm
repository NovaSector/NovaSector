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
	var/is_friendly = FALSE

	// Scan for living mobs
	for (var/mob/living/living_mob in view(7, chassis.loc))
		is_friendly = FALSE

		var/obj/item/card/id/advanced/mob_id_card = living_mob.get_idcard()
		if(mob_id_card)
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
		button_icon_state = "mech_ivanov_cooldown"
		build_all_button_icons()
		addtimer(CALLBACK(src, PROC_REF(reset_icon)), pod.equip_cooldown)
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
	///Who fired it, for admin logging of the subsequent explosion
	var/mob/firer

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
		var/obj/effect/temp_visual/swarm_rocket_fall/rocket = new /obj/effect/temp_visual/swarm_rocket_fall(fall_location)
		rocket.fingerprintslast = firer
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
	fingerprintslast = src
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
	tracker.firer = usr
	tracker.target = target

	var/drop_delay = 2 SECONDS
	addtimer(CALLBACK(tracker, /obj/effect/swarm_rocket_tracker/proc/step_or_drop), drop_delay)
