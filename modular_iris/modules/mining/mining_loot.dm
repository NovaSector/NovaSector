// The legion has a nasty habit of destroying its own chests, so these ones are non-dense until moved
/obj/structure/closet/crate/necropolis/tendril/legion
	name = "transparent necropolis chest"
	desc = "It's watching you suspiciously. You need a skeleton key to open it. Looks you can move through it."
	density = FALSE
	alpha = 150

/obj/structure/closet/crate/necropolis/tendril/legion/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))

/obj/structure/closet/crate/necropolis/tendril/legion/Destroy(force)
	if(!density)
		UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	return ..()

/obj/structure/closet/crate/necropolis/tendril/legion/proc/on_moved()
	SIGNAL_HANDLER
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	name = "necropolis chest"
	desc = "It's watching you suspiciously. You need a skeleton key to open it."
	density = TRUE
	animate(src, time = 3 SECONDS, alpha = 255)

/obj/effect/wisp
	var/mob/last_owner = null

/obj/effect/wisp/Destroy()
	if(last_owner)
		UnregisterSignal(last_owner, COMSIG_QDELETING)
		last_owner = null

	return ..()

/obj/effect/wisp/orbit(atom/A, radius = 10, clockwise = FALSE, rotation_speed = 20, rotation_segments = 36, pre_rotation = TRUE)
	. = ..()
	if(!.)
		return

	if(last_owner)
		UnregisterSignal(last_owner, COMSIG_QDELETING)

	last_owner = orbit_target
	RegisterSignal(last_owner, COMSIG_QDELETING, PROC_REF(they_be_goned))

/obj/effect/wisp/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(!orbit_target && last_owner && isturf(loc))
		orbit(last_owner, 20)

/obj/effect/wisp/proc/they_be_goned()
	SIGNAL_HANDLER
	last_owner = null
