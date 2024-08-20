#define GRAVITY_PULL 0
#define GRAVITY_REPELL 1
#define GRAVITY_MAYHEM 2

/datum/artifact_effect/gravity
	log_name = "Gravity"
	var/grav_type

/datum/artifact_effect/gravity/New()
	..()
	trigger = TRIGGER_TOUCH
	release_method = ARTIFACT_EFFECT_PULSE
	type_name = ARTIFACT_EFFECT_BLUESPACE
	grav_type = pick(GRAVITY_PULL, GRAVITY_REPELL, GRAVITY_MAYHEM)
	maximum_charges = rand(4,10)
	activation_pulse_cost = maximum_charges

/datum/artifact_effect/gravity/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	if (grav_type == 2)
		for(var/atom/movable/to_throw in range(range, curr_turf))
			mayhem_throw(to_throw, curr_turf, 1)
	else if (grav_type == 1)
		for(var/atom/movable/to_throw in range(range, curr_turf))
			repell(to_throw, curr_turf)
	else if (grav_type == 0)
		for(var/atom/movable/to_throw in range(range, curr_turf))
			grav_pull(to_throw, curr_turf)
	else
		message_admins("The gravity artifact tries to do... something? It doesn't know what to do exactly actually. Tell coders to fix it.")


/datum/artifact_effect/gravity/proc/repell(atom/to_repell, turf/T)
	var/protection = get_anomaly_protection(to_repell)
	if(ishuman(to_repell) && !get_anomaly_protection(to_repell))
		return
	if (istype(to_repell, /obj))
		var/obj/test_anchored = to_repell
		if(test_anchored.anchored)
			return
	var/turfs_to_step = 0
	turfs_to_step = round(protection * 16 / 2) // 8 turfs max range with no protection
	while(turfs_to_step > 0)
		step_away(to_repell, T)
		turfs_to_step--

/datum/artifact_effect/gravity/proc/grav_pull(atom/to_pull, turf/T)
	var/protection = get_anomaly_protection(to_pull)
	if(ishuman(to_pull) && !get_anomaly_protection(to_pull))
		return
	if (istype(to_pull, /obj))
		var/obj/test_anchored = to_pull
		if(test_anchored.anchored)
			return
	var/turfs_to_step = 0
	turfs_to_step = round(protection * 16 / 2) // 8 turfs max range with no protection
	while(turfs_to_step > 0)
		step_towards(to_pull, T)
		turfs_to_step--

/datum/artifact_effect/gravity/proc/mayhem_throw(atom/to_throw, turf/T, amplifier)
	var/protection = get_anomaly_protection(to_throw)
	if(!protection)
		return
	if (istype(to_throw, /obj))
		var/obj/test_anchored = to_throw
		if(test_anchored.anchored)
			return
	var/throw_power = maximum_charges * 2
	var/atom/movable/throw_atom = to_throw
	var/turf/target_turf = pick(orange(get_turf(holder), range * 2 * protection))
	if(!QDELETED(throw_atom))
		throw_atom.throw_at(target_turf, 10 * protection * amplifier, throw_power * protection * amplifier/2)

/datum/artifact_effect/gravity/DoEffectDestroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/atom/movable/to_throw in range(range, curr_turf))
		mayhem_throw(to_throw, curr_turf, 2)


#undef GRAVITY_PULL
#undef GRAVITY_REPELL
#undef GRAVITY_MAYHEM
