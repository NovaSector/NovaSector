// Shadekin Brain - provides dark regeneration and light averseness mechanics.

/obj/item/organ/brain/shadekin
	name = "shadekin brain"
	desc = "A mysterious brain."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-x-d"
	var/applied_status = /datum/status_effect/shadekin_regeneration

/obj/item/organ/brain/shadekin/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/turf/owner_turf = owner.loc
	if(!isturf(owner_turf))
		return
	var/light_amount = owner_turf.get_lumcount()

	if(light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD)
		owner.apply_status_effect(applied_status)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/light_averse)
	else
		owner.add_movespeed_modifier(/datum/movespeed_modifier/light_averse)

/datum/status_effect/shadekin_regeneration
	id = "shadekin_regeneration"
	duration = 2 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/shadekin_regeneration

/datum/status_effect/shadekin_regeneration/on_apply()
	. = ..()
	if(!.)
		return FALSE
	heal_owner()
	return TRUE

/datum/status_effect/shadekin_regeneration/refresh(effect)
	. = ..()
	heal_owner()

/datum/status_effect/shadekin_regeneration/proc/heal_owner()
	owner.heal_overall_damage(brute = 0.5, burn = 0.5, required_bodytype = BODYTYPE_ORGANIC)

/atom/movable/screen/alert/status_effect/shadekin_regeneration
	name = "Dark Regeneration"
	desc = "Feeling the tug of home on your fur, some of its soothing warmth comes to ease your burdens."
	icon_state = "lightless"

/datum/movespeed_modifier/light_averse
	multiplicative_slowdown = 0.25

// Shadekin Eyes - flash sensitive, large eyes with enhanced night vision.

/obj/item/organ/eyes/shadekin
	name = "shadekin eyes"
	desc = "These eyes are massive, and feel warm to the touch. The shadekin that's missing these is probably feeling very queasy."
	eye_icon = 'modular_nova/modules/shadekin/icons/shadekin_eyes.dmi'
	eye_icon_state = "shadekin_eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	blink_animation = FALSE
	iris_overlay = null
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM

// Shadekin Tongue - enables empathic telepathic communication via the Empathy language.

/obj/item/organ/tongue/shadekin
	name = "shadekin tongue"
	desc = "A mysterious tongue."
	icon_state = "silvertongue"
	say_mod = "mars"
	sense_of_taste = TRUE
	modifies_speech = TRUE
	languages_native = list(/datum/language/marish/empathy)

/obj/item/organ/tongue/shadekin/handle_speech(datum/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] in languages_native)
		return modify_speech(source, speech_args)

/obj/item/organ/tongue/shadekin/modify_speech(datum/source, list/speech_args)
	ASYNC
		actually_modify_speech(source, speech_args)
	speech_args[SPEECH_MESSAGE] = ""

/obj/item/organ/tongue/shadekin/proc/actually_modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = owner
	var/shadekin_mood = user.mob_mood.sanity_level
	var/empathy_timer = 2 SECONDS
	var/obj/item/organ/ears/shadekin/user_ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	var/mode = istype(user_ears)
	user.balloon_alert_to_viewers("[mode ? "ears vibrate" : "shivers"]", "projecting thoughts...")

	switch(shadekin_mood)
		if(SANITY_LEVEL_GREAT)
			empathy_timer = 0
		if(SANITY_LEVEL_NEUTRAL)
			empathy_timer = 1 SECONDS
		if(SANITY_LEVEL_UNSTABLE)
			empathy_timer = 4 SECONDS
		if(SANITY_LEVEL_CRAZY)
			empathy_timer = 5 SECONDS
			message = stars(message)
		if(SANITY_LEVEL_INSANE)
			empathy_timer = 6 SECONDS
			message = readable_corrupted_text(message)

	if(empathy_timer && !do_after(source, empathy_timer, source))
		message = full_capitalize(rot13(message))
	var/mood_color = "#5ec7e4"
	switch(shadekin_mood)
		if(SANITY_LEVEL_GREAT)
			mood_color = "#5ec7e4"
		if(SANITY_LEVEL_NEUTRAL)
			mood_color = "#a8d8ea"
		if(SANITY_LEVEL_UNSTABLE)
			mood_color = "#d4a843"
		if(SANITY_LEVEL_CRAZY)
			mood_color = "#c94a4a"
		if(SANITY_LEVEL_INSANE)
			mood_color = "#8b0000"
	var/rendered = "<span style=color:[mood_color];><b>[user.real_name]:</b> [message]</span>"

	user.log_talk(message, LOG_SAY, tag="shadekin")
	for(var/mob/living/carbon/human/living_mob in GLOB.alive_mob_list)
		var/obj/item/organ/ears/shadekin/target_ears = living_mob.get_organ_slot(ORGAN_SLOT_EARS)

		if(!istype(target_ears))
			continue

		to_chat(living_mob, rendered)
		if(living_mob != user)
			mode = istype(target_ears)
			living_mob.balloon_alert_to_viewers("[mode ? "ears vibrate" : "shivers"]", "transmission heard...")

	if(length(GLOB.dead_mob_list))
		for(var/mob/dead_mob in GLOB.dead_mob_list)
			if(dead_mob.client)
				var/link = FOLLOW_LINK(dead_mob, user)
				to_chat(dead_mob, "[link] [rendered]")

// Shadekin Ears - sensitive ears that detect empathic communication.

/obj/item/organ/ears/shadekin
	name = "shadekin ears"
	desc = "Ears, covered in fur."
	damage_multiplier = 2.5
