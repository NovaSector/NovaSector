/datum/language/polysmorph
	name = "polysmorph"
	desc = "The common tongue of the polysmorphs."
	key = "x"
	syllables = list("sss","sSs","SSS")
	default_priority = 50
	icon_state = "xeno"

	mutual_understanding = list(
		/datum/language/xenocommon = 20,
	)

/datum/language/xenocommon //needs hivemind connection to be propely understood without special training (curator)
	mutual_understanding = list(
		/datum/language/polysmorph = 20,
	)


//commented out until i figure out why it breaks in tests
/*
/datum/language/polysmorph/get_random_name(
	gender = NEUTER,
	name_count = default_name_count,
	syllable_min = default_name_syllable_min,
	syllable_max = default_name_syllable_max,
	force_use_syllables = FALSE,
)
	if(force_use_syllables)
		return ..()

	return "[pick(GLOB.polysmorph_names)]"
*/
