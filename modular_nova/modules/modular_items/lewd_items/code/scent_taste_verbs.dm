/mob/living/carbon/human/verb/lick(mob/living/carbon/human/target in get_adjacent_humans())
	set name = "Lick"
	set category = "IC"

	if(!istype(target))
		return FALSE
	if(!get_organ_slot(ORGAN_SLOT_TONGUE))
		to_chat(src, span_warning("You don't have a tongue to lick with."))
		return FALSE
	if(!can_use_erp_flavor_verb(target, "doesn't feel like being touched right now."))
		return FALSE

	var/taste = target.client?.prefs?.read_preference(/datum/preference/text/erp_flavor/taste)
	if(!taste)
		to_chat(src, span_warning("[target] doesn't seem to have a taste."))
		return FALSE

	to_chat(src, span_notice("[target] tastes like [taste]."))
	to_chat(target, span_notice("[src] licks you."))
	return TRUE

/mob/living/carbon/human/verb/smell(mob/living/carbon/human/target in get_adjacent_humans())
	set name = "Smell"
	set category = "IC"

	if(!istype(target))
		return FALSE
	if(!can_use_erp_flavor_verb(target, "doesn't feel like being approached that close right now."))
		return FALSE

	var/scent = target.client?.prefs?.read_preference(/datum/preference/text/erp_flavor/smell)
	if(!scent)
		to_chat(src, span_warning("[target] doesn't seem to have a smell."))
		return FALSE

	to_chat(src, span_notice("[target] smells like [scent]."))
	return TRUE

/mob/living/carbon/human/proc/can_see_erp_flavor(mob/living/carbon/human/target)
	return client?.prefs?.read_preference(/datum/preference/toggle/erp) && target?.client?.prefs?.read_preference(/datum/preference/toggle/erp)

/mob/living/carbon/human/proc/can_use_erp_flavor_verb(mob/living/carbon/human/target, warning_message)
	if(!can_see_erp_flavor(target))
		to_chat(src, span_warning("You need ERP preferences enabled on both characters to do that."))
		return FALSE

	if(HAS_TRAIT(target, TRAIT_QUICKREFLEXES))
		to_chat(src, span_warning("[target] [warning_message]"))
		return FALSE

	return TRUE

/// Returns adjacent humans for the Lick/Smell IC verb target selector.
/mob/living/proc/get_adjacent_humans()
	var/list/nearby_humans = list()
	for(var/mob/living/carbon/human/nearby_human in range(1, src))
		if(nearby_human == src)
			continue
		nearby_humans += nearby_human
	return nearby_humans
