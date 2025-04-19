/datum/status_effect/neuroware
	id = "neuroware"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/neuroware
	var/program_count = 0

/datum/status_effect/neuroware/on_creation(mob/living/new_owner, total_reagents)
	if(total_reagents)
		adjust_program_count(total_reagents)
	return ..()

///Adds the given number to program_count and qdels the effect if 0 or lower.
/datum/status_effect/neuroware/proc/adjust_program_count(count_to_add)
	program_count += count_to_add
	if(program_count <= 0)
		qdel(src)

/atom/movable/screen/alert/status_effect/neuroware
	name = "Neuroware Active"
	desc = "Software is executing in your brain."
	icon_state = ALERT_HACKED
