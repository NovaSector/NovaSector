/mob/living/basic/pet/dog/wolf
	name = "wolf"
	desc = "A white wolf. Typically seen howling at the moon or making supernatural themed roleplaying games."
	icon = 'icons/mob/simple/icemoon/icemoon_monsters.dmi'
	icon_state = "whitewolf"
	icon_living = "whitewolf"
	icon_dead = "whitewolf_dead"
	speak_emote = list("howls")
	friendly_verb_continuous = "howls at"
	friendly_verb_simple = "howl at"
	ai_controller = /datum/ai_controller/basic_controller/dog

	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	death_message = "snarls its last and perishes."

