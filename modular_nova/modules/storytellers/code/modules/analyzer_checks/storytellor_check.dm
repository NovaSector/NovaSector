/datum/storytellor_check
	var/name = "Generic check"


/datum/storytellor_check/proc/can_perform_now(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	return TRUE


/datum/storytellor_check/proc/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	SHOULD_CALL_PARENT(TRUE)
	if(anl)
		anl.try_stop_analyzing(src)
