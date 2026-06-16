/datum/psionic_power/spatial_slip
	action_type = /datum/action/cooldown/psionic/spatial_slip

/datum/action/cooldown/psionic/spatial_slip
	name = "Spatial Slip"
	desc = "Blink a short distance through a bluespace fold."
	button_icon_state = "psi_spatial_slip"
	cooldown_time = 15 SECONDS
	point_cost = 1
	strain_gain = 20
	psionic_flags = PSIONIC_SPATIAL
	school = PSIONIC_SCHOOL_BLUESPACE
	/// Maximum inaccuracy range for the bluespace slip.
	var/slip_range = 4

/datum/action/cooldown/psionic/spatial_slip/psionic_activate(atom/target)
	var/turf/current_turf = get_turf(owner)
	if(!current_turf)
		return FALSE

	if(!do_teleport(owner, current_turf, slip_range, channel = TELEPORT_CHANNEL_BLUESPACE))
		owner.balloon_alert(owner, "fold fails!")
		return FALSE

	to_chat(owner, span_purple("You slip through a brief bluespace fold."))
	return TRUE
