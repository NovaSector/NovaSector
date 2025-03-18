/datum/mood_event/disgust/tele_sickness
	description = "I've teleported way too often..."
	mood_change = -2
	timeout = 3 MINUTES

/datum/component/tele_sickness
	/// The stage that the teleport sickness is currently on
	var/stage = 0

	/// The carbon parent the component is attached to
	var/mob/living/carbon/carbon_parent

/datum/component/tele_sickness/Initialize(...)
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE

	carbon_parent = parent
	stage_counting()

/datum/component/tele_sickness/RegisterWithParent()
	RegisterSignal(carbon_parent, COMSIG_MOVABLE_POST_TELEPORT, PROC_REF(stage_changing))

/datum/component/tele_sickness/proc/bang(turf/turf, mob/living/living_mob)
	if(living_mob.stat == DEAD) //They're dead!
		return
	living_mob.show_message(span_warning("BANG"), MSG_AUDIBLE)
	var/distance = max(0, get_dist(get_turf(carbon_parent), turf))

//Flash
	if(living_mob.flash_act(affect_silicon = 1))
		living_mob.Paralyze(max(20/max(1, distance), 5))
		living_mob.Knockdown(max(200/max(1, distance), 60))

//Bang
	if(distance <= 1) // Adds more stun as to not prime n' pull (#45381)
		living_mob.Paralyze(5)
		living_mob.Knockdown(30)
	living_mob.soundbang_act(1, max(200 / max(1, distance), 60), rand(0, 5))

/datum/component/tele_sickness/proc/stage_changing()
	stage += 1
	stage_effects()

/datum/component/tele_sickness/proc/stage_effects()
	switch(stage)
		if(1 to 2)
			carbon_parent.add_mood_event("tele_sick", /datum/mood_event/disgust/tele_sickness)

		if(3 to 4)
			carbon_parent.add_mood_event("tele_sick", /datum/mood_event/disgust/tele_sickness)
			carbon_parent.adjust_eye_blur(30 SECONDS)

		if(5 to 6)
			carbon_parent.add_mood_event("tele_sick", /datum/mood_event/disgust/tele_sickness)
			carbon_parent.adjust_eye_blur(30 SECONDS)
			carbon_parent.adjust_confusion(30 SECONDS)

		if(7 to 100)
			carbon_parent.add_mood_event("tele_sick", /datum/mood_event/disgust/tele_sickness)
			carbon_parent.adjust_eye_blur(30 SECONDS)
			carbon_parent.adjust_confusion(30 SECONDS)
			carbon_parent.adjust_disgust(150)

		if(101 to INFINITY)
			var/flashbang_turf = get_turf(carbon_parent)
			if(!flashbang_turf)
				return FALSE

			do_sparks(rand(5, 9), FALSE, flashbang_turf)
			playsound(flashbang_turf, 'sound/items/weapons/flashbang.ogg', 100, TRUE, 8, 0.9)
			new /obj/effect/dummy/lighting_obj (flashbang_turf, 9, 4, COLOR_WHITE, 2)
			for(var/mob/living/living_mob in get_hearers_in_view(7, flashbang_turf))
				bang(get_turf(living_mob), living_mob)

			carbon_parent.dust(force = TRUE)
			return FALSE

	return TRUE

/datum/component/tele_sickness/proc/stage_counting()
	if(!stage_effects())
		return

	if(stage > 0)
		stage -= 1

	addtimer(CALLBACK(src, PROC_REF(stage_counting)), 2 MINUTES)

/mob/living/carbon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/tele_sickness)
