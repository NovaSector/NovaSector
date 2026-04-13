/mob/living/carbon/alien/Initialize(mapload)
	. = ..()

	grant_language(/datum/language/common, list(LANGUAGE_UNDERSTOOD))
