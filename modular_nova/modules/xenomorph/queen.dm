/mob/living/carbon/alien/humanoid/royal/queen/Initialize(mapload)
	. = ..()

	alien_speed = 0
	grant_language(/datum/language/common, list(LANGUAGE_UNDERSTOOD))
	return ..()
