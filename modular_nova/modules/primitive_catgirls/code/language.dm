/datum/language/primitive_catgirl
	name = "Ættmál"
	desc = "A liturgical language passed through three centuries of Hearthkin culture, the only tongue which their literature is allowed to be spoken in; \
				especially relating to their pagan practices. While Siik'Tajr is used as a trade language with outsiders, Ættmál remains sacred and mostly unknown \
				to those outside the Hearth."
	key = "H"
	flags = TONGUELESS_SPEECH
	space_chance = 70
	sentence_chance = 25
	between_word_sentence_chance = 10
	between_word_space_chance = 75
	additional_syllable_low = 0
	additional_syllable_high = 0
	syllables = list (
		"al", "an", "ar", "að", "eg", "en", "er", "ha", "he", "il", "in", "ir", "ið", "ki", "le", "na", "nd", "ng", "nn", "og", "ra", "ri",
		"se", "st", "ta", "ur", "ði", "va", "ve", "sem", "sta", "til", "tur", "var", "ver", "við", "ður", "það", "þei", "með", "ega", "ann",
		"tur", "egr", "eda", "eva", "ada", "the", "tre", "tai", "thor", "thur", "ohd", "din", "gim", "per", "ger", "héð", "bur", "kóp", "vog",
		"bar", "dar", "akur", "jer", "bær", "múl", "fjörð", "jah", "dah", "dim", "din", "dir", "dur", "nya", "miau", "mjau", "ný", "kt", "hø",
	)
	icon_state = "omgkittyhiii"
	icon = 'modular_nova/modules/primitive_catgirls/icons/language_icon.dmi'
	default_priority = 94
	secret = TRUE

	mutual_understanding = list(
	/datum/language/common = 50,
	/datum/language/uncommon = 33,
	)
