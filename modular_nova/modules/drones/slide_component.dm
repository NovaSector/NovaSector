/datum/element/sliding_under
	///The list of allowed mobs to slide under
	var/static/list/allowed_mobs = typecacheof(list(
		/mob/living/basic/cortical_borer,
		/mob/living/basic/drone,
	))

/datum/element/sliding_under/Attach(datum/target)
	. = ..()

	// needs to be an atom
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	//either bumping or ctrl click
	RegisterSignal(target, COMSIG_CLICK_CTRL, PROC_REF(check_conditions))
	//so that we can know how to do that (sliding under)
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(ExamineMessage))

/datum/element/sliding_under/Detach(source, ...)
	. = ..()
	UnregisterSignal(source, list(COMSIG_CLICK_CTRL, COMSIG_ATOM_EXAMINE))

/datum/element/sliding_under/proc/check_conditions(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!isatom(source))
		return

	var/atom/source_atom = source

	//the parent needs to be dense in order to slide through
	if(!source_atom.density)
		return

	// need to be in range
	if(!in_range(source_atom, user))
		return

	//you have to be in the list
	if(!is_type_in_typecache(user, allowed_mobs))
		return

	INVOKE_ASYNC(src, PROC_REF(try_squeezing_through), source_atom, user)

/// Actually attempt the squeezing under
/datum/element/sliding_under/proc/try_squeezing_through(atom/source_atom, mob/user)
	// you need to have patience and can't move away
	if(!do_after(user, 5 SECONDS, source_atom))
		return

	if(!attempt_slide(source_atom, user))
		source_atom.balloon_alert(user, "something blocks the way!")
		return

	source_atom.balloon_alert_to_viewers("something squeezes through!")

/datum/element/sliding_under/proc/attempt_slide(atom/source_atom, mob/user)
	var/turf/destination = get_turf(source_atom)
	if(!destination)
		return FALSE

	// weird edge case for borders doors, and if you're standing on table/rack on the same turf as the door
	if((source_atom.flags_1 & ON_BORDER_1) && (get_turf(user) == destination))
		destination = get_step(destination, source_atom.dir)
		if(!destination)
			return FALSE

	ADD_TRAIT(user, TRAIT_SLIDING_UNDER, REF(src))
	var/moved = user.Move(destination)
	REMOVE_TRAIT(user, TRAIT_SLIDING_UNDER, REF(src))
	return moved

/datum/element/sliding_under/proc/ExamineMessage(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!is_type_in_typecache(user, allowed_mobs))
		return

	examine_list += span_warning("Ctrl + Click [source] to slide under!\n")

// Loads our drone under door slide component dependency
/obj/machinery/door/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/sliding_under)

/obj/machinery/door/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	return HAS_TRAIT(mover, TRAIT_SLIDING_UNDER)

// component for mineral doors too
/obj/structure/mineral_door/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/sliding_under)

/obj/structure/mineral_door/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	return HAS_TRAIT(mover, TRAIT_SLIDING_UNDER)
