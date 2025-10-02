/datum/storyteller_goal/execute_psychic_drone
	id = "psychic_drone"
	name = "Execute the Psychic Drone"
	desc = "Deploy a psychic drone to broadcast disruptive psionic noise across the station."
	category = STORY_GOAL_BAD
	tags = STORY_TAG_ESCALATION | STORY_TAG_AFFECTS_CREW_MIND
	path_ids = list("mass_hysteria", "psychic_breakdown")
	event_path = /datum/round_event/psychic_drone

/datum/storyteller_goal/execute_psychic_drone/is_available(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return inputs.antag_crew_ratio > 0.05

/datum/storyteller_goal/execute_psychic_drone/get_weight(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	// TODO: crew sanity
	return storyteller.threat_points * 0.05 + (inputs.antag_crew_ratio * 10.0)

/datum/storyteller_goal/execute_psychic_drone/get_priority(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller)
	return 3

/datum/storyteller_goal/execute_psychic_drone/trigger_event(list/vault, datum/storyteller_inputs/inputs, datum/storyteller/storyteller, threat_points, station_value)
	..()


/datum/round_event/psychic_drone
	// Default, but randomize per wave or target
	var/target_sex = MALE
	// Assume custom drone mob (implement separately)
	var/drone_path = /mob/living/simple_animal/hostile/psychic_drone
	// Time between noise pulses
	var/wave_duration = 30 SECONDS
	// Total pulses, scaled by threat
	var/num_waves = 5
	// 1=low (mild effects), 5=high (intense hallucinations/vomiting)
	var/noise_strength = 1
	// % chance for positive vs negative noise
	var/positive_noise_chance = 50

/datum/round_event/psychic_drone/__setup_for_storyteller(threat_points)
	. = ..()

	if(threat_points < STORY_THREAT_LOW)
		noise_strength = 1
		num_waves = 3
		positive_noise_chance = 70  // More positive early to build false security
	else if(threat_points < STORY_THREAT_MODERATE)
		noise_strength = 2
		num_waves = 5
		positive_noise_chance = 50
	else if(threat_points < STORY_THREAT_HIGH)
		noise_strength = 3
		num_waves = 7
		positive_noise_chance = 30
	else if(threat_points < STORY_THREAT_EXTREME)
		noise_strength = 4
		num_waves = 10
		positive_noise_chance = 20
	else
		noise_strength = 5
		num_waves = 15
		positive_noise_chance = 10  // Mostly negative at high threat

	// Dynamic scaling
	num_waves = min(num_waves + round(threat_points / 500), 20)  // Max 20 waves

/datum/round_event/psychic_drone/__announce_for_storyteller()
	priority_announce("A faint psychic hum echoes through the station's vents. Crew reports of unease.", "Anomalous Readings")

/datum/round_event/psychic_drone/__start_for_storyteller()
	. = ..()
	var/turf/spawn_turf = pick(get_area_turfs(/area/station/maintenance))
	var/mob/living/simple_animal/hostile/psychic_drone/drone = new drone_path(spawn_turf)
	drone.noise_strength = noise_strength
	drone.positive_noise_chance = positive_noise_chance
	drone.num_waves = num_waves
	drone.wave_duration = wave_duration


	drone.pulse_psychic_noise()
	log_game("Storyteller: Psychic Drone deployed. Strength: [noise_strength], Waves: [num_waves]")


/mob/living/simple_animal/hostile/psychic_drone
	name = "psychic drone"
	desc = "A hovering orb emitting faint psionic waves."
	icon = 'icons/mob/simple/hivebot.dmi'
	icon_state = "commdish"
	density = TRUE
	anchored = TRUE
	health = 2000
	maxHealth = 2000
	melee_damage_lower = 0
	melee_damage_upper = 0
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = FIRE_SUIT_MAX_TEMP_PROTECT
	speed = 0
	faction = list()
	status_flags = 0

	var/noise_strength = 1
	var/positive_noise_chance = 50
	var/num_waves = 5
	var/wave_duration = 30 SECONDS
	var/current_wave = 0

/mob/living/simple_animal/hostile/psychic_drone/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	addtimer(CALLBACK(src, PROC_REF(pulse_psychic_noise)), wave_duration)

/mob/living/simple_animal/hostile/psychic_drone/process()
	if(prob(5))
		var/turf/T = get_step(src, pick(GLOB.cardinals))
		if(!isspaceturf(T))
			forceMove(T)

/mob/living/simple_animal/hostile/psychic_drone/proc/pulse_psychic_noise()
	current_wave++
	if(current_wave > num_waves)
		qdel(src)
		return

	var/list/targets = list()
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(!H.mind || H.stat == DEAD)
			continue
		targets |= H

	if(length(targets))
		var/is_positive = prob(positive_noise_chance)
		var/target_sex_local = pick(MALE, FEMALE, NEUTER)
		for(var/mob/living/carbon/human/target in targets)
			apply_psychic_noise(target, is_positive, noise_strength, target_sex_local)

	// playsound(src, is_positive ? 'sound/hallucinations/wail.ogg' : 'sound/hallucinations/growl1.ogg', 50 * noise_strength, TRUE)

	addtimer(CALLBACK(src, PROC_REF(pulse_psychic_noise)), wave_duration)

/mob/living/simple_animal/hostile/psychic_drone/proc/apply_psychic_noise(mob/living/carbon/human/target, is_positive, strength, target_sex)
	var/debuff_duration = 30 SECONDS * strength

	var/effect_msg = ""
	if(is_positive)
		if(target_sex == MALE)
			effect_msg = span_notice("A confident surge fills your mind, sharpening your focus.")
		else if(target_sex == FEMALE)
			effect_msg = span_notice("Empathic waves soothe your thoughts, easing tensions.")
		else
			effect_msg = span_notice("A neutral hum clears mental fog briefly.")

		target.add_mood_event("psychic_drone", /datum/mood_event/phychic_drone_positive)
		target.add_movespeed_modifier(/datum/movespeed_modifier/psychic_boost, update=TRUE)
		addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human/, remove_movespeed_modifier), \
				/datum/movespeed_modifier/psychic_boost, TRUE), debuff_duration)
	else
		if(target_sex == MALE)
			effect_msg = span_userdanger("Aggressive shrieks invade your head, fueling rage!")
		else if(target_sex == FEMALE)
			effect_msg = span_userdanger("Hysterical cries overwhelm you, shattering composure!")
		else
			effect_msg = span_userdanger("Disorienting wails echo, inducing nausea.")
			target.adjust_disgust(25 * strength)

		if(prob(50 * strength))
			target.vomit()
		target.adjust_hallucinations(30 SECONDS)
		SEND_SOUND(target, sound('sound/items/weapons/flash_ring.ogg'))
		target.add_mood_event("psychic_drone", )

		if(strength <= 2)
			target.add_mood_event("psychic_drone", /datum/mood_event/phychic_drone_negative)
		else if(strength <= 4)
			target.add_mood_event("psychic_drone", /datum/mood_event/phychic_drone_negative/strong)
		else if(strength <= 5)
			target.add_mood_event("psychic_drone", /datum/mood_event/phychic_drone_negative/extreme)
		target.adjustOxyLoss(rand(40-60), forced=TRUE)

	to_chat(target, effect_msg)
	new /obj/effect/temp_visual/psychic_scream(get_turf(target), target)


/datum/mood_event/phychic_drone_negative
	description = ""
	mood_change = -16
	timeout = 30 SECONDS

/datum/mood_event/phychic_drone_negative/strong
	description = ""
	mood_change = -24
	timeout = 30 SECONDS

/datum/mood_event/phychic_drone_negative/extreme
	description = ""
	mood_change = -40
	timeout = 30 SECONDS

/datum/mood_event/phychic_drone_positive
	description = ""
	mood_change = 14
	timeout = 30 SECONDS

/datum/movespeed_modifier/psychic_boost
	multiplicative_slowdown = -2

/obj/effect/temp_visual/psychic_scream
	name = "psychic scream"
	icon = 'icons/effects/effects.dmi'
	icon_state = "cursehand0"
	duration = 10
	layer = ABOVE_MOB_LAYER
