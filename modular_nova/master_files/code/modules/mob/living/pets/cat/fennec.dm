/mob/living/basic/pet/cat/fennec
	name = "fennec fox"
	desc = "Vulpes Zerda. Also known as a Goob or a Dingler."
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_state = "fennec"
	icon_living = "fennec"
	icon_dead = "fennec_dead"
	held_lh = 'modular_nova/master_files/icons/mob/inhands/pets_held_lh.dmi'
	held_rh = 'modular_nova/master_files/icons/mob/inhands/pets_held_rh.dmi'
	head_icon = 'modular_nova/master_files/icons/mob/clothing/head/pets_head.dmi'
	speak_emote = list("screms", "squeaks", "rrrfs")
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
	)
	collar_icon_state = null
	worn_slot_flags = ITEM_SLOT_HEAD
	held_state = "fennec"
	ai_controller = /datum/ai_controller/basic_controller/cat/fennec

/mob/living/basic/pet/cat/fennec/update_overlays()
	. = ..()
	if(stat == DEAD || resting || !held_food)
		return
	if(istype(held_food, /obj/item/fish))
		held_item_overlay = mutable_appearance(icon, "fennec_fish_overlay")
	if(istype(held_food, /obj/item/food/deadmouse))
		held_item_overlay = mutable_appearance(icon, "fennec_mouse_overlay")
	. += held_item_overlay

/datum/bt_node/ai_behavior/random_speech/fennecs
	speech_chance = 5
	speak = list(
		"screm!",
		"rrrrf!",
		"screech!",
		"aaaaaa!",
		"squeak!",
		"yip!",
		"squee!",
	)

/datum/ai_controller/basic_controller/cat/fennec
	behavior_tree_json = "modular_nova/master_files/code/modules/mob/living/pets/cat/fennec.bt.json"

/mob/living/basic/pet/cat/fennec/add_breeding_component()
	AddComponent(\
		/datum/component/breed,\
		can_breed_with = typecacheof(list(/mob/living/basic/pet/cat/fennec)),\
		baby_paths = list(/mob/living/basic/pet/cat/fennec),\
	)
