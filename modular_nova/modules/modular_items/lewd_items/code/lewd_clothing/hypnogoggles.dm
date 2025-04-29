/obj/item/clothing/glasses/hypno
	name = "hypnotic goggles"
	desc = "An all-in-one mnemonic impression repeater and vision tinter, used to entrance the wearer with a programmed phrase. Foam inserts, to boot."
	icon_state = "hypnogoggles"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_eyes.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_eyes.dmi'
	greyscale_colors = "#383840#dc7ef4"
	greyscale_config = /datum/greyscale_config/hypnogoggles
	greyscale_config_worn = /datum/greyscale_config/hypnogoggles/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	/// The hypnotic codephrase. Default always required otherwise things break.
	var/codephrase = "Obey."

/obj/item/clothing/glasses/hypno/Initialize(mapload)
	. = ..()
	if(check_holidays(APRIL_FOOLS))
		codephrase = "Become... video deliveryman!"

/obj/item/clothing/glasses/hypno/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/glasses/hypno/attack_self(mob/user)
	. = ..()
	var/new_codephrase = tgui_input_text(user, "Change The Hypnotic Phrase.", max_length = MAX_MESSAGE_LEN)
	if(!isnull(new_codephrase))
		codephrase = new_codephrase


/obj/item/clothing/glasses/hypno/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_EYES))
		return
	if(!(iscarbon(user) && user.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy)))
		return
	if(!codephrase)
		codephrase = initial(codephrase) // DIE
	log_game("[key_name(user)] was hypnogoggled.")
	to_chat(user, span_reallybig(span_hypnophrase(codephrase)))
	to_chat(user, span_notice(pick("You feel your thoughts focusing on this phrase... you can't seem to get it out of your head.",
									"Your head hurts, but this is all you can think of. It must be vitally important.",
									"You feel a part of your mind repeating this over and over. You need to follow these words.",
									"Something about this sounds... right, for some reason. You feel like you should follow these words.",
									"These words keep echoing in your mind. You find yourself completely fascinated by them.")))
	var/atom/movable/screen/alert/hypnosis/hypno_alert = user.throw_alert("hypnosis", /atom/movable/screen/alert/hypnosis, timeout_override = 30 SECONDS)
	hypno_alert.desc = "\"[codephrase]\"... your mind seems to be fixated on this concept."
	START_PROCESSING(SSobj, src)

/obj/item/clothing/glasses/hypno/dropped(mob/living/user)
	. = ..()
	if(datum_flags & DF_ISPROCESSING)
		log_game("[key_name(user)] is no longer hypnogoggled.")
		to_chat(user, span_userdanger("You suddenly snap out of your hypnosis. The phrase '[codephrase]' no longer feels important to you."))
		STOP_PROCESSING(SSobj, src)


/// We're mimicing behavior that used to be innate in the brain trauma - yes, brain trauma - this used to give you.
/obj/item/clothing/glasses/hypno/process(seconds_per_tick)
	. = ..()
	var/mob/living/carbon/human/wearer = loc
	if(!istype(wearer) || !SPT_PROB(1, seconds_per_tick))
		return
	if(!(wearer.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))) // something is really fucked if they're wearing this at this point anyways
		return
	switch(rand(1, 2))
		if(1)
			to_chat(wearer, span_hypnophrase("<i>...[lowertext(codephrase)]...</i>"))
		if(2)
			new /datum/hallucination/chat(wearer, TRUE, FALSE, span_hypnophrase("[codephrase]"))
