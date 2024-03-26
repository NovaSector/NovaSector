/datum/quirk/possessive
	name = "Possessive"
	desc = "You feel a strong attachment over any item you own, often times you feel like you cant drop them."
	value = 0
	gain_text = span_danger("You feel like everything you own is too precious to drop.")
	lose_text = span_notice("Suddenly you feel like your stuff isnt that inportant anymore.")
	medical_record_text = "Subject has exhibits a possessive tendencey with objects."
	icon = FA_ICON_HANDS_HOLDING

/datum/quirk/possessive/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human.gain_trauma(/datum/brain_trauma/mild/possessive, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/possessive/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human?.cure_trauma_type(/datum/brain_trauma/mild/possessive, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/kleptomaniac
	name = "Kleptomaniac"
	desc = "You feel a the strong urge to pickup anything around often times without your awareness."
	value = 0
	gain_text = span_danger("You feel a sudden urge to take that. Surely no one will notice.")
	lose_text = span_notice("You no longer feel the urge to take things.")
	medical_record_text = "Subject has exhibits kleptomania"
	icon = FA_ICON_HAND_HOLDING

/datum/quirk/kleptomaniac/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human.gain_trauma(/datum/brain_trauma/severe/kleptomaniac, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/kleptomaniac/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human?.cure_trauma_type(/datum/brain_trauma/severe/kleptomaniac, TRAUMA_RESILIENCE_ABSOLUTE)
