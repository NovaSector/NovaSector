/// We want there to be only one of these because this way we cap the amount that are able to run concurrently to 20. (so mass-deletions don't create massive lag)
GLOBAL_DATUM(admin_sparks_system, /datum/effect_system/spark_spread/admin_sparks)

/// The singleton spark system, don't make more of these please!
/datum/effect_system/spark_spread/admin_sparks
	effect_type = /obj/effect/particle_effect/sparks/quantum/inert

/// This spark effect should not start fires or affect turfs/atoms in any way
/obj/effect/particle_effect/sparks/quantum/inert

/obj/effect/particle_effect/sparks/quantum/inert/LateInitialize()
	. = ..()
	UnregisterSignal(src, list(COMSIG_MOVABLE_CROSS, COMSIG_MOVABLE_CROSS_OVER))

/obj/effect/particle_effect/sparks/quantum/inert/affect_location(turf/location, just_initialized = FALSE)
	return

/// Creates non-interactive rainbow sparks at the given source location
/proc/do_admin_sparks(number, cardinals_only, datum/source)
	var/location = isturf(source) ? source : get_turf(source)
	if(isnull(location))
		return

	playsound(location, 'sound/effects/magic/Repulse.ogg', 100, 1)

	// only created when needed
	if(isnull(GLOB.admin_sparks_system))
		GLOB.admin_sparks_system = new

	var/datum/effect_system/spark_spread/admin_sparks/admin_sparks = GLOB.admin_sparks_system
	admin_sparks.set_up(number, cardinals_only, location)
	admin_sparks.attach(location)
	admin_sparks.start()
