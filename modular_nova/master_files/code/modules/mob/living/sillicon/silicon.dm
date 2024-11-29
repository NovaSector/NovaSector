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
