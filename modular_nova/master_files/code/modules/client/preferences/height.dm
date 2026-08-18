// Nova Sector has its own height preference, /datum/preference/choiced/height_scaling, which
// predates upstream's and is a superset of it - it offers five height tiers instead of three and
// handles Teshari, dwarves and the Spacer/Settler quirks.
//
// Both preferences are PREFERENCE_CHARACTER and both call set_mob_height() from apply_to_human(),
// and apply_prefs_to() applies every character preference regardless of is_accessible(), so
// leaving upstream's active would have the two clobber each other depending on preference
// priority order. We neutralize upstream's here rather than dropping the core file, so the
// upstream definition keeps mirroring cleanly.
/datum/preference/choiced/mob_height/is_accessible(datum/preferences/preferences)
	..() // parent is required by SHOULD_CALL_PARENT, but we hide this preference unconditionally
	return FALSE

/datum/preference/choiced/mob_height/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return
