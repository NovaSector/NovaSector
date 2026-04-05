//Ports of https://github.com/DopplerShift13/DopplerShift/pull/622
/datum/controller/subsystem/shuttle/proc/revert_autoEnd()
	emergency_no_recall = FALSE
	endvote_passed = FALSE
	SSevents.can_fire = TRUE
