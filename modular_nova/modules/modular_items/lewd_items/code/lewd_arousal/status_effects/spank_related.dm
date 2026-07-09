// This name means nothing. What does this even do?

/datum/status_effect/subspace
	id = "subspace"
	tick_interval = 1 SECONDS
	duration = 5 MINUTES
	alert_type = null

/datum/status_effect/subspace/on_apply()
	. = ..()
	var/mob/living/carbon/human/target = owner
	target.add_mood_event("subspace", /datum/mood_event/subspace)

/datum/status_effect/subspace/on_remove()
	. = ..()
	var/mob/living/carbon/human/target = owner
	target.clear_mood_event("subspace")

/datum/mood_event/subspace
	description = span_purple("Everything is so woozy... Pain feels so... Awesome.\n")


//Hips are red after spanking
/datum/status_effect/spanked
	id = "spanked"
	duration = 300 SECONDS
	alert_type = null

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(arousal && ishuman(user))
		var/mob/living/carbon/human/examiner = user
		if(examiner.can_see_erp_flavor(src))
			var/arousal_flavor_text = get_arousal_flavor_text()
			if(arousal_flavor_text)
				. += arousal_flavor_text

	if(stat >= DEAD || HAS_TRAIT(src, TRAIT_FAKEDEATH) || src == user || !has_status_effect(/datum/status_effect/spanked) || !is_bottomless())
		return

	. += span_purple("[user.p_Their()] butt has a red tint to it.") + "\n"

/mob/living/carbon/human/proc/get_arousal_flavor_text()
	if(!client?.prefs)
		return ""

	if(arousal >= AROUSAL_HIGH)
		var/high_flavor = client.prefs.read_preference(/datum/preference/text/erp_flavor/high_arousal)
		return high_flavor ? span_userlove(high_flavor) + "\n" : ""
	if(arousal >= AROUSAL_MEDIUM)
		var/medium_flavor = client.prefs.read_preference(/datum/preference/text/erp_flavor/medium_arousal)
		return medium_flavor ? span_userlove(medium_flavor) + "\n" : ""
	if(arousal >= AROUSAL_LOW)
		var/low_flavor = client.prefs.read_preference(/datum/preference/text/erp_flavor/low_arousal)
		return low_flavor ? span_purple(low_flavor) + "\n" : ""
	return ""

//Mood boost for masochist
/datum/mood_event/perv_spanked
	description = span_purple("Ah, yes! More! Punish me!\n")
	timeout = 5 MINUTES
