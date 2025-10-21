/// Kobors
/datum/language_holder/kobold
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/draconic = list(LANGUAGE_ATOM),
		/datum/language/kobold = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/kobold = list(LANGUAGE_ATOM),
	)

// This allows species using human_basic to be eligible for the  Common Second Language quirk
/datum/language_holder/human_basic
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/uncommon = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/uncommon = list(LANGUAGE_ATOM),
	)
