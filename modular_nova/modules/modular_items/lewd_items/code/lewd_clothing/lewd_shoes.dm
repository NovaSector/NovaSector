/// Sprite doesn't visually represent the verticality correctly but the description at time of rewrite implied this was the 'intended' item?? idk. just going with it
/obj/item/clothing/shoes/ballet_heels
	name = "ballet heels"
	desc = "Restrictive, knee-high heels. Unfathomably difficult to walk in."
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	greyscale_colors = "#383840"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/ballet_heels"
	post_init_icon_state = "balletheels"
	greyscale_config = /datum/greyscale_config/ballet_heel
	greyscale_config_worn = /datum/greyscale_config/ballet_heel/worn
	greyscale_config_worn_digi = /datum/greyscale_config/ballet_heel/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	slowdown = SHOES_SLOWDOWN+1.5
	var/causes_pain = TRUE

/obj/item/clothing/shoes/ballet_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list(
		'modular_nova/master_files/sound/effects/footstep/highheel1.ogg' = 1,
		'modular_nova/master_files/sound/effects/footstep/highheel2.ogg' = 1,
	), 70, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, falloff_exponent = SOUND_FALLOFF_EXPONENT)

	if(causes_pain)
		RegisterSignal(src, COMSIG_SHOES_STEP_ACTION, PROC_REF(step_pain))


//Ballet heels hurt to use and cause a bit of pain from frequent walking in them.
/obj/item/clothing/shoes/proc/step_pain()
	SIGNAL_HANDLER
	var/mob/living/carbon/human/our_guy = loc
	if(!istype(our_guy)) // are they REALLY /our guy/?
		return

	if(prob(0.2)) //one in five hundred chance it procs
		//Robotic legs feel no pain
		var/obj/item/bodypart/leg/right = our_guy.get_bodypart(BODY_ZONE_R_LEG)
		var/obj/item/bodypart/leg/left = our_guy.get_bodypart(BODY_ZONE_L_LEG)
		if (right.bodytype == BODYTYPE_ROBOTIC && left.bodytype == BODYTYPE_ROBOTIC)
			return

		to_chat(our_guy, span_warning("Your feet ache from walking in these heels."))
		our_guy.add_mood_event("shoe_pain", /datum/mood_event/shoe_pain)

/obj/item/clothing/shoes/ballet_heels/domina_heels
	name = "dominant heels"
	desc = "A pair of aesthetically pleasing heels."
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	icon_state = "dominaheels"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	post_init_icon_state = null
	slowdown = SHOES_SLOWDOWN
	causes_pain = FALSE

/*
*	LATEX SOCKS
*/

/obj/item/clothing/shoes/latex_socks
	name = "latex socks"
	desc = "A pair of shiny, split-toe socks made of some strange material."
	w_class = WEIGHT_CLASS_SMALL
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	greyscale_colors = "#383840"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/latex_socks"
	post_init_icon_state = "latex_socks"
	greyscale_config = /datum/greyscale_config/latex_socks
	greyscale_config_worn = /datum/greyscale_config/latex_socks/worn
	greyscale_config_worn_digi = /datum/greyscale_config/latex_socks/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
