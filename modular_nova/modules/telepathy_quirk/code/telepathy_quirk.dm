/datum/quirk/telepathic
	name = "Telepathic"
	desc = "You are able to transmit your thoughts to other living creatures."
	gain_text = span_purple("Your mind roils with psychic energy.")
	lose_text = span_notice("Mundanity encroaches upon your thoughts once again.")
	medical_record_text = "Patient has an unusually enlarged Broca's area visible in cerebral biology, and appears to be able to communicate via extrasensory means."
	value = 0
	icon = FA_ICON_HEAD_SIDE_COUGH
	/// Ref used to easily retrieve the action used when removing the quirk from silicons
	var/datum/weakref/tele_action_ref

/datum/quirk/telepathic/add(client/client_source)
		var/datum/action/cooldown/spell/pointed/telepathy/tele_action = new

		tele_action.Grant(quirk_holder)
		tele_action_ref = WEAKREF(tele_action)

/datum/quirk/telepathic/remove()
	var/datum/action/cooldown/spell/pointed/telepathy/tele_action = tele_action_ref?.resolve()
	if (!isnull(tele_action))
		QDEL_NULL(tele_action)
	tele_action_ref = null
