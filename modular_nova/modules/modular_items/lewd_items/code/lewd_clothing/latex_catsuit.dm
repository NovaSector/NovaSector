/obj/item/clothing/under/misc/latex_catsuit
	name = "latex catsuit"
	desc = "A shiny uniform that fits snugly to the skin."
	icon_state = "latex_catsuit_female"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_digi = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-digi.dmi'
	worn_icon_taur_snake = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-snake.dmi'
	worn_icon_taur_paw = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-paw.dmi'
	worn_icon_taur_hoof = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-hoof.dmi'
	inhand_icon_state = "latex_catsuit"
	lefthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	equip_sound = 'modular_nova/modules/modular_items/lewd_items/sounds/latex.ogg'
	can_adjust = FALSE
	strip_delay = 10
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION


//this fragment of code makes unequipping not instant
/obj/item/clothing/under/misc/latex_catsuit/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/human/affected_human = user
		if(src == affected_human.w_uniform)
			if(!do_after(affected_human, 6 SECONDS, target = src))
				return
	. = ..()

// //some gender identification magic
/obj/item/clothing/under/misc/latex_catsuit/equipped(mob/living/affected_mob, slot)
	. = ..()
	var/mob/living/carbon/human/affected_human = affected_mob
	if(src == affected_human.w_uniform)
		if(affected_mob.gender == FEMALE)
			icon_state = "latex_catsuit_female"
		else
			icon_state = "latex_catsuit_male"

		affected_mob.update_worn_undersuit()


/obj/item/clothing/under/misc/latex_catsuit/dropped(mob/living/affected_mob)
	. = ..()
	accessory_overlay = null


//Plug to bypass the bug with instant suit equip/drop
/obj/item/clothing/under/misc/latex_catsuit/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	return

