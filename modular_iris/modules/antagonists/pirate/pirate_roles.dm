/obj/effect/mob_spawn/ghost_role/human/pirate/grey/tidy
	name = "\improper Assistant sleeper"
	desc = "A dirty cryogenic sleeper."
	density = FALSE
	you_are_text = "You used to be a Nanotrasen assistant, until your station was bombed irrepairably. You've joined a faction called the Tidy Tiders afterwards, wandering through space."
	flavour_text = "Be civil, and if the crew rejects your payment, unleash bloodshed."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "an assistant militant"
	outfit = /datum/outfit/pirate/tider
	rank = "Tider Trooper"

/obj/effect/mob_spawn/ghost_role/human/pirate/grey/tidy/medic
	prompt_name = "an assistant medic"
	rank = "Tider Corpsman"
	outfit = /datum/outfit/pirate/tider/medic

/obj/effect/mob_spawn/ghost_role/human/pirate/grey/tidy/captain
	prompt_name = "an assistant captain"
	you_are_text = "You used to be a Nanotrasen assistant, until your station was bombed irrepairably. You've made a faction called the Tidy Tiders afterwards, wandering through space and recruiting anyone else."
	rank = "Tider Maximus"
	outfit = /datum/outfit/pirate/tider/captain
