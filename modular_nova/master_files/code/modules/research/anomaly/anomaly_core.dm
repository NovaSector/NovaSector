// NOVA EDIT ADDITION START - PSIONICS - Allow psions to attune matching anomaly cores.
/obj/item/assembly/signaler/anomaly/examine(mob/user)
	. = ..()
	if(!isliving(user))
		return

	var/mob/living/living_user = user
	if(living_user.get_psionic_profile())
		. += span_purple("<b>Alt-click</b> to attune your thoughts to its resonance.")

/obj/item/assembly/signaler/anomaly/click_alt(mob/user)
	if(!isliving(user))
		return NONE

	var/mob/living/living_user = user
	var/datum/component/psionic_profile/profile = living_user.get_psionic_profile()
	if(!profile)
		return NONE

	var/datum/psionic_school/school = get_psionic_school_for_anomaly_core(type)
	if(!school)
		to_chat(living_user, span_notice("[src] hums against your thoughts, but its resonance does not match an imprinted branch."))
		return CLICK_ACTION_BLOCKING
	if(!profile.attune_school(school.type))
		return CLICK_ACTION_BLOCKING

	qdel(src)
	return CLICK_ACTION_SUCCESS
// NOVA EDIT ADDITION END
