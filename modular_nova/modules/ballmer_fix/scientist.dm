// No more force-say
/datum/job/scientist/New()
	liver_traits -= TRAIT_BALLMER_SCIENTIST
	return ..()
