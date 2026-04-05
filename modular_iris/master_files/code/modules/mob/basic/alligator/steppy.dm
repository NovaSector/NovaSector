/mob/living/basic/alligator // Not actually obtainable in-game outside of remora btw, save yourself the search.
	name = "alligator"
	desc = "Thats an alligator. Probably shouldn't wrestle it."
	icon = 'modular_iris/master_files/icons/mob/simple/alligator.dmi'
	icon_state = "gator"
	icon_living = "gator"
	icon_dead = "gator_dead"
	health = 125
	maxHealth = 125
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_emote = list("snaps")
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "rolls over"
	response_disarm_simple = "roll over"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	melee_damage_lower = 20
	melee_damage_upper = 24
	speed = 8
	glide_size = 2
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	ai_controller = /datum/ai_controller/basic_controller/alligator
	attack_vis_effect = ATTACK_EFFECT_BITE

/mob/living/basic/alligator/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_CLAW)

/mob/living/basic/alligator/steppy
	name = "Steppy"
	desc = "Cargo's pet gator. Is he being detained!?"
	gender = MALE
