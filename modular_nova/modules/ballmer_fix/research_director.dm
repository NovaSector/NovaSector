// No more force-say
/datum/job/research_director/New()
	liver_traits -= TRAIT_SCIENTIST_LIVER
	return ..()
