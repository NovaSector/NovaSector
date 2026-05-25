/datum/language/marish
	name = "Marish"
	desc = "Where shadekin have a language rooted in empathy, there are still subtle tones and syllables that are as delicate as the emotions that shadekin normally communicate with."
	key = "q"
	space_chance = 55
	icon = 'modular_nova/master_files/icons/misc/language.dmi'
	icon_state = "marish"
	default_priority = 90
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD | NO_STUTTER
	syllables = list("mar", "mwrrr", "maaAr", "'aarrr", "wrurrl", "mmar")

/datum/language/marish/empathy
	name = "Empathy"
	desc = "Shadekin seem to always know what the others are thinking. This is probably why."
	key = "9"
	secret = TRUE
	icon_state = "empathy"
