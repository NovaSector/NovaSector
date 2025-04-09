/// Gag-Related Text
#define DEPHELMET_GAGGED_TEXT span_purple("Something is gagging your mouth! You can barely make a sound...")
#define DEPHELMET_UNGAGGED_TEXT span_purple("Your mouth is free. You breathe out with relief.")
/// Hearing-Related Text
#define DEPHELMET_DEAF_TEXT span_purple("You can barely hear anything! Your other senses have become more apparent...")
#define DEPHELMET_HEARING_TEXT span_purple("Finally you can hear the world around you once more.")
/// Sight-Related Text
#define DEPHELMET_BLIND_TEXT span_purple("The helmet is blocking your vision! You can't make out anything on the other side...")
#define DEPHELMET_SIGHT_TEXT span_purple("The helmet no longer restricts your vision.")

/obj/item/clothing/head/deprivation_helmet
	name = "deprivation helmet"
	desc = "When configured, completely cuts off the wearer from the outside world. Three switches rest on the back."
	icon_state = "dephelmet"
	base_icon_state = "dephelmet"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_hats.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_hats.dmi'
	greyscale_colors = "#383840#dc7ef4#383840#dc7ef4"
	greyscale_config = /datum/greyscale_config/dephelmet
	greyscale_config_worn = /datum/greyscale_config/dephelmet/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	clothing_flags = SNUG_FIT
	unique_reskin = list(
		"Earred" = "dephelmet",
		"Earless" = "dephelmet_earless"
	)
	obj_flags = INFINITE_RESKIN
	actions_types = list(
		/datum/action/item_action/toggle_vision,
		/datum/action/item_action/toggle_hearing,
		/datum/action/item_action/toggle_speech,
	)
	/// Is speech being prevented
	var/muzzle = FALSE
	/// Is hearing being prevented
	var/earmuffs = FALSE
	/// Is vision being prevented
	var/prevent_vision = FALSE


/// VISION CONTROL
/datum/action/item_action/toggle_vision
	name = "Vision Switch"
	desc = "Makes it impossible to see anything."

/datum/action/item_action/toggle_vision/Trigger(trigger_flags)
	var/obj/item/clothing/head/deprivation_helmet/deprivation_helmet = target
	var/mob/living/carbon/affected_carbon = usr
	if(istype(deprivation_helmet))
		if(deprivation_helmet == affected_carbon.head)
			to_chat(usr, span_notice("You can't reach the deprivation helmet switch!"))
		else
			deprivation_helmet.SwitchHelmet("vision")

/// HEARING CONTROL
/datum/action/item_action/toggle_hearing
	name = "Hearing Switch"
	desc = "Makes it impossible to hear anything."

/datum/action/item_action/toggle_hearing/Trigger(trigger_flags)
	var/obj/item/clothing/head/deprivation_helmet/deprivation_helmet = target
	var/mob/living/carbon/affected_carbon = usr
	if(istype(deprivation_helmet))
		if(deprivation_helmet == affected_carbon.head)
			to_chat(usr, span_notice("You can't reach the deprivation helmet switch!"))
		else
			deprivation_helmet.SwitchHelmet("hearing")


/datum/action/item_action/toggle_speech
	name = "Speech Switch"
	desc = "Makes it impossible to say anything."

/datum/action/item_action/toggle_speech/Trigger(trigger_flags)
	var/obj/item/clothing/head/deprivation_helmet/deprivation_helmet = target
	var/mob/living/carbon/affected_carbon = usr
	if(istype(deprivation_helmet))
		if(deprivation_helmet == affected_carbon.head)
			to_chat(usr, span_notice("You can't reach the deprivation helmet switch!"))
		else
			deprivation_helmet.SwitchHelmet("speech")


