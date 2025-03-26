/datum/quirk/changeling
	name = "Changeling"
	desc = "You are a changeling, one that for some reason or another has entered a dormant, non-predatory state. The crew will likely still hunt you down if you are discovered, because as far as they're concerned, you're the same monster through-and-through. As part of this momentary suppressed state, some of your typical abilities seem to be just as dormant."
	icon = FA_ICON_SPAGHETTI_MONSTER_FLYING
	value = 0
	medical_record_text = ""
	quirk_flags = QUIRK_HIDE_FROM_SCAN

/datum/quirk/changeling/add(client/client_source)
	var/datum/mind/target_mind = quirk_holder.mind
	var/datum/antagonist/changeling/quirk/C = target_mind.has_antag_datum(/datum/antagonist/changeling/quirk)
	if(!C)
		C = target_mind.add_antag_datum(/datum/antagonist/changeling/quirk)
		target_mind.special_role = ROLE_CHANGELING
	return C

/datum/quirk/changeling/remove(client/client_source)
	var/datum/mind/target_mind = quirk_holder.mind
	var/datum/antagonist/changeling/quirk/C = quirk_holder?.mind.has_antag_datum(/datum/antagonist/changeling/quirk)
	if(C)
		target_mind.remove_antag_datum(/datum/antagonist/changeling/quirk)
		target_mind.special_role = null
