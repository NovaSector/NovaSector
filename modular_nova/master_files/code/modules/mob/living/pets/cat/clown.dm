/mob/living/basic/pet/cat/clown
	name = "clown cat"
	desc = "A funny little creature imported to Clown Planet, beloved by millions."
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_state = "clowncat"
	icon_living = "clowncat"
	icon_dead = "clowncat_dead"
	speak_emote = list("purrs", "honks", "meows")
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	unsuitable_atmos_damage = 0.5
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/organ/ears/cat = 1,
		/obj/item/organ/tail/cat = 1,
		/obj/item/clothing/mask/gas/clown_hat = 1,

	)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "asks to not joke about that"
	response_disarm_simple = "ask not to joke about that"
	response_harm_continuous = "throws tomatos"
	response_harm_simple = "throws tomato"
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_icon_state = "clowncat"
	can_be_held = TRUE
	ai_controller = /datum/ai_controller/basic_controller/cat/clown
	held_state = "cat2"
	attack_verb_continuous = "honks"
	attack_verb_simple = "honk"
	attack_sound = 'sound/items/bikehorn.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW

/datum/ai_controller/basic_controller/cat/clown
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/catclown,
	)

/datum/ai_planning_subtree/random_speech/catclown
	speech_chance = 10
	sound = list('sound/effects/footstep/clownstep1.ogg', 'sound/effects/footstep/clownstep2.ogg', 'sound/items/bikehorn.ogg',)
	speak = list(
		"hoooonk!",
		"meow!",
		"honk!",
		"mrow!",
		"henk!",
	)
	emote_see = list("plays tricks.", "slips.", "honks a tiny horn.")
