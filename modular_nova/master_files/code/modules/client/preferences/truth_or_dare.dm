// Quick preference for people to opt into random Truth or Dare requests, typicalla via PDA.

/datum/preference/choiced/accepts_unsolicited_truth_or_dare
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "accepts_random_td"

/datum/preference/choiced/accepts_unsolicited_truth_or_dare/init_possible_values()
	return list("No", "Yes - Varies/Ask", "Yes - SFW Only", "Yes - NSFW Truths Only", "Yes - NSFW Truths and Dares")

/datum/preference/choiced/accepts_unsolicited_truth_or_dare/create_default_value()
	return "No"

/datum/preference/choiced/accepts_unsolicited_truth_or_dare/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
