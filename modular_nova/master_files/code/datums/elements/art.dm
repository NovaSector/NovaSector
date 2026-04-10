/datum/element/art/apply_moodlet(atom/source, mob/living/user, impress)
	. = ..()
	SEND_SIGNAL(user, COMSIG_LIVING_APPRAISE_ART, source)
