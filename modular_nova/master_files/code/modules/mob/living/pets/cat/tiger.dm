/mob/living/basic/pet/cat/tiger
	name = "tiger cat"
	desc = "A small cat with tiger stripes."
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	ai_controller = /datum/ai_controller/basic_controller/cat/tiger
	icon_state = "tiger"
	icon_living = "tiger"
	icon_dead = "tiger_dead"
	speak_emote = list("roar","roars", "purrs", "meows",)
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	unsuitable_atmos_damage = 0.5
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/organ/ears/cat = 1,
		/obj/item/organ/tail/cat = 1,
		/obj/item/clothing/head/pelt/tiger = 1,
	)

/datum/ai_controller/basic_controller/cat/tiger
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/living/pets/cat/tiger.bt.json"

/datum/bt_node/ai_behavior/random_speech/cattiger
	speech_chance = 10
	speak = list(
		"roar!",
		"meow!",
		"grrr!",
	)
