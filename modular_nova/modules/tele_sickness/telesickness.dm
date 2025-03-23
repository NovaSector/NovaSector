/datum/mood_event/disgust/tele_sickness
	description = "I've teleported way too often..."
	mood_change = -6
	timeout = 2 MINUTES

/atom/movable/screen/alert/status_effect/tele_sickness
	name = "Teleport Sickness"
	desc = "Your body has teleported recently. It may be dangerous to continue teleporting."
	icon_state = "flux"

/datum/status_effect/tele_sickness
	id = "tele_sickness"
	status_type = STATUS_EFFECT_REFRESH
	duration = 2 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/tele_sickness
	remove_on_fullheal = TRUE // staff of healing ~synergy~
	show_duration = TRUE

	/// the stage of the sickness, which stacks on the amount of times you teleport
	var/stage = 0

/datum/status_effect/tele_sickness/on_apply()
	RegisterSignal(owner, COMSIG_MOVABLE_POST_TELEPORT, PROC_REF(stage_changing))
	stage_counting()
	return TRUE

/datum/status_effect/tele_sickness/on_remove()
	UnregisterSignal(owner, COMSIG_MOVABLE_POST_TELEPORT)

/// Flashbang proc for the viewers of the recently deceased light particle
/datum/status_effect/tele_sickness/proc/bang(turf/turf, mob/living/living_mob)
	if(living_mob.stat == DEAD) //They're dead!
		return
	living_mob.show_message(span_warning("BANG"), MSG_AUDIBLE)
	var/distance = max(0, get_dist(get_turf(owner), turf))

//Flash
	if(living_mob.flash_act(affect_silicon = 1))
		living_mob.Paralyze(max(2 SECONDS/max(1, distance), 0.5 SECONDS))
		living_mob.Knockdown(max(20 SECONDS/max(1, distance), 6 SECONDS))

//Bang
	if(distance <= 1) // Adds more stun as to not prime n' pull (#45381)
		living_mob.Paralyze(0.5 SECONDS)
		living_mob.Knockdown(3 SECONDS)
	living_mob.soundbang_act(1, max(200 / max(1, distance), 60), rand(0, 5))

/// adds a stage and does the stage effects: is listening for the post teleport comsig
/datum/status_effect/tele_sickness/proc/stage_changing()
	if(IS_SPACE_NINJA(owner))
		stage += 0.5

	else
		stage += 1

	stage_effects()

/// these are the stage effects from teleporting too much-- every other stage has new effects
/datum/status_effect/tele_sickness/proc/stage_effects()
	switch(stage)
		if(1 to 2)
			owner.add_mood_event("tele_sick", /datum/mood_event/disgust/tele_sickness)

		if(3 to 4)
			owner.add_mood_event("tele_sick", /datum/mood_event/disgust/tele_sickness)
			owner.adjust_eye_blur_up_to(10 SECONDS, 1 MINUTES)

		if(5 to 6)
			owner.add_mood_event("tele_sick", /datum/mood_event/disgust/tele_sickness)
			owner.adjust_eye_blur_up_to(10 SECONDS, 1 MINUTES)
			owner.adjust_confusion_up_to(10 SECONDS, 1 MINUTES)

		if(7 to 100)
			owner.add_mood_event("tele_sick", /datum/mood_event/disgust/tele_sickness)
			owner.adjust_eye_blur_up_to(10 SECONDS, 1 MINUTES)
			owner.adjust_confusion_up_to(10 SECONDS, 1 MINUTES)
			owner.adjust_disgust(150)

		if(101 to INFINITY)
			var/flashbang_turf = get_turf(owner)
			if(!flashbang_turf)
				return FALSE

			do_sparks(rand(5, 9), FALSE, flashbang_turf)
			playsound(flashbang_turf, 'sound/items/weapons/flashbang.ogg', 100, TRUE, 8, 0.9)
			new /obj/effect/dummy/lighting_obj (flashbang_turf, 9, 4, COLOR_WHITE, 2)
			for(var/mob/living/living_mob in get_hearers_in_view(7, flashbang_turf))
				bang(get_turf(living_mob), living_mob)

			owner.dust(force = TRUE)
			return FALSE

	return TRUE

/// this is the "timer" that counts and brings down the stages from teleporting: it will stop if the target teleported too much however
/datum/status_effect/tele_sickness/proc/stage_counting()
	if(!stage_effects())
		return

	if(stage > 0)
		stage -= 1

	addtimer(CALLBACK(src, PROC_REF(stage_counting)), 1 MINUTES, TIMER_STOPPABLE | TIMER_DELETE_ME)
