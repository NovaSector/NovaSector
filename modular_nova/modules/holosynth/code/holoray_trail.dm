/// Renders a holopad-style holoray from the parent item to a linked mob.
/// The ray follows the pen, the linked mob, and any non-linked mob carrying the pen.
/// Right-click while held toggles the trail; examine shows the current state.
/datum/component/holoray_trail
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// Weakref to the mob the ray points at
	var/datum/weakref/linked_mob_ref
	/// Weakref to a non-linked-mob carrier whose movement the ray follows
	var/datum/weakref/holder_ref
	/// The active ray overlay (only set while the mob is deployed and the trail is enabled)
	var/obj/effect/overlay/holoray/holoray
	/// Whether the ray is rendered when conditions allow it
	var/enabled = TRUE

/datum/component/holoray_trail/Initialize(mob/linked_mob)
	if(!isitem(parent) || isnull(linked_mob))
		return COMPONENT_INCOMPATIBLE
	linked_mob_ref = WEAKREF(linked_mob)

/datum/component/holoray_trail/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_parent_moved))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF_SECONDARY, PROC_REF(on_toggle))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	var/mob/linked_mob = linked_mob_ref?.resolve()
	if(linked_mob)
		RegisterSignal(linked_mob, COMSIG_MOVABLE_MOVED, PROC_REF(on_tracked_moved))
	update_holder_tracking()
	refresh_ray()

/datum/component/holoray_trail/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_MOVABLE_MOVED, COMSIG_ITEM_ATTACK_SELF_SECONDARY, COMSIG_ATOM_EXAMINE))
	var/mob/linked_mob = linked_mob_ref?.resolve()
	if(linked_mob)
		UnregisterSignal(linked_mob, COMSIG_MOVABLE_MOVED)
	var/mob/holder = holder_ref?.resolve()
	if(holder)
		UnregisterSignal(holder, COMSIG_MOVABLE_MOVED)
	holder_ref = null
	QDEL_NULL(holoray)

/// Ensures the ray exists + points from the parent's turf to the linked mob's turf, or tears it down if it shouldn't exist.
/datum/component/holoray_trail/proc/refresh_ray()
	var/atom/movable/host = parent
	var/mob/living/linked_mob = linked_mob_ref?.resolve()
	var/turf/host_turf = get_turf(host)
	var/turf/mob_turf = get_turf(linked_mob)
	if(!enabled || isnull(linked_mob) || isnull(host_turf) || isnull(mob_turf) || linked_mob.loc == host)
		QDEL_NULL(holoray)
		return
	if(isnull(holoray))
		holoray = new /obj/effect/overlay/holoray(host_turf)
	else if(holoray.loc != host_turf)
		holoray.abstract_move(host_turf)
	var/distx = mob_turf.x - holoray.x
	var/disty = mob_turf.y - holoray.y
	var/newangle
	if(!disty)
		newangle = (distx >= 0) ? 90 : 270
	else
		newangle = arctan(distx / disty) + (disty < 0 ? 180 : (distx < 0 ? 360 : 0))
	var/matrix/ray_matrix = matrix().Scale(1, sqrt(distx * distx + disty * disty))
	if(get_dist(mob_turf, host_turf) <= 1)
		animate(holoray, transform = turn(ray_matrix, newangle), time = 1)
	else
		holoray.transform = turn(ray_matrix, newangle)

/// Tracks `COMSIG_MOVABLE_MOVED` on the parent's current carrier when it's not the linked mob, so the ray follows them.
/datum/component/holoray_trail/proc/update_holder_tracking()
	var/atom/movable/host = parent
	var/mob/old_holder = holder_ref?.resolve()
	var/mob/linked_mob = linked_mob_ref?.resolve()
	var/atom/movable/new_holder = ismob(host.loc) ? host.loc : null
	if(new_holder == linked_mob)
		new_holder = null
	if(old_holder == new_holder)
		return
	if(old_holder)
		UnregisterSignal(old_holder, COMSIG_MOVABLE_MOVED)
	holder_ref = null
	if(new_holder)
		holder_ref = WEAKREF(new_holder)
		RegisterSignal(new_holder, COMSIG_MOVABLE_MOVED, PROC_REF(on_tracked_moved))

/datum/component/holoray_trail/proc/on_parent_moved(datum/source, atom/old_loc)
	SIGNAL_HANDLER
	update_holder_tracking()
	refresh_ray()

/datum/component/holoray_trail/proc/on_tracked_moved(datum/source, atom/old_loc)
	SIGNAL_HANDLER
	refresh_ray()

/datum/component/holoray_trail/proc/on_toggle(datum/source, mob/user)
	SIGNAL_HANDLER
	enabled = !enabled
	var/atom/host = parent
	host.balloon_alert(user, "trail [enabled ? "on" : "off"]")
	refresh_ray()
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/holoray_trail/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_info("Right-click while held to toggle the projection trail ([enabled ? "on" : "off"]).")
