/// An element that makes guns throw their user back if they are just a little guy
/datum/element/gun_launches_little_guys
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

	/// The throwing force applied to the gun's user
	var/throwing_force
	/// The throwing range applied to the gun's user
	var/throwing_range

/datum/element/gun_launches_little_guys/Attach(datum/target, throwing_force = 2, throwing_range = 3)
	. = ..()
	if(!isgun(target))
		return ELEMENT_INCOMPATIBLE

	src.throwing_force = throwing_force
	src.throwing_range = throwing_range

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(examine))
	RegisterSignal(target, COMSIG_MOB_FIRED_GUN, PROC_REF(throw_it_back))

/datum/element/gun_launches_little_guys/Detach(datum/target)
	. = ..()
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(target, COMSIG_MOB_FIRED_GUN)

/// Warns that this gun might throw you away really hard
/datum/element/gun_launches_little_guys/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("It has some serious kick to it, smaller users should take caution while firing.")

/// Checks if the shooter is just a little guy. If so? Throw it back.
/datum/element/gun_launches_little_guys/proc/throw_it_back(mob/living/carbon/user, obj/item/gun/gun_fired, target, params, zone_override, list/bonus_spread_values)
	SIGNAL_HANDLER

	if(!isteshari(user) || !isdwarf(user) || !HAS_TRAIT(user, TRAIT_DWARF))
		return

	var/fling_direction = REVERSE_DIR(get_dir(user, target))
	var/atom/throw_target = get_edge_target_turf(user, fling_direction)
	user.Knockdown(1 SECONDS)
	user.throw_at(throw_target, throwing_range, throwing_force)
