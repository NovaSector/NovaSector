/datum/component/omen/quirk/RegisterWithParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_LIVING_DEATH) // No death gibbing

