// No more force-say
/datum/job/scientist/New()
	liver_traits -= TRAIT_SCIENTIST_LIVER
	return ..()
