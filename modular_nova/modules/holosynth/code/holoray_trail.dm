/// Holoray variant that replaces the base class's render-step glow with a
/// plain emissive appearance. The base glow uses RESET_TRANSFORM + pixel_x/y = 32,
/// which leaves a phantom un-transformed copy of the ray one tile NE of the
/// source. The holopad hides that under its own machine sprite; a bare pen
/// doesn't. A mutable_appearance on EMISSIVE_PLANE inherits our transform and
/// renders in the same place as the main sprite.
/obj/effect/overlay/holoray/holosynth

/obj/effect/overlay/holoray/holosynth/Initialize(mapload)
	. = ..()
	if(glow)
		cut_overlay(glow)
		LAZYREMOVE(update_overlays_on_z, glow)
		QDEL_NULL(glow)
	add_overlay(emissive_appearance(icon, icon_state, src, alpha = alpha))

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
	var/obj/effect/overlay/holoray/holosynth/holoray
	/// Whether the ray is rendered when conditions allow it
	var/enabled = TRUE
	/// Tint applied to the ray sprite; null leaves the default blue.
	var/ray_color

/datum/component/holoray_trail/Initialize(mob/linked_mob, ray_color)
	if(!isitem(parent) || isnull(linked_mob))
		return COMPONENT_INCOMPATIBLE
	linked_mob_ref = WEAKREF(linked_mob)
	src.ray_color = ray_color

/datum/component/holoray_trail/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_parent_moved))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF_SECONDARY, PROC_REF(on_toggle))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	var/mob/linked_mob = linked_mob_ref?.resolve()
	if(linked_mob)
		RegisterSignal(linked_mob, COMSIG_MOVABLE_MOVED, PROC_REF(on_tracked_moved))
		RegisterSignal(linked_mob, COMSIG_QDELETING, PROC_REF(on_linked_mob_qdel))
	update_holder_tracking()
	refresh_ray()

/datum/component/holoray_trail/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_MOVABLE_MOVED, COMSIG_ITEM_ATTACK_SELF_SECONDARY, COMSIG_ATOM_EXAMINE))
	var/mob/linked_mob = linked_mob_ref?.resolve()
	if(linked_mob)
		UnregisterSignal(linked_mob, list(COMSIG_MOVABLE_MOVED, COMSIG_QDELETING))
	var/mob/holder = holder_ref?.resolve()
	if(holder)
		UnregisterSignal(holder, COMSIG_MOVABLE_MOVED)
	holder_ref = null
	QDEL_NULL(holoray)

/// Self-destructs when the linked mob is deleted.
/datum/component/holoray_trail/proc/on_linked_mob_qdel(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, list(COMSIG_MOVABLE_MOVED, COMSIG_QDELETING))
	qdel(src)

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
		holoray = new /obj/effect/overlay/holoray/holosynth(host_turf)
		if(ray_color)
			holoray.color = ray_color
	else if(holoray.loc != host_turf)
		holoray.abstract_move(host_turf)
	var/distx = mob_turf.x - holoray.x
	var/disty = mob_turf.y - holoray.y
	var/newangle
	if(!disty)
		newangle = (distx >= 0) ? 90 : 270
	else
		newangle = arctan(distx / disty) + (disty < 0 ? 180 : (distx < 0 ? 360 : 0))
	var/matrix/new_transform = turn(matrix().Scale(1, sqrt(distx * distx + disty * disty)), newangle)
	if(get_dist(mob_turf, host_turf) <= 1)
		animate(holoray, transform = new_transform, time = 0.1 SECONDS)
	else
		holoray.transform = new_transform

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
