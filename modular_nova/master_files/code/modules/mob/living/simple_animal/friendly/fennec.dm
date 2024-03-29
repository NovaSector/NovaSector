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
	has_collar_resting_icon_state = FALSE
	can_be_held = TRUE
	worn_slot_flags = ITEM_SLOT_HEAD
	held_state = "fennec"
