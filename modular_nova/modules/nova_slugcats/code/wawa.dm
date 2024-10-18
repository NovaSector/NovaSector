/datum/language/slugcat
	name = "Move-Speak"
	desc = "A primarily nonverbal language comprised of body movements, gesticulation, and sign language, with only intermittent vocalizations.  It's completely incomprehensible on vocalization alone."
	key = "M"
	flags = TONGUELESS_SPEECH
	space_chance = 30
	syllables = list(
		"wa", "wawa", "awa", "a"
	)
	icon = 'modular_nova/modules/nova_slugcats/lang.dmi' //temporarily shunted here to avoid merge conflicts due to active language PRs
	icon_state = "slugspeak"
	default_priority = 90
