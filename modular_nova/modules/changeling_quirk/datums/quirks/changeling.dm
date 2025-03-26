/datum/quirk/changeling
	name = "Changeling"
	desc = "You're a member of the Changeling Hive, a species of alien predator that is capable of shapeshifting. You have a stinger and can synthesize deadly chemicals internally. All Changelings are linked together through a hivemind."
	icon = FA_ICON_SPAGHETTI_MONSTER_FLYING
	value = 0
	medical_record_text = "Patient possesses dangerous and alien abilities including a stinger, chemical enhancements, and some form of natural bio-camo!"

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
