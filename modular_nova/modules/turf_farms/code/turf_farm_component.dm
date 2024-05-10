/datum/component/turf_farm
	/// References the parent atom that this component is attached to
	var/turf/turf_parent
	/// If this turf has a plant growing on it, checked to make sure multiple plants aren't planted on it at once
	var/obj/machinery/hydroponics/turf_farm/tracked_farm
	/// How effective is this soil? Effects the hidden tray's "rating" variable. Lower is worse, 1 is identical to a standard hydro tray.
	var/soil_effectiveness = 1

/datum/component/turf_farm/Initialize(soil_effectiveness)
	if(!isturf(parent))
		return COMPONENT_INCOMPATIBLE
	turf_parent = parent
	src.soil_effectiveness = soil_effectiveness
	RegisterSignal(turf_parent, COMSIG_ATOM_ATTACKBY, PROC_REF(check_attack))
	RegisterSignal(turf_parent, COMSIG_ATOM_EXAMINE, PROC_REF(check_examine))
	RegisterSignal(turf_parent, COMSIG_QDELETING, PROC_REF(delete_farm))

/datum/component/turf_farm/Destroy(force)
	UnregisterSignal(turf_parent, list(COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_EXAMINE, COMSIG_QDELETING))
	if(tracked_farm)
		UnregisterSignal(tracked_farm, COMSIG_QDELETING)
	QDEL_NULL(tracked_farm)
	turf_parent = null
	return ..()

/// Checks if seeds have been used on the parent to try planting them
/datum/component/turf_farm/proc/check_attack(datum/source, obj/item/attacking_item, mob/user)
	SIGNAL_HANDLER

	if(!istype(attacking_item, /obj/item/seeds))
		return
	if(tracked_farm)
		turf_parent.balloon_alert(user, "soil already occupied")
		return
	tracked_farm = new(turf_parent)
	tracked_farm.rating = soil_effectiveness
	RegisterSignal(tracked_farm, COMSIG_QDELETING, PROC_REF(delete_farm))
	INVOKE_ASYNC(src, PROC_REF(actually_attackby), attacking_item, user)

/// Used for an invoke async so that there's no illegal sleeping
/datum/component/turf_farm/proc/actually_attackby(obj/item/attacking_item, mob/user)
	tracked_farm.attackby(attacking_item, user)

/// Gives some helpful examine information for hinting that players might be able to plant seeds here
/datum/component/turf_farm/proc/check_examine(datum/source, mob/user, list/examine_list)
	examine_list += span_notice("You can plant <b>seeds</b> in [turf_parent]")
	switch(soil_effectiveness)
		if(0 to 0.5)
			examine_list += span_notice("[turf_parent] appears to be exceptionally poor quality planting space, however...")
		if(0.6 to 0.9)
			examine_list += span_notice("[turf_parent] appears to be pretty poor quality planting space, however...")
		if(1 to 1.9)
			examine_list += span_notice("[turf_parent] looks to be pretty average planting space, too...")
		if(2 to 2.9)
			examine_list += span_notice("[turf_parent] looks like a pretty good spot to grow plants, too...")
		if(3 to 3.9)
			examine_list += span_notice("[turf_parent] looks like a rich spot to grow plants, they would flourish here...")
		else
			examine_list += span_notice("[turf_parent] looks like an exceptionally rich spot to grow plants, any greenery here would be beyond flourishing...")

/// Deletes the stored farm plot if there is one
/datum/component/turf_farm/proc/delete_farm()
	SIGNAL_HANDLER

	QDEL_NULL(tracked_farm)
