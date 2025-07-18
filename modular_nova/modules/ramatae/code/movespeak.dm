/datum/language/ramatae
	name = "Move-Speak"
	desc = "A primarily nonverbal language comprised of body movements, gesticulation, and sign language, with only intermittent warbles & other vocalizations. It's almost completely incomprehensible without its somatic components."
	key = "M"
	flags = TONGUELESS_SPEECH
	space_chance = 30
	syllables = list(
		"wa", "wawa", "awa", "a"
	)
	icon = 'modular_nova/master_files/icons/misc/language.dmi'
	icon_state = "movespeak"
	default_priority = 80

	default_name_syllable_min = 5
	default_name_syllable_max = 10
