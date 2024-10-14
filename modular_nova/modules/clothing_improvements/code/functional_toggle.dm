/*
Functional Toggle lets you convert stuff to functional (exo suit), with armor, cold and heat protection values, to non functional (neck), with all those set to zero.
It allows people to use a jacket over a piece or armor and only sacrifice the minimal amount of functionality in the pursuit of design.
Use CTRL + SHIFT + LEFT CLICK to turn them on and off.
*/


/obj/item/clothing/suit/
	var/only_functional = FALSE

/obj/item/clothing/suit/Initialize(mapload)
	. = ..()
	
	if(!(flags_1 & HAS_CONTEXTUAL_SCREENTIPS_1)) 
		register_context()

/obj/item/clothing/suit/examine(mob/user)
	. = ..()
	
	if(!only_functional)
		. += span_info("Ctrl + Shift + Left Click to swap between functional (suit) and non-functional (neck) mode, to allow for things such as wearing a (nonfunctional) jacket over a piece of armor for the visual effect.")

/obj/item/clothing/suit/click_ctrl_shift(mob/user)
	if(!iscarbon(user))
		return NONE
	if(only_functional)
		return NONE
	var/mob/living/carbon/char = user
	if((char.get_item_by_slot(ITEM_SLOT_NECK) == src) || (char.get_item_by_slot(ITEM_SLOT_OCLOTHING) == src))
		to_chat(user, span_warning("You can't adjust [src] while wearing it!"))
		return CLICK_ACTION_BLOCKING
	if(!user.is_holding(src))
		to_chat(user, span_warning("You must be holding [src] in order to adjust it!"))
		return CLICK_ACTION_BLOCKING
	if(slot_flags & ITEM_SLOT_OCLOTHING)
		slot_flags = ITEM_SLOT_NECK
		cold_protection = null
		heat_protection = null
		slowdown = 0
		set_armor(/datum/armor/none)
		user.visible_message(span_notice("[user] adjusts their [src] for non-functional use."), span_notice("You adjust your [src] for non-functional use."))
	else
		slot_flags = initial(slot_flags)
		cold_protection = initial(cold_protection)
		heat_protection = initial(heat_protection)
		slowdown = initial(slowdown)
		set_armor(initial(armor_type))
		user.visible_message(span_notice("[user] adjusts their [src] for functional use."), span_notice("You adjust your [src] for functional use."))
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/suit/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	
	if(only_functional)
		return
	if(slot_flags == ITEM_SLOT_NECK)
		context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Toggle functional mode"
	else
		context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Toggle non-functional mode"
	return CONTEXTUAL_SCREENTIP_SET

// Add the things here that shouldn't have this functionality.

/obj/item/clothing/suit/space
	only_functional = TRUE

// Stuff that gives other effects, like reactive armor, reflective armor, etc.

/obj/item/clothing/suit/armor/reactive
	only_functional = TRUE

/obj/item/clothing/suit/hooded/ablative
	only_functional = TRUE

/obj/item/clothing/suit/armor/heavy/adamantine
	only_functional = TRUE

/obj/item/clothing/suit/armor/laserproof
	only_functional = TRUE

/obj/item/clothing/suit/hooded/berserker
	only_functional = TRUE

/obj/item/clothing/suit/armor/abductor/vest
	only_functional = TRUE