// Universal proc to handle all three action buttons.
/obj/item/clothing/head/deprivation_helmet/proc/SwitchHelmet(button)
	var/user_client = button
	switch(user_client)
		if("speech")
			if(muzzle == TRUE)
				playsound_if_pref(usr, 'sound/items/weapons/magout.ogg', 40, TRUE)
				to_chat(usr, span_notice("Speech switch off."))
				if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
					REMOVE_TRAIT(usr, TRAIT_MUTE, CLOTHING_TRAIT)
			else
				playsound_if_pref(usr, 'sound/items/weapons/magin.ogg', 40, TRUE)
				to_chat(usr, span_notice("Speech switch on."))
				if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
					ADD_TRAIT(usr, TRAIT_MUTE, CLOTHING_TRAIT)
					to_chat(usr, DEPHELMET_GAGGED_TEXT)
			muzzle = !muzzle
		if("hearing")
			if(earmuffs == TRUE)
				playsound_if_pref(usr, 'sound/items/weapons/magout.ogg', 40, TRUE)
				to_chat(usr, span_notice("Hearing switch off."))
				if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
					REMOVE_TRAIT(usr, TRAIT_DEAF, CLOTHING_TRAIT)
			else
				playsound_if_pref(usr, 'sound/items/weapons/magin.ogg', 40, TRUE)
				to_chat(usr, span_notice("Hearing switch on."))
				if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
					ADD_TRAIT(usr, TRAIT_DEAF, CLOTHING_TRAIT)
					to_chat(usr, DEPHELMET_DEAF_TEXT)
			earmuffs = !earmuffs
		if("vision")
			var/mob/living/carbon/human/user = usr
			if(prevent_vision == TRUE)
				playsound_if_pref(usr, 'sound/items/weapons/magout.ogg', 40, TRUE)
				to_chat(usr, span_notice("Vision switch off."))
				if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
					user.cure_blind("deprivation_helmet_[REF(src)]")
			else
				playsound_if_pref(usr, 'sound/items/weapons/magin.ogg', 40, TRUE)
				to_chat(usr, span_notice("Vision switch on."))
				if(usr.get_item_by_slot(ITEM_SLOT_HEAD) == src)
					user.become_blind("deprivation_helmet_[REF(src)]")
					to_chat(usr, DEPHELMET_BLIND_TEXT)
			prevent_vision = !prevent_vision

/// We've been grabbed or otherwise equipped to a slot, check if we're worn on the head and apply relevant behavior
/obj/item/clothing/head/deprivation_helmet/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_HEAD))
		return
	if(muzzle == TRUE)
		ADD_TRAIT(user, TRAIT_MUTE, CLOTHING_TRAIT)
		to_chat(usr, DEPHELMET_GAGGED_TEXT)
	if(earmuffs == TRUE)
		ADD_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)
		to_chat(usr, DEPHELMET_DEAF_TEXT)
	if(prevent_vision == TRUE)
		user.become_blind("deprivation_helmet_[REF(src)]")
		to_chat(usr, DEPHELMET_BLIND_TEXT)


// We've been taken off or dropped! Check if we should fix anything.
/obj/item/clothing/head/deprivation_helmet/dropped(mob/living/carbon/human/user)
	. = ..()
	if(muzzle == TRUE)
		REMOVE_TRAIT(user, TRAIT_MUTE, CLOTHING_TRAIT)
	if(earmuffs == TRUE)
		earmuffs = FALSE
		REMOVE_TRAIT(user, TRAIT_DEAF, CLOTHING_TRAIT)
		earmuffs = TRUE
	if(prevent_vision == TRUE)
		user.cure_blind("deprivation_helmet_[REF(src)]")

	/// Some stuff for unequip messages
	if(src == user.head)
		if(muzzle == TRUE) // This text works for the mute as well, so no additional check.
			to_chat(user, DEPHELMET_UNGAGGED_TEXT)
		if(earmuffs == TRUE && !HAS_TRAIT(user, TRAIT_DEAF))
			to_chat(user, DEPHELMET_HEARING_TEXT)
		if(prevent_vision == TRUE && !user.is_blind())
			to_chat(user, DEPHELMET_SIGHT_TEXT)

#undef DEPHELMET_GAGGED_TEXT
#undef DEPHELMET_UNGAGGED_TEXT
#undef DEPHELMET_DEAF_TEXT
#undef DEPHELMET_HEARING_TEXT
#undef DEPHELMET_BLIND_TEXT
#undef DEPHELMET_SIGHT_TEXT
