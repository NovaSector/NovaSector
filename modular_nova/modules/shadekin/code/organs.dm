// Shadekin Brain - provides dark regeneration and light averseness mechanics.

/obj/item/organ/brain/shadekin
	name = "shadekin brain"
	desc = "A mysterious brain."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-x-d"

/obj/item/organ/brain/shadekin/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/turf/owner_turf = owner.loc
	if(!isturf(owner_turf))
		return
	var/light_amount = owner_turf.get_lumcount()

	if(light_amount < SHADOW_SPECIES_LIGHT_THRESHOLD)
		owner.apply_status_effect(/datum/status_effect/shadekin_regeneration)
	else
		owner.remove_status_effect(/datum/status_effect/shadekin_regeneration)
		owner.add_movespeed_modifier(/datum/movespeed_modifier/light_averse)

/datum/status_effect/shadekin_regeneration
	id = "shadekin_regeneration"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/shadekin_regeneration

/datum/status_effect/shadekin_regeneration/on_apply()
	. = ..()
	if(!.)
		return FALSE
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_owner_moved))
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/light_averse)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/dark_affinity)
	owner.add_actionspeed_modifier(/datum/actionspeed_modifier/hands_of_darkness)
	heal_owner()
	return TRUE

/datum/status_effect/shadekin_regeneration/on_remove()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/dark_affinity)
	owner.remove_actionspeed_modifier(/datum/actionspeed_modifier/hands_of_darkness)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/light_averse)
	return ..()

/datum/status_effect/shadekin_regeneration/tick(seconds_between_ticks)
	heal_owner()

/datum/status_effect/shadekin_regeneration/proc/heal_owner()
	owner.heal_overall_damage(brute = 0.5, burn = 0.5, required_bodytype = BODYTYPE_ORGANIC)

/datum/status_effect/shadekin_regeneration/proc/on_owner_moved(datum/source)
	SIGNAL_HANDLER
	var/turf/owner_turf = owner?.loc
	if(!isturf(owner_turf))
		return
	if(owner_turf.get_lumcount() >= SHADOW_SPECIES_LIGHT_THRESHOLD)
		qdel(src)

/atom/movable/screen/alert/status_effect/shadekin_regeneration
	name = "Dark Regeneration"
	desc = "Feeling the tug of home, some of its soothing warmth comes to ease your burdens. Your wounds mend, your movements quicken, and your actions hasten."
	icon_state = "lightless"

/datum/movespeed_modifier/light_averse
	multiplicative_slowdown = 0.25

/datum/movespeed_modifier/dark_affinity
	multiplicative_slowdown = -0.2

/datum/actionspeed_modifier/hands_of_darkness
	multiplicative_slowdown = -0.25

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
	color_cutoffs = list(20, 10, 40)

// Shadekin Tongue - enables empathic telepathic communication via the Empathy language.

/obj/item/organ/tongue/shadekin
	name = "shadekin tongue"
	desc = "A mysterious tongue."
	icon_state = "silvertongue"
	say_mod = "mars"
	sense_of_taste = TRUE
	modifies_speech = TRUE
	languages_native = list(/datum/language/marish/empathy)
	/// Whether the current empathy transmission was interrupted.
	var/empathy_interrupted = FALSE
	/// Typecache of areas which block communication via empathy
	var/static/list/blacklisted_areas

/obj/item/organ/tongue/shadekin/handle_speech(datum/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] in languages_native)
		return modify_speech(source, speech_args)

/obj/item/organ/tongue/shadekin/modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	speech_args[SPEECH_MESSAGE] = ""
	var/mob/living/carbon/human/user = owner
	var/shadekin_mood = user.mob_mood.sanity_level
	var/empathy_timer = 2 SECONDS
	var/mood_color = "#5ec7e4"
	var/obj/item/organ/ears/shadekin/user_ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	var/mode = istype(user_ears)
	user.balloon_alert_to_viewers("[mode ? "ears vibrate" : "shivers"]", "projecting thoughts...")

	switch(shadekin_mood)
		if(SANITY_LEVEL_GREAT)
			empathy_timer = 0
			mood_color = "#3aff28"
		if(SANITY_LEVEL_NEUTRAL)
			empathy_timer = 1 SECONDS
			mood_color = "#a8d8ea"
		if(SANITY_LEVEL_UNSTABLE)
			empathy_timer = 4 SECONDS
			mood_color = "#d4a843"
		if(SANITY_LEVEL_CRAZY)
			empathy_timer = 5 SECONDS
			mood_color = "#c94a4a"
			message = stars(message)
		if(SANITY_LEVEL_INSANE)
			empathy_timer = 6 SECONDS
			mood_color = "#8b0000"
			message = readable_corrupted_text(message)

	if(empathy_timer)
		empathy_interrupted = FALSE
		RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_empathy_interrupted))
		addtimer(CALLBACK(src, PROC_REF(deliver_empathy), user, message, mood_color), empathy_timer)
	else
		deliver_empathy(user, message, mood_color)

/obj/item/organ/tongue/shadekin/proc/on_empathy_interrupted(datum/source)
	SIGNAL_HANDLER
	empathy_interrupted = TRUE
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

/obj/item/organ/tongue/shadekin/proc/deliver_empathy(mob/living/carbon/human/user, message, mood_color)
	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)

	//don't send messages in ghost cafe
	if(isnull(blacklisted_areas))
		blacklisted_areas = typecacheof(GLOB.ghost_cafe_areas)
	var/area/user_area = get_area(user)
	if(is_type_in_typecache(user_area, blacklisted_areas))
		to_chat(user, span_warning("Your empathic transmission fizzles out..."))
		return
	if(empathy_interrupted)
		message = full_capitalize(rot13(message))
	var/rendered = "<span style='color: [mood_color]'><b>[user.real_name]:</b> [message]</span>"
	user.log_talk(rendered, LOG_SAY, tag = "shadekin")
	for(var/mob/living/carbon/human/living_mob in GLOB.alive_mob_list)
		var/obj/item/organ/ears/shadekin/target_ears = living_mob.get_organ_slot(ORGAN_SLOT_EARS)

		if(!istype(target_ears))
			continue

		//don't receive messages in ghost cafe
		var/area/target_area = get_area(living_mob)
		if(is_type_in_typecache(target_area, blacklisted_areas))
			continue

		to_chat(living_mob, rendered)
		if(living_mob != user)
			var/mode = istype(target_ears)
			living_mob.balloon_alert_to_viewers("[mode ? "ears vibrate" : "shivers"]", "transmission heard...")

	for(var/mob/dead_mob as anything in GLOB.dead_mob_list)
		if(isnull(dead_mob.client) || isnewplayer(dead_mob))
			continue
		var/link = FOLLOW_LINK(dead_mob, user)
		to_chat(dead_mob, "[link] [rendered]")

// Shadekin Ears - sensitive ears that detect empathic communication.

/obj/item/organ/ears/shadekin
	name = "shadekin ears"
	desc = "Ears, covered in fur."
	damage_multiplier = 2.5
