/datum/dynamic_ruleset/midround/mutant_infestation
	name = "HNZ-1 Pathogen Outbreak"
	config_tag = "Mutant Infestation"
	preview_antag_datum = /datum/antagonist/mutant
	midround_type = HEAVY_MIDROUND
	pref_flag = ROLE_MUTANT
	weight = 0
	min_pop = 30
	min_antag_cap = 2
	false_alarm_able = TRUE

/datum/dynamic_ruleset/midround/mutant_infestation/New(list/dynamic_config)
	. = ..()
	max_antag_cap += prob(50)

/datum/dynamic_ruleset/midround/mutant_infestation/execute()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(announce_mutant_infestation)), 600 SECONDS)

/datum/dynamic_ruleset/midround/mutant_infestation/proc/announce_mutant_infestation()
	alert_sound_to_playing(sound('modular_nova/modules/alerts/sound/alerts/alert2.ogg'), override_volume = TRUE)
	priority_announce("Automated air filtration screeing systems have flagged an unknown pathogen in the ventilation systems, quarantine is in effect.", "Level-1 Viral Biohazard Alert", ANNOUNCER_MUTANTS)

/datum/dynamic_ruleset/midround/mutant_infestation/false_alarm()
	announce_mutant_infestation()

/datum/dynamic_ruleset/midround/mutant_infestation/collect_candidates()
	return GLOB.alive_player_list

/datum/dynamic_ruleset/midround/mutant_infestation/is_valid_candidate(mob/candidate, client/candidate_client)
	. = ..()
	if(!.)
		return FALSE
	if(!is_station_level(candidate.z))
		return FALSE
	if(!ishuman(candidate))
		return FALSE
	var/mob/living/carbon/human/human_candidate = candidate
	if(!(human_candidate.dna?.species))
		return FALSE
	return TRUE

/datum/dynamic_ruleset/midround/mutant_infestation/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/mutant)
	try_to_mutant_infect(candidate.current, TRUE)
	notify_ghosts("[candidate.current.real_name] has been infected by the HNZ-1 pathogen!",
		source = candidate.current,
	)
