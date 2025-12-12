/datum/brain_trauma/very_special/no_libido
	name = "Loss of Libido"
	desc = "The patient has completely lost sexual interest."
	scan_desc = "lack of libido"
	gain_text = span_notice("You don't feel horny anymore.")
	lose_text = span_notice("A pleasant warmth spreads over your body.")
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/very_special/no_libido/on_gain()
	. = ..()
	var/mob/living/carbon/human/affected_human = owner
	ADD_TRAIT(affected_human, TRAIT_NO_LIBIDO, TRAIT_APHRO)

/datum/brain_trauma/very_special/no_libido/on_lose()
	. = ..()
	var/mob/living/carbon/human/affected_human = owner
	REMOVE_TRAIT(affected_human, TRAIT_NO_LIBIDO, TRAIT_APHRO)
