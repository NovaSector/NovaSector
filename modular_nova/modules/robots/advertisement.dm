
GLOBAL_LIST_EMPTY(all_advertisements)

/datum/asset/simple/space_cola_ad
	assets = list(
		"space_cola.png" = 'modular_nova/modules/robots/sprites/space_cola.png'
	)

/datum/advertisement
	var/mob/living/target
	var/permanently_closed = TRUE
	var/severity = 0
	var/play_close_noise = TRUE
	var/current_ui = "Advertisement"
	var/list/verbal_ads = list(
		"I just love the taste of Space Cola to start my shift!",
		"I'm going to buy some Space Cola, anyone wanna join me?",
		"Have you tried the refreshing taste of Space Cola? Proven to cure cancer in select studies!",
		"I'm a huge fan of Space Cola; I don't drink anything else!",
		"Bounce back from a hard day on the job with a sweet, refreshing Space Cola, now back with the classic flavor and old school ingredients.",
	)
	var/speech_loop
	var/close_cola_timer
	var/num_of_ads_closed = 1
	var/can_close_ad_safely = FALSE
	var/moving_to_promo = FALSE

/datum/advertisement/New()
	. = ..()
	LAZYADD(GLOB.all_advertisements, src)

/datum/advertisement/Destroy(force)
	LAZYREMOVE(GLOB.all_advertisements, src)
	. = ..()

/datum/advertisement/ui_state(mob/user)
	return GLOB.always_state

/datum/advertisement/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE

/datum/advertisement/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/simple/space_cola_ad),
	)

/datum/advertisement/proc/open_for(mob/target, severity)
	if(!istype(target))
		return
	src.target = target
	src.severity = severity
	if(severity == 1)
		permanently_closed = FALSE
	var/sound/annoying_sound = sound('modular_nova/modules/robots/sounds/popup_open.ogg', volume = 100)
	SEND_SOUND(target, annoying_sound)
	ui_interact(target)

/datum/advertisement/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, current_ui)
		ui.open()

/datum/advertisement/ui_data(mob/user)
	var/list/data = list()
	data["severity"] = severity
	data["customer"] = target.name ? target.name : "Customer"
	return data

/datum/advertisement/ui_close(mob/user)
	. = ..()
	if(current_ui == "Advertisement")
		if(play_close_noise)
			var/sound/annoying_sound = sound('modular_nova/modules/robots/sounds/popup_close.ogg', volume = 100)
			SEND_SOUND(user, annoying_sound)
		if(!permanently_closed && !QDELETED(src) && target && !target.stat)
			addtimer(CALLBACK(src, PROC_REF(open_for), target, severity), 5 SECONDS, TIMER_DELETE_ME)
		else
			if(!moving_to_promo)
				qdel(src)
	else
		deltimer(speech_loop)
		deltimer(close_cola_timer)
		if(!can_close_ad_safely) // motherfucker alt-F4'd the window, no cheating allowed
			if(target && !target.stat)
				var/sound/cheater_sound = sound('sound/machines/buzz/buzz-two.ogg', volume = 100)
				SEND_SOUND(user, cheater_sound)
				for(var/i in 1 to num_of_ads_closed * 2)
					addtimer(CALLBACK(src, PROC_REF(show_ad), severity), rand(5, 15))
		else
			var/sound/annoying_sound = sound('modular_nova/modules/robots/sounds/popup_close.ogg', volume = 100)
			SEND_SOUND(user, annoying_sound)

/datum/advertisement/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("purchase")
			if(!target || target.stat) // we're too occupied to purchase right now
				return TRUE
			var/broke = FALSE
			var/datum/bank_account/sucker = target.get_bank_account()
			if(sucker)
				if(!sucker.has_money(100))
					broke = TRUE
				else
					sucker.adjust_money(-100, "Clicked a pop-up ad")
					var/obj/item/card/id/sucker_id = target.get_idcard()
					var/list/possible_products = list(
						"Lamplight: The Dating App For Moths, By Moths",
						"Joe Grey-tide's Personal Routine: 6 Week Plan",
						"NANOTRASEN AND THE GROVE: Tales from Spacehemia Podcast",
						"SpaceBox Premium",
						"OnlyHorses",
						"Nanotrasen Defragmenter Gold Edition",
						"Extended Shuttle Warranty",
						"THE TRUTH",
					)
					sucker_id.say("Thank you for subscribing to [pick(possible_products)] for 100 credits!")
					playsound(sucker_id, 'sound/effects/cashregister.ogg', 60, TRUE)
			else
				broke = TRUE
			if(broke) // deploy our """alternative""" approach
				var/datum/tgui/possible_ui = SStgui.get_open_ui(target, src)
				play_close_noise = FALSE
				permanently_closed = TRUE
				moving_to_promo = TRUE
				if(possible_ui)
					possible_ui.close()
				for(var/datum/advertisement/ad in GLOB.all_advertisements)
					if(ad.target == target && ad != src)
						num_of_ads_closed++
						ad.play_close_noise = FALSE
						ad.permanently_closed = TRUE
						qdel(ad)
					CHECK_TICK
				current_ui = "AdvertisementCantPay"
				playsound(target, 'modular_nova/modules/robots/sounds/popup_broke.ogg', 100, FALSE)
				speech_loop = addtimer(CALLBACK(src, PROC_REF(advertise_space_cola)), 5 SECONDS, TIMER_STOPPABLE | TIMER_LOOP | TIMER_DELETE_ME)
				close_cola_timer = addtimer(CALLBACK(src, PROC_REF(close_space_cola_ad)), 20 SECONDS, TIMER_STOPPABLE | TIMER_LOOP | TIMER_DELETE_ME)
				ui_interact(target)
				return TRUE
			qdel(src)
			return TRUE
		if("toggle_close_perma")
			permanently_closed = TRUE
			return TRUE
		if("actually_close")
			var/datum/tgui/possible_ui = SStgui.get_open_ui(target, src)
			if(possible_ui)
				possible_ui.close()
			return TRUE
	return FALSE

/datum/advertisement/proc/advertise_space_cola()
	if(target && !target.stat)
		target.say(message = prob(25) ? ";[pick(verbal_ads)]" : pick(verbal_ads), forced = TRUE, ignore_spam = TRUE, filterproof = TRUE)

/datum/advertisement/proc/close_space_cola_ad()
	can_close_ad_safely = TRUE
	qdel(src)

/datum/advertisement/proc/show_ad(severity)
	if(target && target.client && !target.stat)
		var/datum/advertisement/popup = new
		popup.open_for(target, severity)
