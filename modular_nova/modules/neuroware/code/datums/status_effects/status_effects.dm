///Indicates when neuroware reagents are processing by displaying a screen alert.
///Removes itself when program_count reaches 0.
/datum/status_effect/neuroware
	id = "neuroware"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/neuroware
	///The total number of neuroware reagents expected to be metabolizing. When it reaches 0, the status effect deletes itself.
	var/program_count = 1

///Adds the given number to program_count and qdels the effect if 0 or lower.
/datum/status_effect/neuroware/proc/adjust_program_count(count_to_add)
	program_count += count_to_add
	if(program_count <= 0)
		qdel(src)

/atom/movable/screen/alert/status_effect/neuroware
	name = "Neuroware Active"
	desc = "Software is executing in your brain."
	icon = 'modular_nova/modules/neuroware/icons/screen_alert.dmi'
	icon_state = "neuroware"
