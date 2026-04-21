/mob/living/carbon/human/verb/lick(mob/living/carbon/human/target in get_adjacent_humans())
	set name = "Lick"
	set category = "IC"

	if(!istype(target))
		return FALSE

	if(HAS_TRAIT(target, TRAIT_QUICKREFLEXES))
		to_chat(src, span_warning("[target] doesn't feel like being touched right now."))
		return FALSE

	var/taste = target.dna?.features?[FLAVOR_KEY_TASTE]
	if(!taste)
		to_chat(src, span_warning("[target] doesn't seem to have a taste."))
		return FALSE

	to_chat(src, span_notice("[target] tastes like [taste]."))
	to_chat(target, span_notice("[src] licks you."))

/mob/living/carbon/human/verb/smell(mob/living/carbon/human/target in get_adjacent_humans())
	set name = "Smell"
	set category = "IC"

	if(!istype(target))
		return FALSE

	if(HAS_TRAIT(target, TRAIT_QUICKREFLEXES))
		to_chat(src, span_warning("[target] doesn't feel like being approached that close right now."))
		return FALSE

	var/scent = target.dna?.features?[FLAVOR_KEY_SMELL]
	if(!scent)
		to_chat(src, span_warning("[target] doesn't seem to have a smell."))
		return FALSE

	to_chat(src, span_notice("[target] smells like [scent]."))

/// Returns a list of humans adjacent to src (excluding src itself). Used as the target
/// filter for the Lick/Smell IC verbs.
/mob/living/proc/get_adjacent_humans()
	var/list/nearby_humans = list()
	for(var/mob/living/carbon/human/nearby_human in orange(1, src))
		if(nearby_human == src)
			continue
		nearby_humans += nearby_human
	return nearby_humans
