/mob/living/silicon
	/// The Examine Panel datum for the mob.
	var/datum/examine_panel/mob_examine_panel
	/// The scream emote selected in prefs
	var/selected_scream


/mob/living/silicon/Initialize(mapload)
	. = ..()
	mob_examine_panel = new(src)


/mob/living/silicon/Destroy()
	QDEL_NULL(mob_examine_panel)
	return ..()

/// Sets the cyborg's gender and pronouns from preferences. Expects a client.
/mob/living/silicon/proc/set_gender(client/player_client)
	var/silicon_gender = player_client.prefs.read_preference(/datum/preference/choiced/silicon_gender)
	if(silicon_gender == "Use gender")
		gender = player_client.prefs.read_preference(/datum/preference/choiced/gender)
	else
		gender = silicon_gender
