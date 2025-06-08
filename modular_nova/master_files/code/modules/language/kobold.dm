/datum/language/kobold
	name = "Kobold"
	desc = "Yip yip."
	key = "k"
	space_chance = 100
	sentence_chance = 100
	between_word_sentence_chance = 10
	between_word_space_chance = 75
	additional_syllable_low = 0
	additional_syllable_high = 3
	syllables = list("yip", "yap", "eep", "mip", "meep", "merp", "ree", "ek")
	default_priority = 80

	icon_state = "animal"

/datum/language/kobold/get_random_name(
	gender = NEUTER,
	name_count = 2,
	syllable_min = 2,
	syllable_max = 4,
	force_use_syllables = FALSE,
)
	return "kobold ([rand(1, 999)])"
