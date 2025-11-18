/datum/language/chitinclick
	name = "Chitinclick"
	desc = "A popular non-Human language that finds extensive use by various types of anthropomorphic invertebrates. It consists of complex flutters, chittering, antenna movements, and sparse guttural syllables."
	key = "C"
	space_chance = 40
	sentence_chance = 10
	between_word_sentence_chance = 0
	between_word_space_chance = 75
	additional_syllable_low = -2
	additional_syllable_high = -1
	//References some replaced languages.
	syllables = list(
		// Original
		"a", "ak", "ae", "ai", "az", "ba", "bz", "bu", "bh", "br", "bi",
		"c", "ca", "ci", "ch", "chk", "cr", "cl", "ce", "cu", "cli", "cla",
		"du", "dr", "dri", "de", "do", "dza", "dk", "g", "ga", "gr", "dz",
		"gi", "gchk", "i", "ii", "ik", "it", "il", "ie", "iz", "ir", "io",
		"pi", "pz", "pe", "po", "phk", "k", "kz", "kl", "ka", "kli", "kh",
		"kch", "vh", "vr", "vz", "veh", "mr", "mz", "mi", "ma", "mhk", "zz",
		"ze", "zu", "zo", "za", "nz", "zi", "fz", "fr", "f", "fi", "click",
		"chit", "rr", "ru", "ra", "rzz", "ri", "re",
		// Buzzwords
		"zz", "buzz", "ZZ",
	)

	icon_state = "chitinclick"
	icon = 'modular_nova/master_files/icons/misc/language.dmi'
