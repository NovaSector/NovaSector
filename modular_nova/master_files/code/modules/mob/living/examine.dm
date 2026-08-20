// The single override of this proc for humans - add new examine lines here rather than overriding it again.
/mob/living/carbon/human/examine(mob/user)
	. = ..()
	. += get_dnr_examine(user)
	insert_examine_headshot(., user)
	. += get_arousal_examine(user)
	. += get_empath_examine(user)

// Hooked per subtype rather than on /mob/living/silicon: AIs and cyborgs append their parent's lines at the
// end of their own, so hooking the parent would bury the headshot in the middle of the examine.
/mob/living/silicon/ai/examine(mob/user)
	. = ..()
	insert_examine_headshot(., user)

/mob/living/silicon/robot/examine(mob/user)
	. = ..()
	insert_examine_headshot(., user)

/mob/living/silicon/pai/examine(mob/user)
	. = ..()
	insert_examine_headshot(., user)

/// Puts our headshot thumbnail at the top of [examine_list], if [user] should be shown one.
/mob/living/proc/insert_examine_headshot(list/examine_list, mob/user)
	if(!user?.client?.prefs?.read_preference(/datum/preference/toggle/show_headshot_on_examine))
		return

	if(isliving(user))
		var/mob/living/living_user = user
		if(living_user.is_blind())
			return

	var/headshot_url = get_headshot_url()
	if(!headshot_url)
		return

	// The link is validated when it's set, but make sure nothing can break out of the src attribute anyway.
	var/static/regex/forbidden_characters = regex(@{"['"<> ]"})
	if(forbidden_characters.Find(headshot_url))
		return

	examine_list.Insert(1, "<span class='examine_headshot'><img src='[headshot_url]'></span>")

/// Returns the image link to use as our headshot, if we have one to show.
/mob/living/proc/get_headshot_url()
	return null

/mob/living/carbon/human/get_headshot_url()
	if(is_face_obscured())
		return null
	return dna?.features?[EXAMINE_DNA_HEADSHOT]

/mob/living/silicon/get_headshot_url()
	return client?.prefs?.read_preference(/datum/preference/text/headshot/silicon)
