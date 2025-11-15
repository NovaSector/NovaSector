/// shadows can now lose limbs, take wounds and lose blood - because of this, we'll need them to regenerate those
/datum/status_effect/shadow/regeneration/heal_owner()
	. = ..()
	// limbs #1
	// wounds #2
	// bloodlevel #3
