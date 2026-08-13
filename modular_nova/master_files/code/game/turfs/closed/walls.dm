// NOVA EDIT ADDITION START - PSIONICS - Support temporary psionic wall phasing.
/turf/closed/wall
	var/psionically_warped = FALSE
	var/psionic_warp_timer
	var/psionic_warp_old_density
	var/psionic_warp_old_alpha
	var/psionic_warp_old_color

/turf/closed/wall/proc/psionic_warp(duration = PSIONIC_WARP_DURATION, warp_color = PSIONIC_DEFAULT_COLOR)
	if(psionically_warped)
		return FALSE
	psionically_warped = TRUE
	psionic_warp_old_density = density
	psionic_warp_old_alpha = alpha
	psionic_warp_old_color = color
	psionic_warp_timer = addtimer(CALLBACK(src, PROC_REF(clear_psionic_warp)), duration, TIMER_STOPPABLE)
	density = FALSE
	alpha = 90
	color = warp_color || PSIONIC_DEFAULT_COLOR
	add_filter("psionic_warp", 1, wave_filter(x = 3, y = 3, size = 1, offset = rand()))
	RegisterSignal(src, COMSIG_ATOM_EXAMINE, PROC_REF(on_psionic_warp_examine))
	return TRUE

/turf/closed/wall/proc/clear_psionic_warp()
	if(!psionically_warped)
		return
	psionically_warped = FALSE
	if(psionic_warp_timer)
		deltimer(psionic_warp_timer)
	psionic_warp_timer = null
	density = psionic_warp_old_density
	alpha = psionic_warp_old_alpha
	color = psionic_warp_old_color
	psionic_warp_old_density = null
	psionic_warp_old_alpha = null
	psionic_warp_old_color = null
	remove_filter("psionic_warp")
	UnregisterSignal(src, COMSIG_ATOM_EXAMINE)

/turf/closed/wall/proc/on_psionic_warp_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_purple("A wavering psionic fold has made it briefly passable.")
// NOVA EDIT ADDITION END
